<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Order;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    /**
     * Get all orders with pagination
     */
    public function index(Request $request)
    {
        $perPage = $request->get('per_page', 15);
        
        $orders = Order::with(['customer', 'orderItems.medication'])
            ->orderBy('purchase_date', 'desc')
            ->paginate($perPage);

        return response()->json($orders);
    }

    /**
     * Get orders by lot number
     */
    public function getByLotNumber(Request $request)
    {
        $request->validate([
            'lot_number' => 'required|string',
        ]);

        $lotNumber = $request->lot_number;

        $orders = Order::with(['customer', 'orderItems.medication'])
            ->whereHas('orderItems.medication', function ($query) use ($lotNumber) {
                $query->where('lot_number', $lotNumber);
            })
            ->orderBy('purchase_date', 'desc')
            ->get();

        return response()->json([
            'orders' => $orders,
            'count' => $orders->count(),
        ]);
    }

    /**
     * Get single order details
     */
    public function show($id)
    {
        $order = Order::with(['customer', 'orderItems.medication', 'alerts'])
            ->findOrFail($id);

        return response()->json([
            'order' => $order,
        ]);
    }
}
