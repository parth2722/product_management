<template>
  <v-container class="mt-5">
    <v-card>
      <v-card-header>
        <h4 class="mb-0">
          Edit Category
          <v-btn
            to="/categories"
            color="error"
            class="float-end"
            >Back</v-btn
          >
        </h4>
      </v-card-header>
      <br />
      <v-card-body>
        <v-form @submit.prevent="saveCategory">
          <v-row>
            <v-col cols="12">
              <v-text-field
                v-model="category.name"
                label="Name"
                required
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="category.slug"
                label="Slug"
                required
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="category.description"
                label="Description"
                required
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="category.position"
                label="Position"
                type="number"
                required
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="category.status"
                label="Status"
                type="number"
                required
              ></v-text-field>
            </v-col>
          </v-row>
          <br />
          <v-btn
            type="submit"
            color="error"
            >SAVE</v-btn
          >
        </v-form>
      </v-card-body>
    </v-card>
  </v-container>
</template>


<script>
import axios from 'axios'
import { useRouter, useRoute } from 'vue-router'
import { ref, onMounted, computed,watch } from 'vue';
export default {
  name: 'categoryCreate',
  setup() {
    const router = useRouter()
    const category = ref({
      name: '',
      slug: '',
      description: '',
      position: '',
      status: '',
    })
    const route = useRoute()

    const fetchCategory = async () => {
      try {
        const response = await axios.get(`http://localhost:8000/api/category/${route.params.slug}`)
        category.value = response.data
      } catch (error) {
        console.error('Error fetching category data:', error)
      }
    }

    const saveCategory = async () => {
      try {
        await axios.put(`http://localhost:8000/api/category/${route.params.slug}`, category.value, {
          // headers: { 'Content-Type': 'multipart/form-data' },
        })
        router.push('/categories')
      } catch (error) {
        console.error('Error saving category:', error)
      }
    }

    onMounted(fetchCategory)
    return {
      category,
      saveCategory,
    }
  },
}
</script>

<style scoped>
.error-message {
  color: red;
}
</style>



