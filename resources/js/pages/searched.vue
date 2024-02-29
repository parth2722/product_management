<template>
    <div>
        <launch-sale></launch-sale>
        <v-container class="py-8">
            <div class="text-gray-600">
                Showing {{ filteredProducts.length }} results for "<span class="font-semibold">{{ searchQuery }}</span>"
            </div>
            <div class="products-container">
                <v-col v-for="product in filteredProducts" :key="product.id">
                    <router-link :to="`/store/${product.url_key}`">
                        <v-card border variant="outlined" class="md:h-full"
                            style="box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.3)">
                            <div class="h-64 relative">
                                <v-img :src="'http://127.0.0.1:8000' + product.image" height="250"></v-img>
                            </div>
                            <v-card-text class="mt-2">
                                <span style="font-size: 25px;">{{ product.name }}</span>
                                <div class="flex font-medium items-center justify-between mt-4">
                                    <span style="font-size: 18px; font-weight: 800;">{{ product.detail }}</span>
                                    <!-- &nbsp; -->
                                    <br>
                                    <br>
                                    <span style="font-size: 18px; font-weight: 800;">${{ product.price }}</span>
                                </div>
                            </v-card-text>
                        </v-card>
                    </router-link>
                </v-col>
            </div>
        </v-container>
    </div>
</template>

<script setup>
import LaunchSale from '../components/LaunchSale.vue';
import axios from 'axios';
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import bus from '../plugins/eventBus';

const route = useRoute();
const filteredProducts = ref([]);
const searchQuery = ref('');

const updateFilteredProducts = async () => {
    try {
        const response = await axios.get('http://127.0.0.1:8000/api/products');
        const allProducts = response.data;

        searchQuery.value = route.query.q || '';
        let productsFound = false;

        if (searchQuery.value) {
            filteredProducts.value = allProducts.filter(product =>
                (product.name && product.name.toLowerCase().includes(searchQuery.value.toLowerCase())) ||
                (product.price && product.price.toLowerCase().includes(searchQuery.value.toLowerCase())) ||
                (product.detail && product.detail.toLowerCase().includes(searchQuery.value.toLowerCase())) ||
                (product.category && product.category.toLowerCase().includes(searchQuery.value.toLowerCase()))
            );
            productsFound = filteredProducts.value.length > 0;
        } else {
            filteredProducts.value = allProducts;
            productsFound = true; // Assuming all products are considered found when there is no search query
        }

        // Use the productsFound flag to conditionally display a message
        if (!productsFound) {
            // Display your message here, for example:
            console.log('No products found for the search query:', searchQuery.value);
        }
    } catch (error) {
        console.error('Error fetching or updating product data:', error);
    }
};


onMounted(() => {
    bus.on('search', () => {
        updateFilteredProducts();
    });
    updateFilteredProducts(); // Initial update based on the query in the route
});

const allProducts = ref([]); // Store all products in a ref for easy access
</script>

<route lang="yaml">
    meta:
        layout: Parth
</route>

<style scoped>
.yellow-text {
    font-size: 60px;
    color: orange;
    text-align: center;
    margin: 0;
}


.v-card {
    width: 250px;
    /* Adjust card width as needed */
    margin: 0 auto;
}

.v-img {
    object-fit: cover;
    border-radius: 8px;
}


.products-container {
    display: flex;
    flex-wrap: wrap;
}

.v-col {
    flex: 0 0 calc(25.73% - 10px);
    /* Adjust the percentage and margin as needed */
    margin-bottom: 20px;
    /* Adjust margin as needed */
}
</style>

