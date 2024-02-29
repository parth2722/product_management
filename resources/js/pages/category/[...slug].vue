<script setup>
import Parth from '../../layouts/Parth.vue';
import axios from 'axios'
import { ref, onMounted, computed, watch } from 'vue';
import { useRoute } from 'vue-router';
import { useMainStore } from '../../store/index';
const route = useRoute()
const category = ref(null)
const products = ref([])
const filteredBadges = ref(new Set())
const breadcrumbs = ref([]);
const mainStore = useMainStore();
const user_id = mainStore.user ? mainStore.user.id : null;

const addedToWishlist = ref(false);
const userWishlist = ref([]);
const isLoggedIn = computed(() => {
    return mainStore.getToken !== null;
});
const fetchCategoryData = async () => {
    try {
        const response = await axios.get(`http://localhost:8000/api/category/${route.params.slug}`)
        console.log(response.data.product_categories)
        category.value = response.data.category
        products.value = response.data.product_categories

        breadcrumbs.value = [
            { title: 'Home', href: '/home' },
            { title: response.data.name, href: null },
        ];
    } catch (error) {
        console.error('Error fetching category data:', error)
    }
}
const filteredProducts = computed(() => {
    if (filteredBadges.value.size === 0) {
        return products.value
    } else {
        return products.value.filter((product) =>
            filteredBadges.value.has(product.badge)
        )
    }
})
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

onMounted(() => {
    fetchCategoryData();
    fetchUserWishlist();
});


watch(() => route.params.slug, () => {
    // Fetch data for the new category
    fetchCategoryData();
});
</script>

<template>
    <parth>

        <v-container>
            <v-breadcrumbs :items="breadcrumbs" divider=">"></v-breadcrumbs>
            <div class="products-container">
                <v-col v-for="product in filteredProducts" :key="product.id" class="no-padding">
                    <router-link :to="`/store/${product.url_key}`" class="v-card">
                        <template v-slot="{ navigate }">
                            <v-card border variant="outlined" class="md:h-full"
                                style="box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.3)">
                                <div v-if="isLoggedIn">
                                    <v-btn style="width: 1px; height: 60px; border-radius: 50%" v-if="!addedToWishlist"
                                        @click="addToWishlist(product, navigate)">
                                        <v-icon>mdi-heart-outline</v-icon>
                                    </v-btn>
                                    <v-btn style="width: 1px; height: 60px; border-radius: 50%" v-else
                                        @click="removeFromWishlist(product, navigate)">
                                        <v-icon color="red">mdi-heart</v-icon>
                                    </v-btn>
                                </div>
                                <div class="h-64 relative">
                                    <v-img :src="'http://127.0.0.1:8000' + product.image" height="250"></v-img>
                                </div>
                                <v-card-text class="mt-10">
                                    <span style="font-size: 25px;">{{ product.name }}</span>
                                    <span style="font-size: 18px; font-weight: 800; margin-left: 11%;">${{ product.price
                                    }}</span>
                                </v-card-text>
                            </v-card>
                        </template>
                    </router-link>

                </v-col>
            </div>
        </v-container>
    </parth>
</template>


<style scoped>
.yellow-text {
    font-size: 60px;
    color: orange;
    text-align: center;
    margin: 0;
}

.no-padding {
    padding: 0;
    margin: 0;
}

.v-card {
    width: 250px;

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
    flex: 0 0 calc(24.73% - 10px);
}</style>
