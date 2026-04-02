import api from './api'

export default {
  getOrders(params) {
    return api.get('/orders', { params })
  },

  getOrdersByLot(lotNumber) {
    return api.get('/orders/by-lot', { params: { lot_number: lotNumber } })
  },

  getOrder(id) {
    return api.get(`/orders/${id}`)
  },
}
