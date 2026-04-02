<?php

namespace Database\Seeders;

use App\Models\Medication;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class MedicationSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $medications = [
            [
                'name' => 'Acetaminophen 500mg',
                'lot_number' => '951357',
                'description' => 'Pain reliever and fever reducer'
            ],
            [
                'name' => 'Ibuprofen 200mg',
                'lot_number' => '951358',
                'description' => 'Anti-inflammatory pain reliever'
            ],
            [
                'name' => 'Amoxicillin 250mg',
                'lot_number' => '951359',
                'description' => 'Antibiotic for bacterial infections'
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
            [
                'name' => 'Omeprazole 20mg',
                'lot_number' => '951357',
                'description' => 'Proton pump inhibitor for acid reflux'
            ],
            [
                'name' => 'Levothyroxine 50mcg',
                'lot_number' => '951363',
                'description' => 'Thyroid hormone replacement'
            ],
        ];

        foreach ($medications as $medication) {
            Medication::create($medication);
        }
    }
}
