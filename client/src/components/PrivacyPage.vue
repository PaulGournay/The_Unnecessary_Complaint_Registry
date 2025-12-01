<template>
  <div class="policy-page">
    <div class="page-header">
      <h1>Privacy Policy</h1>
    </div>

    <div class="content">
      <section class="policy-section">
        <h2>1. Information We Collect</h2>
        <p>
          We collect information you provide directly to us, such as when you register an
          account or submit complaints:
        </p>
        <ul>
          <li>Username and password (securely hashed)</li>
          <li>Email address (if provided)</li>
          <li>Complaint details and category selections</li>
          <li>User role (complainer or archivist)</li>
        </ul>
      </section>

      <section class="policy-section">
        <h2>2. How We Use Your Information</h2>
        <p>We use the information we collect to:</p>
        <ul>
          <li>Create and maintain your account</li>
          <li>Display your complaints in the registry</li>
          <li>Allow other users to upvote and interact with your complaints</li>
          <li>Maintain the integrity of our platform</li>
        </ul>
      </section>

      <section class="policy-section">
        <h2>3. Data Security</h2>
        <p>
          Your password is hashed using industry-standard bcrypt encryption. We use JWT
          tokens for secure authentication. All data is stored in our secure MySQL
          database.
        </p>
      </section>

      <section class="policy-section">
        <h2>4. Your Rights</h2>
        <p>
          You have the right to access, modify, or delete your account and associated
          complaints at any time. Archivists have the authority to remove complaints that
          violate our community standards.
        </p>
      </section>

      <section class="policy-section">
        <h2>5. Third-Party Services</h2>
        <p>
          We do not sell or share your personal information with third parties. Our
          platform is self-contained and does not integrate with external tracking
          services.
        </p>
      </section>

      <section class="policy-section">
        <h2>6. Changes to This Policy</h2>
        <p>
          We may update this privacy policy from time to time. We will notify users of any
          material changes by posting the updated policy on our site.
        </p>
      </section>

      <section class="policy-section">
        <h2>7. Contact Us</h2>
        <p>
          If you have questions about this privacy policy, please contact us at
          <a href="mailto:privacy@complaintregistry.com">privacy@complaintregistry.com</a>
        </p>
      </section>
    </div>
  </div>
</template>

<script setup></script>

<style scoped>
.policy-page {
  max-width: 900px;
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
  margin: 0;
}

.content {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.policy-section {
  padding: 25px;
  background: #f9f9f9;
  border-radius: 8px;
  border-left: 4px solid #667eea;
}

.policy-section h2 {
  margin-top: 0;
  color: #2c3e50;
  font-size: 20px;
}

.policy-section p {
  color: #555;
  line-height: 1.7;
  margin: 15px 0;
}

.policy-section ul {
  color: #555;
  line-height: 1.8;
  margin: 15px 0;
  padding-left: 20px;
}

.policy-section li {
  margin: 8px 0;
}

.policy-section a {
  color: #667eea;
  text-decoration: none;
}

.policy-section a:hover {
  text-decoration: underline;
}
</style>
