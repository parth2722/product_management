<?php

use App\Http\Controllers\Cartorder;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CoupanController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\WishlistController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware('api')->group(function () {
    Route::resource('products', ProductController::class)->parameters(['products' => 'url_key']);
    Route::resource('category', CategoryController::class)->parameters(['category' => 'slug']);
    Route::resource('user', UserController::class)->parameters(['user' => 'id']);
    Route::resource('coupons', CoupanController::class)->parameters(['coupons' => 'id']);
    Route::resource('wishlist', WishlistController::class)->parameters(['wishlist' => 'id']);
});
Route::post('/register', [ProductController::class, 'register'])->name('api.register');
Route::post('/login', [ProductController::class, 'login'])->name('api.login');
Route::post('/addresses', [Cartorder::class, 'addresses']);
Route::post('/createCart', [Cartorder::class, 'createCart']);
Route::post('/cartPayment', [Cartorder::class, 'cartPayment']);
Route::post('/processPayment', [Cartorder::class, 'processPayment']);
Route::post('/createOrder', [Cartorder::class, 'createOrder']);
Route::post('/orderPayment', [Cartorder::class, 'orderPayment']);
Route::post('/orderItems', [Cartorder::class, 'orderItems']);
Route::post('/orderAddress', [Cartorder::class, 'orderAddress']);
Route::post('/shipment', [Cartorder::class, 'shipment']);
Route::post('/shipmentitem', [Cartorder::class, 'shipmentitem']);
Route::post('/invoice', [Cartorder::class, 'invoice']);

Route::get('/generatePdf/{id}', [Cartorder::class, 'generatePdf']);
Route::get('/shipmentitems', [Cartorder::class, 'shipmentitems']);
Route::get('/invoices', [Cartorder::class, 'invoices']);
Route::get('/invoicesdata/{id}', [Cartorder::class, 'invoicesdata']);
Route::get('/shipmentitems', [Cartorder::class, 'shipmentitems']);
Route::get('/showorders/{id}', [Cartorder::class, 'showorders']);
Route::get('/orderAddressShow/{id}', [Cartorder::class, 'orderAddressShow']);
Route::get('/createOrder', [Cartorder::class, 'createOrder']);
Route::get('/orders', [Cartorder::class, 'orders']);
Route::get('/address/{id}', [Cartorder::class, 'address']);
Route::get('/createCart', [Cartorder::class, 'createCart']);
Route::get('/orderPaymentg', [Cartorder::class, 'orderPaymentg']);
Route::get('/orderView', [Cartorder::class, 'orderView']);
Route::post('/orderItem', [Cartorder::class, 'orderItem']);
Route::post('/refundCreate', [Cartorder::class, 'refundCreate']);
Route::post('/rating', [Cartorder::class, 'rating']);

Route::get('/Userorders/{id}', [Cartorder::class, 'Userorders']);

Route::get('/refund', [Cartorder::class, 'refund']);
Route::get('/ratingData/{id}', [Cartorder::class, 'ratingData']);
Route::get('/orderIteminvoice/{id}', [Cartorder::class, 'orderIteminvoice']);

Route::delete('/deleteAddress/{id}', [Cartorder::class, 'deleteAddress']);

Route::put('/orderupdate/{id}', [Cartorder::class, 'orderupdate']);
Route::put('/updateAddress/{id}', [Cartorder::class, 'updateAddress']);
Route::get('/set-locale/{locale}', [Cartorder::class, 'setLocale']);
