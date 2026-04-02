<template>
  <div class="login-container">
    <div class="login-card">
      <div class="login-header">
        <h1 class="login-title">
          <span class="login-icon">⚕️</span>
          Pharmacovigilance Alert
        </h1>
        <p class="login-subtitle">Sign in to access the system</p>
      </div>

      <form @submit.prevent="handleLogin" class="login-form">
        <BaseInput
          v-model="credentials.email"
          type="email"
          label="Email Address"
          placeholder="Enter your email"
          :disabled="loading"
          required
          @keyup.enter="handleLogin"
        />

        <BaseInput
          v-model="credentials.password"
          type="password"
          label="Password"
          placeholder="Enter your password"
          :disabled="loading"
          required
          @keyup.enter="handleLogin"
        />

        <BaseAlert
          v-if="error"
          type="error"
          :closeable="true"
          @close="error = null"
          class="login-error"
        >
          {{ error }}
        </BaseAlert>

        <BaseButton
          type="submit"
          variant="primary"
          size="lg"
          :loading="loading"
          :disabled="loading"
          class="login-button"
        >
          {{ loading ? 'Signing in...' : 'Sign In' }}
        </BaseButton>
      </form>

      <div class="demo-credentials">
        <p class="demo-title">Demo Credentials</p>
        <p class="demo-item"><strong>Email:</strong> admin@pharmacovigilance.com</p>
        <p class="demo-item"><strong>Password:</strong> password123</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import BaseInput from '../components/common/BaseInput.vue'
import BaseButton from '../components/common/BaseButton.vue'
import BaseAlert from '../components/common/BaseAlert.vue'

const router = useRouter()
const authStore = useAuthStore()

const credentials = ref({
  email: '',
  password: '',
})

const loading = ref(false)
const error = ref(null)

async function handleLogin() {
  if (!credentials.value.email || !credentials.value.password) {
    error.value = 'Please enter both email and password'
    return
  }

  loading.value = true
  error.value = null

  try {
    await authStore.login(credentials.value)
    router.push('/dashboard')
  } catch (err) {
    error.value = err.response?.data?.message || 'Invalid credentials'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, var(--color-primary, #667eea) 0%, #764ba2 100%);
  padding: 20px;
}

.login-card {
  background-color: var(--color-background, #ffffff);
  border-radius: 12px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
  padding: 40px;
  max-width: 450px;
  width: 100%;
}

.login-header {
  text-align: center;
  margin-bottom: 30px;
}

.login-icon {
  font-size: 2.5rem;
  display: block;
  margin-bottom: 15px;
}

.login-title {
  color: var(--color-text-heading, #08060d);
  margin: 0;
  font-size: 28px;
  font-weight: 600;
}

.login-subtitle {
  color: var(--color-text-secondary, #9ca3af);
  font-size: 14px;
  margin: 10px 0 0 0;
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
  margin-bottom: 30px;
}

.login-error {
  margin: 0;
}

.login-button {
  width: 100%;
}

.demo-credentials {
  background-color: var(--color-surface-light, #f8f9fa);
  border: 1px solid var(--color-border-light, #e5e7eb);
  padding: 16px;
  border-radius: 8px;
  font-size: 13px;
  color: var(--color-text-secondary, #6b6375);
}

.demo-title {
  margin: 0 0 10px 0;
  font-weight: 600;
  color: var(--color-text, #6b6375);
  font-size: 14px;
}

.demo-item {
  margin: 6px 0;
  font-size: 12px;
}

@media (max-width: 480px) {
  .login-card {
    padding: 25px;
  }

  .login-title {
    font-size: 22px;
  }

  .login-icon {
    font-size: 2rem;
  }
}
</style>

