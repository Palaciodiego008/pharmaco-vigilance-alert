<template>
  <AppLayout>
    <div class="alerts-page">
      <h1 class="page-title">Alert History</h1>

      <div v-if="loading" class="loading">Loading...</div>
      <div v-else-if="error" class="error-message">{{ error }}</div>

      <div v-else class="alerts-container">
        <div class="alerts-header">
          <h2>Sent Alerts ({{ alerts.length }})</h2>
        </div>

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
      </div>
    </div>
  </AppLayout>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import AppLayout from '../components/AppLayout.vue'
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

.page-title {
  font-size: 32px;
  color: #333;
  margin-bottom: 30px;
}

.loading, .error-message {
  text-align: center;
  padding: 40px;
}

.alerts-container {
  background: white;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.alerts-header h2 {
  margin: 0 0 20px 0;
  font-size: 20px;
  color: #333;
}

.no-alerts {
  text-align: center;
  padding: 40px;
  color: #666;
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
  border-bottom: 1px solid #dee2e6;
}

.alerts-table th {
  background-color: #f8f9fa;
  font-weight: 600;
  color: #333;
}

.alerts-table tr:hover {
  background-color: #f8f9fa;
}

.badge {
  display: inline-block;
  padding: 4px 12px;
  background-color: #667eea;
  color: white;
  border-radius: 20px;
  font-size: 12px;
  text-transform: uppercase;
}
</style>
