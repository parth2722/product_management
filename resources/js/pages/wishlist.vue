<template>
    <v-container>
        <v-row align="center">
            <v-col>
                <v-card-title>
                    <span class="blurred-text">My wishlist</span>
                </v-card-title>
            </v-col>
        </v-row>
        <table class="min-w-full border border-gray-200">
            <thead>
                <tr>
                    <th class="px-4 py-2">Image</th>
                    <th class="px-4 py-2">Product Name</th>
                    <th class="px-4 py-2">Price</th>
                    <th class="px-4 py-2">Actions</th>
                    <th class="px-4 py-2">Add-cart</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(product, index) in products" :key="index">
                    <td class="border px-4 py-2">

                        <router-link :to="`/store/${product.url_key}`">
                            <img loading="lazy" :src="product.image" alt="Product Image" class="w-16 h-16">
                        </router-link>
                    </td>
                    <td class="border px-4 py-2">
                        <!-- Use router-link to navigate to the product detail page -->
                        <router-link :to="`/store/${product.url_key}`">
                            <span class="text-gray-800 font-semibold">{{ product.name }}</span>
                        </router-link>
                    </td>
                    <td class="border px-4 py-2 font-weight-600">
                        ₹{{ product.price }}
                    </td>
                    <td class="border px-4 py-2">
                        <v-btn @click="removeFromWishlist(product)" icon>
                            <v-icon color="red darken-4">mdi-delete</v-icon>
                        </v-btn>
                    </td>

                    <td class="border px-4 py-2" style="width: 5px;">
                        <v-btn  class="rounded-lg" size="large" block @click="addToCart(product)">
                            <v-icon>mdi-cart</v-icon>
                        </v-btn>

                    </td>
                </tr>
            </tbody>
        </table>
    </v-container>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import { useMainStore } from '../store/index';
const wishlist = ref([]);
const products = ref([]);
const mainStore = useMainStore();
import { useCartStore } from '@/stores/store';
const cartItems = ref([]);
const cartStore = useCartStore();

const fetchWishlist = async () => {
    try {
        const user_id = mainStore.user.id;
        const response = await axios.get(`http://127.0.0.1:8000/api/wishlist/${user_id}`);
        wishlist.value = response.data;
        console.log(response.data)
        products.value = response.data.map((item) => item.product);

    } catch (error) {
        console.error('Error fetching wishlist data:', error);
    }
};

const alreadyInCart = (product, cartItems) => {
    const x = cartItems.find((item) => item.id === product.id);
    return x !== undefined;
};



const addToCart = (product) => {
    console.log('addToCart method called');
    const storedItems = localStorage.getItem('cartItems');
    const cartItems = storedItems ? JSON.parse(storedItems) : [];

    if (!alreadyInCart(product, cartItems)) {
        const cartItem = {
            id: product.id,
            name: product.name,
            image: product.image,
            price: product.price,
            detail: product.detail,
            url_key: product.url_key,
        };
        console.log('Adding to cart:', cartItem);
        // Call the action from Pinia store
        cartStore.addToCart(products.value.id, cartItem);

        // Update localStorage with the modified cartItems
        localStorage.setItem('cartItems', JSON.stringify(cartItems.concat(cartItem)));
    } else {
        alert(`${product.name} already in cart`);
    }
};


const removeFromWishlist = async (product) => {
    await fetchWishlist();
    try {
        // Find the index of the product in the wishlist array
        const productIndex = wishlist.value.findIndex(
            (item) => item.product_id === product.id
        );
        if (productIndex !== -1) {
            // If the product is in the wishlist, remove it
            await axios.delete(
                `/api/wishlist/${wishlist.value[productIndex].id}`
            );
            await fetchWishlist();
            // Set addedToWishlist to false after successful removal
        }
    } catch (error) {
        // Handle any errors that may occur during the request
        console.error("Error removing product from wishlist:", error);
    }
};

onMounted(() => {
    fetchWishlist();
    const storedItems = localStorage.getItem('cartItems');
    cartItems.value = storedItems ? JSON.parse(storedItems) : [];
});
</script>
<route lang="yaml">
    meta:

        layout: Parth
    </route>

<style scoped>
.blurred-text {
    color: rgb(247, 160, 0);
    backdrop-filter: blur(5px);
    font-size: 40px;
    font-weight: 550;
    padding: 8px;
    display: inline-block;
}
</style>
