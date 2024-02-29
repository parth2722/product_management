<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ordertransactions extends Model
{
    use HasFactory;
    protected $fillable = ['transactionId', 'status', 'type', 'paymentMethod', 'orderId	', 'amount'];
}
