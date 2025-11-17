<template>
  <div class="complaint-list">
    <div class="search-and-form">
      <input v-model="searchQuery" placeholder="Search complaints..." />

      <div v-if="user.role === 'complainer'" class="new-complaint-form">
        <h3>Submit a New Overly Specific Complaint</h3>
        <form @submit.prevent="submitComplaint">
          <input v-model="newComplaint.title" placeholder="Complaint Title" required />
          <textarea v-model="newComplaint.detail" placeholder="Be extremely specific..." required></textarea>
          <select v-model="newComplaint.category_id" required>
            <option disabled value="">Select a Category</option>
            <option v-for="cat in categories" :key="cat.id" :value="cat.id">
              {{ cat.name }}
            </option>
          </select>
          <button type="submit">Register Complaint</button>
        </form>
      </div>
    </div>

    <h2>The Registry (Sorted by Specificity Score)</h2>

    <div v-for="complaint in filteredComplaints" :key="complaint.id" class="complaint-card">
      <div class="card-header">
        <strong>{{ complaint.title }}</strong>
        <span class="category-tag">{{ complaint.category_name }}</span>
      </div>
      <p>{{ complaint.detail }}</p>

      <div class="card-footer">
        <span class="score">Specificity Score: {{ complaint.specificity_score }}</span>
        
        <button 
          v-if="user.role === 'complainer'" 
          @click="upvoteComplaint(complaint)"
        >
          Upvote (+1 Specificity)
        </button>

        <button 
          v-if="user.id === complaint.complainer_id && !editingComplaint" 
          @click="startEdit(complaint)"
        >
          Make More Specific (Edit)
        </button>

        <button 
          v-if="user.role === 'archivist'" 
          @click="deleteComplaint(complaint.id)"
          class="delete-btn"
        >
          Archive (Delete)
        </button>
      </div>
      
      <div v-if="editingComplaint && editingComplaint.id === complaint.id" class="edit-form">
          <h4>Edit Complaint</h4>
          <input v-model="editingComplaint.title" placeholder="New Title" required />
          <textarea v-model="editingComplaint.detail" placeholder="New Detail" required></textarea>
          <select v-model="editingComplaint.category_id" required>
            <option v-for="cat in categories" :key="cat.id" :value="cat.id">
              {{ cat.name }}
            </option>
          </select>
          <button @click="updateComplaint">Save</button>
          <button @click="cancelEdit">Cancel</button>
      </div>
    </div>

    <p v-if="!filteredComplaints.length">No complaints found matching your search.</p>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'ComplaintList',
  props: ['user', 'token'],
  data() {
    return {
      complaints: [],
      categories: [],
      newComplaint: {
        title: '',
        detail: '',
        category_id: '',
      },
      editingComplaint: null, // Stores the complaint being edited
      searchQuery: '',
    };
  },
  computed: {
    filteredComplaints() {
      // Filter by search query (case-insensitive on title/detail)
      const filtered = this.complaints.filter(c =>
        c.title.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
        c.detail.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
      // Sorting is already done server-side by specificity_score DESC, but we'll re-sort here just in case of local updates
      return filtered.sort((a, b) => b.specificity_score - a.specificity_score);
    },
    // Axios instance with auth header
    api() {
        return axios.create({
            baseURL: 'http://localhost:3000/api',
            headers: { 'Authorization': `Bearer ${this.token}` }
        });
    }
  },
  methods: {
    async fetchCategories() {
      try {
        const response = await axios.get('http://localhost:3000/api/categories');
        this.categories = response.data;
      } catch (error) {
        console.error('Error fetching categories:', error);
      }
    },
    async fetchComplaints() {
      try {
        const response = await axios.get('http://localhost:3000/api/complaints');
        this.complaints = response.data;
      } catch (error) {
        console.error('Error fetching complaints:', error);
      }
    },
    async submitComplaint() {
      try {
        await this.api.post('/complaints', this.newComplaint);
        
        // Reset form
        this.newComplaint = { title: '', detail: '', category_id: '' };
        
        await this.fetchComplaints(); // Refresh list
      } catch (error) {
        alert('Failed to submit complaint.');
        console.error('Error submitting complaint:', error);
      }
    },
    async upvoteComplaint(complaint) {
      try {
        await this.api.put(`/complaints/upvote/${complaint.id}`);
        
        // Optimistically update the local score
        complaint.specificity_score++;
        // Re-sort the array manually since the score changed
        this.complaints.sort((a, b) => b.specificity_score - a.specificity_score); 

      } catch (error) {
        alert('Failed to upvote complaint.');
        console.error('Error upvoting complaint:', error);
      }
    },
    async deleteComplaint(id) {
      if (!confirm("Are you sure the complaint is too generic and must be archived?")) return;
      
      try {
        await this.api.delete(`/complaints/${id}`);
        
        // Remove from local array
        this.complaints = this.complaints.filter(c => c.id !== id);
      } catch (error) {
        alert(error.response.data.message || 'Failed to delete complaint.');
        console.error('Error deleting complaint:', error);
      }
    },
    startEdit(complaint) {
      // Create a shallow copy for editing
      this.editingComplaint = { ...complaint }; 
    },
    cancelEdit() {
      this.editingComplaint = null;
    },
    async updateComplaint() {
        try {
            const { id, title, detail, category_id } = this.editingComplaint;

            await this.api.put(`/complaints/${id}`, { title, detail, category_id });
            
            // Update the main array with the new data
            const index = this.complaints.findIndex(c => c.id === id);
            if (index !== -1) {
                this.complaints[index].title = title;
                this.complaints[index].detail = detail;
                this.complaints[index].category_name = this.categories.find(c => c.id === category_id).name;
            }
            this.cancelEdit();
        } catch (error) {
            alert('Failed to update complaint. You can only edit your own complaints.');
            console.error('Error updating complaint:', error);
        }
    }
  },
  mounted() {
    this.fetchCategories();
    this.fetchComplaints();
  },
};
</script>

<style scoped>
.complaint-list {
  max-width: 800px;
  margin: 0 auto;
}
.search-and-form {
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 1px solid #eee;
}
.search-and-form input {
    padding: 10px;
    width: 100%;
    margin-bottom: 15px;
}
.new-complaint-form {
  border: 1px solid #ccc;
  padding: 15px;
  border-radius: 8px;
}
.new-complaint-form input, .new-complaint-form textarea, .new-complaint-form select {
    display: block;
    width: 100%;
    padding: 8px;
    margin-bottom: 10px;
    box-sizing: border-box;
}
.complaint-card {
  border: 2px solid #2c3e50;
  border-radius: 6px;
  padding: 15px;
  margin-bottom: 15px;
  text-align: left;
}
.card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 5px;
}
.category-tag {
    background-color: #3498db;
    color: white;
    padding: 3px 8px;
    border-radius: 3px;
    font-size: 0.8em;
}
.card-footer {
    display: flex;
    justify-content: flex-start;
    align-items: center;
    gap: 10px;
    margin-top: 10px;
    padding-top: 10px;
    border-top: 1px solid #eee;
}
.score {
    font-weight: bold;
    color: #e74c3c;
}
.delete-btn {
    background-color: #c0392b;
    color: white;
    border: none;
}
.edit-form {
    border-top: 1px solid #ddd;
    margin-top: 10px;
    padding-top: 10px;
}
.edit-form input, .edit-form textarea, .edit-form select {
    margin-bottom: 5px;
}
</style>