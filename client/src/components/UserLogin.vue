<template>
  <div class="login-wrapper">
    <div class="ios-card login-card">
      <div class="card-header">
        <h2>Welcome Back</h2>
        <p class="subtitle">Sign in to access the registry</p>
      </div>

      <form @submit.prevent="handleLogin" class="ios-form">
        <div class="input-group">
          <input 
            v-model="username" 
            placeholder="Username" 
            class="ios-input" 
            required 
          />
          <input 
            v-model="password" 
            type="password" 
            placeholder="Password" 
            class="ios-input" 
            required 
          />
        </div>
        
        <button type="submit" class="ios-btn-primary">Log In</button>
        
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
  name: "UserLogin",
  emits: ["login-success"], // Fixed: matched the event name used in App.vue
  data() {
    return {
      username: "",
      password: "",
      message: "",
      error: false,
    };
  },
  methods: {
    async handleLogin() {
      this.message = "";
      this.error = false;

      try {
        const response = await axios.post("http://localhost:3000/api/login", {
          username: this.username,
          password: this.password,
        });

        this.message = "Success! Redirecting...";
        // Emit 'login-success' to match App.vue listener
        setTimeout(() => {
          this.$emit("login-success", response.data);
        }, 1000);
      } catch (err) {
        this.error = true;
        this.message = err.response
          ? err.response.data.message
          : "Login failed. Server error.";
        console.error(err);
      }
    },
  },
};
</script>

<style scoped>
/* Wrapper to center content */
.login-wrapper {
  display: flex;
  justify-content: center;
  padding-top: 60px;
  padding-bottom: 60px;
}

/* iOS Card Style */
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
  margin-bottom: 30px;
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
  background-color: #f2f2f7; /* iOS Input Background */
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

.ios-input::placeholder {
  color: #aeaeb2;
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

/* Status Messages */
.status-msg {
  text-align: center;
  font-size: 14px;
  font-weight: 500;
  margin-top: 10px;
  min-height: 20px;
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