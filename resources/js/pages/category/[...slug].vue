<script setup>
import Parth from '../../layouts/Parth.vue';
import LaunchSale from '../../components/LaunchSale.vue';
import axios from 'axios'
import { ref, onMounted, computed, watch } from 'vue';
import { useRoute } from 'vue-router';
const route = useRoute()
const category = ref(null)
const products = ref([])
const filteredBadges = ref(new Set())
const breadcrumbs = ref([]);

const fetchCategoryData = async () => {
    try {
        const response = await axios.get(`http://localhost:8000/api/category/${route.params.slug}`)
        console.log(response.data.product_categories)
        category.value = response.data.category
        products.value = response.data.product_categories
        console.log('aoo', response.data)
        breadcrumbs.value = [
            { title: 'Home', href: '/home' },
            { title: response.data.name, href: null },
        ];
    } catch (error) {
        console.error('Error fetching category data:', error)
    }
}

// const badges = computed(() => [
//     ...new Set(
//         products.value
//             .filter((product) => product.badge)
//             .map((product) => product.badge),
//     ),
// ])

const filteredProducts = computed(() => {
    if (filteredBadges.value.size === 0) {
        return products.value
    } else {
        return products.value.filter((product) =>
            filteredBadges.value.has(product.badge)
        )
    }
})


onMounted(fetchCategoryData)

watch(() => route.params.slug, () => {
    // Fetch data for the new category
    fetchCategoryData();
});
</script>

<template>
    <parth>
        <div class="pb-16">
            <launch-sale></launch-sale>
            <v-container class="py-8">
                <v-breadcrumbs  :items="breadcrumbs" divider=">"></v-breadcrumbs>
                <div class="products-container">
                    <v-col v-for="product in filteredProducts" :key="product.id">
                        <router-link :to="`/store/${product.url_key}`">
                            <v-card border variant="outlined" class="md:h-full"
                                style="box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.3)">
                                <div class="h-64 relative">
                                    <v-img :src="'http://127.0.0.1:8000' + product.image" height="250"></v-img>
                                </div>
                                <v-card-text class="mt-14">
                                    <span style="font-size: 25px;">{{ product.name }}</span>
                                    <div>
                                        <span style="font-size: 18px; font-weight: 800;">{{ product.detail }}</span>
                                        <span style="font-size: 18px; font-weight: 800;">${{ product.price }}</span>
                                    </div>
                                </v-card-text>
                            </v-card>
                        </router-link>
                    </v-col>
                </div>

            </v-container>
        </div>
    </parth>
</template>


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
    margin-bottom: 20px;
}
</style>
