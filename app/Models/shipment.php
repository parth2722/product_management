<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class shipment extends Model
{
    use HasFactory;

    protected $fillable = ['status', 'totalQty', 'carrierTitle', 'trackNumber', 'customerId', 'customerType', 'orderId', 'orderAddressId'];
}
