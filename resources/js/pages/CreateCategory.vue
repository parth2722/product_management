<template>
    <v-container class="mt-5">
        <v-card>
            <v-card-header>
                <h4 class="mb-0">
                    Add Category
                    <v-btn to="/categories" color="error" class="float-end">Back</v-btn>
                </h4>

            </v-card-header>
            <v-card-body>
                <v-progress-circular v-if="isLoading" :title="isLoadingTitle"></v-progress-circular>
                <v-form v-else @submit.prevent="saveCategory">
                    <v-row>
                        <v-col cols="12" md="6">
                            <v-text-field v-model="category.name" label="Name" :error-messages="[validationError.name]"
                                :error="validationError.name ? true : false" required></v-text-field>
                        </v-col>
                        <v-col cols="12" md="6">
                            <v-text-field v-model="category.slug" label="Slug" :error-messages="[validationError.slug]"
                                :error="validationError.slug ? true : false" required></v-text-field>
                        </v-col>
                        <v-col cols="12">
                            <v-text-field v-model="category.description" label="Description"
                                :error-messages="[validationError.description]"
                                :error="validationError.description ? true : false" required></v-text-field>
                        </v-col>
                        <v-col cols="12" md="6">
                            <v-text-field v-model="category.position" label="Position" type="number"
                                :error-messages="[validationError.position]"
                                :error="validationError.position ? true : false" required></v-text-field>
                        </v-col>
                        <v-col cols="12" md="6">
                            <v-text-field v-model="category.status" label="Status" type="number" min="0" max="1"
                                :error-messages="[validationError.status]" :error="validationError.status ? true : false"
                                required></v-text-field>
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
import { useRouter } from 'vue-router';
export default {
    name: 'categoryCreate',
    setup() {
        const router = useRouter()
        const category = ref({
            name: '',
            slug: '',
            description: '',
            position: '',
            status: 0, // Default value is set to 0, adjust as needed
        })

        const isLoading = ref(false)
        const isLoadingTitle = ref('Loading')
        const validationError = ref({})

        const saveCategory = async () => {
            // Clear previous validation errors
            validationError.value = {}
            console.log(category.value.slug)
            if (
                !category.value.name ||
                !category.value.slug ||
                !category.value.description ||
                !category.value.position ||
                !category.value.status
            ) {
                validationError.value = {
                    name: !category.value.name ? 'Name is required.' : '',
                    slug: !category.value.slug ? 'slug is required.' : '',
                    description: !category.value.description ? 'description is required.' : '',
                    position: !category.value.position ? 'position is required.' : '',
                    status: !category.value.status ? 'status is required.' : '',
                }
                return
            }

            isLoading.value = true
            isLoadingTitle.value = 'Saving'

            const formData = new FormData()
            formData.append('name', category.value.name)
            formData.append('slug', category.value.slug) // Take the slug from the form data
            formData.append('description', category.value.description)
            formData.append('position', category.value.position)
            formData.append('status', category.value.status)

            try {
                const res = await axios.post(`http://localhost:8000/api/category`, formData)
                console.log(res)
                // alert(res.data.message);

                router.push({ path: '/categories' })
            } catch (error) {
                console.error('Error saving category:', error)
                // Handle error as needed
            } finally {
                isLoading.value = false
                isLoadingTitle.value = 'Loading'
            }
        }


        return {
            category,
            isLoading,
            isLoadingTitle,
            validationError,


            saveCategory,
        }
    },
}
</script>

<style scoped>
.error-message {
    color: white;
}
</style>
