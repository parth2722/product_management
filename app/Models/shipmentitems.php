<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class shipmentitems extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'description', 'sku', 'qty', 'price', 'total', 'productId', 'productType', 'orderItemId', 'shipmentId'];
}
