<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Customer;
use App\Models\Medication;
use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Database\Seeder;
use Carbon\Carbon;

class PDFRequirementSeeder extends Seeder
{
    /**
     * Seed the database with data matching PDF requirements.
     * 
     * Objective: Build a Pharmacovigilance module that enables a compounding pharmacy 
     * to identify and notify customers who purchased a medication associated with a 
     * specific lot number (951357) within a defined time range (last month).
     */
    public function run(): void
    {
        // 1. Create admin user (if not exists)
        User::firstOrCreate(
            ['email' => 'admin@pharmacovigilance.com'],
            [
                'name' => 'Pharmacovigilance Admin',
                'password' => bcrypt('password123'),
            ]
        );

        // 2. Create customers with realistic data
        $customers = [
            ['name' => 'John Smith', 'email' => 'john.smith@example.com', 'phone' => '555-0101'],
            ['name' => 'Sarah Johnson', 'email' => 'sarah.johnson@example.com', 'phone' => '555-0102'],
            ['name' => 'Michael Brown', 'email' => 'michael.brown@example.com', 'phone' => '555-0103'],
            ['name' => 'Emma Davis', 'email' => 'emma.davis@example.com', 'phone' => '555-0104'],
            ['name' => 'Robert Wilson', 'email' => 'robert.wilson@example.com', 'phone' => '555-0105'],
            ['name' => 'Jennifer Martinez', 'email' => 'jennifer.martinez@example.com', 'phone' => '555-0106'],
            ['name' => 'David Anderson', 'email' => 'david.anderson@example.com', 'phone' => '555-0107'],
            ['name' => 'Lisa Taylor', 'email' => 'lisa.taylor@example.com', 'phone' => '555-0108'],
        ];

        foreach ($customers as $customer) {
            Customer::firstOrCreate(
                ['email' => $customer['email']],
                $customer
            );
        }

        // 3. Create medications including lot 951357
        $medications = [
            // Primary lot 951357 - This is the critical one
            [
                'name' => 'Amoxicillin 500mg Capsule',
                'lot_number' => '951357',
                'description' => 'Antibiotic for bacterial infections (ALERT LOT)'
            ],
            [
                'name' => 'Amoxicillin/Clavulanic Acid 875mg',
                'lot_number' => '951357',
                'description' => 'Combination antibiotic (ALERT LOT)'
            ],
            // Other medications for comparison
            [
                'name' => 'Acetaminophen 500mg',
                'lot_number' => '951358',
                'description' => 'Pain reliever and fever reducer'
            ],
            [
                'name' => 'Ibuprofen 200mg',
                'lot_number' => '951359',
                'description' => 'Anti-inflammatory pain reliever'
            ],
            [
                'name' => 'Lisinopril 10mg',
                'lot_number' => '951360',
                'description' => 'Blood pressure medication'
            ],
            [
                'name' => 'Metformin 500mg',
                'lot_number' => '951361',
                'description' => 'Diabetes medication'
            ],
            [
                'name' => 'Atorvastatin 20mg',
                'lot_number' => '951362',
                'description' => 'Cholesterol-lowering medication'
            ],
        ];

        foreach ($medications as $medication) {
            Medication::firstOrCreate(
                ['lot_number' => $medication['lot_number'], 'name' => $medication['name']],
                $medication
            );
        }

        // 4. Create orders - ALL within last 30 days with lot 951357
        $customers = Customer::all();
        $lot951357Medications = Medication::where('lot_number', '951357')->get();
        $otherMedications = Medication::where('lot_number', '<>', '951357')->get();

        $today = Carbon::now();
        $thirtyDaysAgo = Carbon::now()->subDays(30);

        // Create 10 orders with lot 951357 (distributed in last 30 days)
        for ($i = 0; $i < 10; $i++) {
            $customer = $customers->random();
            $purchaseDate = Carbon::createFromTimestamp(
                rand($thirtyDaysAgo->timestamp, $today->timestamp)
            );

            $order = Order::create([
                'customer_id' => $customer->id,
                'purchase_date' => $purchaseDate,
                'total_amount' => 0,
                'status' => 'completed',
            ]);

            // Always include at least one medication from lot 951357
            $medicationWith951357 = $lot951357Medications->random();
            $quantity = rand(1, 3);
            $unitPrice = rand(15, 50);
            $subtotal = $quantity * $unitPrice;

            OrderItem::create([
                'order_id' => $order->id,
                'medication_id' => $medicationWith951357->id,
                'quantity' => $quantity,
                'unit_price' => $unitPrice,
                'subtotal' => $subtotal,
            ]);

            $orderTotal = $subtotal;

            // Randomly add 1-2 other medications to some orders
            if (rand(0, 1) && $otherMedications->count() > 0) {
                $otherMed = $otherMedications->random();
                $quantity2 = rand(1, 2);
                $unitPrice2 = rand(10, 40);
                $subtotal2 = $quantity2 * $unitPrice2;

                OrderItem::create([
                    'order_id' => $order->id,
                    'medication_id' => $otherMed->id,
                    'quantity' => $quantity2,
                    'unit_price' => $unitPrice2,
                    'subtotal' => $subtotal2,
                ]);

                $orderTotal += $subtotal2;
            }

            // Update order total
            $order->update(['total_amount' => $orderTotal]);
        }

        // Create 5 more orders WITHOUT lot 951357 (for filtering contrast)
        for ($i = 0; $i < 5; $i++) {
            $customer = $customers->random();
            $purchaseDate = Carbon::createFromTimestamp(
                rand($thirtyDaysAgo->timestamp, $today->timestamp)
            );

            $order = Order::create([
                'customer_id' => $customer->id,
                'purchase_date' => $purchaseDate,
                'total_amount' => 0,
                'status' => 'completed',
            ]);

            // Only other medications
            $numItems = rand(1, 2);
            $orderTotal = 0;

            for ($j = 0; $j < $numItems; $j++) {
                $medication = $otherMedications->random();
                $quantity = rand(1, 3);
                $unitPrice = rand(10, 50);
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

            $order->update(['total_amount' => $orderTotal]);
        }

        echo "✅ PDF Requirement Seeder completed!\n";
        echo "   - 1 Admin user\n";
        echo "   - 8 Customers\n";
        echo "   - 7 Medications (2 with lot 951357)\n";
        echo "   - 10 Orders with lot 951357 (in last 30 days)\n";
        echo "   - 5 Orders without lot 951357 (for contrast)\n";
        echo "\n📋 Test lot number: 951357\n";
        echo "📅 Date range: Last 30 days\n";
    }
}
