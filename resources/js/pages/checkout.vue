<template>
    <v-container>
        <v-row>
            <v-col class="col-md-6">
                <router-link to="/home">
                    <img src="./1.png" width="110" height="130" class="navbar-brand" />
                </router-link>
            </v-col>
            <v-col class="col-md-4">
                <h1 class="yellow-text">Checkout</h1>
            </v-col>

            <v-col class="col-md-2">
                <router-link to="/cart" class="nav-link" style="margin-left: 80%;">
                    <v-icon color="black" size="40">mdi-cart</v-icon>
                </router-link>
            </v-col>
        </v-row>

        <br>
        <v-row>

            <v-col class="col-md-6">

                <div>
                    <h3 class="text-lg font-medium text-secondary-900 m-0" style="font-size: 21px; font-weight: 600">
                        Address Details
                    </h3>
                    <br />

                    <div v-for="(address, index) in addresses" :key="address.id" class="mb-6 border-b pb-4">
                        <div class="flex items-start justify-between">
                            <div class="mr-4">
                                <label class="custom-label">
                                    <input type="radio" :value="address" v-model="selectedAddress" class="mr-2" />
                                    {{ address.fullName }}&nbsp;&nbsp;
                                    {{ address.phone }}
                                    <p class="text-secondary-600">
                                        {{ address.email }},
                                        {{ address.city }},
                                        {{ address.state }},
                                        {{ address.country }} -
                                        {{ address.postcode }}
                                    </p>
                                </label>
                            </div>
                            <button class="text-blue bg-white px-4 py-2 rounded" @click="handleEditAddress(address)">
                                Edit
                            </button>
                        </div>
                    </div>

                </div>
                <div v-if="showEditForm">
                    <h3>Edit Address</h3>
                    <v-form @submit.prevent="saveEditedAddress">
                        <!-- Address fields for editing -->
                        <v-text-field v-model="editedAddress.fullName" label="Full Name"></v-text-field>
                        <v-text-field v-model="editedAddress.email" label="Email"></v-text-field>
                        <v-text-field v-model="editedAddress.phone" label="Mobile Number"></v-text-field>
                        <v-text-field v-model="editedAddress.country" label="Country"></v-text-field>
                        <v-text-field v-model="editedAddress.state" label="State"></v-text-field>
                        <v-text-field v-model="editedAddress.city" label="City"></v-text-field>

                        <v-text-field v-model="editedAddress.postcode" label="Postcode"></v-text-field>

                        <v-btn class="btn" color="orange" type="submit">Save</v-btn>
                    </v-form>
                </div>
                <v-card>

                    <!-- Add New Address Button -->
                    <v-btn class="btn" color="orange" @click="showAddressForm = true">Add New Address</v-btn>

                    <!-- Address Form -->
                    <v-card-text v-if="showAddressForm">
                        <v-form @submit.prevent="addressdata">
                            <!-- Address fields -->
                            <v-text-field v-model="formData.fullName" label="fullName"></v-text-field>
                            <v-text-field v-model="formData.email" label="Email"></v-text-field>
                            <v-text-field v-model="formData.phone" label="Mobile Number"></v-text-field>
                            <v-text-field v-model="formData.country" label="Country"></v-text-field>
                            <v-text-field v-model="formData.state" label="State"></v-text-field>
                            <v-text-field v-model="formData.city" label="City"></v-text-field>
                            <v-text-field v-model="formData.postcode" label="Postcode"></v-text-field>
                            <v-btn class="btn" color="orange" @click="addressdata">Save</v-btn>
                        </v-form>
                    </v-card-text>

                </v-card>
            </v-col>


            <v-col class="col-md-4">

                <v-card>
                    <span class="blurred-textt">ORDER SUMMARY</span>
                    <table>

                        <tr>
                            <td>Price ({{ cartItems.length }} items)</td>
                            <td>₹{{ calculateTotalAmount() }}</td>
                        </tr>

                        <br>
                        <tr v-if="isCouponApplied">
                            <td class="py-2">
                                Coupon Discount ({{ appliedCouponCode.code }}):
                            </td>
                            <td class="py-2">
                                Rs. {{ appliedCouponCode.discount_amount }}
                            </td>
                        </tr>

                        <br>
                        <tr>
                            <h5>
                                <td>Total Amount</td>
                            </h5>
                            <td>
                                {{ showOriginalTotal ? '₹' + calculateTotalAmount() : (cartItems.length > 0 ? '₹' +
                                    cartItems[0].totalAmount : '₹0') }}
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" class="py-4">
                                <div class="flex items-center">
                                    <div class="flex items-center">
                                        <!-- Hide the button and input field when appliedCouponCode is present -->
                                        <button v-if="!isCouponApplied" @click="applyCoupon"
                                            class="bg-orange-400 text-white py-2 px-4 mr-2 rounded">Apply Coupon</button>
                                        <input v-if="!isCouponApplied" v-model="code" type="text" placeholder="Coupon Code"
                                            :class="{ 'border-red-500': codeError }"
                                            class="border border-gray-300 py-2 px-4">

                                    </div>
                                    <p v-if="codeError" class="text-red-500 mt-2">{{ codeErrorMessage }}</p>
                                </div>
                                <p v-if="codeError" class="text-red-500 mt-2">{{ codeErrorMessage }}</p>
                                <!-- <p v-if="couponAlreadyApplied" class="text-green-500 mt-2">Coupon code '{{ appliedCouponCode }}' is already applied!</p> -->

                            </td>
                        </tr>
                        <hr>

                    </table>
                </v-card>


                <v-card>
                    <hr>
                    <v-card-title>
                        <h2 class="blurred-textt">Payment Options</h2>
                    </v-card-title>
                    <v-card-text>


                        <v-checkbox v-model="cashOnDeliveryChecked" label="Cash on Delivery"
                            @change="handlePaymentCOD"></v-checkbox>

                        <v-checkbox v-model="creditCardChecked" label="Card Payment"></v-checkbox>

                        <div v-if="creditCardChecked">
                            <v-row>
                                <v-col>
                                    <v-text-field v-model="creditCardNumber" label="Credit Card Number"></v-text-field>
                                </v-col>
                                <v-col>
                                    <v-text-field v-model="expiryDate" label="Expiry Date"></v-text-field>
                                </v-col>
                                <v-col>
                                    <v-text-field v-model="cvv" label="CVV"></v-text-field>
                                </v-col>
                            </v-row>
                        </div>

                        <!-- Confirm Order button -->
                        <v-btn class="btn" color="orange" @click="handlePaymentAndConfirmOrder">Proceed to
                            Payment</v-btn>

                    </v-card-text>
                </v-card>

            </v-col>
        </v-row>
    </v-container>
