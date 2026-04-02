<template>
  <footer class="layout-footer">
    <div class="footer-content">
      <div class="footer-section">
        <h4 class="footer-title">Pharmaco Vigilance Alert</h4>
        <p class="footer-description">
          Advanced pharmacovigilance monitoring and alert management system
        </p>
      </div>

      <div class="footer-section">
        <h4 class="footer-title">Quick Links</h4>
        <ul class="footer-links">
          <li>
            <router-link to="/dashboard">Dashboard</router-link>
          </li>
          <li>
            <router-link to="/search">Search</router-link>
          </li>
          <li>
            <router-link to="/alerts">Alerts</router-link>
          </li>
        </ul>
      </div>

      <div class="footer-section">
        <h4 class="footer-title">Support</h4>
        <ul class="footer-links">
          <li>
            <a href="#" @click.prevent>Documentation</a>
          </li>
          <li>
            <a href="#" @click.prevent>Contact Us</a>
          </li>
          <li>
            <a href="#" @click.prevent>Terms & Privacy</a>
          </li>
        </ul>
      </div>
    </div>

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
  padding: 40px 20px 20px;
  margin-top: 60px;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 30px;
  margin-bottom: 30px;
}

.footer-section {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.footer-title {
  font-size: 14px;
  font-weight: 600;
  color: var(--color-text-heading, #08060d);
  margin: 0;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.footer-description {
  font-size: 13px;
  color: var(--color-text-secondary, #9ca3af);
  line-height: 1.6;
  margin: 0;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.footer-links a {
  font-size: 13px;
  color: var(--color-text, #6b6375);
  text-decoration: none;
  transition: color 0.2s ease;

  &:hover {
    color: var(--color-primary, #aa3bff);
  }
}

.footer-bottom {
  max-width: 1200px;
  margin: 0 auto;
  padding-top: 20px;
  border-top: 1px solid var(--color-border, #e5e4e7);
  text-align: center;
}

.footer-copyright {
  font-size: 12px;
  color: var(--color-text-secondary, #9ca3af);
  margin: 0;
}

@media (max-width: 768px) {
  .layout-footer {
    padding: 30px 15px 15px;
    margin-top: 40px;
  }

  .footer-content {
    grid-template-columns: 1fr;
    gap: 20px;
    margin-bottom: 20px;
  }

  .footer-bottom {
    padding-top: 15px;
  }
}
</style>
