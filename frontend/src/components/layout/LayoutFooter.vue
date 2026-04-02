<template>
  <footer class="layout-footer">
    <div class="footer-bottom">
      <p class="footer-copyright">
        &copy; {{ currentYear }} Pharmaco Vigilance Alert. All rights reserved.
      </p>
    </div>
  </footer>
</template>

<script setup>
import { ref } from 'vue'

const currentYear = ref(new Date().getFullYear())
</script>

<style scoped>
.layout-footer {
  background-color: var(--footer-bg, var(--color-surface, #f9f9f9));
  border-top: 1px solid var(--color-border, #e5e4e7);
  padding: 20px;
  margin-top: 60px;
}

.footer-bottom {
  max-width: 1200px;
  margin: 0 auto;
  text-align: center;
}

.footer-copyright {
  font-size: 12px;
  color: var(--color-text-secondary, #9ca3af);
  margin: 0;
}

@media (max-width: 768px) {
  .layout-footer {
    padding: 15px;
    margin-top: 40px;
  }
}
</style>
