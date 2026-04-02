<template>
  <AppLayout>
    <div class="dashboard">
      <h1 class="page-title">Dashboard</h1>
      
      <div class="welcome-card">
        <h2>Welcome to the Pharmacovigilance Alert System</h2>
        <p>Use this system to identify and notify customers about medications with specific lot numbers.</p>
      </div>

      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon">🔍</div>
          <div class="stat-info">
            <h3>Search Medications</h3>
            <p>Find orders by lot number</p>
            <router-link to="/search" class="btn-primary">Go to Search</router-link>
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-icon">📧</div>
          <div class="stat-info">
            <h3>Alert History</h3>
            <p>View sent alerts</p>
            <router-link to="/alerts" class="btn-primary">View Alerts</router-link>
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-icon">💊</div>
          <div class="stat-info">
            <h3>Target Lot Number</h3>
            <p class="highlight">951357</p>
            <p class="small">Default search parameter</p>
          </div>
        </div>
      </div>

      <div class="info-card">
        <h3>Quick Guide</h3>
        <ol>
          <li>Navigate to the <strong>Search</strong> page</li>
          <li>Enter lot number (e.g., 951357) and optional date range</li>
          <li>Review the list of affected orders</li>
          <li>Send individual or bulk alerts to customers</li>
          <li>Check the <strong>Alert History</strong> to see sent notifications</li>
        </ol>
      </div>
    </div>
  </AppLayout>
</template>

<script setup>
import AppLayout from '../components/AppLayout.vue'
</script>

<style scoped>
.dashboard {
  max-width: 1200px;
  margin: 0 auto;
}

.page-title {
  font-size: 32px;
  color: #333;
  margin-bottom: 30px;
}

.welcome-card {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 30px;
  border-radius: 10px;
  margin-bottom: 30px;
  box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
}

.welcome-card h2 {
  margin: 0 0 10px 0;
  font-size: 24px;
}

.welcome-card p {
  margin: 0;
  opacity: 0.9;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.stat-card {
  background: white;
  padding: 25px;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
  display: flex;
  align-items: center;
  gap: 20px;
}

.stat-icon {
  font-size: 48px;
}

.stat-info h3 {
  margin: 0 0 5px 0;
  font-size: 18px;
  color: #333;
}

.stat-info p {
  margin: 0 0 15px 0;
  color: #666;
  font-size: 14px;
}

.stat-info .highlight {
  font-size: 28px;
  font-weight: bold;
  color: #dc3545;
  margin: 10px 0;
}

.stat-info .small {
  font-size: 12px;
  color: #999;
}

.btn-primary {
  display: inline-block;
  padding: 8px 16px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  text-decoration: none;
  border-radius: 5px;
  font-size: 14px;
  transition: opacity 0.3s;
}

.btn-primary:hover {
  opacity: 0.9;
}

.info-card {
  background: white;
  padding: 25px;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.info-card h3 {
  margin: 0 0 15px 0;
  color: #333;
}

.info-card ol {
  margin: 0;
  padding-left: 20px;
  color: #666;
  line-height: 1.8;
}

.info-card li {
  margin-bottom: 8px;
}
</style>
