<template>
  <div class="contact-page">
    <div class="page-header">
      <h1>Contact Us</h1>
      <p>Have a question or feedback? We'd love to hear from you.</p>
    </div>

    <div class="content">
      <div class="contact-form-section">
        <h2>Get In Touch</h2>
        <form @submit.prevent="submitForm" class="contact-form">
          <div class="form-group">
            <label for="name">Name</label>
            <input
              id="name"
              v-model="form.name"
              type="text"
              placeholder="Your name"
              required
            />
          </div>

          <div class="form-group">
            <label for="email">Email</label>
            <input
              id="email"
              v-model="form.email"
              type="email"
              placeholder="your.email@example.com"
              required
            />
          </div>

          <div class="form-group">
            <label for="subject">Subject</label>
            <input
              id="subject"
              v-model="form.subject"
              type="text"
              placeholder="What's this about?"
              required
            />
          </div>

          <div class="form-group">
            <label for="message">Message</label>
            <textarea
              id="message"
              v-model="form.message"
              placeholder="Tell us your thoughts..."
              rows="6"
              required
            ></textarea>
          </div>

          <button type="submit" class="submit-btn">Send Message</button>
        </form>

        <p v-if="submitMessage" class="submit-message">{{ submitMessage }}</p>
      </div>

      <div class="contact-info-section">
        <h2>Other Ways to Reach Us</h2>
        <div class="info-item">
          <h3>Email</h3>
          <p>contact@complaintregistry.com</p>
        </div>
        <div class="info-item">
          <h3>Social Media</h3>
          <p>Follow us on Twitter, Facebook, and Instagram @ComplaintRegistry</p>
        </div>
        <div class="info-item">
          <h3>Response Time</h3>
          <p>We typically respond to inquiries within 24-48 hours.</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";

const form = ref({
  name: "",
  email: "",
  subject: "",
  message: "",
});

const submitMessage = ref("");
</script>

<style scoped>
.contact-page {
  max-width: 1000px;
  margin: 0 auto;
  padding: 40px 20px;
}

.page-header {
  text-align: center;
  margin-bottom: 50px;
  padding-bottom: 20px;
  border-bottom: 3px solid #667eea;
}

.page-header h1 {
  font-size: 36px;
  color: #2c3e50;
  margin: 0 0 10px 0;
}

.page-header p {
  color: #7f8c8d;
  font-size: 16px;
  margin: 0;
}

.content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 40px;
}

@media (max-width: 768px) {
  .content {
    grid-template-columns: 1fr;
  }
}

.contact-form-section,
.contact-info-section {
  background: #f9f9f9;
  padding: 30px;
  border-radius: 8px;
}

h2 {
  color: #2c3e50;
  font-size: 22px;
  margin-top: 0;
}

.contact-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-group label {
  font-weight: 600;
  color: #2c3e50;
  font-size: 14px;
}

.form-group input,
.form-group textarea {
  padding: 10px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  font-family: inherit;
  transition: border-color 0.3s;
}

.form-group input:focus,
.form-group textarea:focus {
  outline: none;
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.submit-btn {
  padding: 12px 24px;
  background: #667eea;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: background 0.3s;
  margin-top: 10px;
}

.submit-btn:hover {
  background: #5568d3;
}

.submit-message {
  color: #27ae60;
  background: #ecfdf5;
  padding: 12px;
  border-radius: 6px;
  font-size: 14px;
}

.info-item {
  margin-bottom: 25px;
}

.info-item h3 {
  color: #2c3e50;
  font-size: 16px;
  margin: 0 0 8px 0;
}

.info-item p {
  color: #555;
  line-height: 1.6;
  margin: 0;
}
</style>
