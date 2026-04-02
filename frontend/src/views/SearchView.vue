<template>
  <div class="search-page">
    <div class="page-header">
      <h1 class="page-title">Medication Search</h1>
      <p class="page-subtitle">Find orders by lot number and send alerts to customers.</p>
    </div>

    <BaseCard class="search-card" title="Search Orders by Lot Number">
      <form @submit.prevent="handleSearch" class="search-form">
        <div class="form-row">
          <BaseInput
            v-model="searchParams.lot_number"
            type="text"
            label="Lot Number *"
            placeholder="e.g., 951357"
            :disabled="loading"
            required
          />

          <BaseInput
            v-model="searchParams.start_date"
            type="date"
            label="Start Date"
            :disabled="loading"
          />

          <BaseInput
            v-model="searchParams.end_date"
            type="date"
            label="End Date"
            :disabled="loading"
          />
        </div>

        <BaseButton
          type="submit"
          variant="primary"
          :loading="loading"
          :disabled="loading"
        >
          {{ loading ? 'Searching...' : 'Search' }}
        </BaseButton>
      </form>
    </BaseCard>

    <BaseAlert
      v-if="error"
      type="error"
      :closeable="true"
      @close="error = null"
      class="search-error"
    >
      {{ error }}
    </BaseAlert>

    <BaseAlert
      v-if="successMessage"
      type="success"
      auto-close
      class="search-success"
    >
      {{ successMessage }}
    </BaseAlert>

    <div v-if="searchResults" class="results-section">
      <div class="results-header">
        <h2>Search Results</h2>
        <div class="results-info">
          <span class="badge">{{ searchResults.orders_count }} orders found</span>
          <span class="lot-badge">Lot: {{ searchResults.search_params.lot_number }}</span>
        </div>
      </div>

      <div v-if="searchResults.orders_count > 0" class="bulk-actions">
        <BaseButton
          variant="secondary"
          size="sm"
          :disabled="bulkLoading"
          @click="selectAll"
        >
          Select All
        </BaseButton>
        <BaseButton
          variant="secondary"
          size="sm"
          :disabled="bulkLoading"
          @click="deselectAll"
        >
          Deselect All
        </BaseButton>
        <BaseButton
          variant="danger"
          size="sm"
          :disabled="selectedOrders.length === 0 || bulkLoading"
          :loading="bulkLoading"
          @click="sendBulkAlerts"
        >
          {{ bulkLoading ? 'Sending...' : `Send Alerts (${selectedOrders.length})` }}
        </BaseButton>
      </div>

      <div v-if="searchResults.orders_count === 0" class="no-results">
        <p>No orders found for the specified criteria.</p>
      </div>

      <BaseCard v-else class="orders-card">
        <div class="orders-table-container">
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
      </BaseCard>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import BaseCard from '../components/common/BaseCard.vue'
import BaseButton from '../components/common/BaseButton.vue'
import BaseInput from '../components/common/BaseInput.vue'
import BaseAlert from '../components/common/BaseAlert.vue'
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
const successMessage = ref(null)
const successType = ref('success') // 'success' or 'bulk'

const allSelected = computed(() => {
  if (!searchResults.value || searchResults.value.orders.length === 0) return false
  return selectedOrders.value.length === searchResults.value.orders.length
})

async function handleSearch() {
  // Validation
  if (!searchParams.value.lot_number.trim()) {
    error.value = 'Lot number is required'
    return
  }

  // Validate date range if both dates are provided
  if (searchParams.value.start_date && searchParams.value.end_date) {
    const startDate = new Date(searchParams.value.start_date)
    const endDate = new Date(searchParams.value.end_date)

    if (endDate < startDate) {
      error.value = 'End date must be on or after the start date'
      return
    }
  }

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
  successMessage.value = null
  error.value = null

  try {
    await alertService.sendAlert({
      customer_id: order.customer.id,
      order_id: order.id,
      lot_number: searchParams.value.lot_number,
    })
    successMessage.value = `Alert sent successfully to ${order.customer.name}`
    successType.value = 'success'
    // Clear success message after 4 seconds
    setTimeout(() => {
      successMessage.value = null
    }, 4000)
  } catch (err) {
    error.value = 'Failed to send alert: ' + (err.response?.data?.message || err.message)
  } finally {
    sendingAlerts.value[order.id] = false
  }
}

async function sendBulkAlerts() {
  if (!confirm(`Send alerts to ${selectedOrders.value.length} customers?`)) return

  bulkLoading.value = true
  successMessage.value = null
  error.value = null

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

    successMessage.value = `Bulk alert completed!\nSuccess: ${response.data.success_count} | Failed: ${response.data.failed_count}`
    successType.value = 'bulk'
    selectedOrders.value = []
    // Clear success message after 5 seconds
    setTimeout(() => {
      successMessage.value = null
    }, 5000)
  } catch (err) {
    error.value = 'Failed to send bulk alerts: ' + (err.response?.data?.message || err.message)
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

.search-card {
  margin-bottom: 20px;
}

.search-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.form-row {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 16px;
}

.search-error {
  margin-bottom: 20px;
}

.results-section {
  background-color: var(--color-background, #ffffff);
  padding: 20px;
  border-radius: 8px;
  border: 1px solid var(--color-border, #e5e4e7);
}

.results-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  flex-wrap: wrap;
  gap: 16px;
}

.results-header h2 {
  margin: 0;
  font-size: 20px;
  color: var(--color-text-heading, #08060d);
  font-weight: 600;
}

.results-info {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.badge {
  background-color: var(--color-primary, #667eea);
  color: white;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 13px;
  font-weight: 500;
}

.lot-badge {
  background-color: var(--color-error, #dc3545);
  color: white;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 13px;
  font-weight: 600;
}

.bulk-actions {
  display: flex;
  gap: 12px;
  margin-bottom: 20px;
  padding: 16px;
  background-color: var(--color-surface-light, #f8f9fa);
  border-radius: 6px;
  flex-wrap: wrap;
}

.no-results {
  text-align: center;
  padding: 40px 20px;
  color: var(--color-text-secondary, #9ca3af);
}

.orders-card {
  margin-top: 20px;
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
  border-bottom: 1px solid var(--color-border, #e5e4e7);
}

.orders-table th {
  background-color: var(--color-surface-light, #f8f9fa);
  font-weight: 600;
  color: var(--color-text-heading, #08060d);
  font-size: 13px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.orders-table tr:hover {
  background-color: var(--color-surface-light, #f8f9fa);
}

.actions {
  display: flex;
  gap: 8px;
}

.btn-icon {
  background: none;
  border: none;
  cursor: pointer;
  font-size: 16px;
  padding: 4px;
  transition: transform 0.2s ease;
}

.btn-icon:hover {
  transform: scale(1.2);
}

.btn-icon:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn-alert:hover {
  filter: brightness(1.1);
}

@media (max-width: 768px) {
  .page-title {
    font-size: 24px;
  }

  .results-header {
    flex-direction: column;
    align-items: flex-start;
  }

  .bulk-actions {
    flex-direction: column;
  }

  .orders-table {
    font-size: 13px;
  }

  .orders-table th,
  .orders-table td {
    padding: 8px;
  }
}
</style>
