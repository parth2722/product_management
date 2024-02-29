<script setup>
import axios from 'axios';
import { ref, onMounted,computed } from 'vue';
import { useRoute } from 'vue-router';
import { useCartStore } from '@/stores/store';
import Parth from '../../layouts/Parth.vue';
import { useMainStore } from '../../store/index';
const breadcrumbs = ref([]);
const productData = ref([]);

const Rdata = ref([]);
const mainStore = useMainStore();
const route = useRoute();
const cartStore = useCartStore();
const user_id = mainStore.user ? mainStore.user.id : null;


const addedToWishlist = ref(false);
const userWishlist = ref([]);
const isLoggedIn = computed(() => {
    return mainStore.getToken !== null;
});

const fetchProductData = async () => {
    try {
        const response = await axios.get(`http://127.0.0.1:8000/api/products/${route.params.url_key}`);
        productData.value = response.data.product;
        console.log(response.data)
        breadcrumbs.value = [
            { title: 'Home', href: '/home' },
            // { title: 'Products', href: '/products' },
            { title: response.data.selectedCategory, href: '/category/' + response.data.product.product_categories[0].slug },
            { title: productData.value.name, href: null },
        ];
        fetchRating();
    } catch (error) {
        console.error('Error fetching product data:', error);
    }
};
const product_id = ref(null); // Add userId ref
const fetchRating = async () => {
    try {
        product_id.value = productData.value.id;
        const response = await axios.get(`http://127.0.0.1:8000/api/ratingData/${product_id.value}`);
        Rdata.value = response.data;



    } catch (error) {
        console.error('Error fetching product data:', error);
    }
};

const calculateAverageRating = () => {
    const totalRatings = Rdata.value.length;
    const sumRatings = Rdata.value.reduce((sum, rating) => sum + rating.star, 0);
    const averageRating = totalRatings > 0 ? Math.round(sumRatings / totalRatings) : 0;
    return averageRating; // Return the actual average rating value
};



onMounted(() => {
    fetchProductData();
    fetchUserWishlist();
});



const addToCart = () => {
    console.log('addToCart method called');
    const cartItem = {
        id: productData.value.id,
        name: productData.value.name,
        image: productData.value.image,
        price: productData.value.price,
        detail: productData.value.detail,
        url_key: productData.value.url_key,
    };

    console.log('Adding to cart:', cartItem);

    // Call the action from Pinia store
    cartStore.addToCart(productData.value.id, cartItem);
};


const addToWishlist = async () => {
    await fetchUserWishlist();

    try {

        const isProductInWishlist = userWishlist.value.some(
            (item) => item.product_id === productData.value.id
        );

        if (isProductInWishlist) {
            // If the product is already in the wishlist, set addedToWishlist to true
            addedToWishlist.value = true;
        } else {
            // If the product is not in the wishlist, add it
            const formData = new FormData();
            formData.append("user_id", user_id);
            formData.append("product_id", productData.value.id);

            // Make a POST request to add the product to the wishlist
            await axios.post("/api/wishlist", formData);

            // Set addedToWishlist to true after successful addition
            addedToWishlist.value = true;
        }
    } catch (error) {
        // Handle any errors that may occur during the request
        console.error("Error adding product to wishlist:", error);
    }
};
const removeFromWishlist = async () => {
    await fetchUserWishlist();
    try {
        // Find the index of the product in the wishlist array
        const productIndex = userWishlist.value.findIndex(
            (item) => item.product_id === productData.value.id
        );
        if (productIndex !== -1) {
            // If the product is in the wishlist, remove it
            await axios.delete(
                `/api/wishlist/${userWishlist.value[productIndex].id}`
            );

            // Set addedToWishlist to false after successful removal
            addedToWishlist.value = false;
        }
    } catch (error) {
        // Handle any errors that may occur during the request
        console.error("Error removing product from wishlist:", error);
    }
};

const fetchUserWishlist = async () => {
    await axios
        .get(`/api/wishlist/${user_id}`)
        .then((response) => {
            userWishlist.value = response.data;
        })
        .catch((error) => {
            console.error("Error fetching user wishlist:", error);
        });
    checkWishlist();
};

