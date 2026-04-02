<?php

namespace Database\Seeders;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Customer;
use App\Models\Medication;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Carbon\Carbon;

class OrderSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $customers = Customer::all();
        $medications = Medication::all();

        // Create orders from the last 45 days
        for ($i = 0; $i < 20; $i++) {
            $customer = $customers->random();
            $purchaseDate = Carbon::now()->subDays(rand(1, 45));
            
            $order = Order::create([
                'customer_id' => $customer->id,
                'purchase_date' => $purchaseDate,
                'total_amount' => 0,
                'status' => 'completed',
            ]);

            // Add 1-3 random medications to each order
            $numItems = rand(1, 3);
            $orderTotal = 0;

            for ($j = 0; $j < $numItems; $j++) {
                $medication = $medications->random();
                $quantity = rand(1, 3);
                $unitPrice = rand(10, 100);
                $subtotal = $quantity * $unitPrice;
                
                OrderItem::create([
                    'order_id' => $order->id,
                    'medication_id' => $medication->id,
                    'quantity' => $quantity,
                    'unit_price' => $unitPrice,
                    'subtotal' => $subtotal,
                ]);

                $orderTotal += $subtotal;
            }

            // Update order total
            $order->update(['total_amount' => $orderTotal]);
        }
    }
}
