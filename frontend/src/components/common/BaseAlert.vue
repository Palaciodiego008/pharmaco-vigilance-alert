<template>
  <div v-if="show" :class="['alert', `alert--${type}`]">
    <div class="alert__content">
      <span class="alert__icon">{{ icons[type] }}</span>
      <div>
        <h4 v-if="title" class="alert__title">{{ title }}</h4>
        <p v-if="message" class="alert__message">{{ message }}</p>
        <slot></slot>
      </div>
    </div>
    <button v-if="closeable" class="alert__close" @click="show = false">
      ✕
    </button>
  </div>
</template>

<script>
export default {
  name: 'BaseAlert',
  props: {
    type: {
      type: String,
      default: 'info',
      validator: (value) =>
        ['success', 'error', 'warning', 'info'].includes(value),
    },
    title: String,
    message: String,
    closeable: {
      type: Boolean,
      default: true,
    },
    autoClose: {
      type: Number,
      default: 0,
    },
  },
  data() {
    return {
      show: true,
      icons: {
        success: '✓',
        error: '✕',
        warning: '⚠',
        info: 'ℹ',
      },
    };
  },
  watch: {
    autoClose(value) {
      if (value > 0) {
        setTimeout(() => {
          this.show = false;
        }, value);
      }
    },
  },
  mounted() {
    if (this.autoClose > 0) {
      setTimeout(() => {
        this.show = false;
      }, this.autoClose);
    }
  },
};
</script>

<style scoped>
.alert {
  padding: 1rem;
  border-radius: 0.5rem;
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  animation: slideIn 0.3s ease;
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.alert__content {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  flex: 1;
}

.alert__icon {
  font-weight: bold;
  font-size: 1.25rem;
  flex-shrink: 0;
}

.alert__title {
  margin: 0 0 0.25rem 0;
  font-size: 0.95rem;
  font-weight: 600;
}

.alert__message {
  margin: 0;
  font-size: 0.875rem;
}

.alert__close {
  background: none;
  border: none;
  cursor: pointer;
  font-size: 1.25rem;
  padding: 0;
  color: inherit;
  opacity: 0.7;
  transition: opacity 0.2s;
}

.alert__close:hover {
  opacity: 1;
}

/* Variantes */
.alert--success {
  background-color: #d1fae5;
  border: 1px solid #6ee7b7;
  color: #047857;
}

.alert--error {
  background-color: #fee2e2;
  border: 1px solid #fca5a5;
  color: #991b1b;
}

.alert--warning {
  background-color: #fef3c7;
  border: 1px solid #fde68a;
  color: #92400e;
}

.alert--info {
  background-color: #dbeafe;
  border: 1px solid #93c5fd;
  color: #1e40af;
}
</style>
