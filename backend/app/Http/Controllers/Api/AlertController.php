<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Alert;
use App\Models\Customer;
use App\Models\Order;
use App\Models\Medication;
use App\Mail\PharmacovigilanceAlert;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Carbon\Carbon;

class AlertController extends Controller
{
    /**
     * Send alert to a single customer
     */
    public function send(Request $request)
    {
        $request->validate([
            'customer_id' => 'required|exists:customers,id',
            'order_id' => 'required|exists:orders,id',
            'lot_number' => 'required|string',
        ]);

        $customer = Customer::findOrFail($request->customer_id);
        $order = Order::with('orderItems.medication')->findOrFail($request->order_id);
        
        // Find medication with the lot number
        $medication = Medication::where('lot_number', $request->lot_number)->first();

        if (!$medication) {
            return response()->json([
                'message' => 'Medication with specified lot number not found',
            ], 404);
        }

        // Create alert message
        $message = "PHARMACOVIGILANCE ALERT: The medication '{$medication->name}' (Lot #{$medication->lot_number}) that you purchased on {$order->purchase_date->format('F d, Y')} has been identified in a pharmacovigilance review. Please contact your healthcare provider immediately for further guidance.";

        try {
            // Send email
            Mail::to($customer->email)->send(new PharmacovigilanceAlert($customer, $order, $medication));

            // Log the alert
            $alert = Alert::create([
                'customer_id' => $customer->id,
                'order_id' => $order->id,
                'user_id' => $request->user()->id,
                'alert_type' => 'email',
                'message' => $message,
                'sent_at' => Carbon::now(),
            ]);

            return response()->json([
                'message' => 'Alert sent successfully',
                'alert' => $alert,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to send alert',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Send bulk alerts to multiple customers
     */
    public function sendBulk(Request $request)
    {
        $request->validate([
            'alerts' => 'required|array',
            'alerts.*.customer_id' => 'required|exists:customers,id',
            'alerts.*.order_id' => 'required|exists:orders,id',
            'lot_number' => 'required|string',
        ]);

        $medication = Medication::where('lot_number', $request->lot_number)->first();

        if (!$medication) {
            return response()->json([
                'message' => 'Medication with specified lot number not found',
            ], 404);
        }

        $successCount = 0;
        $failedCount = 0;
        $errors = [];

        foreach ($request->alerts as $alertData) {
            try {
                $customer = Customer::findOrFail($alertData['customer_id']);
                $order = Order::with('orderItems.medication')->findOrFail($alertData['order_id']);

                $message = "PHARMACOVIGILANCE ALERT: The medication '{$medication->name}' (Lot #{$medication->lot_number}) that you purchased on {$order->purchase_date->format('F d, Y')} has been identified in a pharmacovigilance review. Please contact your healthcare provider immediately for further guidance.";

                // Send email
                Mail::to($customer->email)->send(new PharmacovigilanceAlert($customer, $order, $medication));

                // Log the alert
                Alert::create([
                    'customer_id' => $customer->id,
                    'order_id' => $order->id,
                    'user_id' => $request->user()->id,
                    'alert_type' => 'email',
                    'message' => $message,
                    'sent_at' => Carbon::now(),
                ]);

                $successCount++;
            } catch (\Exception $e) {
                $failedCount++;
                $errors[] = [
                    'customer_id' => $alertData['customer_id'],
                    'error' => $e->getMessage(),
                ];
            }
        }

        return response()->json([
            'message' => 'Bulk alert process completed',
            'success_count' => $successCount,
            'failed_count' => $failedCount,
            'errors' => $errors,
        ]);
    }

    /**
     * Get all alerts
     */
    public function index()
    {
        $alerts = Alert::with(['customer', 'order', 'user'])
            ->orderBy('sent_at', 'desc')
            ->get();

        return response()->json([
            'alerts' => $alerts,
        ]);
    }
}
