<template>
  <div class="profile-container">
    <h2>My Profile</h2>

    <div class="profile-card">
      <div class="pfp-section">
        <h3>Choose your Avatar</h3>
        <div class="pfp-grid">
          <div
            v-for="option in pfpOptions"
            :key="option"
            class="pfp-option"
            :class="{ active: selectedPfp === option }"
            @click="selectedPfp = option"
          >
            <img :src="getImgUrl(option)" alt="avatar" />
          </div>
        </div>
      </div>

      <form @submit.prevent="updateProfile" class="edit-form">
        <div class="form-group">
          <label>Username</label>
          <input v-model="username" required />
        </div>

        <div class="form-group">
          <label>Email Address</label>
          <input v-model="email" type="email" required />
        </div>

        <div class="form-group">
          <label>Role</label>
          <input :value="user.role" disabled class="disabled-input" />
          <small>Roles cannot be changed here.</small>
        </div>

        <button type="submit" class="save-btn">Save Changes</button>
      </form>

      <p v-if="message" :class="{ success: !error, error: error }">{{ message }}</p>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import pfp1 from "@/assets/pfp_image/pfp1.jpeg";
import pfp2 from "@/assets/pfp_image/pfp2.jpeg";
import pfp3 from "@/assets/pfp_image/pfp3.jpeg";
import pfp4 from "@/assets/pfp_image/pfp4.jpeg";

export default {
  name: "UserProfile",
  props: ["user", "token"],
  emits: ["user-updated"],
  data() {
    return {
      pfpMap: {
        "pfp1.jpeg": pfp1,
        "pfp2.jpeg": pfp2,
        "pfp3.jpeg": pfp3,
        "pfp4.jpeg": pfp4,
      },
      pfpOptions: ["pfp1.jpeg", "pfp2.jpeg", "pfp3.jpeg", "pfp4.jpeg"],

      selectedPfp: this.user.pfp || "pfp1.jpeg",
      username: this.user.username,
      email: this.user.email, // Initialize with current email
      message: "",
      error: false,
    };
  },
  methods: {
    getImgUrl(name) {
      return this.pfpMap[name] || this.pfpMap["pfp1.jpeg"];
    },
    async updateProfile() {
      this.message = "";
      this.error = false;

      try {
        const response = await axios.put(
          "http://localhost:3000/api/users/profile",
          {
            username: this.username,
            email: this.email, // Send updated email
            pfp: this.selectedPfp,
          },
          {
            headers: { Authorization: `Bearer ${this.token}` },
          }
        );

        this.message = "Profile updated!";
        this.$emit("user-updated", response.data.user);
      } catch (err) {
        this.error = true;
        this.message = err.response ? err.response.data.message : "Update failed.";
      }
    },
  },
};
</script>

<style scoped>
.profile-container {
  max-width: 600px;
  margin: 0 auto;
}
.profile-card {
  border: 1px solid #ddd;
  padding: 20px;
  border-radius: 8px;
  background: white;
}
.pfp-grid {
  display: flex;
  gap: 15px;
  justify-content: center;
  margin-bottom: 30px;
}
.pfp-option {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  cursor: pointer;
  border: 3px solid transparent;
  overflow: hidden;
  transition: transform 0.2s;
}
.pfp-option img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.pfp-option:hover {
  transform: scale(1.1);
}
.pfp-option.active {
  border-color: #3498db;
  transform: scale(1.1);
  box-shadow: 0 0 10px rgba(52, 152, 219, 0.5);
}
.form-group {
  margin-bottom: 15px;
  text-align: left;
}
.form-group label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
}
.form-group input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
.disabled-input {
  background-color: #f9f9f9;
  color: #666;
}
.save-btn {
  background-color: #2c3e50;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
}
.save-btn:hover {
  background-color: #34495e;
}
.success {
  color: green;
  margin-top: 10px;
}
.error {
  color: red;
  margin-top: 10px;
}
</style>
