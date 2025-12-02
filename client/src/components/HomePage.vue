<template>
  <div class="home-container">
    
    <div class="hero-wrapper">
      <section class="hero-section">
        <div class="hero-content">
          <span class="hero-badge">Now Open for Submission</span>
          <h1 class="hero-title">The Unnecessary<br>Complaint Registry</h1>
          <p class="hero-subtitle">
            A sanctuary for grievances so specific, so petty, and so incredibly low-stakes that they deserve to be archived forever.
          </p>
          
          <div class="hero-actions">
            <button @click="$emit('navigate', 'Register')" class="ios-btn-primary large">
              Start Complaining
            </button>
            <button @click="$emit('navigate', 'Login')" class="ios-btn-secondary">
              Log In
            </button>
          </div>
        </div>
      </section>
    </div>

    <div class="content-width">
      
      <section class="ios-section">
        <div class="section-header">
          <h2>How It Works</h2>
        </div>
        <div class="ios-card feature-list">
          <div class="feature-item">
            <div class="icon-box blue">✍️</div>
            <div class="feature-text">
              <h3>Lodge a Complaint</h3>
              <p>Submit your grievance with extreme detail. No category limits—type whatever you want.</p>
            </div>
          </div>
          <div class="separator"></div>
          <div class="feature-item">
            <div class="icon-box red">💯</div>
            <div class="feature-text">
              <h3>Specificity Score</h3>
              <p>The community votes. If your annoyance resonates, your score goes up.</p>
            </div>
          </div>
          <div class="separator"></div>
          <div class="feature-item">
            <div class="icon-box gray">🗄️</div>
            <div class="feature-text">
              <h3>The Archives</h3>
              <p>Our Archivists curate the registry, removing anything too generic or useful.</p>
            </div>
          </div>
        </div>
      </section>

      <section class="ios-section">
        <div class="section-header">
          <h2>Trending Specifics</h2>
          <span class="header-link" @click="$emit('navigate', 'Login')">View All</span>
        </div>
        <div class="ios-card padding-card">
          <p class="intro-text">
            Top-rated annoyances from our community:
          </p>
          
          <div class="tags-container">
            <span v-if="loading" class="ios-tag loading-tag">Loading trends...</span>
            
            <span 
              v-else
              v-for="complaint in topComplaints" 
              :key="complaint.id" 
              class="ios-tag"
            >
              {{ complaint.title }}
            </span>

            <span v-if="!loading && topComplaints.length === 0" class="ios-tag">
              No complaints yet. Be the first!
            </span>
          </div>

        </div>
      </section>

      <section class="cta-section">
        <h2>Have something to get off your chest?</h2>
        <p>Join the registry today. It's free and cathartic.</p>
        <button @click="$emit('navigate', 'Register')" class="ios-btn-primary">
          Create Account
        </button>
      </section>

    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "HomePage",
  // We use emits so the buttons can switch views in App.vue
  emits: ['navigate'], 
  data() {
    return {
      topComplaints: [],
      loading: true
    };
  },
  methods: {
    async fetchTrending() {
      try {
        // We use the public route that fetches all complaints
        const response = await axios.get("http://localhost:3000/api/complaints");
        
        // The API already sorts by specificity_score DESC. 
        // We just take the top 5.
        this.topComplaints = response.data.slice(0, 5);
      } catch (error) {
        console.error("Error fetching trending complaints:", error);
      } finally {
        this.loading = false;
      }
    }
  },
  mounted() {
    this.fetchTrending();
  }
};
</script>

<style scoped>
/* --- Layout & Base --- */
.home-container {
  /* iOS Grouped Background Color */
  background-color: #F2F2F7; 
  min-height: 100vh;
  padding-bottom: 60px;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
}

.content-width {
  max-width: 700px;
  margin: 0 auto;
  padding: 0 20px;
}

/* --- Hero Section --- */
.hero-wrapper {
  padding: 20px;
  max-width: 1000px;
  margin: 0 auto;
}

.hero-section {
  text-align: center;
  padding: 100px 20px;
  border-radius: 32px;
  
  /* Background Image Logic */
  background-image: linear-gradient(rgba(255, 255, 255, 0.85), rgba(255, 255, 255, 0.6)), 
                    url("../assets/HomePageBG.png");
  background-size: cover;
  background-position: center;
  
  box-shadow: 0 20px 40px rgba(0,0,0,0.08);
  margin-bottom: 20px;
  position: relative;
  overflow: hidden;
}

