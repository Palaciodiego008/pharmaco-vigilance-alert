<template>
  <div class="app-layout">
    <LayoutHeader />
    
    <div class="app-layout__body">
      <LayoutSidebar />
      
      <main class="app-layout__main">
        <slot />
      </main>
    </div>

    <LayoutFooter />
  </div>
</template>

<script setup>
import LayoutHeader from './LayoutHeader.vue'
import LayoutSidebar from './LayoutSidebar.vue'
import LayoutFooter from './LayoutFooter.vue'
</script>

<style scoped>
.app-layout {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.app-layout__body {
  display: flex;
  flex: 1;
}

.app-layout__main {
  flex: 1;
  overflow-y: auto;
  background-color: var(--color-background, #ffffff);
  padding: 20px;
}

@media (max-width: 768px) {
  .app-layout__main {
    padding: 15px;
  }
}

@media (max-width: 480px) {
  .app-layout__main {
    padding: 10px;
  }
}
</style>
