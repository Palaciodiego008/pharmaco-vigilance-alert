<template>
  <AppLayout>
    <div class="search-page">
      <h1 class="page-title">Medication Search</h1>

      <div class="search-card">
        <h2>Search Orders by Lot Number</h2>
        
        <form @submit.prevent="handleSearch" class="search-form">
          <div class="form-row">
            <div class="form-group">
              <label for="lot_number">Lot Number *</label>
              <input
                id="lot_number"
                v-model="searchParams.lot_number"
                type="text"
                required
                placeholder="e.g., 951357"
                :disabled="loading"
              />
            </div>

            <div class="form-group">
              <label for="start_date">Start Date</label>
              <input
                id="start_date"
                v-model="searchParams.start_date"
                type="date"
                :disabled="loading"
              />
            </div>

            <div class="form-group">
              <label for="end_date">End Date</label>
              <input
                id="end_date"
                v-model="searchParams.end_date"
                type="date"
                :disabled="loading"
              />
            </div>
          </div>

          <button type="submit" class="btn-search" :disabled="loading">
            {{ loading ? 'Searching...' : 'Search' }}
          </button>
        </form>
      </div>

      <div v-if="error" class="error-message">
        {{ error }}
      </div>

      <div v-if="searchResults" class="results-section">
        <div class="results-header">
          <h2>Search Results</h2>
          <div class="results-info">
            <span class="badge">{{ searchResults.orders_count }} orders found</span>
            <span class="lot-badge">Lot: {{ searchResults.search_params.lot_number }}</span>
          </div>
        </div>

        <div v-if="searchResults.orders_count > 0" class="bulk-actions">
          <button
            @click="selectAll"
            class="btn-secondary"
            :disabled="bulkLoading"
          >
            Select All
          </button>
          <button
            @click="deselectAll"
            class="btn-secondary"
            :disabled="bulkLoading"
          >
            Deselect All
          </button>
          <button
            @click="sendBulkAlerts"
            class="btn-danger"
            :disabled="selectedOrders.length === 0 || bulkLoading"
          >
            {{ bulkLoading ? 'Sending...' : `Send Alerts (${selectedOrders.length})` }}
          </button>
        </div>

        <div v-if="searchResults.orders_count === 0" class="no-results">
          <p>No orders found for the specified criteria.</p>
        </div>

        <div v-else class="orders-table-container">
          <table class="orders-table">
            <thead>
              <tr>
                <th><input type="checkbox" @change="toggleSelectAll" :checked="allSelected" /></th>
                <th>Order ID</th>
                <th>Customer Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Purchase Date</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="order in searchResults.orders" :key="order.id">
                <td>
                  <input
                    type="checkbox"
                    :value="order.id"
                    v-model="selectedOrders"
                    :id="`order-${order.id}`"
                  />
                </td>
                <td>#{{ order.id }}</td>
                <td>{{ order.customer.name }}</td>
                <td>{{ order.customer.email }}</td>
                <td>{{ order.customer.phone || 'N/A' }}</td>
                <td>{{ formatDate(order.purchase_date) }}</td>
                <td class="actions">
                  <button
                    @click="viewOrder(order.id)"
                    class="btn-icon"
                    title="View Order"
                  >
                    👁️
                  </button>
                  <button
                    @click="viewCustomer(order.customer.id)"
                    class="btn-icon"
                    title="View Customer"
                  >
                    👤
                  </button>
                  <button
                    @click="sendSingleAlert(order)"
                    class="btn-icon btn-alert"
                    title="Send Alert"
                    :disabled="sendingAlerts[order.id]"
                  >
                    {{ sendingAlerts[order.id] ? '⏳' : '📧' }}
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </AppLayout>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import AppLayout from '../components/AppLayout.vue'
import medicationService from '../services/medications'
import alertService from '../services/alerts'

const router = useRouter()

const searchParams = ref({
  lot_number: '951357',
  start_date: '',
  end_date: '',
})

const searchResults = ref(null)
const loading = ref(false)
const error = ref(null)
const selectedOrders = ref([])
const sendingAlerts = ref({})
const bulkLoading = ref(false)

const allSelected = computed(() => {
  if (!searchResults.value || searchResults.value.orders.length === 0) return false
  return selectedOrders.value.length === searchResults.value.orders.length
})

async function handleSearch() {
  loading.value = true
  error.value = null
  searchResults.value = null
  selectedOrders.value = []

  try {
    const response = await medicationService.searchMedications(searchParams.value)
    searchResults.value = response.data
  } catch (err) {
    error.value = err.response?.data?.message || 'Search failed'
  } finally {
    loading.value = false
  }
}

function formatDate(date) {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  })
}

