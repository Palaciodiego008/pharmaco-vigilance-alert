#!/bin/bash

echo "🚀 Starting Pharmacovigilance Alert System Setup..."
echo ""

# Check if MySQL is running
echo "📊 Checking MySQL connection..."
if ! mysql -u root -e "SELECT 1" &> /dev/null; then
    echo "❌ MySQL is not running or not accessible. Please start MySQL first."
    exit 1
fi

echo "✅ MySQL is running"
echo ""

# Backend setup
echo "🔧 Setting up Backend..."
cd backend

echo "📦 Installing Composer dependencies..."
composer install --quiet

echo "🗄️  Creating database..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS pharmacovigilance;"

echo "🔄 Running migrations and seeders..."
php artisan migrate:fresh --seed --force

echo "✅ Backend setup complete!"
echo ""

# Return to root
cd ..

# Frontend setup
echo "🎨 Setting up Frontend..."
cd frontend

echo "📦 Installing NPM dependencies..."
npm install

echo "✅ Frontend setup complete!"
echo ""

cd ..

echo ""
echo "✨ Setup Complete! ✨"
echo ""
echo "To start the application:"
echo ""
echo "1. Start Backend (Terminal 1):"
echo "   cd backend && php artisan serve"
echo ""
echo "2. Start Frontend (Terminal 2):"
echo "   cd frontend && npm run dev"
echo ""
echo "3. Access the application:"
echo "   Frontend: http://localhost:5173"
echo "   Backend API: http://localhost:8000"
echo ""
echo "4. Login credentials:"
echo "   Email: admin@pharmacovigilance.com"
echo "   Password: password123"
echo ""