</template>

<script setup>

import { onMounted, ref, computed, watch } from 'vue';
import { useMainStore } from '../store/index';
import { useRouter, useRoute } from 'vue-router';
import axios from 'axios';

import { loadStripe } from '@stripe/stripe-js'
const mainStore = useMainStore();
const showAddressForm = ref(false);
const showOriginalTotal = ref(true);
const router = useRouter();
const code = ref(localStorage.getItem('appliedCouponCode') || '');
const cartItems = ref([]);
const isCouponApplied = ref(!!localStorage.getItem('appliedCouponCode'));
const appliedCouponCode = ref(JSON.parse(localStorage.getItem('appliedCouponCode')) || {});
const codeError = ref(false);
const codeErrorMessage = ref('');


const formData = ref({
    fullName: '',
    email: '',
    phone: '',
    country: '',
    state: '',
    city: '',

    postcode: '',
    sameadr: false,
});
const userInfo = ref({
    email: '',
    name: '',
    number: '',
});


const addresses = ref({
    id: '',
    name: '',
    type: '',
    phone: '',
    address: '',
    readonly: true,
    checked: true,
});


const editedAddress = ref({
    id: '',
    fullName: '',
    email: '',
    phone: '',
    country: '',
    state: '',
    city: '',

    postcode: '',
});

const userId = ref(null); // Add userId ref
const showEditForm = ref(false);
const selectedAddress = ref("");

