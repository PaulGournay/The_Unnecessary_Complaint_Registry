<template>
  <div class="home-page">
    <div class="hero">
      <h1 class="hero-title">Welcome to The Overly Specific Complaint Registry</h1>
      <p class="hero-subtitle">Where every grievance finds its perfect niche</p>
    </div>

    <div class="content">
      <section class="feature-section">
        <h2>What is This?</h2>
        <p>
          Ever experienced a complaint so specific that nobody else could possibly understand how much it bothers you? 
          You've come to the right place. Our registry celebrates the art of hyper-specific complaints, from 
          the existential dread of laundry to acoustic annoyances that drive you up the wall.
        </p>
      </section>

      <section class="feature-section">
        <h2>How It Works</h2>
        <ol>
          <li><strong>Register:</strong> Create an account to join our community of complainers.</li>
          <li><strong>Lodge Your Complaint:</strong> Submit your most specific grievance with all the glorious detail.</li>
          <li><strong>Upvote:</strong> Help others discover complaints they didn't know they shared.</li>
          <li><strong>Archive:</strong> Archivists keep our collection organized and pristine.</li>
        </ol>
      </section>

      <section class="feature-section">
        <h2>Categories</h2>
        <p>Browse complaints across various categories:</p>
        <ul>
          <li>Acoustic Annoyances</li>
          <li>Pocket Problems</li>
          <li>Existential Dread of Laundry</li>
          <li>...and more!</li>
        </ul>
      </section>
    </div>
  </div>
</template>

<script setup>
</script>

<style scoped>
.home-page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
}

.hero {
  text-align: center;
  margin-bottom: 60px;
  padding: 40px 20px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border-radius: 10px;
}

.hero-title {
  font-size: 36px;
  font-weight: 700;
  margin: 0 0 15px 0;
}

.hero-subtitle {
  font-size: 18px;
  opacity: 0.9;
  margin: 0;
}

.content {
  display: flex;
  flex-direction: column;
  gap: 40px;
}

.feature-section {
  padding: 30px;
  background: #f5f5f5;
  border-radius: 8px;
  border-left: 4px solid #667eea;
}

.feature-section h2 {
  margin-top: 0;
  color: #2c3e50;
  font-size: 24px;
}

.feature-section p {
  color: #555;
  line-height: 1.6;
  margin: 15px 0;
}

.feature-section ol,
.feature-section ul {
  color: #555;
  line-height: 1.8;
}

.feature-section li {
  margin: 10px 0;
}
</style>
