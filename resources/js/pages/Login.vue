<template>
    <v-container>
        <v-row justify="center">
            <v-col cols="12" sm="6" class="mt-4">
                <h2>Login</h2>
                <v-alert v-if="error" type="error">{{ error }}</v-alert>
                <v-form @submit.prevent="login">
                    <v-text-field v-model="form.email" label="Email" type="email"
                        :rules="emailRules"></v-text-field>
                    <v-text-field v-model="form.password" label="Password" type="password"
                        :rules="passwordRules"></v-text-field>
                    <v-btn type="submit" color="primary">Login</v-btn>
                    &nbsp;
                    <v-btn @click="goToRegister" color="secondary">Register</v-btn>
                </v-form>

            </v-col>
        </v-row>
    </v-container>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

import { useMainStore } from '../store/';
import axios from 'axios';

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

const goToRegister = () => {
    // Redirect to the registration page
    router.push({ path: "/Register" });
};

const error = ref(null); // Define error as a ref
</script>
