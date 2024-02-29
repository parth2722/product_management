<template>
    <div class="container mx-auto p-4">
      <div class="bg-white p-8 max-w-md mx-auto rounded shadow-md">
        <h1 class="text-orange-500 text-4xl font-bold mb-8">Register</h1>

        <div v-if="isLoading" class="mb-4">
          <div class="text-center text-gray-700">Loading</div>
        </div>

        <form v-else @submit.prevent="saveuser">
          <!-- Name Field -->
          <div class="mb-4">
            <label for="name" class="block text-gray-700 font-bold mb-2">Name</label>
            <input v-model="users.name" type="text" id="name" name="name" class="w-full p-2 border border-gray-300 rounded">
          </div>

          <!-- Email Field -->
          <div class="mb-4">
            <label for="email" class="block text-gray-700 font-bold mb-2">Email</label>
            <input v-model="users.email" type="email" id="email" name="email" class="w-full p-2 border border-gray-300 rounded">
          </div>

          <!-- Password Field -->
          <div class="mb-4">
            <label for="password" class="block text-gray-700 font-bold mb-2">Password</label>
            <input v-model="users.password" type="{{ showPassword ? 'text' : 'password' }}" id="password" name="password" class="w-full p-2 border border-gray-300 rounded">
          </div>

          <div class="mb-4">
            <label for="confirmPassword" class="block text-gray-700 font-bold mb-2">Confirm Password</label>
            <input v-model="users.confirmPassword" type="password" id="confirmPassword" name="confirmPassword" class="w-full p-2 border border-gray-300 rounded">
          </div>

          <div class="mb-4">
            <input v-model="showPassword" type="checkbox" id="showPassword" name="showPassword" class="mr-2">
            <label for="showPassword" class="text-gray-700">Show Password</label>
          </div>

          <button type="submit" class="bg-red-500 text-white p-2 rounded">Register</button>
        </form>
      </div>
    </div>
  </template>

<script>
import axios from 'axios'
import { useRouter, useRoute } from 'vue-router'
import { ref, onMounted, computed, watch } from 'vue';
export default {
    name: 'UserCreate',
    setup() {
        const router = useRouter()
        const users = ref({
            name: '',
            email: '',
            password: '',
        })
        const isLoading = ref(false)
        const isLoadingTitle = ref('Loading')
        const confirmPasswordRules = [
            value => !!value || 'Please confirm your password',
            value => value === users.value.password || 'Passwords do not match',
        ]

        const showPassword = ref(false)
        const saveuser = async () => {
            // Check if passwords match
            if (users.value.password !== users.value.confirmPassword) {
                // Handle the case where passwords don't match, for example, show an error message
                alert('Passwords do not match')
                return
            }

            isLoading.value = true
            isLoadingTitle.value = 'Saving'

            const formData = new FormData()
            formData.append('name', users.value.name)
            formData.append('email', users.value.email)
            formData.append('password', users.value.password)

            try {
                const res = await axios.post(`http://localhost:8000/api/user`, formData)
                console.log(res)

                router.push({ path: '/frontLogin' })
            } catch (error) {
                console.error('Error saving user:', error)
                // Handle error as needed
            } finally {
                isLoading.value = false
                isLoadingTitle.value = 'Loading'
            }
        }
        const goToRegister = () => {
            // Redirect to the registration page
            router.push({ path: "/login" });
        };
        return {
            users,
            isLoading,
            goToRegister,
            isLoadingTitle,
            saveuser,
            confirmPasswordRules,
            showPassword,
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
    color: white;
}

.yellow-text {
    color: orange;
    text-align: center;

    font-size: 40px;
    font-weight: 600;
}
</style>
