<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class orderpayments extends Model
{
    use HasFactory;
    protected $fillable = ['method', 'methodTitle', 'orderId'];

}
