<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class category extends Model
{
    use HasFactory;
    protected $fillable = ['name', 'slug', 'description', 'position', 'status'];

    // Category model
    public function productCategories()
    {
        return $this->belongsToMany(Product::class, 'product_categories');
    }
}
