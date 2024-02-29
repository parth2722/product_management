<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class addresses extends Model
{
    use HasFactory;
    protected $fillable = ['customerId', 'cartId','fullName','postcode','city','state','country','email','phone'];
}
