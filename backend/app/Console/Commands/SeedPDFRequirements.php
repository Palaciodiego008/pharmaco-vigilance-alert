<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Database\Seeders\PDFRequirementSeeder;

class SeedPDFRequirements extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'db:seed-pdf-requirements {--fresh : Drop all tables and re-run all migrations before seeding}';

    /**
     * The description of the console command.
     *
     * @var string
     */
    protected $description = 'Seed the database with data matching PDF requirements (lot 951357, last 30 days)';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        if ($this->option('fresh')) {
            $this->call('migrate:fresh');
        }

        $this->call('db:seed', [
            '--class' => PDFRequirementSeeder::class,
        ]);

        $this->info('✅ PDF Requirements seeding completed!');
    }
}
