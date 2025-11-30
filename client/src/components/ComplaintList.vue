<template>
  <div class="complaint-list">

    <div v-if="user.role === 'archivist'" class="list_user">
        <div v-for="person in users" :key="person.id">
          <img :src="getImgUrl(person.pfp)" alt="PFP" />
          <p>{{ person.username }}</p>
          <button @click="banUser(person.id)" class="icon-btn delete-btn">BAN</button>
        </div>
      </div>

    <div class="search-and-form">
      <div class="search-wrapper">
        <span class="search-icon">🔍</span>
        <input v-model="searchQuery" placeholder="Search complaints..." class="search-input" />
      </div>

      

      <div v-if="user.role === 'complainer'" class="new-complaint-form">
        <h3>Submit a New Overly Specific Complaint</h3>
        <form @submit.prevent="submitComplaint">
          <input v-model="newComplaint.title" placeholder="Complaint Title" required />
          <textarea
            v-model="newComplaint.detail"
            placeholder="Be extremely specific..."
            required
          ></textarea>
          <select v-model="newComplaint.category_id" required>
            <option disabled value="">Select a Category</option>
            <option v-for="cat in categories" :key="cat.id" :value="cat.id">
              {{ cat.name }}
            </option>
          </select>
          <button type="submit" class="submit-btn">Register Complaint</button>
        </form>
      </div>
    </div>

    <h2>The Registry (Sorted by Specificity)</h2>

    <div
      v-for="complaint in filteredComplaints"
      :key="complaint.id"
      class="complaint-card"
    >
      <div class="post-meta-header">
        <div class="post-user-info">
          <img :src="getImgUrl(complaint.complainer_pfp)" class="post-avatar" />
          <span class="post-author">u/{{ complaint.complainer_name }}</span>
        </div>
        <span class="meta-separator">•</span>
        <span class="category-pill">{{ complaint.category_name }}</span>
      </div>

      <div class="card-content">
        <h3 class="post-title">{{ complaint.title }}</h3>
        <p class="post-body">{{ complaint.detail }}</p>
      </div>

      <div class="card-footer">
        <span class="score-badge">Votes : {{ complaint.specificity_score }}</span>
          <button 
            v-if="user.role === 'complainer'" 
            @click="downvoteComplaint(complaint)" 
            class="icon-btn upvote-btn"
            title="Downvote"
          >
            ▼ Downvote
          </button>

          <button 
            v-if="user.role === 'complainer'" 
            @click="upvoteComplaint(complaint)" 
            class="icon-btn upvote-btn"
            title="Upvote"
          >
            ▲ Upvote
          </button>

          <button
            v-if="user.id === complaint.complainer_id && !editingComplaint"
            @click="startEdit(complaint)"
            class="icon-btn edit-btn"
          >
            Edit
          </button>

          <button
          v-if="user.role === 'archivist'"
          @click="resetVote(complaint)"
          class="icon-btn reset-btn"
          >
            Reset Score
          </button>

          <button
            v-if="user.role === 'archivist'"
            @click="deleteComplaint(complaint.id)"
            class="icon-btn delete-btn"
          >
            Archive
          </button>
      </div>

      <div
        v-if="editingComplaint && editingComplaint.id === complaint.id"
        class="edit-form"
      >
        <h4>Edit Complaint</h4>
        <input v-model="editingComplaint.title" placeholder="New Title" required />
        <textarea
          v-model="editingComplaint.detail"
          placeholder="New Detail"
          required
        ></textarea>
        <select v-model="editingComplaint.category_id" required>
          <option v-for="cat in categories" :key="cat.id" :value="cat.id">
            {{ cat.name }}
          </option>
        </select>
        <div class="edit-actions">
          <button @click="updateComplaint" class="save-btn">Save</button>
          <button @click="cancelEdit" class="cancel-btn">Cancel</button>
        </div>
      </div>
    </div>

    <p v-if="!filteredComplaints.length" class="empty-msg">No complaints found matching your search.</p>
  </div>
</template>

<script>
import axios from "axios";

// Import images (ensure these paths match your project structure)
import pfp1 from "@/assets/pfp_image/pfp1.jpeg";
import pfp2 from "@/assets/pfp_image/pfp2.jpeg";
import pfp3 from "@/assets/pfp_image/pfp3.jpeg";
import pfp4 from "@/assets/pfp_image/pfp4.jpeg";

