<?php

namespace App\Http\Controllers;


use App\Models\wishlists;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class WishlistController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $wishlists =wishlists ::all();
        return response()->json($wishlists);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $wishlist = wishlists::create($request->all());
        return response()->json($wishlist, Response::HTTP_CREATED);
    }

    /**
     * Display the specified resource based on user_id and product_id.
     */
    public function show(string $user_id)
    {
        $wishlist = wishlists::where('user_id', $user_id)->with('product')->get();

        if (!$wishlist) {
            return response()->json(['error' => 'Wishlist not found'], Response::HTTP_NOT_FOUND);
        }

        return response()->json($wishlist);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $wishlist = wishlists::find($id);

        if (!$wishlist) {
            return response()->json(['error' => 'Wishlist not found'], Response::HTTP_NOT_FOUND);
        }

        $wishlist->update($request->all());

        return response()->json($wishlist, Response::HTTP_OK);
    }

    /**
     * Remove the specified resource from storage based on product_id and user_id.
     */
    public function destroy(string $id)
    {
        $wishlist = wishlists::find($id);

        if (!$wishlist) {
            return response()->json(['error' => 'Wishlist not found'], Response::HTTP_NOT_FOUND);
        }

        $wishlist->delete();

        return response()->json(['message' => 'Wishlist item deleted successfully']);
    }
}
