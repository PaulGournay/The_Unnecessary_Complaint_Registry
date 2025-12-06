# The Unnecessary Complaint Registry

A Single Page Application (SPA) designed as a sanctuary for grievances so specific, so petty, and so incredibly low-stakes that they deserve to be archived forever. Built for fun, learning, and community bonding over small annoyances like "The sound of styrofoam rubbing together."

## 🚀 Features

* **User Roles:** Two distinct experiences for **Complainers** (Standard Users) and **Archivists** (Admins).
* **Specificity Score:** A dynamic voting system where the community decides how relatable a specific complaint is.
* **One-Vote Integrity:** Smart voting logic ensuring users can only vote once per complaint.
* **Admin Dashboard:** Archivists can ban users, archive (delete) complaints, and reset vote counts.
* **Admin Inbox:** A dedicated message center for Archivists to receive feedback from the Contact page.
* **Profile Management:** Users can customize their profiles with preset avatars (PFPs).
* **iOS 16 Aesthetic:** A modern, "Inset Grouped" design language with glassmorphism effects.

## 🛠️ Tech Stack

* **Frontend:** Vue.js 3
* **Backend:** Node.js, Express
* **Database:** MySQL
* **Authentication:** JWT (JSON Web Tokens) & Bcrypt

---

## ⚙️ Setup & Installation

### 1. Database Setup
1.  Navigate to the SQL file location: `client/src/assets/complaint_registry.sql`.
2.  Open **XAMPP** (or WAMP) and start **Apache** and **MySQL**.
3.  Go to **phpMyAdmin** (usually `http://localhost/phpmyadmin`).
4.  Create a new database named: `complaint_registry`.
5.  **Import** the SQL file into this new database.
    * *Note: The file includes example users, categories, votes, and complaints.*

### 2. Install Dependencies
Open your terminal and run the following commands to install node modules for the root, client, and server:

```bash
# Install root dependencies
npm install

# Install Client dependencies
cd client && npm install && cd ..

# Install Server dependencies
cd server && npm install && cd ..
```
### 2. Run the Project
To start both the backend server and the frontend client simultaneously:
```bash
npm run dev
```
* Frontend: http://localhost:8080 (or 5173)

* Backend: http://localhost:3000

## 🧪 Example Accounts

Paul – complainer --> password : 1234

Sam – complainer --> password : 1234

Clayton – complainer --> password : 1234

pierre – complainer --> password : 1234

admin – archivist --> password : 1234