export default {
  name: "ComplaintList",
  props: ["user", "token"],
  data() {
    return {
      complaints: [],
      categories: [],
      users: [],
      pfpMap: {
        "pfp1.jpeg": pfp1,
        "pfp2.jpeg": pfp2,
        "pfp3.jpeg": pfp3,
        "pfp4.jpeg": pfp4,
      },
      newComplaint: {
        title: "",
        detail: "",
        category_id: "",
      },
      editingComplaint: null,
      searchQuery: "",
    };
  },
  computed: {
    filteredComplaints() {
      const filtered = this.complaints.filter(
        (c) =>
          c.title.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
          c.detail.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
      return filtered.sort((a, b) => b.specificity_score - a.specificity_score);
    },
    api() {
      return axios.create({
        baseURL: "http://localhost:3000/api",
        headers: { Authorization: `Bearer ${this.token}` },
      });
    },
  },
  methods: {
    async fetchCategories() {
      try {
        const response = await axios.get("http://localhost:3000/api/categories");
        this.categories = response.data;
      } catch (error) {
        console.error("Error fetching categories:", error);
      }
    },
    async fetchComplaints() {
      try {
        const response = await axios.get("http://localhost:3000/api/complaints");
        this.complaints = response.data;
      } catch (error) {
        console.error("Error fetching complaints:", error);
      }
    },
    async fetchUsers() {
      try {
        const response = await axios.get("http://localhost:3000/api/users");
        this.users = response.data;
      } catch (error) {
        console.error("Error fetching users:", error);
      }
    },
    async submitComplaint() {
      try {
        await this.api.post("/complaints", this.newComplaint);
        this.newComplaint = { title: "", detail: "", category_id: "" };
        await this.fetchComplaints();
      } catch (error) {
        alert("Failed to submit complaint.");
      }
    },
    async upvoteComplaint(complaint) {
      try {
        await this.api.put(`/complaints/upvote/${complaint.id}`);
        complaint.specificity_score++;
        this.complaints.sort((a, b) => b.specificity_score - a.specificity_score);
      } catch (error) {
        alert("Failed to upvote complaint.");
      }
    },
    async downvoteComplaint(complaint) {
      try {
        await this.api.put(`/complaints/downvote/${complaint.id}`);
        complaint.specificity_score--;
        this.complaints.sort((a, b) => b.specificity_score - a.specificity_score);
      } catch (error) {
        alert("Failed to downvote complaint.");
      }
    },
    async resetVote(complaint){
      if (!confirm("Are you sure you want to reset the vote for this complaint ?")) return;
      try {
        await this.api.put(`/complaints/reset/${complaint.id}`);
        complaint.specificity_score = 0;
        this.fetchComplaints();
      } catch(error){
        alert("Failed to reset vote count");
      }
    },
    async deleteComplaint(id) {
      if (!confirm("Are you sure the complaint is too generic and must be archived?")) return;
      try {
        await this.api.delete(`/complaints/${id}`);
        this.complaints = this.complaints.filter((c) => c.id !== id);
      } catch (error) {
        alert(error.response.data.message || "Failed to delete complaint.");
      }
    },
    async banUser(id) {
      if (!confirm("Are you sure you want to ban this user?")) return;
      try {
        await this.api.delete(`/users/delete/${id}`);
        this.fetchUsers();
        this.fetchComplaints();
      } catch (error) {
        alert("Failed to ban user.");
      }
    },
    startEdit(complaint) {
      this.editingComplaint = { ...complaint };
    },
    cancelEdit() {
      this.editingComplaint = null;
    },
    async updateComplaint() {
      try {
        const { id, title, detail, category_id } = this.editingComplaint;
        await this.api.put(`/complaints/${id}`, { title, detail, category_id });
        const index = this.complaints.findIndex((c) => c.id === id);
        if (index !== -1) {
          this.complaints[index].title = title;
          this.complaints[index].detail = detail;
          this.complaints[index].category_name = this.categories.find(
            (c) => c.id === category_id
          ).name;
        }
        this.cancelEdit();
      } catch (error) {
        alert("Failed to update complaint.");
      }
    },
    getImgUrl(name) {
        // Fallback if null, otherwise map name to import
        if(!name) return this.pfpMap["pfp1.jpeg"];
        return this.pfpMap[name] || this.pfpMap["pfp1.jpeg"];
    },
  },
  mounted() {
    this.fetchCategories();
    this.fetchComplaints();
    this.fetchUsers();
  },
};
</script>

<style scoped>
.complaint-list {
  max-width: 700px;
  margin: 0 auto;
  padding-bottom: 40px;
}

/* --- Search & Form --- */
.search-wrapper {
  position: relative;
  margin-bottom: 20px;
}
.search-icon {
  position: absolute;
  left: 12px;
  top: 50%;
  transform: translateY(-50%);
  color: #8e8e93;
}
.search-input {
  width: 100%;
  padding: 12px 12px 12px 40px;
  border-radius: 10px;
  border: 1px solid #ddd;
  background-color: #fff;
  font-size: 16px;
  box-sizing: border-box;
}

.new-complaint-form {
  background: white;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.05);
  margin-bottom: 30px;
  border: 1px solid #eee;
}
.new-complaint-form input, 
.new-complaint-form textarea, 
.new-complaint-form select {
  width: 100%;
  padding: 10px;
  margin-bottom: 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  box-sizing: border-box;
  font-family: inherit;
}
.submit-btn {
  background-color: #007aff;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 6px;
  cursor: pointer;
  font-weight: 600;
  width: 100%;
}
.submit-btn:hover { background-color: #005ecb; }

/* --- Complaint Card --- */
.complaint-card {
  background: white;
  border: 1px solid #e5e5ea;
  border-radius: 12px;
  padding: 16px;
  margin-bottom: 16px;
  transition: box-shadow 0.2s;
}
.complaint-card:hover {
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

/* New Social Header Styles */
.post-meta-header {
  display: flex;
  align-items: center;
  font-size: 13px;
  color: #8e8e93;
  margin-bottom: 8px;
}

.post-user-info {
  display: flex;
  align-items: center;
  gap: 6px;
  color: #1c1c1e;
  font-weight: 600;
}

.post-avatar {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  object-fit: cover;
  border: 1px solid #eee;
}

.post-author {
  color: #1c1c1e;
}

.meta-separator {
  margin: 0 8px;
  color: #c7c7cc;
}

.category-pill {
  background-color: #f2f2f7;
  color: #007aff;
  padding: 2px 8px;
  border-radius: 10px;
  font-weight: 600;
  font-size: 11px;
  text-transform: uppercase;
}

/* Card Content */
.post-title {
  margin: 0 0 8px 0;
  font-size: 18px;
  font-weight: 700;
  color: #000;
}

.post-body {
  color: #3a3a3c;
  line-height: 1.5;
  margin: 0 0 16px 0;
  font-size: 15px;
}

/* Footer & Buttons */
.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-top: 1px solid #f2f2f7;
  padding-top: 12px;
}

.score-badge {
  font-size: 12px;
  font-weight: 700;
  color: #ff2d55;
  background-color: #fff0f2;
  padding: 4px 10px;
  border-radius: 10px;
}

.action-buttons {
  display: flex;
  gap: 10px;
  justify-content: space-between;
}

.icon-btn {
  background: none;
  border: none;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  padding: 6px 10px;
  border-radius: 6px;
  transition: background 0.2s;
}

.upvote-btn { color: #007aff; }
.upvote-btn:hover { background-color: #f0f8ff; }

.reset-btn {color: #000;}
.reset-btn:hover {background-color: #fff5ff;}


.edit-btn { color: #ff9500; }
.edit-btn:hover { background-color: #fff8eb; }

.delete-btn { color: #ff3b30; }
.delete-btn:hover { background-color: #fff0f0; }

/* Edit Mode */
.edit-form {
  margin-top: 15px;
  padding-top: 15px;
  border-top: 1px solid #eee;
}
.edit-form input, 
.edit-form textarea, 
.edit-form select {
  width: 100%;
  margin-bottom: 8px;
  padding: 8px;
  border: 1px solid #ddd;
  border-radius: 6px;
}
.edit-actions {
  display: flex;
  gap: 10px;
  justify-content: flex-end;
}
.save-btn {
  background: #007aff; color: white; border: none; padding: 6px 12px; border-radius: 6px; cursor: pointer;
}
.cancel-btn {
  background: transparent; color: #8e8e93; border: none; cursor: pointer;
}

/* Archivist User List (Reused previous styles) */
.list_user {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-bottom: 20px;
}
.list_user > div {
  background: white;
  padding: 10px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  gap: 12px;
  border: 1px solid #eee;
}
.list_user img {
  width: 40px; height: 40px; border-radius: 50%; object-fit: cover;
}
.list_user p { margin: 0; font-weight: 600; flex-grow: 1;}

</style>