// API endpoints
export const API_ENDPOINTS = {
  LOGIN: '/login',
  LOGOUT: '/logout',
  MEDICATIONS: {
    SEARCH: '/medications/search',
  },
  ORDERS: {
    LIST: '/orders',
    DETAILS: (id) => `/orders/${id}`,
  },
  CUSTOMERS: {
    LIST: '/customers',
    DETAILS: (id) => `/customers/${id}`,
  },
  ALERTS: {
    LIST: '/alerts',
    SEND: '/alerts/send',
    SEND_BULK: '/alerts/send-bulk',
  },
};

// Status codes
export const HTTP_STATUS = {
  OK: 200,
  CREATED: 201,
  BAD_REQUEST: 400,
  UNAUTHORIZED: 401,
  FORBIDDEN: 403,
  NOT_FOUND: 404,
  INTERNAL_ERROR: 500,
};

// Order statuses
export const ORDER_STATUS = {
  PENDING: 'pending',
  COMPLETED: 'completed',
  CANCELLED: 'cancelled',
  PROCESSING: 'processing',
};

export const ORDER_STATUS_LABELS = {
  pending: 'Pendiente',
  completed: 'Completado',
  cancelled: 'Cancelado',
  processing: 'Procesando',
};

export const ORDER_STATUS_COLORS = {
  pending: '#f59e0b',
  completed: '#10b981',
  cancelled: '#ef4444',
  processing: '#0ea5e9',
};

// Alert types
export const ALERT_TYPES = {
  EMAIL: 'email',
  SMS: 'sms',
  PUSH: 'push',
};

// Local storage keys
export const STORAGE_KEYS = {
  AUTH_TOKEN: 'auth_token',
  USER: 'user',
  PREFERENCES: 'preferences',
};

// Pagination
export const DEFAULT_PAGE_SIZE = 15;
export const PAGE_SIZES = [10, 15, 25, 50];

// Validation messages
export const VALIDATION_MESSAGES = {
  REQUIRED: 'Este campo es requerido',
  EMAIL: 'Ingrese un email válido',
  MIN_LENGTH: (min) => `Mínimo ${min} caracteres`,
  MAX_LENGTH: (max) => `Máximo ${max} caracteres`,
  PASSWORD_WEAK: 'La contraseña debe tener al menos 8 caracteres',
  PASSWORDS_DONT_MATCH: 'Las contraseñas no coinciden',
};

// Date formats
export const DATE_FORMATS = {
  SHORT: 'DD/MM/YYYY',
  LONG: 'DD MMMM YYYY',
  TIME: 'HH:mm:ss',
  DATETIME: 'DD/MM/YYYY HH:mm',
};

// Route names
export const ROUTE_NAMES = {
  LOGIN: 'login',
  DASHBOARD: 'dashboard',
  SEARCH: 'search',
  ORDERS: 'orders',
  ORDER_DETAILS: 'order-details',
  CUSTOMERS: 'customers',
  CUSTOMER_DETAILS: 'customer-details',
  ALERTS: 'alerts',
};
