<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Medication;
use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Http\Request;
use Carbon\Carbon;

class MedicationController extends Controller
{
    /**
     * Search medications by lot number and optional date range
     */
    public function search(Request $request)
    {
        $request->validate([
            'lot_number' => 'required|string',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
        ]);

        $lotNumber = $request->lot_number;
        $startDate = $request->start_date ?? Carbon::now()->subDays(30)->format('Y-m-d');
        $endDate = $request->end_date ?? Carbon::now()->format('Y-m-d');

        // Find medications with the specified lot number
        $medications = Medication::where('lot_number', $lotNumber)->get();

        if ($medications->isEmpty()) {
            return response()->json([
                'message' => 'No medications found with the specified lot number',
                'medications' => [],
                'orders' => [],
            ], 404);
        }

        // Get orders containing these medications within the date range
        $medicationIds = $medications->pluck('id');
        
        $orders = Order::with(['customer', 'orderItems.medication'])
            ->whereHas('orderItems', function ($query) use ($medicationIds) {
                $query->whereIn('medication_id', $medicationIds);
            })
            ->whereBetween('purchase_date', [$startDate, $endDate])
            ->orderBy('purchase_date', 'desc')
            ->get();

        return response()->json([
            'message' => 'Search completed successfully',
            'search_params' => [
                'lot_number' => $lotNumber,
                'start_date' => $startDate,
                'end_date' => $endDate,
            ],
            'medications' => $medications,
            'orders_count' => $orders->count(),
            'orders' => $orders,
        ]);
    }

    /**
     * Get all medications
     */
    public function index()
    {
        $medications = Medication::all();
        
        return response()->json([
            'medications' => $medications,
        ]);
    }
}
