<template>
  <div id="app" class="flex flex-col min-h-screen">
    <header class="app-header">
      <div class="header-left">
        <div class="logo-container" @click="currentView = 'Home'">
          <img src="./assets/logo.png" alt="Logo" class="header-logo" />
        </div>
        <h1 class="header-title">Unnecessary Complaint Registery</h1>
      </div>

      <nav class="header-nav">
        <div class="nav-links" v-if="!user">
          <button @click="currentView = 'Home'" class="nav-button">Home</button>
          <button @click="currentView = 'About'" class="nav-button">About</button>
          <button @click="currentView = 'Contact'" class="nav-button">Contact</button>
        </div>

        <div class="nav-links" v-else>
          <button
            @click="currentView = 'ComplaintList'"
            class="nav-button"
            :class="{ active: currentView === 'ComplaintList' }"
          >
            Complaints
          </button>

          <div class="user-profile-nav" @click="currentView = 'UserProfile'">
            <div class="pfp-circle">
              <img :src="getUserPfpUrl(user.pfp)" alt="PFP" class="pfp-img" />
            </div>
            <button class="user-welcome-btn">
              {{ user.username }}
            </button>
          </div>
        </div>

        <div class="auth-buttons">
          <template v-if="!user">
            <button @click="currentView = 'Login'" class="btn-ios-text">Log In</button>
            <button @click="currentView = 'Register'" class="btn-ios-primary">
              Register
            </button>
          </template>

          <template v-else>
            <span class="user-role" v-if="user.role === 'archivist'">(Admin)</span>
            <button @click="logout" class="btn-ios-text destructive">Log Out</button>
          </template>
        </div>
      </nav>
    </header>

    <div class="content flex-1">
      <HomePage v-if="currentView === 'Home'" @navigate="currentView = $event" />
      <AboutPage v-else-if="currentView === 'About'" @navigate="currentView = $event" />
      <ContactPage
        v-else-if="currentView === 'Contact'"
        @navigate="currentView = $event"
      />
      <PrivacyPage
        v-else-if="currentView === 'Privacy'"
        @navigate="currentView = $event"
      />
      <TermsPage v-else-if="currentView === 'Terms'" @navigate="currentView = $event" />
      <Register
        v-else-if="currentView === 'Register'"
        @registered="currentView = 'Login'"
      />
      <Login v-else-if="currentView === 'Login'" @login-success="handleLogin" />
      <ComplaintList
        v-else-if="user && currentView === 'ComplaintList'"
        :user="user"
        :token="token"
      />
      <UserProfile
        v-else-if="user && currentView === 'UserProfile'"
        :user="user"
        :token="token"
        @user-updated="handleUserUpdate"
      />
      <div v-else-if="!user && currentView === 'ComplaintList'">
        <h2>Please Login or Register to view the complaints.</h2>
      </div>
    </div>

    <AppFooter @navigate="currentView = $event" />
  </div>
</template>

<script>
import Login from "./components/UserLogin.vue";
import Register from "./components/UserRegister.vue";
import ComplaintList from "./components/ComplaintList.vue";
import AppFooter from "./components/AppFooter.vue";
import HomePage from "./components/HomePage.vue";
import AboutPage from "./components/AboutPage.vue";
import ContactPage from "./components/ContactPage.vue";
import PrivacyPage from "./components/PrivacyPage.vue";
import TermsPage from "./components/TermsPage.vue";
import UserProfile from "./components/UserProfile.vue";
import pfp1 from "@/assets/pfp_image/pfp1.jpeg";
import pfp2 from "@/assets/pfp_image/pfp2.jpeg";
import pfp3 from "@/assets/pfp_image/pfp3.jpeg";
import pfp4 from "@/assets/pfp_image/pfp4.jpeg";
export default {
  name: "App",
  components: {
    Login,
    Register,
    ComplaintList,
    AppFooter,
    HomePage,
    AboutPage,
    ContactPage,
    PrivacyPage,
    TermsPage,
    UserProfile,
  },
  data() {
    return {
      user: null, // Stores { id, username, role }
      token: null, // Stores JWT
      currentView: "Home",
      pfpMap: {
        "pfp1.jpeg": pfp1,
        "pfp2.jpeg": pfp2,
        "pfp3.jpeg": pfp3,
        "pfp4.jpeg": pfp4,
      },
    };
  },
  methods: {
    handleLogin(data) {
      this.user = data.user;
      this.token = data.token;
      // Store token in local storage for persistence
      localStorage.setItem("userToken", this.token);
      localStorage.setItem("userInfo", JSON.stringify(this.user));
      this.currentView = "ComplaintList";
    },
    logout() {
      this.user = null;
      this.token = null;
      localStorage.removeItem("userToken");
      localStorage.removeItem("userInfo");
      this.currentView = "Home";
    },
    checkLocalStorage() {
      const storedToken = localStorage.getItem("userToken");
      const storedUser = localStorage.getItem("userInfo");
      if (storedToken && storedUser) {
        this.token = storedToken;
        this.user = JSON.parse(storedUser);
        this.currentView = "ComplaintList";
      }
    },
    handleUserUpdate(updatedUser) {
      this.user = updatedUser;
      // Update local storage so refresh keeps the new pic
      localStorage.setItem("userInfo", JSON.stringify(this.user));
    },
    getUserPfpUrl(pfpName) {
      if (!pfpName) pfpName = "pfp1.jpeg";
      return this.pfpMap[pfpName] || this.pfpMap["pfp1.jpeg"];
    },
  },
  mounted() {
    this.checkLocalStorage();
  },
};
</script>

