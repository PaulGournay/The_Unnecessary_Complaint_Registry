<template>
  <div id="app">
    <header>
      <h1>The Overly Specific Complaint Registry</h1>
      <nav>
        <button v-if="!user" @click="currentView = 'Login'">Login</button>
        <button v-if="!user" @click="currentView = 'Register'">Register</button>
        <template v-if="user">
          <span>Welcome, {{ user.username }} ({{ user.role }})!</span>
          <button @click="currentView = 'ComplaintList'">Registry</button>
          <button @click="logout">Logout</button>
        </template>
      </nav>
    </header>

    <div class="content">
      <Register v-if="currentView === 'Register'" @registered="currentView = 'Login'" />
      <Login v-else-if="currentView === 'Login'" @login-success="handleLogin" />
      <ComplaintList v-else-if="user" :user="user" :token="token" />
      <div v-else>
        <h2>Please Login or Register to view the complaints.</h2>
      </div>
    </div>
  </div>
</template>

<script>
import Login from './components/UserLogin.vue';
import Register from './components/UserRegister.vue';
import ComplaintList from './components/ComplaintList.vue';

export default {
  name: 'App',
  components: {
    Login,
    Register,
    ComplaintList,
  },
  data() {
    return {
      user: null, // Stores { id, username, role }
      token: null, // Stores JWT
      currentView: 'Login', 
    };
  },
  methods: {
    handleLogin(data) {
      this.user = data.user;
      this.token = data.token;
      // Store token in local storage for persistence
      localStorage.setItem('userToken', this.token);
      localStorage.setItem('userInfo', JSON.stringify(this.user));
      this.currentView = 'ComplaintList';
    },
    logout() {
      this.user = null;
      this.token = null;
      localStorage.removeItem('userToken');
      localStorage.removeItem('userInfo');
      this.currentView = 'Login';
    },
    checkLocalStorage() {
      const storedToken = localStorage.getItem('userToken');
      const storedUser = localStorage.getItem('userInfo');
      if (storedToken && storedUser) {
        this.token = storedToken;
        this.user = JSON.parse(storedUser);
        this.currentView = 'ComplaintList';
      }
    }
  },
  mounted() {
    this.checkLocalStorage();
  }
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  text-align: center;
  color: #2c3e50;
}
header {
  padding: 20px;
  background-color: #f4f4f4;
  border-bottom: 2px solid #ddd;
}
nav button {
    margin-left: 10px;
}
.content {
    padding: 20px;
}
</style>