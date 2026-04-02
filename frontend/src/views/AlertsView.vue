<template>
  <div class="alerts-page">
    <div class="page-header">
      <h1 class="page-title">Alert History</h1>
      <p class="page-subtitle">View all sent alerts and notifications to customers.</p>
    </div>

    <BaseAlert v-if="loading" type="info">Loading alert history...</BaseAlert>
    <BaseAlert v-else-if="error" type="error">{{ error }}</BaseAlert>

    <BaseCard v-else :title="`Sent Alerts (${alerts.length})`">
      <div v-if="alerts.length === 0" class="no-alerts">
        <p>No alerts have been sent yet.</p>
      </div>

      <div v-else class="alerts-table-container">
        <table class="alerts-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Customer</th>
              <th>Order ID</th>
              <th>Type</th>
              <th>Sent By</th>
              <th>Sent At</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="alert in alerts" :key="alert.id">
              <td>#{{ alert.id }}</td>
              <td>{{ alert.customer.name }}</td>
              <td>#{{ alert.order_id }}</td>
              <td><span class="badge">{{ alert.alert_type }}</span></td>
              <td>{{ alert.user.name }}</td>
              <td>{{ formatDateTime(alert.sent_at) }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </BaseCard>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import BaseCard from '../components/common/BaseCard.vue'
import BaseAlert from '../components/common/BaseAlert.vue'
import alertService from '../services/alerts'

const alerts = ref([])
const loading = ref(false)
const error = ref(null)

onMounted(async () => {
  loading.value = true
  try {
    const response = await alertService.getAlerts()
    alerts.value = response.data.alerts
  } catch (err) {
    error.value = 'Failed to load alerts'
  } finally {
    loading.value = false
  }
})

function formatDateTime(datetime) {
  return new Date(datetime).toLocaleString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  })
}
</script>

<style scoped>
.alerts-page {
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

.no-alerts {
  text-align: center;
  padding: 40px 20px;
  color: var(--color-text-secondary, #9ca3af);
  font-size: 14px;
}

.alerts-table-container {
  overflow-x: auto;
}

.alerts-table {
  width: 100%;
  border-collapse: collapse;
}

.alerts-table th,
.alerts-table td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid var(--color-border, #e5e4e7);
}

.alerts-table th {
  background-color: var(--color-surface-light, #f8f9fa);
  font-weight: 600;
  color: var(--color-text-heading, #08060d);
  font-size: 13px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.alerts-table tr:hover {
  background-color: var(--color-surface-light, #f8f9fa);
}

.badge {
  display: inline-block;
  padding: 4px 12px;
  background-color: var(--color-primary, #667eea);
  color: white;
  border-radius: 20px;
  font-size: 12px;
  text-transform: uppercase;
  font-weight: 500;
}

@media (max-width: 768px) {
  .page-title {
    font-size: 24px;
  }

  .alerts-table {
    font-size: 13px;
  }

  .alerts-table th,
  .alerts-table td {
    padding: 8px;
  }
}
</style>
