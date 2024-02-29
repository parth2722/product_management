<template>
    <div>

        <div class="flex flex-col justify-center md:space-y-0 space-y-4 md:flex md:flex-row md:items-center md:w-full">
            <router-link to="/home" class="hover:text-primary underline-offset-8 " color="gray" exact>Home</router-link>
            <router-link v-for="category in categories" :key="category.slug" :to="`/category/${category.slug}`"
                class="hover:text-primary underline-offset-8"
                active-class="text-primary underline router-link-exact-active hover:text-primary underline-offset-8" exact>
                {{ category.name }}
            </router-link>

        </div>

    </div>
</template>

<script setup>
import axios from 'axios';
import { ref, onMounted, watch } from 'vue';
import { useRoute } from 'vue-router';

// Initialize a reactive reference to hold the fetched categories
const categories = ref([]);

// Access the current route using useRoute
const $route = useRoute();
const fetchCategories = async () => {
    try {
        const response = await axios.get('http://localhost:8000/api/category/');
        // Assuming the API response contains an array of categories
        categories.value = response.data;
    } catch (error) {
        console.error('Error fetching categories:', error);
    }
};

// Initial fetch when the component is mounted
onMounted(fetchCategories);
watch(() => $route, fetchCategories);
</script>

<style scoped>
div>a {
    margin-right: 6% !important;
}
</style>
