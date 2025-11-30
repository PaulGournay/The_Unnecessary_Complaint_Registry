<template>
  <div class="register-container">
    <h2>Register a New User</h2>
    <form @submit.prevent="handleRegister">
      <input v-model="username" placeholder="Username" required />
      
      <input v-model="email" type="email" placeholder="Email Address" required />
      
      <input v-model="password" type="password" placeholder="Password" required />
      <p>By default, you will be a **Complainer**.</p>
      <p>
        If you use the username **'admin'**, you will be registered as an **Archivist**.
      </p>
      <button type="submit">Register</button>
      <p v-if="message" :class="{ success: !error, error: error }">{{ message }}</p>
    </form>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "UserRegister",
  emits: ["registered"],
  data() {
    return {
      username: "",
      email: "", // Initialize email
      password: "",
      message: "",
      error: false,
    };
  },
  methods: {
    async handleRegister() {
      this.message = "";
      this.error = false;

      const role = this.username.toLowerCase() === "admin" ? "archivist" : "complainer";

      try {
        const response = await axios.post("http://localhost:3000/api/register", {
          username: this.username,
          email: this.email, // Send email
          password: this.password,
          role: role,
        });
        this.message = response.data.message + " Redirecting to login...";
        setTimeout(() => {
          this.$emit("registered");
        }, 1500);
      } catch (err) {
        this.error = true;
        this.message = err.response
          ? err.response.data.message
          : "Registration failed. Server error.";
        console.error(err);
      }
    },
  },
};
</script>

<style scoped>
/* Keep existing styles */
.register-container {
  max-width: 300px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 8px;
}
input {
  display: block;
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  box-sizing: border-box;
}
button {
  padding: 10px 20px;
}
.success { color: green; }
.error { color: red; }
</style>