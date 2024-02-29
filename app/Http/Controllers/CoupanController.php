<?php

namespace App\Http\Controllers;

use App\Models\coupon;
use Illuminate\Http\Request;

class CoupanController extends Controller
{
    public function index()
    {
        // Get all coupons
        $coupons = coupon::all();
        return response()->json($coupons);
    }

    public function show(string $code)
    {
        // Get a specific coupon by ID
        $coupon = coupon::where('code', $code)->get();
        return response()->json($coupon);
    }



    public function store(Request $request)
    {
        // Create a new coupon
        $coupon = coupon::create($request->all());
        return response()->json($coupon, 201);
    }


    public function update(Request $request, string $id)
    {
        $user = coupon::find($id);
        if (!$user) {
            return response()->json('Category not found', 404);
        }
        $user->update($request->all());
        return response()->json($user, 200);
    }

    public function destroy(string $id)
    {
        $user = coupon::find($id);

        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }
        $user->delete();

        return response()->json(['message' => 'User deleted successfully']);
    }
}
