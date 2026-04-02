import api from './api'

export default {
  sendAlert(data) {
    return api.post('/alerts/send', data)
  },

  sendBulkAlerts(data) {
    return api.post('/alerts/send-bulk', data)
  },

  getAlerts() {
    return api.get('/alerts')
  },
}
