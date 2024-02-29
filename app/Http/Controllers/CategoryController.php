<?php

namespace App\Http\Controllers;

use App\Models\category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $products = category::all();
        return response()->json($products); // Return products as a JSON response
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {

        $category = category::create($request->all());
        return response()->json($category, 200);
    }

    /**
     * Display the specified resource.
     */
    /**
     * Display the specified resource.
     */
    public function show(string $slug)
    {

        $category = category::with('productCategories')->where('slug', $slug)->first();

        if (!$category) {
            return response()->json('Category not found', 404);
        }

        return response()->json($category);
    }



    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $slug)
    {
        $category = category::where('slug', $slug)->first();
        if (!$category) {
            return response()->json('Category not found', 404);
        }
        $category->update($request->all());
        return response()->json($category, 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $slug)
    {
        $category = category::where('slug', $slug)->first();

        if (!$category) {
            return response()->json(['error' => 'Product not found'], 404);
        }

        $category->delete();

        return response()->json(['message' => 'Product deleted successfully']);
    }
}
