<template>
  <button
    :class="[
      'button',
      `button--${variant}`,
      `button--${size}`,
      { 'button--loading': loading },
      customClass,
    ]"
    :disabled="disabled || loading"
    :type="type"
    @click="$emit('click')"
  >
    <span v-if="loading" class="button__spinner"></span>
    <slot v-else>{{ label }}</slot>
  </button>
</template>

<script>
export default {
  name: 'BaseButton',
  props: {
    variant: {
      type: String,
      default: 'primary',
      validator: (value) =>
        ['primary', 'secondary', 'danger', 'success', 'warning'].includes(value),
    },
    size: {
      type: String,
      default: 'md',
      validator: (value) => ['sm', 'md', 'lg'].includes(value),
    },
    type: {
      type: String,
      default: 'button',
      validator: (value) => ['button', 'submit', 'reset'].includes(value),
    },
    label: String,
    disabled: Boolean,
    loading: Boolean,
    customClass: String,
  },
  emits: ['click'],
};
</script>

<style scoped>
.button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-weight: 500;
  border: none;
  border-radius: 0.5rem;
  cursor: pointer;
  transition: all 0.2s ease;
  font-family: inherit;
  gap: 0.5rem;
  position: relative;
}

/* Variantes */
.button--primary {
  background-color: #2563eb;
  color: white;
}

.button--primary:hover:not(:disabled) {
  background-color: #1e40af;
}

.button--secondary {
  background-color: #e5e7eb;
  color: #111827;
}

.button--secondary:hover:not(:disabled) {
  background-color: #d1d5db;
}

.button--danger {
  background-color: #ef4444;
  color: white;
}

.button--danger:hover:not(:disabled) {
  background-color: #dc2626;
}

.button--success {
  background-color: #22c55e;
  color: white;
}

.button--success:hover:not(:disabled) {
  background-color: #16a34a;
}

.button--warning {
  background-color: #f59e0b;
  color: white;
}

.button--warning:hover:not(:disabled) {
  background-color: #d97706;
}

/* Tamaños */
.button--sm {
  padding: 0.5rem 0.75rem;
  font-size: 0.875rem;
}

.button--md {
  padding: 0.75rem 1.5rem;
  font-size: 1rem;
}

.button--lg {
  padding: 1rem 2rem;
  font-size: 1.125rem;
}

/* Estados */
.button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.button--loading {
  pointer-events: none;
}

.button__spinner {
  display: inline-block;
  width: 1em;
  height: 1em;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-top-color: white;
  border-radius: 50%;
  animation: spin 0.6s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}
</style>
