<template>
  <div :class="['card', { 'card--border': border, 'card--shadow': shadow }]">
    <div v-if="title" class="card__header">
      <h3 class="card__title">{{ title }}</h3>
    </div>
    <div class="card__body">
      <slot></slot>
    </div>
    <div v-if="$slots.footer" class="card__footer">
      <slot name="footer"></slot>
    </div>
  </div>
</template>

<script>
export default {
  name: 'BaseCard',
  props: {
    title: String,
    border: {
      type: Boolean,
      default: true,
    },
    shadow: {
      type: Boolean,
      default: true,
    },
  },
};
</script>

<style scoped>
.card {
  background-color: white;
  border-radius: 0.75rem;
  padding: 1.5rem;
}

.card--border {
  border: 1px solid #e5e7eb;
}

.card--shadow {
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.card__header {
  margin-bottom: 1.5rem;
  padding-bottom: 1.5rem;
  border-bottom: 1px solid #e5e7eb;
}

.card__title {
  margin: 0;
  font-size: 1.25rem;
  font-weight: 600;
  color: #111827;
}

.card__body {
  margin-bottom: 1.5rem;
}

.card__footer {
  padding-top: 1.5rem;
  border-top: 1px solid #e5e7eb;
}
</style>
