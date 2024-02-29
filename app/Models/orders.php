<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class orders extends Model
{
    use HasFactory;
    protected $fillable = ['status','coupan_codes','discount_amounts', 'customerEmail','address_id', 'customerName', 'shippingMethod','totalItemCount','totalQtyOrdered','grandTotal','customerId','cartId'];

    public function user(){
        return $this->belongsTo(User::class, 'customerId', 'id');
    }
    public function payment(){
        return $this->hasOne(orderpayments::class, 'orderId', 'id');
    }
    public function orderitem(){
        return $this->hasMany(orderitems::class, 'orderId', 'id');
    }

}
