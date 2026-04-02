<template>
  <AppLayout>
    <div class="order-details">
      <div class="header-actions">
        <button @click="$router.back()" class="btn-back">← Back</button>
        <h1 class="page-title">Order Details</h1>
      </div>

      <div v-if="loading" class="loading">Loading...</div>
      <div v-else-if="error" class="error-message">{{ error }}</div>

      <div v-else-if="order" class="details-container">
        <div class="info-card">
          <h2>Order Information</h2>
          <div class="info-grid">
            <div class="info-item">
              <label>Order ID:</label>
              <span>#{{ order.id }}</span>
            </div>
            <div class="info-item">
              <label>Purchase Date:</label>
              <span>{{ formatDate(order.purchase_date) }}</span>
            </div>
            <div class="info-item">
              <label>Status:</label>
              <span class="badge">{{ order.status }}</span>
            </div>
            <div class="info-item">
              <label>Total Amount:</label>
              <span class="amount">${{ order.total_amount }}</span>
            </div>
          </div>
        </div>

        <div class="info-card">
          <h2>Customer Information</h2>
          <div class="info-grid">
            <div class="info-item">
              <label>Name:</label>
              <span>{{ order.customer.name }}</span>
            </div>
            <div class="info-item">
              <label>Email:</label>
              <span>{{ order.customer.email }}</span>
            </div>
            <div class="info-item">
              <label>Phone:</label>
              <span>{{ order.customer.phone || 'N/A' }}</span>
            </div>
          </div>
        </div>

        <div class="info-card">
          <h2>Order Items</h2>
          <table class="items-table">
            <thead>
              <tr>
                <th>Medication</th>
                <th>Lot Number</th>
                <th>Quantity</th>
                <th>Unit Price</th>
                <th>Subtotal</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in order.order_items" :key="item.id">
                <td>{{ item.medication.name }}</td>
                <td><span class="lot-number">{{ item.medication.lot_number }}</span></td>
                <td>{{ item.quantity }}</td>
                <td>${{ item.unit_price }}</td>
                <td>${{ item.subtotal }}</td>
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
import { useRoute } from 'vue-router'
import AppLayout from '../components/AppLayout.vue'
import orderService from '../services/orders'

const route = useRoute()
const order = ref(null)
const loading = ref(false)
const error = ref(null)

onMounted(async () => {
  loading.value = true
  try {
    const response = await orderService.getOrder(route.params.id)
    order.value = response.data.order
  } catch (err) {
    error.value = 'Failed to load order details'
  } finally {
    loading.value = false
  }
})

function formatDate(date) {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  })
}
</script>

<style scoped>
.order-details {
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

.badge {
  display: inline-block;
  padding: 4px 12px;
  background-color: #28a745;
  color: white;
  border-radius: 20px;
  font-size: 12px;
  text-transform: uppercase;
}

.amount {
  font-size: 24px;
  font-weight: bold;
  color: #667eea;
}

.items-table {
  width: 100%;
  border-collapse: collapse;
}

.items-table th,
.items-table td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #dee2e6;
}

.items-table th {
  background-color: #f8f9fa;
  font-weight: 600;
}

.lot-number {
  background-color: #dc3545;
  color: white;
  padding: 2px 8px;
  border-radius: 4px;
  font-weight: bold;
  font-size: 12px;
}
</style>