const fetchLoggedInUser = async () => {
    const storedUser = JSON.parse(localStorage.getItem('user'));
    console.log("parth", storedUser.id);
    userId.value = storedUser.id; // Set userId value
    try {
        const response = await axios.get(`http://127.0.0.1:8000/api/address/${userId.value}`);
        addresses.value = response.data;
        console.log(response.data)
    } catch (error) {
        console.error("Error fetching addresses:", error);
    }
};

const storedCouponCode = localStorage.getItem('appliedCouponCode');
console.log('add', storedCouponCode)

const handlePaymentAndConfirmOrder = async () => {
    await setOrderIdAndCustomerId();
    await handlePayment();
    // Call addressdata function
    await addressdata();
    router.push('/orderConfirm');
};

const handlePaymentCOD = async () => {
    // Set orderId and customerId here or invoke a function to set them
    await setOrderIdAndCustomerId();

    // Rest of your code
    await handleCheckboxChange();
    await addressdata();
    clearFormData();
    router.push('/orderConfirm');
};
const handleEditAddress = (address) => {
    // Show the edit form and populate it with the selected address data
    showEditForm.value = true;
    editedAddress.value = { ...address };
};

const saveEditedAddress = async () => {
    try {
        // Perform the edit address logic here using the API
        const response = await axios.put(`http://localhost:8000/api/updateAddress/${editedAddress.value.id}`, editedAddress.value, {
            // If needed, include headers like 'Content-Type' here
        });

        // Check if the edit was successful based on the response
        if (response.status === 200) {
            console.log('Address edited successfully:', response.data);

            fetchLoggedInUser();
            showEditForm.value = false;
        } else {
            console.error('Error editing address:', response.data);
            // Handle the error, show a message, or take appropriate actions
        }
    } catch (error) {
        console.error('Error editing address:', error);
        // Handle network errors, unexpected responses, or other errors
    }
};



const setOrderIdAndCustomerId = async () => {
    // Assuming you have some asynchronous operation to set orderId and customerId
    const orderId = localStorage.getItem('orderId');
    const customerId = localStorage.getItem('customerId');
    localStorage.setItem('selectedAddress', selectedAddress.value);

    localStorage.setItem('orderId', orderId);
    localStorage.setItem('customerId', customerId);

    console.log('orderId:', orderId);
    console.log('customerId:', customerId);
};

const applyCoupon = async () => {
    try {
        const response = await axios.get(`http://127.0.0.1:8000/api/coupons/${code.value}`);

        if (response.data && response.data.length > 0 && response.data[0].discount_amount !== undefined) {
            const discountAmount = response.data[0].discount_amount;
            const parth = response.data[0]
            console.log('pp', parth)
            console.log('Discount Amount:', discountAmount);

            // Calculate total amount before discount
            const totalAmountBeforeDiscount = cartItems.value.reduce((total, item) => {
                return total + item.price * item.quantity;
            }, 0);

            // Apply the discount to the total amount
            const discountedTotalAmount = totalAmountBeforeDiscount - discountAmount;

            // Save the updated total amount to cartItems
            cartItems.value.forEach((item) => {
                item.totalAmount = discountedTotalAmount;
            });

            localStorage.setItem('cartItems', JSON.stringify(cartItems.value));
            showOriginalTotal.value = false;
            console.log('Coupon applied successfully!');
            console.log('Updated Cart Items:', cartItems.value);
            isCouponApplied.value = true;
            appliedCouponCode.value = response.data[0];
            localStorage.setItem('appliedCouponCode', JSON.stringify(parth));
        } else {
            console.log('Invalid coupon response. Please check the API response.');
            codeError.value = true;
            codeErrorMessage.value = 'Error applying coupon. Please try again later.';
        }
    } catch (error) {
        console.error('Error applying coupon:', error);
        // Handle other potential errors, such as network issues or server errors
    }
};