const checkWishlist = async () => {
    const isProductInWishlist = userWishlist.value.some(
        (item) => item.product_id === productData.value.id
    );

    if (isProductInWishlist) {
        // If the product is already in the wishlist, set addedToWishlist to true
        addedToWishlist.value = true;
    }
};

</script>

<template>
    <parth>
        <v-container>
        <section class="product-details">

            <div class="flex justify-center max-h-96 xl:max-h-[600px]">
                <div class="bg-white rounded-lg w-full">
                    <!-- Inside your template -->
                    <div class="flex items-center justify-between">
                        <v-breadcrumbs :items="breadcrumbs" divider=">"></v-breadcrumbs>
                        <div v-if="isLoggedIn">
                        <v-btn style="width: 1px; height: 60px; border-radius: 50%" v-if="!addedToWishlist"
                            @click="addToWishlist">
                            <v-icon>mdi-heart-outline</v-icon>
                        </v-btn>
                        <v-btn style="width: 1px; height: 60px; border-radius: 50%" v-else @click="removeFromWishlist">
                            <v-icon color="red">mdi-heart</v-icon>
                        </v-btn>
                    </div>
                    </div>

                    <!-- Use v-bind to correctly set the image source -->
                    <v-img :src="'http://127.0.0.1:8000' + productData.image" height="200"></v-img>

                    <div class="flex mt-4 w-full">
                        <v-btn style="background-color: rgb(231, 150, 0); width: 200px !important;" class="rounded-lg" size="large" block @click="addToCart">
                            <span class="py-2 lg:text-lg">Add To Cart</span>
                        </v-btn>
                    </div>
                </div>

            </div>
            <div class="mt-8 md:mt-0" style="margin-left: 9%;">

                <h3 style="font-size: 30px; font-weight: 600;">{{ productData.name }}</h3>


                <div class="flex items-center justify-between mt-4">
                    <div>
                        <span style="font-size: 25px; font-weight: 600;">${{ productData.price }}</span>
                    </div>

                </div>
                <span style="font-size: 1px; ">{{ productData.url_key }}</span>
                <div>
                    <div class="flex items-center">
                        <div class="mr-2">
                            <span v-for="index in 5" :key="index"
                                :class="{ 'text-2xl cursor-pointer': true, 'text-yellow-500': index <= calculateAverageRating() }">★</span>
                        </div>
                        <span class="text-gray-600">{{ calculateAverageRating() }}</span>
                    </div>

                    <div class="mt-4">
                        <!-- Make sure to use the correct property name -->
                        <span style="font-weight: 500;">{{ productData.detail }}</span>
                    </div>

                    <!-- Replace the existing code for displaying stars with this -->


                    <div class="mt-4">
                        <!-- Make sure to use the correct property name -->
                        <span style="font-weight: 500;">{{ Rdata.user_id }}</span>
                    </div>


                    <div class="mt-4">
                        <div class="border border-gray-300 p-2 mt-6">
                            <div class="flex items-center justify-between p-4">
                                <div class="text-xl font-semibold">
                                    Ratings &amp; Reviews
                                </div>
                            </div>
                        </div>
                        <div v-for="review in Rdata" :key="review.id">
                            <div class="border border-gray-300 p-6 my-4 rounded-md">
                                <div class="flex items-center text-lg md:text-xl mb-2">
                                    <span class="text-yellow-500">{{ review.star }}★</span>
                                    <span class="ml-2">{{ review.title }}</span>
                                </div>
                                <div class="text-gray-600 text-sm md:text-base">
                                    <div class="mb-2">{{ review.description }}</div>
                                    <div class="font-semibold">~ {{ review.user.name }}</div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </section>
    </v-container>
    </parth>
</template>

<style scoped>
.product-details {
    display: grid;
    grid-template-columns: 1fr;
    grid-template-rows: auto auto;
    grid-template-areas: 'image' 'details';
}

@media (min-width: 768px) {
    .product-details {
        display: grid;
        grid-template-columns: 1fr 1fr;
        grid-template-rows: auto;
        grid-template-areas: 'image details';
    }
}
</style>
