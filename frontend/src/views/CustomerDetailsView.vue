<template>
  <div class="customer-details">
    <div class="header-actions">
      <BaseButton variant="secondary" size="sm" @click="$router.back()">← Back</BaseButton>
      <h1 class="page-title">Customer Details</h1>
    </div>

    <BaseAlert v-if="loading" type="info">Loading customer details...</BaseAlert>
    <BaseAlert v-else-if="error" type="error">{{ error }}</BaseAlert>

    <div v-else-if="customer" class="details-container">
      <BaseCard title="Customer Information">
        <div class="info-grid">
          <div class="info-item">
            <label>Name:</label>
            <span class="info-value">{{ customer.name }}</span>
          </div>
          <div class="info-item">
            <label>Email:</label>
            <span class="info-value">{{ customer.email }}</span>
          </div>
          <div class="info-item">
            <label>Phone:</label>
            <span class="info-value">{{ customer.phone || 'N/A' }}</span>
          </div>
        </div>
      </BaseCard>

      <BaseCard :title="`Order History (${customer.orders?.length || 0} orders)`">
        <div v-if="customer.orders?.length" class="orders-table-container">
          <table class="orders-table">
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
                  <BaseButton
                    variant="primary"
                    size="sm"
                    @click="$router.push(`/orders/${order.id}`)"
                  >
                    View
                  </BaseButton>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div v-else class="no-data">
          <p>No orders found for this customer.</p>
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

.no-data {
  text-align: center;
  color: var(--color-text-secondary, #9ca3af);
  padding: 20px;
  font-size: 14px;
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
