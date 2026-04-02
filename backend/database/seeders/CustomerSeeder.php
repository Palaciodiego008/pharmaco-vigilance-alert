<?php

namespace Database\Seeders;

use App\Models\Customer;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class CustomerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $customers = [
            ['name' => 'John Smith', 'email' => 'john.smith@email.com', 'phone' => '555-0101'],
            ['name' => 'Maria Garcia', 'email' => 'maria.garcia@email.com', 'phone' => '555-0102'],
            ['name' => 'Robert Johnson', 'email' => 'robert.johnson@email.com', 'phone' => '555-0103'],
            ['name' => 'Emily Davis', 'email' => 'emily.davis@email.com', 'phone' => '555-0104'],
            ['name' => 'Michael Wilson', 'email' => 'michael.wilson@email.com', 'phone' => '555-0105'],
            ['name' => 'Sarah Brown', 'email' => 'sarah.brown@email.com', 'phone' => '555-0106'],
            ['name' => 'David Martinez', 'email' => 'david.martinez@email.com', 'phone' => '555-0107'],
            ['name' => 'Jennifer Taylor', 'email' => 'jennifer.taylor@email.com', 'phone' => '555-0108'],
            ['name' => 'James Anderson', 'email' => 'james.anderson@email.com', 'phone' => '555-0109'],
            ['name' => 'Lisa Thomas', 'email' => 'lisa.thomas@email.com', 'phone' => '555-0110'],
        ];

        foreach ($customers as $customer) {
            Customer::create($customer);
        }
    }
}
