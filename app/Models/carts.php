<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class carts extends Model
{
    use HasFactory;
    protected $fillable = ['customerEmail','coupan_codes', 'customerName', 'itemsCount', 'itemsQty', 'grandTotal', 'customerId'];
}
