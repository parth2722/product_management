<?php

namespace Database\Seeders;

// database/seeders/ProductsCategoriesSeeder.php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductsCategoriesSeeder extends Seeder
{
    public function run()
    {
        $categories = [
            ['name' => 'Electronics'],
            ['name' => 'Clothing'],
            ['name' => 'Home and Kitchen'],
            // Add more categories as needed
        ];

        DB::table('products_categories')->insert($categories);
    }
}

