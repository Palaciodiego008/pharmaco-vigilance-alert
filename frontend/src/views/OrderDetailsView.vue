<template>
  <div class="order-details">
    <div class="header-actions">
      <BaseButton variant="secondary" size="sm" @click="$router.back()">← Back</BaseButton>
      <h1 class="page-title">Order Details</h1>
    </div>

    <BaseAlert v-if="loading" type="info">Loading order details...</BaseAlert>
    <BaseAlert v-else-if="error" type="error">{{ error }}</BaseAlert>

    <div v-else-if="order" class="details-container">
      <BaseCard title="Order Information">
        <div class="info-grid">
          <div class="info-item">
            <label>Order ID:</label>
            <span class="info-value">#{{ order.id }}</span>
          </div>
          <div class="info-item">
            <label>Purchase Date:</label>
            <span class="info-value">{{ formatDate(order.purchase_date) }}</span>
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
      </BaseCard>

      <BaseCard title="Customer Information">
        <div class="info-grid">
          <div class="info-item">
            <label>Name:</label>
            <span class="info-value">{{ order.customer.name }}</span>
          </div>
          <div class="info-item">
            <label>Email:</label>
            <span class="info-value">{{ order.customer.email }}</span>
          </div>
          <div class="info-item">
            <label>Phone:</label>
            <span class="info-value">{{ order.customer.phone || 'N/A' }}</span>
          </div>
        </div>
      </BaseCard>

      <BaseCard title="Order Items">
        <div class="items-table-container">
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
      </BaseCard>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import BaseCard from '../components/common/BaseCard.vue'
import BaseButton from '../components/common/BaseButton.vue'
import BaseAlert from '../components/common/BaseAlert.vue'
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
  flex-wrap: wrap;
}

.page-title {
  font-size: 32px;
  font-weight: 600;
  color: var(--color-text-heading, #08060d);
  margin: 0;
}

.details-container {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 16px;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.info-item label {
  font-weight: 600;
  color: var(--color-text-secondary, #9ca3af);
  font-size: 13px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.info-value {
  color: var(--color-text-heading, #08060d);
  font-size: 15px;
}

.badge {
  display: inline-block;
  padding: 4px 12px;
  background-color: var(--color-success, #28a745);
  color: white;
  border-radius: 20px;
  font-size: 12px;
  text-transform: uppercase;
  font-weight: 600;
  width: fit-content;
}

.amount {
  font-size: 24px;
  font-weight: 700;
  color: var(--color-primary, #667eea);
}

.items-table-container {
  overflow-x: auto;
}

.items-table {
  width: 100%;
  border-collapse: collapse;
}

.items-table th,
.items-table td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid var(--color-border, #e5e4e7);
}

.items-table th {
  background-color: var(--color-surface-light, #f8f9fa);
  font-weight: 600;
  color: var(--color-text-heading, #08060d);
  font-size: 13px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.items-table tr:hover {
  background-color: var(--color-surface-light, #f8f9fa);
}

.lot-number {
  background-color: var(--color-error, #dc3545);
  color: white;
  padding: 3px 8px;
  border-radius: 4px;
  font-weight: 600;
  font-size: 12px;
}

@media (max-width: 768px) {
  .page-title {
    font-size: 24px;
  }

  .header-actions {
    flex-direction: column;
    align-items: flex-start;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }
}
</style>