const handleCheckboxChange = async () => {
    try {
        // Retrieve user information from localStorage
        const storedUser = JSON.parse(localStorage.getItem('user'));
        const cartItems = JSON.parse(localStorage.getItem('cartItems'));
        const selectedAddressId = localStorage.getItem('selectedAddress');
        // const appliedCouponCode = localStorage.getItem('appliedCouponCode');

        console.log('selecteddata', appliedCouponCode.value.code)

        await addressdata();

        if (!storedUser || !cartItems) {
            // Handle the case where user information or cart items are not found in localStorage
            console.error('User information or cart items not found in localStorage');
            return;
        }

        const grandTotal = cartItems[0].totalAmount;
        const couponsCode = appliedCouponCode.value.code

        const totalQuantity = cartItems.reduce((total, item) => total + item.quantity, 0);
        const totalItems = cartItems.length;

        // Make a POST request to create a cart
        const cartResponse = await axios.post('http://127.0.0.1:8000/api/createCart', {
            customerId: storedUser.id,
            customerName: storedUser.name,
            customerEmail: storedUser.email,
            grandTotal: grandTotal,
            itemsQty: totalQuantity,
            itemsCount: totalItems,
            coupan_codes: couponsCode,
        });

        // Handle the response as needed
        console.log('Cart creation response:', cartResponse.data);


        // Handle payment based on the selected method
        if (cashOnDeliveryChecked.value) {
            // Handle Cash on Delivery
            const codResponse = await axios.post('http://127.0.0.1:8000/api/cartPayment', {
                method: 'Cod',
                methodTitle: 'Cod',
                status: 'pending',
            });
            console.log('Cash on Delivery payment response:', codResponse.data);
        }

        // Handle payment based on the selected method
        // Handle payment based on the selected method
        if (cashOnDeliveryChecked.value) {
            try {
                // Make a POST request to create an order
                const orderResponse = await axios.post('http://127.0.0.1:8000/api/createOrder', {
                    customerId: storedUser.id,
                    customerName: storedUser.name,
                    customerEmail: storedUser.email,
                    status: 'pending',
                    shippingMethod: 'Cod',
                    grandTotal: grandTotal,
                    totalQtyOrdered: totalQuantity,
                    totalItemCount: totalItems,
                    coupan_codes: couponsCode,
                    discount_amounts: appliedCouponCode.value.discount_amount,

                });

                console.log('Cash on Delivery order created:', orderResponse.data);

                // Extract orderId from the response
                const orderId = orderResponse.data.id;
                const customerId = orderResponse.data.customerId;
                localStorage.setItem('selectedAddress', selectedAddress.value);

                localStorage.setItem('customerId', customerId);
                localStorage.setItem('orderId', orderId);
                // Handle Cash on Delivery payment with the obtained orderId
                const codResponse = await axios.post('http://127.0.0.1:8000/api/orderPayment', {
                    method: 'Cod',
                    methodTitle: 'Cod',
                    orderId: orderId,
                });

                const {
                    fullName,
                    postcode,
                    city,
                    state,
                    country,
                    email,
                    phone,

                } = selectedAddress.value;

                // Create payload for API request
                const orderAddressPayload = {
                    fullName,
                    postcode,
                    city,
                    state,
                    country,
                    email,
                    phone,
                    order_Id: orderId
                };

                // Make API request to 'http://127.0.0.1:8000/api/orderAddress'
                const codResponseadd = await axios.post('http://127.0.0.1:8000/api/orderAddress', orderAddressPayload);


                for (const item of cartItems) {
                    const codcartItems = await axios.post('http://127.0.0.1:8000/api/orderItems', {
                        productId: item.id,
                        name: item.name,
                        sku: item.url_key,
                        price: item.price,
                        total: grandTotal,
                        orderId: orderId,
                    });

                    console.log('Product sent to orderItems API:', codcartItems.data);
                }
                console.log('Cash on Delivery payment response:', codResponse.data);

                console.log('Cash on Delivery payment response:', codResponseadd.data);
            } catch (error) {
                // Handle errors, e.g., display an error message
                console.error('Error processing Cash on Delivery:', error);
            }
        }


        clearFormData();

    } catch (error) {
        // Handle errors, e.g., display an error message
        console.error('Error processing payment:', error);
    }
};

