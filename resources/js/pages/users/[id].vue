<template>
    <v-container class="mt-5">
        <v-card>

            <h4 class="mb-0">
                <v-btn to="/user" color="error" class="float-end">Back</v-btn>
            </h4>

            <v-card-body>
                <v-form @submit.prevent="saveUser">
                    <v-row>
                        <v-col cols="12">
                            <v-text-field v-model="users.name" label="Name" required></v-text-field>
                        </v-col>
                        <v-col cols="12">
                            <v-text-field v-model="users.email" label="email" required></v-text-field>
                        </v-col>
                        <v-col cols="12">
                            <v-text-field v-model="users.gender" label="gender" required></v-text-field>
                        </v-col>
                        <v-col cols="12">
                            <v-text-field v-model="users.number" label="number" required></v-text-field>
                        </v-col>
                        <v-col cols="12">
                            <v-text-field v-model="users.password" label="Password" required type="password"></v-text-field>
                        </v-col>
                        <v-col cols="12">
                            <v-text-field v-model="users.confirmPassword" label="Confirm Password" required type="password"
                                :rules="[v => v === users.password || 'Passwords do not match']"></v-text-field>
                        </v-col>
                    </v-row>

                    <v-btn type="submit" color="error">SAVE</v-btn>
                </v-form>
            </v-card-body>
        </v-card>
    </v-container>
</template>


<script>
import axios from 'axios'
import { ref, onMounted, computed, watch } from 'vue';
import { useRouter, useRoute } from 'vue-router';
export default {
    name: 'UserCreate',
    setup() {
        const router = useRouter()
        const users = ref({
            name: '',
            email: '',
            gender: '',
            number: '',
            password: '',
            confirmPassword: '',
        })

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

                router.push('/user')
            } catch (error) {
                console.error('Error saving user:', error)
            }
        }

        onMounted(fetchUser)
        return {
            users,
            saveUser,
        }
    },
}
</script>

<style scoped>
.error-message {
    color: red;
}
</style>
