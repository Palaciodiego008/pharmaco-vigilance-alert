<template>
  <div class="layout">
    <nav class="navbar">
      <div class="navbar-brand">
        <h1>Pharmacovigilance System</h1>
      </div>
      <div class="navbar-menu">
        <router-link to="/dashboard" class="nav-link">Dashboard</router-link>
        <router-link to="/search" class="nav-link">Search</router-link>
        <router-link to="/alerts" class="nav-link">Alert History</router-link>
      </div>
      <div class="navbar-user">
        <span class="user-name">{{ authStore.user?.name }}</span>
        <button @click="handleLogout" class="btn-logout">Logout</button>
      </div>
    </nav>

    <main class="main-content">
      <slot />
    </main>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const router = useRouter()
const authStore = useAuthStore()

async function handleLogout() {
  await authStore.logout()
  router.push('/login')
}
</script>

<style scoped>
.layout {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.navbar {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 1rem 2rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.navbar-brand h1 {
  margin: 0;
  font-size: 20px;
  font-weight: 600;
}

.navbar-menu {
  display: flex;
  gap: 1.5rem;
}

.nav-link {
  color: white;
  text-decoration: none;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  transition: background-color 0.3s;
}

.nav-link:hover,
.nav-link.router-link-active {
  background-color: rgba(255, 255, 255, 0.2);
}

.navbar-user {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.user-name {
  font-size: 14px;
}

.btn-logout {
  padding: 0.5rem 1rem;
  background-color: rgba(255, 255, 255, 0.2);
  color: white;
  border: 1px solid white;
  border-radius: 5px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.3s;
}

.btn-logout:hover {
  background-color: rgba(255, 255, 255, 0.3);
}

.main-content {
  flex: 1;
  padding: 2rem;
  max-width: 1400px;
  width: 100%;
  margin: 0 auto;
}
</style>