<style>
/* --- Global Reset & Font --- */
body, html {
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  box-sizing: border-box;
}
#app {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial,
    sans-serif;
  -webkit-font-smoothing: antialiased;
  color: #1c1c1e; /* iOS nearly black */
  background-color: #f2f2f7; /* iOS Grouped Background */
  min-height: 100vh;
}


/* --- Glassmorphic Header --- */
.app-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 25px;

  /* The iOS Glass Effect */
  background-color: rgba(255, 255, 255, 0.35);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(253, 119, 119, 0.1);

  /* Make it sticky */
  position: sticky;
  top: 0;
  z-index: 1000;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 12px;
  cursor: pointer;
}

.header-logo {
  height: 120px;
  width: 120px;
  border-radius: 8px;
  object-fit: contain;
}

.header-title {
  font-size: 30px;
  font-weight: 600;
  color: #000;
  margin: 0;
  letter-spacing: -0.5px; /* Tighter tracking like iOS */
}

/* --- Navigation --- */
.header-nav {
  display: flex;
  align-items: center;
  gap: 20px;
}

.nav-links {
  display: flex;
  gap: 8px;
}

.nav-button {
  background: transparent;
  border: none;
  color: #007aff; /* Apple Blue */
  font-size: 16px;
  padding: 8px 16px;
  border-radius: 20px; /* Pill shape */
  cursor: pointer;
  transition: background-color 0.2s;
}

.nav-button:hover {
  background-color: rgba(0, 122, 255, 0.1);
}

.nav-button.active {
  background-color: rgba(0, 122, 255, 0.1);
  font-weight: 600;
}

/* --- Profile Pill --- */
.user-profile-nav {
  display: flex;
  align-items: center;
  gap: 10px;
  background-color: rgba(118, 118, 128, 0.12); /* iOS Gray Fill */
  padding: 4px 12px 4px 4px; /* Offset padding for the circle */
  border-radius: 30px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.user-profile-nav:hover {
  background-color: rgba(118, 118, 128, 0.2);
}

.pfp-circle {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  overflow: hidden;
  background-color: #fff;
}

.pfp-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.user-welcome-btn {
  background: none;
  border: none;
  font-weight: 500;
  font-size: 14px;
  color: #000;
  cursor: pointer;
}

/* --- Auth Buttons (iOS Style) --- */
.auth-buttons {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-left: 10px;
  padding-left: 10px;
  border-left: 1px solid #e5e5ea;
}

.btn-ios-text {
  background: none;
  border: none;
  color: #007aff;
  font-size: 16px;
  cursor: pointer;
  font-weight: 400;
}
.btn-ios-text:hover {
  text-decoration: underline;
}

.btn-ios-text.destructive {
  color: #ff3b30; /* iOS Red */
}

.btn-ios-primary {
  background-color: #007aff;
  color: white;
  border: none;
  padding: 6px 16px;
  border-radius: 18px;
  font-size: 15px;
  font-weight: 600;
  cursor: pointer;
}
.btn-ios-primary:hover {
  background-color: #005ecb;
}

.user-role {
  font-size: 12px;
  color: #8e8e93;
  font-weight: 600;
  text-transform: uppercase;
}

/* --- Mobile --- */
@media (max-width: 768px) {
  .app-header {
    flex-direction: column;
    gap: 12px;
    padding: 15px;
  }

  .auth-buttons {
    border-left: none;
    margin-left: 0;
  }

  .header-title {
    font-size: 18px;
  }
}
</style>
