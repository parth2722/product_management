<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class orderAdd extends Model
{
    use HasFactory;

    protected $fillable = ['fullName', 'postcode', 'city', 'state', 'country', 'email', 'phone', 'order_Id'];
}
