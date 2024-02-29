<template>
    <div class="v-container">
        <div class="p-8 space-y-4">
            <div class="flex justify-between kbhDeL pr-4 border-b">
                <div class="KpPZbF text-2xl font-semibold mb-4">
                    <h1>Ratings & Reviews</h1>
                </div>
                <div class="_52cNDb">
                    <a
                        href="/boult-curve-boomx-rich-bass-flexi-band-magnetic-earbuds-ipx5-water-resistant-bluetooth-headset/p/itmbfd57eac5bfa9?pid=ACCFEZ99MFMDR8CM">
                        <div class="_2snLhA flex items-center">
                            <div class="_1k8CFo flex-1">
                                <span style="font-size: 20px; font-weight: 500;">{{ product.name }}</span>
                            </div>

                            <div class="_2jTZAi ml-4">
                                <img loading="lazy" :src="product.image" alt="Product Image" class="product-image">
                            </div>
                        </div>
                    </a>
                </div>
            </div>


            <div class="border-b pb-4">
                <div class="text-lg font-semibold mb-2">Rate this product</div>
                <div class="flex items-center">
                    <div class="mr-2">

                        <span v-for="index in 5" :key="index" @click="setRating(index)"
                            :class="{ 'text-2xl cursor-pointer': true, 'text-yellow-500': index <= selectedRating }">★</span>
                    </div>
                    <span class="text-gray-600">{{ ratingDescriptions[selectedRating - 1] || 'No rating' }}</span>
                </div>
            </div>

            <!-- Review Section -->
            <div>
                <div class="text-lg font-semibold mb-2">Review this product</div>
                <div>
                    <form @submit.prevent="submitReview">
                        <div class="mb-4">
                            <div class="text-sm text-gray-600 mb-1">Description</div>
                            <textarea rows="8" placeholder="Description..." class="w-full border p-2"
                                v-model="reviewDescription"></textarea>
                        </div>
                        <div class="mb-4">
                            <div class="text-sm text-gray-600 mb-1">Title (optional)</div>
                            <input placeholder="Review title..." class="w-full border p-2" v-model="reviewTitle" />
                        </div>
                        <button type="submit" @click="saveProduct()"
                            class="px-6 py-2 bg-green-500 text-white">Submit</button>
                    </form>
                </div>
            </div>
        </div>

    </div>
</template>

<script setup>
import axios from 'axios';
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
const selectedRating = ref(0);
const reviewTitle = ref('');
const reviewDescription = ref('');

import { useMainStore } from '../../store/index';

const mainStore = useMainStore();
const ratingDescriptions = ['Very Bad', 'Bad', 'Neutral', 'Good', 'Very Good'];
const product = ref({});
const setRating = (rating) => {
    selectedRating.value = rating;
};

const rating = ref({
    product_name: '',
    star: '',
    description: '',
    title: '',
    product_id: '',

    user_id: '',
});
const route = useRoute();
const router = useRouter();


const saveProduct = async () => {


    const formData = new FormData();
    const customerId = mainStore.user.id;
    const productData = product.value;

    formData.append('product_name', productData.name);
    formData.append('star', selectedRating.value);  // Use selectedRating directly, it's not part of rating.value
    formData.append('description', reviewDescription.value);  // Use reviewDescription directly
    formData.append('title', reviewTitle.value);  // Use reviewTitle directly
    formData.append('product_id', productData.id);
    formData.append('user_id', customerId);

    try {
        const response = await axios.post("http://localhost:8000/api/rating", formData)

        router.push('/home')
    } catch (error) {
        console.error('Error updating product:', error)
    }
}

const fetchProducts = async () => {
    try {
        console.log('id', route.params.url_key);
        const response = await axios.get(`http://localhost:8000/api/products/${route.params.url_key}`)
        product.value = response.data.product
    } catch (error) {
        console.error('Error fetching product data:', error)
    }
}



onMounted(() => {
    fetchProducts();
});
</script>
<route lang="yaml">
    meta:

        layout: Parth
    </route>


<style scoped>
.product-image {
    width: 100px;
    height: 100px;
}

.product-container {
    display: flex;

    align-items: center;
    /* Vertically align items */
}

.product-image {
    width: 100px;
    height: 100px;
}

.right-section {
    margin-left: 30px;
    /* Adjust the margin between the left and right sections */
}
</style>
