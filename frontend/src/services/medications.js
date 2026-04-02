import api from './api'

export default {
  searchMedications(params) {
    return api.get('/medications/search', { params })
  },

  getAllMedications() {
    return api.get('/medications')
  },
}
