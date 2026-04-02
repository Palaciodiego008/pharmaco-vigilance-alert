# Pharmacovigilance Alert System

A comprehensive full-stack application for managing pharmacovigilance alerts in compounding pharmacies. Built with Laravel (backend) and Vue.js (frontend) in a monorepo structure.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Installation](#installation)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Database Schema](#database-schema)
- [Design Decisions](#design-decisions)
- [Docker Deployment](#docker-deployment)

## 🎯 Overview

This system enables compounding pharmacies to:
- Identify customers who purchased medications with specific lot numbers
- Send email alerts to affected customers
- Track alert history with audit logging
- Manage customer and order information

## ✨ Features

### Core Features
- ✅ User authentication (Laravel Sanctum)
- ✅ Medication search by lot number and date range
- ✅ Order retrieval with filtering
- ✅ Customer management
- ✅ Individual and bulk email alerts
- ✅ Alert audit logging
- ✅ Responsive UI with Vue.js

### Bonus Features
- ✅ Pagination support
- ✅ Docker containerization
- ✅ Clean architecture (MVC)
- ✅ Input validation and error handling
- ✅ Reusable Vue components
- ✅ RESTful API design

## 🛠 Tech Stack

### Backend
- **Framework:** Laravel 13.x
- **Authentication:** Laravel Sanctum
- **Database:** MySQL 8.0
- **Mail:** SMTP (Mailhog for development)

### Frontend
- **Framework:** Vue 3 (Composition API)
- **Build Tool:** Vite
- **State Management:** Pinia
- **Routing:** Vue Router 4
- **HTTP Client:** Axios

### DevOps
- **Containerization:** Docker & Docker Compose
- **Database UI:** phpMyAdmin

## 🏗 Architecture

```
pharmaco-vigilance-alert/
├── backend/                 # Laravel API
│   ├── app/
│   │   ├── Http/Controllers/Api/
│   │   ├── Mail/
│   │   └── Models/
│   ├── database/
│   │   ├── migrations/
│   │   └── seeders/
│   └── routes/api.php
├── frontend/                # Vue.js SPA
│   ├── src/
│   │   ├── components/
│   │   ├── views/
│   │   ├── services/
│   │   ├── stores/
│   │   └── router/
│   └── package.json
├── docker-compose.yml
└── README.md
```

## 📦 Installation

### Prerequisites
- PHP 8.2+
- Composer
- Node.js 18+
- MySQL 8.0
- Docker (optional)

### Method 1: Local Setup

#### Backend Setup

1. Navigate to backend directory:
```bash
cd backend
```

2. Install dependencies:
```bash
composer install
```

3. Create database:
```bash
mysql -u root -p
CREATE DATABASE pharmacovigilance;
exit;
```

4. Configure environment (already configured):
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=pharmacovigilance
DB_USERNAME=root
DB_PASSWORD=
```

5. Run migrations and seed data:
```bash
php artisan migrate --seed
```

6. Start the server:
```bash
php artisan serve
```

Backend will run on `http://localhost:8000`

#### Frontend Setup

1. Navigate to frontend directory:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
```

3. Start development server:
```bash
npm run dev
```

Frontend will run on `http://localhost:5173`

### Method 2: Docker Setup

1. Build and start containers:
```bash
docker-compose up -d
```

2. Run migrations inside container:
```bash
docker exec -it pharmacovigilance_backend php artisan migrate --seed
```

**Services:**
- Frontend: http://localhost:5173
- Backend API: http://localhost:8000
- phpMyAdmin: http://localhost:8080
- MySQL: localhost:3306

## 🚀 Usage

### Login Credentials

**Admin Account:**
- Email: `admin@pharmacovigilance.com`
- Password: `password123`

**Manager Account:**
- Email: `manager@pharmacovigilance.com`
- Password: `password123`

### Workflow

1. **Login** - Access the system with provided credentials
2. **Search** - Navigate to Search page
3. **Filter** - Enter lot number (e.g., 951357) and optional date range
4. **Review** - View list of affected orders
5. **Alert** - Send individual or bulk alerts
6. **Audit** - Check Alert History for sent notifications

## 📡 API Documentation

### Authentication

#### POST /api/login
Login and get access token

**Request:**
```json
{
  "email": "admin@pharmacovigilance.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "message": "Login successful",
  "user": {
    "id": 1,
    "name": "Pharmacovigilance Admin",
    "email": "admin@pharmacovigilance.com"
  },
  "token": "1|abc123..."
}
```

### Medications

#### GET /api/medications/search
Search medications by lot number

**Parameters:**
- `lot_number` (required): Medication lot number
- `start_date` (optional): Start of date range
- `end_date` (optional): End of date range

### Alerts

#### POST /api/alerts/send
Send alert to single customer

**Request:**
```json
{
  "customer_id": 1,
  "order_id": 5,
  "lot_number": "951357"
}
```

#### POST /api/alerts/send-bulk
Send bulk alerts

## 🗄 Database Schema

### Users
- id, name, email, password, timestamps

### Customers
- id, name, email, phone, timestamps

### Medications
- id, name, lot_number (indexed), description, timestamps

### Orders
- id, customer_id (FK), purchase_date, total_amount, status, timestamps

### Order_Items
- id, order_id (FK), medication_id (FK), quantity, unit_price, subtotal, timestamps

### Alerts
- id, customer_id (FK), order_id (FK), user_id (FK), alert_type, message, sent_at, timestamps

## 💡 Design Decisions

### Architecture
1. **Monorepo Structure**: Keeps frontend and backend together for easier development
2. **RESTful API**: Follows REST principles for clean endpoints
3. **Token-Based Auth**: Laravel Sanctum provides secure authentication
4. **Composition API**: Vue 3 for better code organization
5. **Service Layer**: Frontend services abstract API calls

### Security
- Password hashing with bcrypt
- Token-based authentication
- Input validation on both sides
- SQL injection prevention through Eloquent ORM

### Performance
- Database indexing on lot_number
- Pagination support
- Eager loading to prevent N+1 queries
- Axios interceptors for token management

## 🐳 Docker Deployment

### Start Services
```bash
docker-compose up -d
```

### Stop Services
```bash
docker-compose down
```

### Reset Database
```bash
docker exec -it pharmacovigilance_backend php artisan migrate:fresh --seed
```

## 📝 Sample Data

The system comes pre-seeded with:
- 2 users (admin and manager)
- 10 customers
- 8 medications (including lot #951357)
- 20 orders from the last 45 days