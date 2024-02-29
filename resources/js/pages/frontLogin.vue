<template>
    <div class="container mx-auto">
      <div class="flex justify-center mt-4">
        <div class="w-full sm:w-1/2">
          <h1 class="text-orange-500 text-center text-4xl font-semibold mb-6">Login</h1>
          <div v-if="error" class="bg-red-500 text-white p-4 mb-4">{{ error }}</div>
          <form @submit.prevent="login" class="mb-4">
            <div class="mb-4">
              <label for="email" class="block text-gray-700 font-bold mb-2">Email</label>
              <input v-model="form.email" type="email" id="email" name="email" class="w-full p-2 border border-gray-300 rounded">
            </div>

            <div class="mb-4">
              <label for="password" class="block text-gray-700 font-bold mb-2">Password</label>
              <input v-model="form.password" type="password" id="password" name="password" class="w-full p-2 border border-gray-300 rounded">
            </div>

            <div class="flex">
              <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mr-2">Login</button>
              <Glogin></Glogin>
              <g-itlogin></g-itlogin>
            </div>
          </form>
        </div>
      </div>
    </div>
  </template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useMainStore } from '../store/';
import axios from 'axios';
import Glogin from './Glogin.vue'
import GItlogin from './GItlogin.vue'
const router = useRouter();
const authStore = useMainStore();

const form = ref({
    email: '',
    password: ''
});

const emailRules = [
    (v) => !!v || 'E-mail is required',
    (v) => /.+@.+\..+/.test(v) || 'E-mail must be valid',
];

const passwordRules = [
    (v) => !!v || 'Password is required',
    (v) => (v && v.length >= 8) || 'Password must be at least 8 characters',
];

const login = async () => {
    try {
        // Client-side validations
        if (!form.value.email || !form.value.password) {
            throw new Error('Please fill in all fields.');
        }

        const res = await axios.post('/api/login', form.value);
        if (res.data.success) {
            authStore.setToken(res.data.token);
            authStore.setUser(res.data.user);
            if (res.data.user.role == 1) {
                router.replace({ path: "/adminPanel" });
            } else {
                router.replace({ path: "/home" });
            }

        } else {
            throw new Error(res.data.message);
        }
    } catch (e) {
        // Handle validation errors or API response errors
        console.error('Login error:', e.message);
        // Set the error message to be displayed in the UI
        error.value = e.message;
    }
};

const error = ref(null); // Define error as a ref


</script>


<route lang="yaml">
    meta:
      layout: Parth
    </route>


<style scoped>
.error-message {
    color: white;
}

.yellow-text {
    color: orange;
    text-align: center;

    font-size: 40px;
    font-weight: 600;
}
</style>
