// server.js
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const mysql = require("mysql2/promise");

const app = express();
const port = 3000;
const secretKey =
  "pUrSrRoUH78bj7NkGf0b0nOtqgvvMytdjAqZ8s6db8YG9B59zvtLuLK60wA5tRJuKEEj32PF9n9ZoxBaMw6g79"; //generated using jwtsecretkeygenerator.com

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Database connection pool
const dbPool = mysql.createPool({
  host: "localhost",
  user: "root",
  password: "",
  database: "complaint_registry",
  waitForConnections: true,
  connectionLimit: 10,
});

// Test DB connection
(async () => {
  try {
    const connection = await dbPool.getConnection();
    console.log("Database connection successful.");
    connection.release();
  } catch (error) {
    console.error("Failed to connect to the database:", error.message);
    process.exit(1);
  }
})();

// --- JWT Functions & Middleware ---

function generateToken(user) {
  const payload = { id: user.id, username: user.username, role: user.role };
  const options = { expiresIn: "1h" };
  return jwt.sign(payload, secretKey, options);
}

function authenticateToken(req, res, next) {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (token == null) return res.sendStatus(401);

  jwt.verify(token, secretKey, (err, user) => {
    if (err) return res.sendStatus(403);
    req.user = user; // user object now includes id, username, and role
    next();
  });
}

// Middleware for Archivist-only routes
function archivistOnly(req, res, next) {
  if (req.user.role !== "archivist") {
    return res
      .status(403)
      .json({ message: "Access denied. Archivist role required." });
  }
  next();
}

// --- AUTH ROUTES ---

