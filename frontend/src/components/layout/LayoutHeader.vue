<template>
  <header class="header">
    <div class="header__container">
      <div class="header__brand">
        <h1 class="header__logo">
          <router-link to="/dashboard">
            <span class="logo-icon">⚕️</span>
            PharmaAlert
          </router-link>
        </h1>
      </div>

      <nav class="header__nav">
        <router-link
          v-for="item in navItems"
          :key="item.path"
          :to="item.path"
          class="header__link"
          active-class="header__link--active"
        >
          {{ item.label }}
        </router-link>
      </nav>

      <div class="header__actions">
        <div class="header__user">
          <span class="header__username">{{ user?.name }}</span>
          <button class="header__logout" @click="handleLogout" title="Cerrar sesión">
            Salir
          </button>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
import { useAuthStore } from '@/stores/auth';
import { useRouter } from 'vue-router';

export default {
  name: 'LayoutHeader',
  setup() {
    const authStore = useAuthStore();
    const router = useRouter();

    const navItems = [
      { path: '/dashboard', label: 'Dashboard' },
      { path: '/search', label: 'Medicamentos' },
      { path: '/orders', label: 'Órdenes' },
      { path: '/alerts', label: 'Alertas' },
    ];

    const handleLogout = async () => {
      await authStore.logout();
      router.push('/login');
    };

    return {
      navItems,
      handleLogout,
      user: authStore.user,
    };
  },
};
</script>

<style scoped>
.header {
  background-color: #fff;
  border-bottom: 1px solid #e5e7eb;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header__container {
  max-width: 1280px;
  margin: 0 auto;
  padding: 0 1.5rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 70px;
}

.header__brand {
  flex-shrink: 0;
}

.header__logo {
  margin: 0;
  font-size: 1.5rem;
  font-weight: 700;
}

.header__logo a {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: #111827;
  text-decoration: none;
  transition: color 0.2s;
}

.header__logo a:hover {
  color: #2563eb;
}

.logo-icon {
  font-size: 2rem;
}

.header__nav {
  flex: 1;
  display: flex;
  align-items: center;
  gap: 2rem;
  margin: 0 3rem;
}

.header__link {
  color: #6b7280;
  text-decoration: none;
  font-weight: 500;
  padding: 0.5rem 0;
  border-bottom: 2px solid transparent;
  transition: all 0.2s;
}

.header__link:hover,
.header__link--active {
  color: #2563eb;
  border-bottom-color: #2563eb;
}

.header__actions {
  flex-shrink: 0;
}

.header__user {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.header__username {
  color: #374151;
  font-weight: 500;
  font-size: 0.875rem;
}

.header__logout {
  background-color: #ef4444;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 0.5rem;
  cursor: pointer;
  font-weight: 500;
  transition: background-color 0.2s;
}

.header__logout:hover {
  background-color: #dc2626;
}

@media (max-width: 768px) {
  .header__nav {
    display: none;
  }

  .header__container {
    padding: 0 1rem;
  }

  .header__logo {
    font-size: 1.25rem;
  }

  .logo-icon {
    font-size: 1.5rem;
  }
}
</style>
