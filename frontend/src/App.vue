<script setup>
import { onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { useAuthStore } from './stores/auth'
import AppLayout from './components/layout/AppLayout.vue'

const authStore = useAuthStore()
const route = useRoute()

onMounted(() => {
  authStore.initAuth()
})

const isLoginPage = () => route.path === '/login'
</script>

<template>
  <div id="app">
    <AppLayout v-if="!isLoginPage()">
      <router-view />
    </AppLayout>
    <router-view v-else />
  </div>
</template>

<style>
#app {
  min-height: 100vh;
}
</style>
