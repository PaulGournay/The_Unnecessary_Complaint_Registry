<template>
  <div class="home-page">
    <!-- Hero Section -->
    <section class="hero">
      <div class="hero-content">
        <h1 class="hero-title">Welcome to The Unnecessary Complaint Registry</h1>
        <p class="hero-subtitle">Where every grievance finds its perfect niche</p>
        <div class="hero-actions">
          <button @click="$emit('navigate', 'Login')" class="btn-primary">Login</button>
          <button @click="$emit('navigate', 'Register')" class="btn-secondary">
            Register
          </button>
        </div>
      </div>
    </section>

    <!-- Main Content -->
    <div class="content-wrapper">
      <!-- What is This? -->
      <section class="info-section">
        <div class="section-content">
          <h2>What is This?</h2>
          <p>
            Ever experienced a complaint so specific that nobody else could possibly
            understand how much it bothers you? You've come to the right place. Our
            registry celebrates the art of hyper-specific complaints, from the existential
            dread of laundry to acoustic annoyances that drive you up the wall.
          </p>
        </div>
      </section>

      <!-- How It Works -->
      <section class="info-section">
        <div class="section-content">
          <h2>How It Works</h2>
          <ol class="steps-list">
            <li>
              <strong>Register:</strong> Create an account to join our community of
              complainers.
            </li>
            <li>
              <strong>Lodge Your Complaint:</strong> Submit your most specific grievance
              with all the glorious detail.
            </li>
            <li>
              <strong>Upvote:</strong> Help others discover complaints they didn't know
              they shared.
            </li>
            <li>
              <strong>Archive:</strong> Archivists keep our collection organized and
              pristine.
            </li>
          </ol>
        </div>
      </section>

      <!-- Categories -->
      <section class="info-section">
        <div class="section-content">
          <h2>Browse Our Categories</h2>
          <div class="categories-grid">
            <div class="category-card">
              <h3>🔊 Acoustic Annoyances</h3>
              <p>Noises that make you want to scream</p>
            </div>
            <div class="category-card">
              <h3>👖 Pocket Problems</h3>
              <p>Wardrobe-related frustrations</p>
            </div>
            <div class="category-card">
              <h3>👕 Existential Dread of Laundry</h3>
              <p>The emotional toll of cleaning</p>
            </div>
          </div>
        </div>
      </section>

      <!-- CTA Section -->
      <section class="cta-section">
        <h2>Ready to Share Your Complaint?</h2>
        <p>Join thousands of complainers who understand the art of specificity.</p>
        <div class="cta-actions">
          <button @click="$emit('navigate', 'Register')" class="btn-primary-large">
            Get Started Now
          </button>
          <button @click="$emit('navigate', 'Login')" class="btn-secondary-large">
            Already a Member? Login
          </button>
        </div>
      </section>
    </div>

    <!-- Floating Action Buttons (Always Visible) -->
    <div class="floating-actions">
      <button
        @click="$emit('navigate', 'Login')"
        class="float-btn login-btn"
        title="Login"
      >
        <span>Login</span>
      </button>
      <button
        @click="$emit('navigate', 'Register')"
        class="float-btn register-btn"
        title="Register"
      >
        <span>Register</span>
      </button>
    </div>
  </div>
</template>

<style scoped>
.home-page {
  min-height: 100vh;
  background: #fafafa;
  position: relative;
}

/* Hero Section */
.hero {
  background-image: linear-gradient(rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0.5)),
    url("../assets/HomePageBG.png");
  background-size: cover;
  background-position: center;
  padding: 80px 30px;
  text-align: center;
  border-bottom: 1px solid #e0e0e0;
  border-radius: 20px;
}

.hero-content {
  max-width: 800px;
  margin: 0 auto;
}

.hero-title {
  font-size: 42px;
  font-weight: 700;
  color: #1a1a1a;
  margin: 0 0 20px 0;
  line-height: 1.2;
}

.hero-subtitle {
  font-size: 20px;
  color: #666;
  margin: 0 0 40px 0;
}

.hero-actions {
  display: flex;
  gap: 15px;
  justify-content: center;
  flex-wrap: wrap;
}