// // nzsY3lU3dMeZXIxN

const handlePayment = async () => {
    try {

        const storedUser = JSON.parse(localStorage.getItem('user'));
        const cartItems = JSON.parse(localStorage.getItem('cartItems'));
        await addressdata();


        if (!storedUser || !cartItems) {
            // Handle the case where user information or cart items are not found in localStorage
            console.error('User information or cart items not found in localStorage');
            return;
        }

        const grandTotal = cartItems.reduce((total, item) => total + item.price * item.quantity, 0);
        const totalQuantity = cartItems.reduce((total, item) => total + item.quantity, 0);
        const totalItems = cartItems.length;
        // Load Stripe.js on the client side
        const stripe = await loadStripe('pk_test_51OernzJ7YilluosLViNAJC2RUPGpKVFDwmn7MmVZoGXZhDGBFrkigEYSyZcTgWj7you2buBAXkrfq7jACGvbtzfl00YJbqLvW3');

        // Get user information from your authentication store (you may need to replace this with your own method)


        // Step 1: Create a customer on Stripe
        const customerResponse = await axios.post('https://api.stripe.com/v1/customers', {
            email: userInfo.value.email,
            name: userInfo.value.name,
        }, {
            headers: {
                'Authorization': 'Bearer sk_test_51OernzJ7YilluosL0ywVK3wCinCaN76pMK2CXMQZNtlVIECHUPTMlUdX55aRZFhS9bSJ5bsUvuECx81u793HUAQg00UmTsa3JH',
                'Content-Type': 'application/x-www-form-urlencoded',
            },
        });

        const customerId = customerResponse.data.id;

        // Step 2: Create a PaymentIntent
        const paymentIntentResponse = await axios.post('https://api.stripe.com/v1/payment_intents', {
            currency: 'usd',
            payment_method_types: ['card'],
            amount: calculateTotalAmount(),
            payment_method: 'pm_card_mastercard',
            customer: customerId,
        }, {
            headers: {
                'Authorization': 'Bearer sk_test_51OernzJ7YilluosL0ywVK3wCinCaN76pMK2CXMQZNtlVIECHUPTMlUdX55aRZFhS9bSJ5bsUvuECx81u793HUAQg00UmTsa3JH',
                'Content-Type': 'application/x-www-form-urlencoded',
            },
        });

        // Check if the API call was successful
        if (paymentIntentResponse.status !== 200) {
            console.error('Error creating PaymentIntent:', paymentIntentResponse.data.error);
            return;
        }
        const { client_secret } = paymentIntentResponse.data;

        const { paymentIntent, error } = await stripe.confirmCardPayment(client_secret);

        // Step 4: Handle the payment result
        if (paymentIntent.status === 'succeeded') {
            // Payment succeeded, handle success
            console.log('Payment succeeded!');

            // Update the payment status in your API
            const codResponse = await axios.post('http://127.0.0.1:8000/api/cartPayment', {
                method: 'Stripe',
                methodTitle: 'Stripe',
                status: paymentIntent.status,
            });

            const orderResponse = await axios.post('http://127.0.0.1:8000/api/createOrder', {
                customerId: storedUser.id,
                customerName: storedUser.name,
                customerEmail: storedUser.email,
                status: paymentIntent.status,
                shippingMethod: 'Stripe',
                grandTotal: grandTotal,
                totalQtyOrdered: totalQuantity,
                totalItemCount: totalItems,
                coupan_codes: appliedCouponCode.value.code,
                discount_amounts: appliedCouponCode.value.discount_amount,

            });

            console.log('Cash on Delivery order created:', orderResponse.data);

            // Extract orderId from the response
            const orderId = orderResponse.data.id;
            const customerId = orderResponse.data.customerId;
            localStorage.setItem('selectedAddress', selectedAddress.value);

            localStorage.setItem('customerId', customerId);
            localStorage.setItem('orderId', orderId);
            // Handle Cash on Delivery payment with the obtained orderId
            const odResponse = await axios.post('http://127.0.0.1:8000/api/orderPayment', {
                method: 'Stripe',
                methodTitle: 'Stripe',
                orderId: orderId,
            });

            const {
                fullName,
                postcode,
                city,
                state,
                country,
                email,
                phone,

            } = selectedAddress.value;

            // Create payload for API request
            const orderAddressPayload = {
                fullName,
                postcode,
                city,
                state,
                country,
                email,
                phone,
                order_Id: orderId
            };

            // Make API request to 'http://127.0.0.1:8000/api/orderAddress'
            const codResponseadd = await axios.post('http://127.0.0.1:8000/api/orderAddress', orderAddressPayload);

            for (const item of cartItems) {
                const codcartItems = await axios.post('http://127.0.0.1:8000/api/orderItems', {
                    productId: item.id,
                    name: item.name,
                    sku: item.url_key,
                    price: item.price,
                    total: grandTotal,
                    orderId: orderId,
                });

                console.log('Product sent to orderItems API:', codcartItems.data);
            }

            // Make a POST request to create a cart
            const cartResponse = await axios.post('http://127.0.0.1:8000/api/createCart', {
                customerId: storedUser.id,
                customerName: storedUser.name,
                customerEmail: storedUser.email,
                grandTotal: grandTotal,
                itemsQty: totalQuantity,
                itemsCount: totalItems,
                coupan_codes: appliedCouponCode.value.code,
            });
            // Handle the response as needed
            console.log('Cart creation response:', cartResponse.data);
            console.log('Cash on Delivery order created:', odResponse.data);
            console.log('Payment status updated in your API:', codResponse.data);
        } else if (paymentIntent.status === 'requires_action') {
            // Payment still requires action, you may want to handle it further
            console.log('Payment requires additional action.');
        } else {
            // Payment failed, handle error
            console.error(error);
        }


    } catch (error) {
        console.error('Error handling payment:', error);
    }
};


