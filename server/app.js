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
    const [rows] = await dbPool.query(
      "SELECT * FROM users WHERE username = ?",
      [username]
    );

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
    // We added 'u.pfp AS complainer_pfp' to this query
    const query = `
            SELECT 
                c.id, c.title, c.detail, c.specificity_score, c.created_at,
                cat.name AS category_name,
                u.username AS complainer_name, u.id AS complainer_id,
                u.pfp AS complainer_pfp
            FROM complaints c
            JOIN categories cat ON c.category_id = cat.id
            JOIN users u ON c.user_id = u.id
            ORDER BY c.specificity_score DESC, c.created_at DESC
        `;
    const [complaints] = await dbPool.query(query);
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
    const { title, detail, category_id } = req.body;
    const user_id = req.user.id; // Get user ID from the JWT payload

    if (!title || !detail || !category_id) {
      return res.status(400).json({ message: "Missing required fields." });
    }

    const [result] = await dbPool.query(
      "INSERT INTO complaints (title, detail, category_id, user_id) VALUES (?, ?, ?, ?)",
      [title, detail, category_id, user_id]
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

// UPDATE complaint specificity score (Upvote) (Authenticated - Complainer)
app.put("/api/complaints/upvote/:id", authenticateToken, async (req, res) => {
  try {
    const id = req.params.id;
    // Simple increment
    await dbPool.query(
      "UPDATE complaints SET specificity_score = specificity_score + 1 WHERE id = ?",
      [id]
    );
    res.json({ message: "Specificity score updated." });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error upvoting complaint." });
  }
});
app.put("/api/complaints/downvote/:id", authenticateToken, async (req, res) => {
  try {
    const id = req.params.id;
    // Simple increment
    await dbPool.query(
      "UPDATE complaints SET specificity_score = specificity_score - 1 WHERE id = ?",
      [id]
    );
    res.json({ message: "Specificity score updated." });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error upvoting complaint." });
  }
});

app.put("/api/complaints/reset/:id", authenticateToken, async (req, res) => {
  try {
    const id = req.params.id;
    const query = "UPDATE complaints SET specificity_score = 0 WHERE id = ?";
    await dbPool.query(query, [id]);
    res.json({ message: "Specificity score reset. " });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error resetting score. " });
  }
});

// UPDATE a user's own complaint (Complainer/Authenticated)
app.put("/api/complaints/:id", authenticateToken, async (req, res) => {
  try {
    const id = req.params.id;
    const { title, detail, category_id } = req.body;
    const user_id = req.user.id;

    // 1. Check if the complaint belongs to the user
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
      "UPDATE complaints SET title=?, detail=?, category_id=? WHERE id=?",
      [title, detail, category_id, id]
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
  "/api/complaints/:id",
  authenticateToken,
  archivistOnly,
  async (req, res) => {
    try {
      const id = req.params.id;
      await dbPool.query("DELETE FROM complaints WHERE id = ?", [id]);
      res.json({ message: "Complaint deleted by Archivist." });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: "Error deleting complaint." });
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

// --- CATEGORY READ ROUTE ---

// READ all categories
app.get("/api/categories", async (req, res) => {
  try {
    const [categories] = await dbPool.query(
      "SELECT * FROM categories ORDER BY name"
    );
    res.json(categories);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error fetching categories." });
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
