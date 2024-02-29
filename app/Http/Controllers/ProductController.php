<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator; // Add this line for Validator
use App\Models\Product;
use App\Models\category;
use App\Models\User;
use Illuminate\Validation\ValidationException;
use App\Models\productCategory;

class ProductController extends Controller
{
    public function index()
    {
        $products = Product::all();
        return response()->json($products); // Return products as a JSON response
    }
    public function register(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:5',
        ]);

        $user = User::create([
            'name' => $validatedData['name'],
            'email' => $validatedData['email'],
            'password' => bcrypt($validatedData['password']),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response(['token' => $token, 'user' => $user]);
    }



    public function login(Request $request)
    {
        $credentials = $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            $token = $user->createToken('auth_token')->plainTextToken;

            return response(['token' => $token, 'user' => $user, 'success' => true]);
        }

        throw ValidationException::withMessages(['email' => 'Invalid credentials']);
    }

    public function logout(Request $request)
    {
        $request->user()->tokens()->delete();
        return response(['message' => 'Logged out']);
    }
    public function user(Request $request)
    {
        return response()->json($request->user());
    }
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string',
            'detail' => 'required|string',
            'image' => 'nullable',
            'price' => 'nullable|numeric',
            'featured' => 'required|numeric',
            'url_key' => 'required|string',
            'categoryIds' => 'nullable|array', // Validate that categoryIds is an array
            'categoryIds.*' => 'exists:categories,id', // Validate that each categoryId exists in the categories table
        ]);

        // Handle image upload
        if ($request->hasFile('image')) {
            $file = $request->file('image');
            $fileName = time() . '_' . $file->getClientOriginalName();
            $path = $file->storeAs('images', $fileName, 'public');
            $validatedData['image'] = '/storage/' . $path;
        }

        // Create Product entry
        $product = Product::create($validatedData);

        if (isset($validatedData['categoryIds'])) {
            foreach ($validatedData['categoryIds'] as $categoryId) {
                productCategory::create([
                    'product_id' => $product->id,
                    'category_id' => $categoryId,
                ]);
            }
        }

        return response()->json(['message' => 'Product created successfully'], 201);
    }
    public function edit($id)
    {
        try {
            $product = Product::findOrFail($id);

            return response()->json([
                'name' => $product->name,
                'detail' => $product->detail,
                'price' => $product->price,
                'image' => $product->image,
            ], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Product not found'], 404);
        }
    }

    public function update(Request $request, $url_key)
    {
        $product = Product::where('url_key', $url_key)->first();

        if (!$product) {
            return response()->json(['error' => 'Product not found'], 404);
        }
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'detail' => 'required|string',
            'image' => 'nullable',
            'price' => 'required|numeric',
            'featured' => 'required|numeric',
            'url_key' => 'required|string',
            'categoryIds' => 'nullable|string', // Validate that categoryIds is a string
        ]);

        $product->name = $validatedData['name'];
        $product->detail = $validatedData['detail'];
        $product->price = $validatedData['price'];
        $product->featured = $validatedData['featured'];
        $product->url_key = $validatedData['url_key'];

        // Handle image update
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('Product/Images', 'public');
            $imagePath = "/storage/{$imagePath}";
            $product->image = $imagePath;
        }

        $product->save();


        $categoryIds = json_decode($validatedData['categoryIds'], true);

        // Convert category names to IDs
        $categoryIds = array_map(function ($categoryName) {
            $category = category::where('name', $categoryName)->first();
            return $category ? $category->id : null;
        }, $categoryIds);

        // Filter out null values (categories not found)
        $categoryIds = array_filter($categoryIds);

        // Sync categories
        if (!empty($categoryIds)) {
            $product->productCategories()->sync($categoryIds);
        } else {
            // If no categories are selected, detach all existing categories
            $product->productCategories()->detach();
        }

        return response()->json(['message' => 'Product updated successfully']);
    }

    // public function show($url_key)
    // {
    //     $product = Product::where('url_key', $url_key)->first();

    //     return response()->json($product);
    // }


    public function show(string $url_key)
    {

        $categories = category::all();
        $product = Product::where('url_key', $url_key)->with('productCategories')->first();

        if (!$product) {
            return response()->json(['error' => 'Product not found']);
        }

        $selectedCategoryNames = $product->productCategories()->pluck('name')->toArray();

        $responseData = [
            'product' => $product,
            'categories' => $categories,
            'selectedCategory' => $selectedCategoryNames,
        ];

        return response()->json($responseData);
    }
    public function destroy($url_key)
    {
        $product = Product::where('url_key', $url_key)->first();

        if (!$product) {
            return response()->json(['error' => 'Product not found'], 404);
        }

        $product->delete();

        return response()->json(['message' => 'Product deleted successfully']);
    }
}
