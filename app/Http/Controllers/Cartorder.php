<?php

namespace App\Http\Controllers;

use App\Models\addresses;
use App\Models\cartpayments;
use App\Models\carts;
use App\Models\invoices;
use App\Models\orderitems;
use App\Models\orderpayments;
use App\Models\orders;
use App\Models\orderAdd;
use App\Models\rating;
use App\Models\refund;
use App\Models\shipment;
use App\Models\shipmentitems;
use Illuminate\Http\Request;
use Stripe\Stripe;
use Stripe\PaymentIntent;
use Stripe\Exception\CardException;
use PDF;

class Cartorder extends Controller
{
    public function index()
    {
        $carts = carts::all();
        return response()->json($carts);
    }
    public function refundCreate(Request $request)
    {
        $cartpay = refund::create($request->all());
        return response()->json($cartpay, 200);
    }

    public function setLocale($locale)
    {
        session(['locale' => $locale]);

        return redirect()->back();
    }

    public function refund()
    {
        $cartpay = refund::all();
        return response()->json($cartpay, 200);
    }

    public function shipment(Request $request)
    {
        $cartpay = shipment::create($request->all());
        return response()->json($cartpay, 200);
    }

    public function shipmentitem(Request $request)
    {
        $cartpay = shipmentitems::create($request->all());
        return response()->json($cartpay, 200);
    }

    public function orderAddressShow(string $id)
    {
        $cartpay = orderAdd::find($id);
        return response()->json($cartpay, 200);
    }

    public function orderupdate(Request $request, int $id)
    {
        // Convert the $id to an integer (assuming your address ID is an integer)
        $order = orders::find($id);
        $order->update($request->all());
        return response()->json($order, 200);
    }

    public function orderAddress(Request $request)
    {

        $cartpay = orderAdd::create($request->all());
        return response()->json($cartpay, 200);
    }
    public function cartPayment(Request $request)
    {

        $cartpay = cartpayments::create($request->all());
        return response()->json($cartpay, 200);
    }

    public function orderItems(Request $request)
    {
        $orderItems = orderitems::create($request->all());
        return response()->json($orderItems, 200);
    }
    public function orderItem(string $id)
    {
        $orderItems = orderitems::find($id);
        return response()->json($orderItems, 200);
    }

    public function orderIteminvoice()
    {
        $orderItems = orderitems::all();
        return response()->json($orderItems, 200);
    }

    public function orderPayment(Request $request)
    {
        $orderpay = orderpayments::create($request->all());
        return response()->json($orderpay, 200);
    }

    public function orderPaymentg(string $id)
    {
        $orderpay = orderpayments::find($id);

        return response()->json($orderpay, 200);
    }

    public function invoice(Request $request)
    {
        $invoices = invoices::create($request->all());
        return response()->json($invoices);
    }


    public function invoicesdata(string $id)
    {
        $invoices = invoices::find($id);
        return response()->json($invoices);
    }
    public function invoices()
    {
        $invoices = invoices::all();
        return response()->json($invoices);
    }

    public function generatePdf($id)
    {
        $orderItems = orderitems::where('orderId', $id)->get();
        $currentDate = now()->format('Y-m-d');
        $invoiceNumber = mt_rand(100000, 999999);
        $order = orders::find($id);
        $address = addresses::find($id);

        $pdf = PDF::loadView('invoices.invoice', compact('orderItems', 'currentDate', 'invoiceNumber', 'order', 'address'));

        return $pdf->download('Invoice.pdf');
    }

    public function shipmentitems()
    {
        $orders = shipment::all();
        return response()->json($orders);
    }

    public function orders()
    {
        $orders = orders::all();
        return response()->json($orders);
    }
    public function rating(Request $request)
    {
        $rating = rating::create($request->all());
        return response()->json($rating);
    }

    public function ratingData(string $id)
    {
        $rating = rating::where('product_id', $id)->with('user')->get();
        return response()->json($rating);
    }

    public function Userorders(string $id)
    {
        $orders = orders::where('customerId', $id)->with(['user', 'payment', 'orderitem.product','orderitem.order'])->get();
        return response()->json($orders);
    }

    public function showorders(string $id)
    {
        $orders = orders::with(['user', 'payment', 'orderitem'])->find($id);
        return response()->json($orders);
    }

    public function createOrder(Request $request)
    {

        $ordercreate = orders::create($request->all());
        return response()->json($ordercreate, 200);
    }

    public function createCart(Request $request)
    {
        // $carts = carts::all();
        $cartcreate = carts::create($request->all());
        return response()->json($cartcreate, 200);
    }
    public function address(string $id)
    {

        $address = addresses::where('customerId', $id)->get();
        return response()->json($address, 200);
    }
    public function addresses(Request $request)
    {

        $address = addresses::create($request->all());

        return response()->json([

            'address' => $address,
        ]);
    }


    public function updateAddress(Request $request, int $id)
    {
        // Convert the $id to an integer (assuming your address ID is an integer)
        $address = addresses::find($id);

        if (!$address) {
            return response()->json('Address not found', 404);
        }

        $address->update($request->all());

        return response()->json($address, 200);
    }

    public function deleteAddress($id)
    {
        $address = addresses::find($id);

        if (!$address) {
            return response()->json(['error' => 'User not found'], 404);
        }
        $address->delete();

        return response()->json(['message' => 'User deleted successfully']);
    }

    public function processPayment(Request $request)
    {
        try {
            // Set your Stripe secret key
            Stripe::setApiKey(config('services.stripe.secret'));

            // Create a PaymentIntent
            $intent = PaymentIntent::create([
                'amount' => $request->input('amount'),
                'currency' => 'usd',
                'payment_method_types' => ['card'], // Include other payment methods as needed
                'payment_method' => 'pm_card_visa', // Specific payment method, e.g., Visa card
            ]);

            // Get payment_method_types, payment_method, and PaymentIntent client secret
            $paymentMethodInfo = [
                'payment_method_types' => $intent->payment_method_types,
                'payment_method' => $intent->payment_method,
                'client_secret' => $intent->client_secret,
            ];

            // Send the payment method info to the frontend
            return response()->json($paymentMethodInfo);
        } catch (CardException $e) {
            // Handle card errors
            return response()->json(['error' => $e->getMessage()], 422);
        } catch (\Exception $e) {
            // Handle other errors
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function carts(Request $request)
    {

        // $carts = carts::all();
        $carts = carts::create($request->all());
        return response()->json([
            'carts' => $carts,
        ]);
    }
}
