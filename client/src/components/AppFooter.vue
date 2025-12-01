<template>
  <footer class="footer">
    <div class="footer-container">
      <div class="footer-section">
        <h3 class="footer-title">The Unnecessary Complaint Registry</h3>
        <p class="footer-description">
          A platform dedicated to the art of hyper-specific complaints.
        </p>
      </div>

      <div class="footer-section">
        <h4 class="footer-subtitle">Quick Links</h4>
        <nav class="footer-nav">
          <button @click="$emit('navigate', 'Home')" class="footer-link">Home</button>
          <button @click="$emit('navigate', 'About')" class="footer-link">About</button>
          <button @click="$emit('navigate', 'Contact')" class="footer-link">
            Contact
          </button>
        </nav>
      </div>

      <div class="footer-section">
        <h4 class="footer-subtitle">Legal</h4>
        <nav class="footer-nav">
          <button @click="$emit('navigate', 'Privacy')" class="footer-link">
            Privacy Policy
          </button>
          <button @click="$emit('navigate', 'Terms')" class="footer-link">
            Terms of Service
          </button>
        </nav>
      </div>
    </div>

    <div class="footer-bottom">
      <p>&copy; 2025 The Unnecessary Complaint Registry. All rights reserved.</p>
    </div>
  </footer>
</template>

<script setup></script>

<style scoped>
.footer {
  background: linear-gradient(135deg, #f5f5f5 0%, #e8e8e8 100%);
  border-top: 2px solid #d0d0d0;
  padding: 40px 20px 20px;
  margin-top: auto;
  font-family: inherit;
}

.footer-container {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  margin-bottom: 30px;
}

.footer-section {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.footer-title {
  font-size: 18px;
  font-weight: 600;
  color: #2c3e50;
  margin: 0;
}

.footer-subtitle {
  font-size: 14px;
  font-weight: 600;
  color: #34495e;
  margin: 0;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  align-self: center;
}

.footer-description {
  font-size: 13px;
  color: #7f8c8d;
  margin: 0;
  line-height: 1.5;
}

.footer-nav {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.footer-link {
  font-size: 13px;
  color: #7f8c8d;
  text-decoration: none;
  transition: color 0.3s ease;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0;
  font-family: inherit;
}

.footer-link:hover {
  color: #2c3e50;
  text-decoration: underline;
}

.footer-bottom {
  max-width: 1200px;
  margin: 0 auto;
  padding-top: 20px;
  border-top: 1px solid #bdc3c7;
  text-align: center;
  font-size: 12px;
  color: #7f8c8d;
}
</style>
