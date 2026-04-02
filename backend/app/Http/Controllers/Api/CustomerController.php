<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use Illuminate\Http\Request;

class CustomerController extends Controller
{
    /**
     * Get all customers
     */
    public function index()
    {
        $customers = Customer::withCount('orders')->get();
        
        return response()->json([
            'customers' => $customers,
        ]);
    }

    /**
     * Get single customer details
     */
    public function show($id)
    {
        $customer = Customer::with(['orders.orderItems.medication', 'alerts'])
            ->findOrFail($id);

        return response()->json([
            'customer' => $customer,
        ]);
    }
}
