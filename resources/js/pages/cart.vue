<template>
    <parth>
        <v-container>
            <h1 class="text-yellow-500 text-3xl font-bold" style="margin-left: 45%;">Cart page</h1>
            <br>
            <div class="cart-section flex">
                <!-- Cart Items on the Left Side -->
                <div class="cart-items flex-1">
                    <div v-if="cartItems.length === 0">
                        <p>Your cart is empty</p>
                    </div>
                    <div v-else>
                        <span class="text-gray-500 text-sm" style="margin-left: 5%;">CART DETAILS</span>

                        <div v-for="item in cartItems" :key="item.id" class="cart-item border-b border-gray-300 py-4">

                            <div class="flex items-center">
                                <!-- Product Image -->
                                <div>
                                    <img :src="'http://127.0.0.1:8000' + item.image" alt="Product Image"
                                        style="width: 100px; height: 100px;">
                                </div>

                                <!-- Product Details -->
                                <div class="flex-1">
                                    <div class="flex items-center mt-2">
                                        <table class="min-w-full">
                                            <tbody>
                                                <tr>
                                                    <td class="py-2 px-4">
                                                        <p class="font-bold text-lg">{{ item.name }}</p>
                                                    </td>


                                                    <!-- Price -->
                                                    <td class="py-2 px-4 font-semibold text-xl">
                                                        ₹{{ item.price }}
                                                    </td>

                                                    <!-- Increase/Decrease Buttons -->
                                                    <td class="py-2 px-4 flex items-center">
                                                        <button @click="decreaseQuantity(item.id)"
                                                            class="bg-gray-300 px-2">-</button>
                                                        <h5 class="font-medium text-lg mx-2">{{ item.quantity }}</h5>
                                                        <button @click="increaseQuantity(item.id)"
                                                            class="bg-gray-300 px-2">+</button>
                                                    </td>

                                                    <!-- Cross Button -->
                                                    <td class="py-2 px-4">
                                                        <button @click="removeItem(item.id)" class="ml-4 delete-button">
                                                            <span class="material-icons">X</span>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <hr>
                        </div>
                    </div>
                    <router-link :to="isLoggedIn ? '/checkout' : '/frontLogin'">
                        <button class="placed bg-orange-500 text-white py-2 px-4 mt-4 rounded">PLACE ORDER</button>
                      </router-link>

                    <div v-if="cartItems && cartItems.length === 0">
                        <p>Your cart is empty</p>
                    </div>
                </div>

                <!-- Price Details on the Right Side -->
                <div class="price-details ml-4">
                    <div class="border border-gray-300 p-4">
                        <span class="text-gray-500 text-sm">PRICE DETAILS</span>

                        <div class="mt-2">
                            <table class="w-full">
                                <tr>
                                    <td class="py-2">Price ({{ cartItems.length }} items)</td>
                                    <td class="py-2 font-semibold text-lg">₹{{ calculateTotalAmount() }}</td>

                                </tr>
                                <tr>
                                    <td class="py-2">Total Quantity</td>
                                    <td class="py-2">{{ calculateTotalQuantity() }}</td>
                                </tr>
                                <tr v-if="isCouponApplied">
                                    <td class="py-2">
                                        Coupon Discount ({{ appliedCouponCode.code }}):
                                    </td>
                                    <td class="py-2">
                                        Rs. {{ appliedCouponCode.discount_amount }}
                                    </td>
                                </tr>


                                <tr>
                                    <td class="py-2 font-semibold text-lg">Total Amount</td>

                                    <td class="py-2 font-semibold text-lg">
                                        {{ showOriginalTotal ? '₹' + calculateTotalAmount() : (cartItems.length > 0 ? '₹' +
                                            cartItems[0].totalAmount : '₹0') }}
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="py-4">
                                        <div class="flex items-center">
                                            <!-- Hide the button and input field when appliedCouponCode is present -->
                                            <button v-if="!isCouponApplied" @click="applyCoupon"
                                                class="bg-orange-500 text-white py-2 px-4 mr-2 rounded">Apply Coupon</button>
                                            <input v-if="!isCouponApplied" v-model="code" type="text"
                                                placeholder="Coupon Code" :class="{ 'border-red-500': codeError }"
                                                class="border border-gray-300 py-2 px-4">

                                        </div>

                                        <p v-if="codeError" class="text-red-500 mt-2">{{ codeErrorMessage }}</p>

                                    </td>
                                </tr>
                                <hr class="my-4">
                                <div class="text-gray-500 text-sm" style="padding: 20px 0px 0px; margin-left: 15px;">
                                    <div class="_1RVm3P">Safe and Secure Payments. Easy returns. 100% Authentic products.
                                    </div>
                                </div>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </v-container>
    </parth>
</template>
<!-- nzsY3lU3dMeZXIxN -->
<script setup>
import Parth from '../layouts/Parth.vue';
import { onMounted, ref, computed, watch } from 'vue';
import { useCartStore } from '../store/stores';
import { useMainStore } from '../store/index';
import { useRoute, useRouter } from 'vue-router';

const router = useRouter();
const showOriginalTotal = ref(true);
import axios from 'axios';
const cartStore = useCartStore();
const codeError = ref(false);
const codeErrorMessage = ref('');
const code = ref(localStorage.getItem('appliedCouponCode') || '');
const cartItems = ref([]);
const isCouponApplied = ref(!!localStorage.getItem('appliedCouponCode'));
const appliedCouponCode = ref(JSON.parse(localStorage.getItem('appliedCouponCode')) || {});
const store = useMainStore();
const calculateTotalAmount = () => {

    const totalAmount = cartItems.value.reduce((total, item) => {
        return total + item.price * item.quantity;
    }, 0);

    return totalAmount;
};
const isLoggedIn = computed(() => {
    return store.getToken !== null;
});

onMounted(() => {
    const storedItems = localStorage.getItem('cartItems');
    cartItems.value = storedItems ? JSON.parse(storedItems) : [];

    // Check for an applied coupon in local storage
    const storedCoupon = localStorage.getItem('appliedCouponCode');
    if (storedCoupon) {
        isCouponApplied.value = true;
        appliedCouponCode.value = JSON.parse(storedCoupon);
        showOriginalTotal.value = false;
    }
});


const calculateTotalQuantity = () => {
    return cartItems.value.reduce((total, item) => {
        return total + item.quantity;
    }, 0);
};


const removeItem = (productId) => {
    cartStore.removeFromCart(productId);
    cartItems.value = cartStore.cartItems;
    const updatedItems = cartItems.value.filter(item => item.id !== productId);
    localStorage.setItem('cartItems', JSON.stringify(updatedItems));
};

const increaseQuantity = (productId) => {
    const updatedItems = cartItems.value.map((item) => {
        if (item.id === productId) {
            item.quantity++;
        }
        return item;
    });
    cartItems.value = updatedItems;
    localStorage.setItem('cartItems', JSON.stringify(updatedItems));
};

const decreaseQuantity = (productId) => {
    const updatedItems = cartItems.value.map((item) => {
        if (item.id === productId && item.quantity > 1) {
            item.quantity--;
        }
        return item;
    });
    cartItems.value = updatedItems;
    localStorage.setItem('cartItems', JSON.stringify(updatedItems));
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

</script>

<style scoped>
@media screen and (max-width: 768px) {
    .text-yellow-500 {
        font-size: 2rem;
    }

    .cart-section {
        flex-direction: column;
    }

    /* Add more styles as needed for smaller screens */
}</style>
