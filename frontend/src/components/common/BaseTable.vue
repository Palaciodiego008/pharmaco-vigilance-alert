<template>
  <div class="table-container">
    <table class="data-table">
      <thead>
        <tr>
          <th v-for="column in columns" :key="column.key" :class="`text-${column.align || 'left'}`">
            {{ column.label }}
          </th>
        </tr>
      </thead>
      <tbody>
        <tr v-if="items.length === 0" class="table-empty">
          <td :colspan="columns.length" class="text-center">
            {{ emptyMessage }}
          </td>
        </tr>
        <tr v-for="(item, index) in items" :key="index">
          <td v-for="column in columns" :key="column.key" :class="`text-${column.align || 'left'}`">
            <slot :name="column.key" :item="item">
              {{ getNestedValue(item, column.key) }}
            </slot>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  name: 'BaseTable',
  props: {
    columns: {
      type: Array,
      required: true,
    },
    items: {
      type: Array,
      default: () => [],
    },
    emptyMessage: {
      type: String,
      default: 'No hay datos para mostrar',
    },
  },
  methods: {
    getNestedValue(obj, path) {
      const keys = path.split('.');
      let result = obj;
      for (const key of keys) {
        if (result && typeof result === 'object') {
          result = result[key];
        } else {
          return '';
        }
      }
      return result || '';
    },
  },
};
</script>

<style scoped>
.table-container {
  width: 100%;
  overflow-x: auto;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.875rem;
}

.data-table thead {
  background-color: #f9fafb;
  border-bottom: 2px solid #e5e7eb;
}

.data-table th {
  padding: 1rem;
  text-align: left;
  font-weight: 600;
  color: #374151;
  white-space: nowrap;
}

.data-table td {
  padding: 1rem;
  border-bottom: 1px solid #e5e7eb;
}

.data-table tbody tr:hover {
  background-color: #f9fafb;
}

.table-empty td {
  padding: 2rem !important;
  color: #6b7280;
  font-style: italic;
}

.text-left {
  text-align: left;
}

.text-center {
  text-align: center;
}

.text-right {
  text-align: right;
}
</style>