function toggleSelectAll() {
  if (allSelected.value) {
    deselectAll()
  } else {
    selectAll()
  }
}

function selectAll() {
  selectedOrders.value = searchResults.value.orders.map((order) => order.id)
}

function deselectAll() {
  selectedOrders.value = []
}

function viewOrder(orderId) {
  router.push(`/orders/${orderId}`)
}

function viewCustomer(customerId) {
  router.push(`/customers/${customerId}`)
}

async function sendSingleAlert(order) {
  if (!confirm(`Send alert to ${order.customer.name}?`)) return

  sendingAlerts.value[order.id] = true

  try {
    await alertService.sendAlert({
      customer_id: order.customer.id,
      order_id: order.id,
      lot_number: searchParams.value.lot_number,
    })
    alert(`Alert sent successfully to ${order.customer.name}`)
  } catch (err) {
    alert('Failed to send alert: ' + (err.response?.data?.message || err.message))
  } finally {
    sendingAlerts.value[order.id] = false
  }
}

async function sendBulkAlerts() {
  if (!confirm(`Send alerts to ${selectedOrders.value.length} customers?`)) return

  bulkLoading.value = true

  try {
    const alerts = selectedOrders.value.map((orderId) => {
      const order = searchResults.value.orders.find((o) => o.id === orderId)
      return {
        customer_id: order.customer.id,
        order_id: order.id,
      }
    })

    const response = await alertService.sendBulkAlerts({
      alerts,
      lot_number: searchParams.value.lot_number,
    })

    alert(
      `Bulk alert completed!\nSuccess: ${response.data.success_count}\nFailed: ${response.data.failed_count}`
    )
    selectedOrders.value = []
  } catch (err) {
    alert('Failed to send bulk alerts: ' + (err.response?.data?.message || err.message))
  } finally {
    bulkLoading.value = false
  }
}
</script>

<style scoped>
.search-page {
  max-width: 1200px;
  margin: 0 auto;
}

.page-title {
  font-size: 32px;
  color: #333;
  margin-bottom: 30px;
}

.search-card {
  background: white;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
  margin-bottom: 30px;
}

.search-card h2 {
  margin: 0 0 20px 0;
  font-size: 20px;
  color: #333;
}

.form-row {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  color: #333;
  font-weight: 500;
  font-size: 14px;
}

.form-group input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 5px;
  font-size: 14px;
}

.form-group input:focus {
  outline: none;
  border-color: #667eea;
}

.btn-search {
  width: 100%;
  padding: 12px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  border-radius: 5px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
}

.btn-search:hover:not(:disabled) {
  opacity: 0.9;
}

.btn-search:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.error-message {
  background-color: #fee;
  color: #c33;
  padding: 15px;
  border-radius: 5px;
  margin-bottom: 20px;
}

.results-section {
  background: white;
  padding: 30px;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.results-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.results-header h2 {
  margin: 0;
  font-size: 20px;
  color: #333;
}

.results-info {
  display: flex;
  gap: 10px;
}

.badge {
  background-color: #667eea;
  color: white;
  padding: 5px 15px;
  border-radius: 20px;
  font-size: 14px;
}

.lot-badge {
  background-color: #dc3545;
  color: white;
  padding: 5px 15px;
  border-radius: 20px;
  font-size: 14px;
  font-weight: bold;
}

.bulk-actions {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
  padding: 15px;
  background-color: #f8f9fa;
  border-radius: 5px;
}

.btn-secondary {
  padding: 8px 16px;
  background-color: #6c757d;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 14px;
}

.btn-secondary:hover:not(:disabled) {
  background-color: #5a6268;
}

.btn-danger {
  padding: 8px 16px;
  background-color: #dc3545;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
}

.btn-danger:hover:not(:disabled) {
  background-color: #c82333;
}

.btn-secondary:disabled,
.btn-danger:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.no-results {
  text-align: center;
  padding: 40px;
  color: #666;
}

.orders-table-container {
  overflow-x: auto;
}

.orders-table {
  width: 100%;
  border-collapse: collapse;
}

.orders-table th,
.orders-table td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #dee2e6;
}

.orders-table th {
  background-color: #f8f9fa;
  font-weight: 600;
  color: #333;
}

.orders-table tr:hover {
  background-color: #f8f9fa;
}

.actions {
  display: flex;
  gap: 5px;
}

.btn-icon {
  background: none;
  border: none;
  cursor: pointer;
  font-size: 18px;
  padding: 5px;
  transition: transform 0.2s;
}

.btn-icon:hover {
  transform: scale(1.2);
}

.btn-icon:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn-alert {
  filter: grayscale(0);
}

.btn-alert:hover {
  filter: grayscale(0) brightness(1.2);
}
</style>