const addressdata = async () => {
    try {

        const payload = {
            ...formData.value,

            customerId: mainStore.user.id,
        };
        await axios.post('http://127.0.0.1:8000/api/addresses', payload);


        clearFormData();

        console.log('Order confirmed and address saved successfully!');
    } catch (error) {
        console.error('Error confirming order or saving address:', error);
    }
}

const calculateTotalAmount = () => {
    return cartItems.value.reduce((total, item) => {
        return total + item.price * item.quantity;
    }, 0);
};
const calculateTotalQuantity = () => {
    return cartItems.value.reduce((total, item) => {
        return total + item.quantity;
    }, 0);
};



const creditCardChecked = ref(false);
const cashOnDeliveryChecked = ref(false);

const creditCardNumber = ref('');
const expiryDate = ref('');
const cvv = ref('');




const clearFormData = () => {
    // Reset each property to an empty string or a default value
    formData.value = {
        fullName: '',
        email: '',
        phone: '',
        country: '',
        state: '',
        city: '',
        address: '',
        postcode: '',
        sameadr: false,
    };
};
onMounted(() => {
    // fetchAddress();
    fetchLoggedInUser();
});

onMounted(() => {
    const storedItems = localStorage.getItem('cartItems');
    cartItems.value = storedItems ? JSON.parse(storedItems) : [];
    const storedFormData = localStorage.getItem('billingInfo');
    if (storedFormData) {
        formData.value = JSON.parse(storedFormData);
    }

    // Retrieve userInfo from local storage
    const storedUserInfo = localStorage.getItem('user');

    if (storedUserInfo) {
        userInfo.value = JSON.parse(storedUserInfo);
    }
    const storedCoupon = localStorage.getItem('appliedCouponCode');
    if (storedCoupon) {
        isCouponApplied.value = true;
        appliedCouponCode.value = JSON.parse(storedCoupon);
        showOriginalTotal.value = false;
    }
});

</script>

<style scoped>
.blurred-textt {
    color: grey;
    backdrop-filter: blur(5px);
    font-size: 30px;
    font-weight: 550;
    padding: 8px;
    display: inline-block;
    /* To ensure backdrop-filter works properly */
}

.yellow-text {
    color: orange;
    text-align: center;

    font-size: 50px;
    font-weight: 600;
}
</style>
