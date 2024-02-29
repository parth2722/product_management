<template>
    <parth>
        <div>
            <!-- <launch-sale></launch-sale> -->

            <!-- <v-carousel :cycle="true" :interval="2000">
                <v-carousel-item-group v-if="HotProducts.length > 0">
                    <v-carousel-item v-for="product in filteredProducts" :key="product.id">
                        <router-link :to="`/store/${product.url_key}`">
                            <div>
                                <span style="font-size: 30px; font-weight: 500; margin-left: 45%;">{{ product.name }}</span>
                                <br>
                                <div
                                    style="position: relative; background-color: #e0e0e0; overflow: hidden; height: 360px; width: 100%;">
                                    <img :src="'http://127.0.0.1:8000' + product.image"
                                        style="object-fit: contain; object-position: center center; width: 100%; height: 100%;">
                                </div>

                            </div>
                        </router-link>
                    </v-carousel-item>
                </v-carousel-item-group>
            </v-carousel> -->

            <v-container >
                <br>
                <h1 class="text-center text-primary" style="font-size: 40px; font-weight: 800; color: transparent;">
                    Featured Products🔥</h1>
                <br>
                <v-carousel :cycle="true" :interval="2000" hide-delimiters>
                    <v-carousel-item-group v-if="filteredProducts.length > 0">
                        <v-carousel-item v-for="product in chunkedProducts" :key="product[0].id">
                            <v-row>
                                <v-col v-for="item in product" :key="item.id">
                                    <router-link :to="`/store/${item.url_key}`">
                                        <v-card border variant="outlined" class="md:h-full"
                                            style="box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.3)">
                                            <div class="h-64 relative">
                                                <v-img :src="'http://127.0.0.1:8000' + item.image" height="250"></v-img>
                                            </div>
                                            <v-card-text class="mt-2">
                                                <span style="font-size: 25px;">{{ item.name }}</span>
                                                <div class="flex font-medium items-center justify-between mt-4">
                                                    <span style="font-size: 18px; font-weight: 800;">{{ item.detail
                                                    }}</span>
                                                    <br>
                                                    <br>
                                                    <span style="font-size: 18px; font-weight: 800;">${{ item.price
                                                    }}</span>
                                                </div>
                                            </v-card-text>
                                        </v-card>
                                    </router-link>
                                </v-col>
                            </v-row>
                        </v-carousel-item>
                    </v-carousel-item-group>
                </v-carousel>

                <h1 class="text-center text-primary" style="font-size: 40px; font-weight: 800; color: transparent;">
                    Latest Products🔥</h1>
                <br>
                <v-carousel :cycle="true" :interval="2000" hide-delimiters>
                    <v-carousel-item-group v-if="products.length > 0">
                        <v-carousel-item v-for="product in laestProducts" :key="product[0].id">
                            <v-row>
                                <v-col v-for="item in product" :key="item.id">
                                    <router-link :to="`/store/${item.url_key}`">
                                        <v-card border variant="outlined" class="md:h-full"
                                            style="box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.3)">
                                            <div class="h-64 relative">
                                                <v-img :src="'http://127.0.0.1:8000' + item.image" height="250"></v-img>
                                            </div>
                                            <v-card-text class="mt-2">
                                                <span style="font-size: 25px;">{{ item.name }}</span>
                                                <div class="flex font-medium items-center justify-between mt-4">
                                                    <span style="font-size: 18px; font-weight: 800;">{{ item.detail
                                                    }}</span>
                                                    <br>
                                                    <br>
                                                    <span style="font-size: 18px; font-weight: 800;">${{ item.price
                                                    }}</span>
                                                </div>
                                            </v-card-text>
                                        </v-card>
                                    </router-link>
                                </v-col>
                            </v-row>
                        </v-carousel-item>
                    </v-carousel-item-group>
                </v-carousel>
            </v-container>
        </div>
    </parth>
</template>
<script setup>
import Parth from '../layouts/Parth.vue';
import LaunchSale from '../components/LaunchSale.vue';
import axios from 'axios';
import bus from '../plugins/eventBus'
import { ref, onMounted, watch, computed } from 'vue';
import { useRoute } from 'vue-router';
const featuredProducts = ref([])

const products = ref([]);
const route = useRoute();
const NameChange = ref([]);
const filteredProducts = ref([]);

const updateFilteredProducts = (searchQuery) => {
    if (searchQuery) {
        filteredProducts.value = products.value.filter(product =>
            product.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
            product.price.toLowerCase().includes(searchQuery.toLowerCase()) ||
            product.detail.toLowerCase().includes(searchQuery.toLowerCase())
        );
    } else {
        filteredProducts.value = products.value;
    }
};
const chunkedProducts = computed(() => {
    const chunkSize = 4;
    const chunks = [];

    for (let i = 0; i < filteredProducts.value.length; i += chunkSize) {
        chunks.push(filteredProducts.value.slice(i, i + chunkSize));
    }

    return chunks;
});

const HotProducts = computed(() => {
    const chunkSize = 1;
    const chunks = [];

    for (let i = 0; i < filteredProducts.value.length; i += chunkSize) {
        chunks.push(filteredProducts.value.slice(i, i + chunkSize));
    }

    return chunks;
});

const laestProducts = computed(() => {
    const chunkSize = 4;
    const chunks = [];

    for (let i = 0; i < NameChange.value.length; i += chunkSize) {
        chunks.push(NameChange.value.slice(i, i + chunkSize));
    }

    return chunks;
});

const fetchProducts = async () => {
    try {
        const response = await axios.get('http://127.0.0.1:8000/api/products');
        const allProducts = response.data;
        NameChange.value = response.data;
        featuredProducts.value = allProducts.filter(product => product.featured === 1); // Assuming 1 represents featured


        if (route.params.category) {
            products.value = allProducts.filter(product => product.category === route.params.category && product.featured === 1);
        } else {
            products.value = allProducts.filter(product => product.featured === 1);
        }

        updateFilteredProducts();
    } catch (error) {
        console.error('Error fetching product data:', error);
    }
};




onMounted(() => {
    fetchProducts(); // Fetch initial products
    bus.on('search', updateFilteredProducts); // Listen for search events
});

// Watch for changes in the route and update filtered products accordingly
watch(() => route.params.category, fetchProducts);

</script>

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
    flex: 0 0 calc(25.00% - 10px);
    /* Adjust the percentage and margin as needed */

    margin-bottom: 20px;
    /* Adjust margin as needed */
}
</style>
