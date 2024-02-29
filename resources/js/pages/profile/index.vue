<!-- src/components/Profile.vue -->
<template>
    <div class="bg-gray-100 min-h-screen p-8">
        <div class="max-w-3xl mx-auto bg-white p-8 rounded shadow-md">
            <!-- User Details Section -->
            <div class="mb-8">
                <h1 class="text-2xl font-semibold mb-4">My Profile</h1>
                <div class="flex items-center">
                    <!-- <img :src="users.profilePicture" alt="Profile" class="rounded-full w-16 h-16 mr-4" /> -->
                    <div>
                        <h2 class="text-xl font-semibold">
                            {{ users.name }}
                        </h2>
                        <p class="text-gray-600">{{ users.email }}</p>
                    </div>
                </div>
            </div>

            <!-- Order History Section -->
            <!-- <div class="mb-8">
                <h1 class="text-2xl font-semibold mb-4">Order History</h1>

                <div class="mt-4">
                    <label for="status" class="block text-sm font-medium text-gray-600">Order</label>
                    <input v-model="orders.status" class="mt-1 p-2 w-full border rounded" />
                </div>
            </div> -->

            <!-- Account Settings Section -->
            <div>
                <h1 class="text-2xl font-semibold mb-4">Account Settings</h1>
                <div>
                    <label for="fullName" class="block text-sm font-medium text-gray-600">Full Name</label>
                    <input v-model="name" type="text" id="fullName" name="fullName"
                        class="mt-1 p-2 w-full border rounded" />
                </div>
                <div class="mt-4">
                    <label for="email" class="block text-sm font-medium text-gray-600">Email Address</label>
                    <input v-model="email" type="email" id="email" name="email"
                        class="mt-1 p-2 w-full border rounded" />
                </div>
                <div class="mt-4">
                    <label class="block text-sm font-medium text-gray-600">Gender</label>
                    <div class="mt-2">
                        <div class="flex items-center">
                            <input v-model="gender" type="radio" id="male" name="gender" value="male" class="mr-2">
                            <label for="male" class="text-sm">Male</label>
                        </div>
                        <div class="flex items-center mt-2">
                            <input v-model="gender" type="radio" id="female" name="gender" value="female"
                                class="mr-2">
                            <label for="female" class="text-sm">Female</label>
                        </div>
                        <div class="flex items-center mt-2">
                            <input v-model="gender" type="radio" id="other" name="gender" value="other" class="mr-2">
                            <label for="other" class="text-sm">Other</label>
                        </div>
                    </div>
                </div>

                <div class="mt-4">
                    <label for="email" class="block text-sm font-medium text-gray-600">Number</label>
                    <input v-model="number" type="email" id="email" name="email"
                        class="mt-1 p-2 w-full border rounded" />
                </div>
                <button @click="saveUser" class="mt-8 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">
                    Save Changes
                </button>
            </div>
        </div>
    </div>
</template>

<script>
import axios from 'axios'
import { ref, onMounted, computed, watch } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { useMainStore } from '../../store/index';


export default {
    setup() {
        const store = useMainStore();
        const router = useRouter()
        const name = ref(store.getUser.name)
        const email = ref(store.getUser.email)
        // const name = ref(store.getUser.name)
        // const name = ref(store.getUser.name)

        const users = ref({
            name: '',
            email: '',
            gender: '',
            number: '',
            password: '',
            confirmPassword: '',
        })
        const orders = ref({
            status: '',
        });
        const route = useRoute()

        const fetchUser = async () => {
            try {
                const response = await axios.get(`http://localhost:8000/api/user/${route.params.id}`)
                users.value = response.data

            } catch (error) {
                console.error('Error fetching user data:', error)
            }
        }


        const saveUser = async () => {
            if (users.value.password !== users.value.confirmPassword) {
                alert('Passwords do not match')
                return
            }
            try {
                await axios.put(`http://localhost:8000/api/user/${route.params.id}`, users.value, {
                    // headers: { 'Content-Type': 'multipart/form-data' },
                })

                router.push('/home')
            } catch (error) {
                console.error('Error saving user:', error)
            }
        }

        onMounted(fetchUser)
        return {
            users,
            saveUser,
            name,
            email
            // fetchOrders,
        }
    },
}
</script>

<route lang="yaml">
    meta:
      layout: Parth
    </route>

<style scoped>
.error-message {
    color: red;
}
</style>
