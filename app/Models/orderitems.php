<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class orderitems extends Model
{
    use HasFactory;
    protected $fillable = ['sku', 'name', 'price', 'total', 'productId','orderId'];

    public function product(){
        return $this->belongsTo(Product::class , 'productId', 'id');
    }

    public function order(){
        return $this->belongsTo(orders::class , 'orderId', 'id');
    }
}
