<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class refund extends Model
{
    use HasFactory;
    protected $fillable = ['totalQty', 'grandTotal','shippingAmount','order_id'];
}
