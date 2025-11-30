<template>
  <div class="register-wrapper">
    <div class="ios-card register-card">
      <div class="card-header">
        <h2>Create Account</h2>
        <p class="subtitle">Join the registry of specific grievances</p>
      </div>

      <form @submit.prevent="handleRegister" class="ios-form">
        <div class="input-group">
          <input 
            v-model="username" 
            placeholder="Choose a Username" 
            class="ios-input" 
            required 
          />
          <input 
            v-model="email" 
            type="email" 
            placeholder="Email Address" 
            class="ios-input" 
            required 
          />
          <input 
            v-model="password" 
            type="password" 
            placeholder="Create Password" 
            class="ios-input" 
            required 
          />
        </div>

        <div class="helper-text-container">
          <p class="helper-text">
            By default, you will join as a <strong>Complainer</strong>.
          </p>
          <p class="helper-text secondary">
            (Admin access requires specific credentials)
          </p>
        </div>

        <button type="submit" class="ios-btn-primary">Sign Up</button>
        
        <transition name="fade">
          <p v-if="message" :class="['status-msg', { success: !error, error: error }]">
            {{ message }}
          </p>
        </transition>
      </form>
    </div>
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
      email: "",
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
          email: this.email,
          password: this.password,
          role: role,
        });
        this.message =response.data.message +  "Account created! Redirecting to login...";
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
/* Wrapper */
.register-wrapper {
  display: flex;
  justify-content: center;
  padding-top: 40px;
  padding-bottom: 40px;
}

/* iOS Card */
.ios-card {
  background: #ffffff;
  border-radius: 24px;
  padding: 32px;
  width: 100%;
  max-width: 380px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
  border: 1px solid rgba(0, 0, 0, 0.02);
}

/* Typography */
.card-header {
  text-align: center;
  margin-bottom: 25px;
}

h2 {
  margin: 0;
  font-size: 28px;
  font-weight: 700;
  color: #1c1c1e;
  letter-spacing: -0.5px;
}

.subtitle {
  margin: 8px 0 0;
  color: #8e8e93;
  font-size: 15px;
}

/* Inputs */
.ios-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.input-group {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.ios-input {
  width: 100%;
  padding: 16px;
  background-color: #f2f2f7;
  border: 1px solid transparent;
  border-radius: 14px;
  font-size: 17px;
  color: #1c1c1e;
  box-sizing: border-box;
  transition: all 0.2s ease;
}

.ios-input:focus {
  background-color: #ffffff;
  border-color: #007aff;
  outline: none;
  box-shadow: 0 0 0 4px rgba(0, 122, 255, 0.1);
}

/* Helper Text (iOS Footer Style) */
.helper-text-container {
  padding: 0 5px;
}

.helper-text {
  font-size: 13px;
  color: #636366;
  text-align: center;
  margin: 4px 0;
  line-height: 1.4;
}

.helper-text.secondary {
  color: #aeaeb2;
  font-size: 12px;
}

/* Button */
.ios-btn-primary {
  background-color: #007aff;
  color: white;
  border: none;
  padding: 16px;
  border-radius: 14px;
  font-size: 17px;
  font-weight: 600;
  cursor: pointer;
  transition: transform 0.1s ease, background-color 0.2s;
  width: 100%;
}

.ios-btn-primary:active {
  background-color: #005ecb;
  transform: scale(0.98);
}

/* Messages */
.status-msg {
  text-align: center;
  font-size: 14px;
  font-weight: 500;
  margin-top: 10px;
}

.success { color: #34c759; }
.error { color: #ff3b30; }

/* Transitions */
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s;
}
.fade-enter-from, .fade-leave-to {
  opacity: 0;
}
</style>