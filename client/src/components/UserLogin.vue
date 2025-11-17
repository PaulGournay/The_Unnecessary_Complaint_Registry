<template>
  <div class="login-container">
    <h2>User Login</h2>
    <form @submit.prevent="handleLogin">
      <input v-model="username" placeholder="Username" required />
      <input v-model="password" type="password" placeholder="Password" required />
      <button type="submit">Login</button>
      <p v-if="message" :class="{'success': !error, 'error': error}">{{ message }}</p>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'UserLogin',
  emits: ['loggedin'],
  data() {
    return {
      username: '',
      password: '',
      message: '',
      error: false,
    };
  },
  methods: {
    async handleLogin() {
      this.message = '';
      this.error = false;

      try {
        const response = await axios.post('http://localhost:3000/api/login', {
          username: this.username,
          password: this.password,
        });
        
        this.message = response.data.message + ' Redirecting...';
        setTimeout(() => {
          this.$emit('login-success', response.data);
        }, 1500);

      } catch (err) {
        this.error = true;
        this.message = err.response ? err.response.data.message : 'Login failed. Server error.';
        console.error(err);
      }
    },
  },
};
</script>

<style scoped>
.login-container {
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
.success {
    color: green;
}
.error {
    color: red;
}
</style>
