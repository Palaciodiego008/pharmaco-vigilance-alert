<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\MedicationController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\CustomerController;
use App\Http\Controllers\Api\AlertController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// Public routes
Route::post('/login', [AuthController::class, 'login']);

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    // Auth routes
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);
    
    // Medication routes
    Route::get('/medications', [MedicationController::class, 'index']);
    Route::get('/medications/search', [MedicationController::class, 'search']);
    
    // Order routes
    Route::get('/orders', [OrderController::class, 'index']);
    Route::get('/orders/by-lot', [OrderController::class, 'getByLotNumber']);
    Route::get('/orders/{id}', [OrderController::class, 'show']);
    
    // Customer routes
    Route::get('/customers', [CustomerController::class, 'index']);
    Route::get('/customers/{id}', [CustomerController::class, 'show']);
    
    // Alert routes
    Route::get('/alerts', [AlertController::class, 'index']);
    Route::post('/alerts/send', [AlertController::class, 'send']);
    Route::post('/alerts/send-bulk', [AlertController::class, 'sendBulk']);
});