.btn-primary {
  background: #1a1a1a;
  color: white;
  border: none;
  padding: 12px 32px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-primary:hover {
  background: #333;
  box-shadow: 0 4px 12px rgba(26, 26, 26, 0.2);
}

.btn-secondary {
  background: transparent;
  color: #1a1a1a;
  border: 2px solid #1a1a1a;
  padding: 10px 30px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-secondary:hover {
  background: #1a1a1a;
  color: white;
}

/* Content Wrapper */
.content-wrapper {
  max-width: 1000px;
  margin: 0 auto;
  padding: 60px 30px;
}

.info-section {
  margin-bottom: 60px;
}

.section-content {
  background: white;
  padding: 40px;
  border-radius: 8px;
  border: 1px solid #e0e0e0;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.info-section h2 {
  font-size: 28px;
  color: #1a1a1a;
  margin: 0 0 20px 0;
  font-weight: 700;
}

.info-section p {
  color: #555;
  line-height: 1.8;
  margin: 0;
  font-size: 16px;
}

.steps-list {
  color: #555;
  line-height: 2;
  margin: 0;
  padding-left: 25px;
}

.steps-list li {
  margin: 15px 0;
  font-size: 16px;
}

.categories-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  margin-top: 20px;
}

.category-card {
  background: #f9f9f9;
  padding: 25px;
  border-radius: 8px;
  border: 1px solid #e8e8e8;
  text-align: center;
  transition: all 0.3s ease;
}

.category-card:hover {
  border-color: #1a1a1a;
  box-shadow: 0 4px 12px rgba(26, 26, 26, 0.1);
}

.category-card h3 {
  font-size: 18px;
  color: #1a1a1a;
  margin: 0 0 10px 0;
}

.category-card p {
  color: #888;
  margin: 0;
  font-size: 14px;
}

/* CTA Section */
.cta-section {
  background: white;
  padding: 60px 40px;
  border-radius: 8px;
  border: 1px solid #e0e0e0;
  text-align: center;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.cta-section h2 {
  font-size: 32px;
  color: #1a1a1a;
  margin: 0 0 15px 0;
  font-weight: 700;
}

.cta-section > p {
  font-size: 18px;
  color: #666;
  margin: 0 0 35px 0;
}

.cta-actions {
  display: flex;
  gap: 15px;
  justify-content: center;
  flex-wrap: wrap;
}

.btn-primary-large {
  background: #1a1a1a;
  color: white;
  border: none;
  padding: 14px 40px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-primary-large:hover {
  background: #333;
  box-shadow: 0 4px 12px rgba(26, 26, 26, 0.2);
}

.btn-secondary-large {
  background: transparent;
  color: #1a1a1a;
  border: 2px solid #1a1a1a;
  padding: 12px 38px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-secondary-large:hover {
  background: #1a1a1a;
  color: white;
}

/* Floating Action Buttons */
.floating-actions {
  position: fixed;
  right: 30px;
  bottom: 30px;
  display: flex;
  flex-direction: column;
  gap: 15px;
  z-index: 1000;
}

.float-btn {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  border: none;
  font-weight: 600;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  transition: all 0.3s ease;
  font-size: 12px;
  color: white;
}

.login-btn {
  background: #1a1a1a;
}

.login-btn:hover {
  background: #333;
  transform: scale(1.1);
  box-shadow: 0 6px 16px rgba(26, 26, 26, 0.3);
}

.register-btn {
  background: #1a1a1a;
}

.register-btn:hover {
  background: #333;
  transform: scale(1.1);
  box-shadow: 0 6px 16px rgba(26, 26, 26, 0.3);
}

/* Responsive Design */
@media (max-width: 768px) {
  .hero {
    padding: 50px 20px;
  }

  .hero-title {
    font-size: 28px;
  }

  .hero-subtitle {
    font-size: 16px;
  }

  .content-wrapper {
    padding: 40px 20px;
  }

  .section-content {
    padding: 25px;
  }

  .info-section h2 {
    font-size: 22px;
  }

  .floating-actions {
    right: 15px;
    bottom: 15px;
    gap: 10px;
  }

  .float-btn {
    width: 50px;
    height: 50px;
    font-size: 10px;
  }
}
</style>
