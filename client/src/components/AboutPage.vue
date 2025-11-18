<template>
  <div class="about-page">
    <div class="page-header">
      <h1>About Us</h1>
    </div>

    <div class="content">
      <section class="section">
        <h2>Our Mission</h2>
        <p>
          To provide a safe haven for the expression of extraordinarily specific complaints. We believe that 
          every grievance, no matter how niche, deserves to be documented, shared, and appreciated by those 
          who understand.
        </p>
      </section>

      <section class="section">
        <h2>Why This Exists</h2>
        <p>
          Sometimes the most relatable complaints are the ones only you seem to have. That specific sound your 
          refrigerator makes. That particular way your phone screen gets smudged. The unique arrangement of steps 
          that causes your foot to land wrong. These are the moments we celebrate.
        </p>
      </section>

      <section class="section">
        <h2>Our Community</h2>
        <p>
          We have two types of users:
        </p>
        <ul>
          <li><strong>Complainers:</strong> People who lodge and upvote complaints. You know who you are.</li>
          <li><strong>Archivists:</strong> Dedicated individuals who maintain the integrity of our registry and keep things organized.</li>
        </ul>
      </section>

      <section class="section">
        <h2>How We Started</h2>
        <p>
          This registry was born from a simple observation: complaints are often dismissed as negativity, 
          when in fact they're expressions of standards and expectations. We've created a space where 
          specificity is celebrated, and shared grievances create community.
        </p>
      </section>
    </div>
  </div>
</template>

<script setup>
</script>

<style scoped>
.about-page {
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
  gap: 35px;
}

.section {
  padding: 25px;
  background: #f9f9f9;
  border-radius: 8px;
  border-left: 4px solid #667eea;
}

.section h2 {
  margin-top: 0;
  color: #2c3e50;
  font-size: 22px;
}

.section p {
  color: #555;
  line-height: 1.7;
  margin: 15px 0;
}

.section ul {
  color: #555;
  line-height: 1.8;
  margin: 15px 0;
}

.section li {
  margin: 10px 0;
}
</style>
