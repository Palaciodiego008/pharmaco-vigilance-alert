<template>
  <div class="dashboard">
    <div class="page-header">
      <h1 class="page-title">Dashboard</h1>
      <p class="page-subtitle">Welcome back! Manage pharmacovigilance alerts and notifications.</p>
    </div>

    <BaseCard class="welcome-card">
      <h2 class="welcome-title">Welcome to Pharmacovigilance Alert System</h2>
      <p class="welcome-text">
        Use this system to identify and notify customers about medications with specific lot numbers.
      </p>
    </BaseCard>

    <div class="stats-grid">
      <BaseCard class="stat-card">
        <div class="stat-content">
          <div class="stat-icon">🔍</div>
          <div class="stat-info">
            <h3>Search Medications</h3>
            <p>Find orders by lot number</p>
            <router-link to="/search">
              <BaseButton variant="primary" size="sm">Go to Search</BaseButton>
            </router-link>
          </div>
        </div>
      </BaseCard>

      <BaseCard class="stat-card">
        <div class="stat-content">
          <div class="stat-icon">📧</div>
          <div class="stat-info">
            <h3>Alert History</h3>
            <p>View sent alerts</p>
            <router-link to="/alerts">
              <BaseButton variant="primary" size="sm">View Alerts</BaseButton>
            </router-link>
          </div>
        </div>
      </BaseCard>

      <BaseCard class="stat-card">
        <div class="stat-content">
          <div class="stat-icon">💊</div>
          <div class="stat-info">
            <h3>Target Lot Number</h3>
            <p class="highlight">951357</p>
            <p class="small">Default search parameter</p>
          </div>
        </div>
      </BaseCard>
    </div>

    <BaseCard class="info-card" title="Quick Guide">
      <ol class="guide-list">
        <li>Navigate to the <strong>Search</strong> page</li>
        <li>Enter lot number (e.g., 951357) and optional date range</li>
        <li>Review the list of affected orders</li>
        <li>Send individual or bulk alerts to customers</li>
        <li>Check the <strong>Alert History</strong> to see sent notifications</li>
      </ol>
    </BaseCard>
  </div>
</template>

<script setup>
import BaseCard from '../components/common/BaseCard.vue'
import BaseButton from '../components/common/BaseButton.vue'
</script>

<style scoped>
.dashboard {
  max-width: 1200px;
  margin: 0 auto;
}

.page-header {
  margin-bottom: 30px;
}

.page-title {
  font-size: 32px;
  font-weight: 600;
  color: var(--color-text-heading, #08060d);
  margin: 0 0 8px 0;
}

.page-subtitle {
  font-size: 14px;
  color: var(--color-text-secondary, #9ca3af);
  margin: 0;
}

.welcome-card {
  background: linear-gradient(135deg, var(--color-primary, #667eea) 0%, #764ba2 100%);
  color: #ffffff;
  margin-bottom: 30px;
  box-shadow: 0 4px 20px rgba(102, 126, 234, 0.3);
}

.welcome-title {
  color: #ffffff;
  margin: 0 0 10px 0;
  font-size: 24px;
}

.welcome-text {
  color: rgba(255, 255, 255, 0.9);
  margin: 0;
  line-height: 1.6;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.stat-card {
  padding: 0;
}

.stat-content {
  display: flex;
  align-items: center;
  gap: 20px;
  padding: 20px;
}

.stat-icon {
  font-size: 48px;
  flex-shrink: 0;
}

.stat-info h3 {
  margin: 0 0 5px 0;
  font-size: 18px;
  color: var(--color-text-heading, #08060d);
  font-weight: 600;
}

.stat-info p {
  margin: 0 0 12px 0;
  color: var(--color-text-secondary, #9ca3af);
  font-size: 14px;
}

.stat-info .highlight {
  font-size: 28px;
  font-weight: 700;
  color: var(--color-error, #dc3545);
  margin: 10px 0;
}

.stat-info .small {
  font-size: 12px;
  color: var(--color-text-secondary, #9ca3af);
  margin: 8px 0 0 0;
}

.info-card {
  margin-bottom: 20px;
}

.guide-list {
  margin: 0;
  padding-left: 20px;
  color: var(--color-text, #6b6375);
  line-height: 1.8;
}

.guide-list li {
  margin-bottom: 10px;
  font-size: 14px;
}

:deep(.stat-info a) {
  text-decoration: none;
}

@media (max-width: 768px) {
  .page-title {
    font-size: 24px;
  }

  .stats-grid {
    grid-template-columns: 1fr;
  }

  .stat-content {
    flex-direction: column;
    text-align: center;
    padding: 16px;
  }
}
</style>