// Registration
app.post("/api/register", async (req, res) => {
  try {
    const { username, password, role, email } = req.body; // Added email

    // Validate email is present
    if (!username || !password || !email) {
      return res
        .status(400)
        .json({ message: "Username, email, and password are required." });
    }

    const userRole =
      role === "archivist" && username === "admin" ? "archivist" : "complainer";
    const hashedPassword = await bcrypt.hash(password, 10);

    const [existing] = await dbPool.query(
      "SELECT id FROM users WHERE username = ?",
      [username]
    );
    if (existing.length > 0) {
      return res.status(409).json({ message: "Username already exists." });
    }

    // Insert with email
    await dbPool.query(
      "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)",
      [username, email, hashedPassword, userRole]
    );

    res.status(201).json({ message: "Registration successful!" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error registering user." });
  }
});

// Login
app.post("/api/login", async (req, res) => {
  try {
    const { username, password } = req.body;
    let rows;
    if (username.includes("@")) {
      [rows] = await dbPool.query("SELECT * FROM users WHERE email = ?", [
        username,
      ]);
    } else {
      [rows] = await dbPool.query("SELECT * FROM users WHERE username = ?", [
        username,
      ]);
    }

    if (rows.length === 0)
      return res.status(404).json({ message: "User not found." });

    const user = rows[0];
    if (await bcrypt.compare(password, user.password)) {
      const token = generateToken(user);
      res.json({
        message: "Login successful!",
        token: token,
        // Send email to frontend here
        user: {
          id: user.id,
          username: user.username,
          role: user.role,
          pfp: user.pfp,
          email: user.email,
        },
      });
    } else {
      res.status(401).json({ message: "Incorrect password." });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error logging in." });
  }
});

// --- COMPLAINT CRUD ROUTES ---

// READ all complaints (including category and user info)
app.get("/api/complaints", async (req, res) => {
  try {
    let currentUserId = null;

    // 1. Manually check for token to get user ID
    const authHeader = req.headers["authorization"];
    const token = authHeader && authHeader.split(" ")[1];

    // IMPORTANT: You need to require 'jsonwebtoken' and 'secretKey' at top of file
    if (token) {
      try {
        const decoded = jwt.verify(token, secretKey);
        currentUserId = decoded.id;
      } catch (err) {
        /* invalid token, ignore */
      }
    }

    // 2. Query joins with 'complaint_votes' to see if THIS user voted
    const query = `
            SELECT 
                c.id, c.title, c.detail, c.specificity_score, c.category, c.created_at,
                u.username AS complainer_name, u.id AS complainer_id, u.pfp AS complainer_pfp,
                cv.vote_type AS user_vote
            FROM complaints c
            JOIN users u ON c.user_id = u.id
            LEFT JOIN complaint_votes cv ON c.id = cv.complaint_id AND cv.user_id = ?
            ORDER BY c.specificity_score DESC, c.created_at DESC
        `;

    const [complaints] = await dbPool.query(query, [currentUserId]);
    res.json(complaints);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error fetching complaints." });
  }
});

app.get("/api/users", async (req, res) => {
  try {
    const query = `SELECT id, username, pfp FROM users WHERE username != "admin"`;
    const [users] = await dbPool.query(query);
    res.json(users);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error fetching users." });
  }
});

// INSERT a new complaint (Complainer/Authenticated)
app.post("/api/complaints", authenticateToken, async (req, res) => {
  try {
    const { title, detail, category } = req.body; // Changed category_id to category
    const user_id = req.user.id;

    if (!title || !detail || !category) {
      return res.status(400).json({ message: "Missing required fields." });
    }

    const [result] = await dbPool.query(
      "INSERT INTO complaints (title, detail, category, user_id) VALUES (?, ?, ?, ?)",
      [title, detail, category, user_id]
    );

    res.status(201).json({
      message: "Complaint registered successfully!",
      id: result.insertId,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error registering complaint." });
  }
});

app.put("/api/complaints/upvote/:id", authenticateToken, async (req, res) => {
  try {
    const complaintId = req.params.id;
    const userId = req.user.id;

    // Check if vote exists
    const [existing] = await dbPool.query(
      "SELECT vote_type FROM complaint_votes WHERE user_id = ? AND complaint_id = ?",
      [userId, complaintId]
    );

    if (existing.length === 0) {
      // Case 1: No previous vote -> Insert Upvote (+1)
      await dbPool.query(
        "INSERT INTO complaint_votes (user_id, complaint_id, vote_type) VALUES (?, ?, 'up')",
        [userId, complaintId]
      );
      await dbPool.query(
        "UPDATE complaints SET specificity_score = specificity_score + 1 WHERE id = ?",
        [complaintId]
      );
      return res.json({ message: "Upvoted", action: "added" });
    }

    if (existing[0].vote_type === "down") {
      // Case 2: Was Downvoted -> Switch to Upvote (+2)
      await dbPool.query(
        "UPDATE complaint_votes SET vote_type = 'up' WHERE user_id = ? AND complaint_id = ?",
        [userId, complaintId]
      );
      await dbPool.query(
        "UPDATE complaints SET specificity_score = specificity_score + 2 WHERE id = ?",
        [complaintId]
      );
      return res.json({ message: "Vote changed to up", action: "swapped" });
    }

    // Case 3: Already Upvoted -> Do nothing (or remove vote if you prefer toggle)
    return res.status(400).json({ message: "You already upvoted this." });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error processing vote." });
  }
});
app.put("/api/complaints/downvote/:id", authenticateToken, async (req, res) => {
  try {
    const complaintId = req.params.id;
    const userId = req.user.id;

    const [existing] = await dbPool.query(
      "SELECT vote_type FROM complaint_votes WHERE user_id = ? AND complaint_id = ?",
      [userId, complaintId]
    );

    if (existing.length === 0) {
      // Case 1: No previous vote -> Insert Downvote (-1)
      await dbPool.query(
        "INSERT INTO complaint_votes (user_id, complaint_id, vote_type) VALUES (?, ?, 'down')",
        [userId, complaintId]
      );
      await dbPool.query(
        "UPDATE complaints SET specificity_score = specificity_score - 1 WHERE id = ?",
        [complaintId]
      );
      return res.json({ message: "Downvoted", action: "added" });
    }

    if (existing[0].vote_type === "up") {
      // Case 2: Was Upvoted -> Switch to Downvote (-2)
      await dbPool.query(
        "UPDATE complaint_votes SET vote_type = 'down' WHERE user_id = ? AND complaint_id = ?",
        [userId, complaintId]
      );
      await dbPool.query(
        "UPDATE complaints SET specificity_score = specificity_score - 2 WHERE id = ?",
        [complaintId]
      );
      return res.json({ message: "Vote changed to down", action: "swapped" });
    }

    return res.status(400).json({ message: "You already downvoted this." });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error processing vote." });
  }
});

app.put(
  "/api/complaints/reset/:id",
  authenticateToken,
  archivistOnly,
  async (req, res) => {
    try {
      const id = req.params.id;

      // Step 1: Delete all voting records for this complaint
      await dbPool.query("DELETE FROM complaint_votes WHERE complaint_id = ?", [
        id,
      ]);

      // Step 2: Set score to 0
      await dbPool.query(
        "UPDATE complaints SET specificity_score = 0 WHERE id = ?",
        [id]
      );

      res.json({ message: "Specificity score and voting history reset." });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Error resetting score." });
    }
  }
);

// UPDATE complaint specificity score (downvote) (Authenticated - Complainer)
app.put("/api/complaints/downvote/:id", authenticateToken, async (req, res) => {
  try {
    const id = req.params.id;
    // Simple increment
    await dbPool.query(
      "UPDATE complaints SET specificity_score = specificity_score - 1 WHERE id = ?",
      [id]
    );
    res.json({ message: "Specificity score downdated." });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error downvoting complaint." });
  }
});

// UPDATE a user's own complaint (Complainer/Authenticated)
app.put("/api/complaints/:id", authenticateToken, async (req, res) => {
  try {
    const id = req.params.id;
    const { title, detail, category } = req.body; // Changed category_id to category
    const user_id = req.user.id;

    // 1. Check permissions
    const [complaint] = await dbPool.query(
      "SELECT user_id FROM complaints WHERE id = ?",
      [id]
    );
    if (complaint.length === 0 || complaint[0].user_id !== user_id) {
      return res
        .status(403)
        .json({ message: "Forbidden: You can only edit your own complaints." });
    }

    // 2. Perform the update
    await dbPool.query(
      "UPDATE complaints SET title=?, detail=?, category=? WHERE id=?",
      [title, detail, category, id]
    );
    res.json({ message: "Complaint updated successfully." });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error updating complaint." });
  }
});
// UPDATE User Profile
app.put("/api/users/profile", authenticateToken, async (req, res) => {
  try {
    const { username, pfp, email } = req.body; // Added email
    const userId = req.user.id;

    // Update query includes email now
    const query =
      "UPDATE users SET username = ?, email = ?, pfp = ? WHERE id = ?";
    const params = [username, email, pfp, userId];

    await dbPool.query(query, params);

    res.json({
      message: "Profile updated successfully",
      // Return updated user object
      user: { id: userId, username, role: req.user.role, pfp, email },
    });
  } catch (error) {
    console.error("Profile update error:", error);
    res.status(500).json({ message: "Failed to update profile." });
  }
});

// DELETE a complaint (Archivist only)
app.delete(
  "/api/users/delete/:id",
  authenticateToken,
  archivistOnly,
  async (req, res) => {
    try {
      const id = req.params.id;

      // Step 1: Delete votes this user cast on OTHER complaints
      await dbPool.query("DELETE FROM complaint_votes WHERE user_id = ?", [id]);

      // Step 2: Delete complaints created by this user
      // (Note: This will cascade delete votes ON these complaints due to SQL constraints)
      await dbPool.query("DELETE FROM complaints WHERE user_id = ?", [id]);

      // Step 3: Delete the user account
      await dbPool.query("DELETE FROM users WHERE id = ?", [id]);

      res.json({ message: "User banned and all associated data removed." });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Error banning user." });
    }
  }
);

app.delete(
  "/api/users/delete/:id",
  authenticateToken,
  archivistOnly,
  async (req, res) => {
    try {
      const id = req.params.id;
      const query1 = "DELETE FROM complaints WHERE user_id = ?";
      const query2 = "DELETE FROM users WHERE id = ?";
      await dbPool.query(query1, [id]);
      await dbPool.query(query2, [id]);
      res.json({ message: "User banned by Archivist." });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Error banning user." });
    }
  }
);
// --- CONTACT FORM ROUTES ---
app.post("/api/contact", async (req, res) => {
  try {
    const { name, email, subject, message } = req.body;

    if (!name || !email || !subject || !message) {
      return res.status(400).json({ message: "All fields are required." });
    }

    await dbPool.query(
      "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)",
      [name, email, subject, message]
    );

    res.status(201).json({ message: "Message sent successfully!" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Failed to send message." });
  }
});
app.get(
  "/api/admin/messages",
  authenticateToken,
  archivistOnly,
  async (req, res) => {
    try {
      const [messages] = await dbPool.query(
        "SELECT * FROM contact_messages ORDER BY created_at DESC"
      );
      res.json(messages);
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Error fetching messages." });
    }
  }
);
app.delete(
  "/api/admin/messages/:id",
  authenticateToken,
  archivistOnly,
  async (req, res) => {
    try {
      const id = req.params.id;
      await dbPool.query("DELETE FROM contact_messages WHERE id = ?", [id]);
      res.json({ message: "Message deleted." });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Error deleting message." });
    }
  }
);

// Start the server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
