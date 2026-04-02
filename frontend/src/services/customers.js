import api from './api'

export default {
  getCustomers() {
    return api.get('/customers')
  },

  getCustomer(id) {
    return api.get(`/customers/${id}`)
  },
}
