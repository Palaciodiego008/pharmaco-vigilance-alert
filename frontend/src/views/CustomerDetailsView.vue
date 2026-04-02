<template>
  <AppLayout>
    <div class="customer-details">
      <div class="header-actions">
        <button @click="$router.back()" class="btn-back">← Back</button>
        <h1 class="page-title">Customer Details</h1>
      </div>

      <div v-if="loading" class="loading">Loading...</div>
      <div v-else-if="error" class="error-message">{{ error }}</div>

      <div v-else-if="customer" class="details-container">
        <div class="info-card">
          <h2>Customer Information</h2>
          <div class="info-grid">
            <div class="info-item">
              <label>Name:</label>
              <span>{{ customer.name }}</span>
            </div>
            <div class="info-item">
              <label>Email:</label>
              <span>{{ customer.email }}</span>
            </div>
            <div class="info-item">
              <label>Phone:</label>
              <span>{{ customer.phone || 'N/A' }}</span>
            </div>
          </div>
        </div>

        <div class="info-card">
          <h2>Order History ({{ customer.orders?.length || 0 }} orders)</h2>
          <table v-if="customer.orders?.length" class="orders-table">
            <thead>
              <tr>
                <th>Order ID</th>
                <th>Date</th>
                <th>Items</th>
                <th>Total</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="order in customer.orders" :key="order.id">
                <td>#{{ order.id }}</td>
                <td>{{ formatDate(order.purchase_date) }}</td>
                <td>{{ order.order_items.length }}</td>
                <td>${{ order.total_amount }}</td>
                <td>
                  <button @click="$router.push(`/orders/${order.id}`)" class="btn-view">
                    View
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
          <p v-else class="no-data">No orders found</p>
        </div>
      </div>
    </div>
  </AppLayout>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import AppLayout from '../components/AppLayout.vue'
import customerService from '../services/customers'

const route = useRoute()
const customer = ref(null)
const loading = ref(false)
const error = ref(null)

onMounted(async () => {
  loading.value = true
  try {
    const response = await customerService.getCustomer(route.params.id)
    customer.value = response.data.customer
  } catch (err) {
    error.value = 'Failed to load customer details'
  } finally {
    loading.value = false
  }
})

function formatDate(date) {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
  })
}
</script>

<style scoped>
.customer-details {
  max-width: 1000px;
  margin: 0 auto;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 20px;
  margin-bottom: 30px;
}

.btn-back {
  padding: 8px 16px;
  background-color: #6c757d;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.page-title {
  font-size: 32px;
  color: #333;
  margin: 0;
}

.loading, .error-message {
  text-align: center;
  padding: 40px;
}

.details-container {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.info-card {
  background: white;
  padding: 25px;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.info-card h2 {
  margin: 0 0 20px 0;
  font-size: 20px;
  color: #333;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 15px;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.info-item label {
  font-weight: 600;
  color: #666;
  font-size: 14px;
}

.info-item span {
  color: #333;
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
}

.btn-view {
  padding: 6px 12px;
  background-color: #667eea;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 14px;
}

.btn-view:hover {
  background-color: #5568d3;
}

.no-data {
  text-align: center;
  color: #666;
  padding: 20px;
}
</style>
