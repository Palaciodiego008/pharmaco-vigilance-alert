<template>
  <aside class="layout-sidebar">
    <nav class="nav-menu">
      <div class="nav-section">
        <h3 class="nav-title">Menu</h3>
        <ul class="nav-list">
          <li v-for="item in navigationItems" :key="item.name">
            <router-link
              :to="item.path"
              :class="['nav-link', { active: isActive(item.path) }]"
            >
              <span class="nav-icon">{{ item.icon }}</span>
              <span class="nav-label">{{ item.label }}</span>
            </router-link>
          </li>
        </ul>
      </div>
    </nav>
  </aside>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

const navigationItems = [
  {
    name: 'Dashboard',
    label: 'Dashboard',
    path: '/dashboard',
    icon: '📊'
  },
  {
    name: 'Search',
    label: 'Search',
    path: '/search',
    icon: '🔍'
  },
  {
    name: 'Alerts',
    label: 'Alerts',
    path: '/alerts',
    icon: '🔔'
  }
]

const isActive = (path) => {
  return route.path === path || route.path.startsWith(path + '/')
}
</script>

<style scoped>
.layout-sidebar {
  width: 250px;
  background-color: var(--sidebar-bg, var(--color-surface, #f9f9f9));
  border-right: 1px solid var(--color-border, #e5e4e7);
  padding: 20px 0;
  overflow-y: auto;
  max-height: calc(100vh - var(--header-height, 60px));
}

.nav-menu {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.nav-section {
  padding: 0 10px;
}

.nav-title {
  font-size: 12px;
  font-weight: 600;
  text-transform: uppercase;
  color: var(--color-text-secondary, #9ca3af);
  padding: 0 10px;
  margin: 0 0 10px 0;
  letter-spacing: 0.5px;
}

.nav-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.nav-link {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px 15px;
  color: var(--color-text, #6b6375);
  text-decoration: none;
  border-radius: 6px;
  transition: all 0.2s ease;
  font-size: 14px;
  font-weight: 500;

  &:hover {
    background-color: var(--color-hover, rgba(170, 59, 255, 0.1));
    color: var(--color-primary, #aa3bff);
  }

  &.active {
    background-color: var(--color-primary-bg, rgba(170, 59, 255, 0.15));
    color: var(--color-primary, #aa3bff);
    font-weight: 600;
  }
}

.nav-icon {
  font-size: 18px;
  width: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.nav-label {
  flex: 1;
}

@media (max-width: 768px) {
  .layout-sidebar {
    width: 200px;
  }

  .nav-label {
    display: none;
  }

  .nav-link {
    justify-content: center;
    padding: 10px;
  }

  .nav-icon {
    width: auto;
  }
}

@media (max-width: 480px) {
  .layout-sidebar {
    display: none;
  }
}
</style>