.hero-badge {
  background-color: rgba(0, 122, 255, 0.1);
  color: #007AFF;
  backdrop-filter: blur(10px);
  font-size: 12px;
  font-weight: 700;
  text-transform: uppercase;
  padding: 6px 12px;
  border-radius: 20px;
  letter-spacing: 0.5px;
  display: inline-block;
  margin-bottom: 16px;
}

.hero-title {
  font-size: 48px;
  font-weight: 800;
  color: #1C1C1E;
  margin: 0 0 16px 0;
  line-height: 1.1;
  letter-spacing: -1px;
}

.hero-subtitle {
  font-size: 20px;
  color: #48484a;
  max-width: 600px;
  margin: 0 auto 32px;
  line-height: 1.4;
  font-weight: 500;
}

.hero-actions {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 15px;
}

/* --- Buttons --- */
.ios-btn-primary {
  background-color: #1C1C1E;
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 100px;
  font-size: 17px;
  font-weight: 600;
  cursor: pointer;
  transition: transform 0.1s, background-color 0.2s;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.ios-btn-primary:hover {
  background-color: #333;
}

.ios-btn-primary:active {
  transform: scale(0.96);
}

.ios-btn-primary.large {
  padding: 16px 32px;
  font-size: 18px;
}

.ios-btn-secondary {
  background-color: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
  color: #1C1C1E;
  border: 1px solid rgba(0,0,0,0.05);
  padding: 16px 32px;
  border-radius: 100px;
  font-size: 18px;
  font-weight: 600;
  cursor: pointer;
  transition: background 0.2s;
}

.ios-btn-secondary:hover {
  background-color: white;
}

/* --- Content Sections --- */
.ios-section {
  margin-bottom: 30px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  margin-bottom: 10px;
  padding: 0 10px;
}

.section-header h2 {
  font-size: 20px;
  font-weight: 700;
  color: #6E6E73;
  margin: 0;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.header-link {
  color: #007AFF;
  font-size: 14px;
  cursor: pointer;
}

/* --- Cards --- */
.ios-card {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 10px rgba(0,0,0,0.03);
}

.padding-card {
  padding: 24px;
}

/* --- Feature List --- */
.feature-item {
  display: flex;
  align-items: center;
  padding: 20px;
  gap: 16px;
}

.icon-box {
  width: 40px;
  height: 40px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  flex-shrink: 0;
}
.icon-box.blue { background-color: #EAF2FF; }
.icon-box.red { background-color: #FFF0F2; }
.icon-box.gray { background-color: #F2F2F7; }

.feature-text h3 {
  margin: 0 0 4px 0;
  font-size: 17px;
  font-weight: 600;
  color: #1C1C1E;
}

.feature-text p {
  margin: 0;
  font-size: 14px;
  color: #8E8E93;
  line-height: 1.4;
}

.separator {
  height: 1px;
  background-color: #C6C6C8;
  margin-left: 76px;
}

/* --- Tags / Examples --- */
.intro-text {
  margin: 0 0 20px 0;
  color: #3A3A3C;
  font-size: 16px;
}

.tags-container {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.ios-tag {
  background-color: #F2F2F7;
  color: #007AFF;
  padding: 8px 14px;
  border-radius: 100px;
  font-size: 14px;
  font-weight: 500;
  transition: background 0.2s;
}

.ios-tag:hover {
  background-color: #EAF2FF;
}

.loading-tag {
  color: #8E8E93;
}

/* --- Bottom CTA --- */
.cta-section {
  text-align: center;
  padding: 40px 20px;
}

.cta-section h2 {
  font-size: 24px;
  font-weight: 700;
  color: #1C1C1E;
  margin: 0 0 10px 0;
}

.cta-section p {
  font-size: 16px;
  color: #8E8E93;
  margin: 0 0 20px 0;
}

/* Mobile Adjustments */
@media (max-width: 768px) {
  .hero-wrapper {
    padding: 10px;
  }
  .hero-section {
    padding: 60px 20px;
    border-radius: 24px;
  }
  .hero-title {
    font-size: 34px;
  }
  .feature-item {
    padding: 16px;
  }
  .separator {
    margin-left: 66px;
  }
}
</style>