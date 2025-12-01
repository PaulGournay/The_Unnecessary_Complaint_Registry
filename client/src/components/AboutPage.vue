<template>
  <div class="about-page">
    <div class="page-header">
      <h1>About Us</h1>
    </div>
    <section class="team-section">
      <h2>Meet the Team</h2>
      <p class="team-intro">
        We are EFREI Paris students currently on a mobility study exchange at APU Kuala
        Lumpur. This project was created as part of our Advanced Web Programming course.
      </p>

      <div class="team-grid">
        <div class="team-member">
          <div class="member-image-wrapper">
            <img
              src="../assets/about_image/about_Paul.png"
              alt="Paul GOURNAY"
              class="member-image"
            />
          </div>
          <h3 class="member-name">Paul GOURNAY</h3>
        </div>

        <div class="team-member">
          <div class="member-image-wrapper">
            <img
              src="../assets/about_image/about_Maxime.jpeg"
              alt="Maxime BERGER"
              class="member-image"
            />
          </div>
          <h3 class="member-name">Maxime BERGER</h3>
        </div>

        <div class="team-member">
          <div class="member-image-wrapper">
            <img
              src="../assets/about_image/about_Clayton.png"
              alt="Clayton HABYALIMANA"
              class="member-image"
            />
          </div>
          <h3 class="member-name">Clayton HABYALIMANA</h3>
        </div>
      </div>
    </section>

    <div class="content">
      <section class="section">
        <h2>Our Mission</h2>
        <p>
          To provide a safe haven for the expression of extraordinarily specific
          complaints. We believe that every grievance, no matter how niche, deserves to be
          documented, shared, and appreciated by those who understand.
        </p>
      </section>

      <section class="section">
        <h2>Why This Exists</h2>
        <p>
          Sometimes the most relatable complaints are the ones only you seem to have. That
          specific sound your refrigerator makes. That particular way your phone screen
          gets smudged. The unique arrangement of steps that causes your foot to land
          wrong. These are the moments we celebrate.
        </p>
      </section>

      <section class="section">
        <h2>Our Community</h2>
        <p>We have two types of users:</p>
        <ul>
          <li>
            <strong>Complainers:</strong> People who lodge and upvote complaints. You know
            who you are.
          </li>
          <li>
            <strong>Archivists:</strong> Dedicated individuals who maintain the integrity
            of our registry and keep things organized.
          </li>
        </ul>
      </section>

      <section class="section">
        <h2>How We Started</h2>
        <p>
          This registry was born from a simple observation: complaints are often dismissed
          as negativity, when in fact they're expressions of standards and expectations.
          We've created a space where specificity is celebrated, and shared grievances
          create community.
        </p>
      </section>
    </div>
  </div>
</template>

<script setup></script>

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
  border-bottom: 3px solid #1a1a1a;
}

.page-header h1 {
  font-size: 36px;
  color: #1a1a1a;
  margin: 0;
  font-weight: 700;
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
  border-left: 4px solid #1a1a1a;
}

.section h2 {
  margin-top: 0;
  color: #1a1a1a;
  font-size: 22px;
  font-weight: 700;
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

/* Team Section */
.team-section {
  padding: 40px;
  background: white;
  border-radius: 8px;
  border: 1px solid #e0e0e0;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.team-section h2 {
  text-align: center;
  color: #1a1a1a;
  font-size: 28px;
  margin: 0 0 15px 0;
  font-weight: 700;
}

.team-intro {
  text-align: center;
  color: #666;
  font-size: 16px;
  margin: 0 0 40px 0;
  line-height: 1.6;
}

.team-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 40px;
  margin-top: 40px;
}

.team-member {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.member-image-wrapper {
  width: 200px;
  height: 200px;
  margin-bottom: 20px;
  border-radius: 50%;
  overflow: hidden;
  border: 3px solid #1a1a1a;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f5f5f5;
}

.member-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.member-name {
  font-size: 20px;
  font-weight: 700;
  color: #1a1a1a;
  margin: 0 0 10px 0;
}

/* Responsive Design */
@media (max-width: 768px) {
  .page-header {
    margin-bottom: 30px;
  }

  .page-header h1 {
    font-size: 28px;
  }

  .content {
    gap: 25px;
  }

  .section {
    padding: 20px;
  }

  .section h2 {
    font-size: 18px;
  }

  .team-grid {
    grid-template-columns: 1fr;
    gap: 30px;
  }

  .member-image-wrapper {
    width: 150px;
    height: 150px;
  }

  .member-name {
    font-size: 18px;
  }
}
</style>
