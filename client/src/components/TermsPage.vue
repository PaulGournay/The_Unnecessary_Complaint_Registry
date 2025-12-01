<template>
  <div class="policy-page">
    <div class="page-header">
      <h1>Terms of Service</h1>
    </div>

    <div class="content">
      <section class="policy-section">
        <h2>1. Acceptance of Terms</h2>
        <p>
          By using The Unnecessary Complaint Registry, you agree to abide by these terms
          of service. If you do not agree, please do not use our platform.
        </p>
      </section>

      <section class="policy-section">
        <h2>2. User Accounts</h2>
        <p>
          You are responsible for maintaining the confidentiality of your account
          credentials. You agree to provide accurate information during registration and
          to keep your information up to date. You are responsible for all activity that
          occurs under your account.
        </p>
      </section>

      <section class="policy-section">
        <h2>3. User Conduct</h2>
        <p>Users agree not to:</p>
        <ul>
          <li>Submit complaints that are illegal, harmful, or abusive</li>
          <li>Harass, bully, or discriminate against other users</li>
          <li>Post spam, advertisements, or malware</li>
          <li>Impersonate other users or claim false identities</li>
          <li>Attempt to gain unauthorized access to our systems</li>
        </ul>
      </section>

      <section class="policy-section">
        <h2>4. Content Ownership</h2>
        <p>
          Users retain ownership of the complaints they submit. By submitting content to
          our registry, you grant us the right to display, archive, and share your
          complaints publicly on our platform.
        </p>
      </section>

      <section class="policy-section">
        <h2>5. Archivist Responsibilities</h2>
        <p>
          Archivists have been granted special privileges to maintain the registry. They
          agree to:
        </p>
        <ul>
          <li>Act in good faith and in the best interest of the community</li>
          <li>Remove complaints that violate these terms</li>
          <li>Keep the registry organized and well-maintained</li>
          <li>Not abuse their deletion privileges</li>
        </ul>
      </section>

      <section class="policy-section">
        <h2>6. Limitation of Liability</h2>
        <p>
          The Unnecessary Complaint Registry is provided "as is." We are not liable for
          any indirect, incidental, or consequential damages arising from your use of our
          platform.
        </p>
      </section>

      <section class="policy-section">
        <h2>7. Termination</h2>
        <p>
          We reserve the right to terminate or suspend accounts that violate these terms
          or engage in harmful behavior. Users may delete their accounts at any time.
        </p>
      </section>

      <section class="policy-section">
        <h2>8. Changes to Terms</h2>
        <p>
          We may modify these terms at any time. Continued use of the platform constitutes
          acceptance of the updated terms.
        </p>
      </section>

      <section class="policy-section">
        <h2>9. Contact for Legal Inquiries</h2>
        <p>
          For legal inquiries or concerns, please contact us at
          <a href="mailto:legal@complaintregistry.com">legal@complaintregistry.com</a>
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
