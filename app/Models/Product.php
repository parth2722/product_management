<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;
    protected $fillable = ['name', 'detail', 'price', 'image', 'featured', 'url_key', 'categoryID'];

    public function productCategories()
    {
        return $this->belongsToMany(category::class, 'product_categories');
    }

    public function orderitem()
    {
        return $this->hasMany(orderitems::class, 'productId', 'id');
    }
}
