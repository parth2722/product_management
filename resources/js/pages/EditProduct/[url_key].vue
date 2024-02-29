<template>
    <v-container class="mt-5">
      <v-card>
        <v-card-title>
          <h4 class="mb-0">
            Edit product
            <nuxt-link
              to="/productsList"
              class="btn btn-danger float-end"
              >Back</nuxt-link
            >
          </h4>
        </v-card-title>
        <v-card-text>
          <v-form @submit.prevent="saveProduct">
            <v-text-field
              v-model="product.name"
              label="Name"
              required
            ></v-text-field>
            <br />
            <v-text-field
              v-model="product.detail"
              label="Detail"
              required
            ></v-text-field>
            <br />
            <v-text-field
              v-model="product.price"
              label="Price"
              type="number"
              required
            ></v-text-field>
            <br />
            <v-text-field
              v-model="product.featured"
              label="featured"
              type="number"
              required
            ></v-text-field>
            <br />
            <v-text-field
              v-model="product.url_key"
              label="url_key"
              required
            ></v-text-field>
            <br />
            <v-file-input
              @change="handleFileChange"
              label="Image"
            ></v-file-input>
            <br />
            <v-img
              v-if="product.image"
              :src="'http://127.0.0.1:8000' + product.image"
              width="150"
              height="150"
            ></v-img>
            <br />
            <v-select
              v-model="selectedCategory"
              :items="category"
              label="Categories"
              multiple
              item-text="name"
              item-value="id"
            ></v-select>

            <br />
            <v-btn
              type="submit"
              color="danger"
              >SAVE</v-btn
            >
          </v-form>
        </v-card-text>
      </v-card>
    </v-container>
  </template>



  <script>
  import axios from 'axios'
  import { ref,onMounted } from 'vue'
  import { useRoute,useRouter } from 'vue-router'

  export default {
    name: 'productCreate',
    setup() {
      const router = useRouter()
      const selectedCategory = ref([])
      const category = ref([])
      const product = ref({
        name: '',
        detail: '',
        price: '',
        featured: '',
        url_key: '',
        image: null,
      })
      const route = useRoute()

      const fetchProducts = async () => {
        try {
          const response = await axios.get(`http://localhost:8000/api/products/${route.params.url_key}`)
          selectedCategory.value = response.data.selectedCategory
          product.value = response.data.product
          category.value = response.data.categories.map(category => category.name)
        } catch (error) {
          console.error('Error fetching product data:', error)
        }
      }
      const saveProduct = async () => {
        // Convert the price to a number
        product.value.price = parseFloat(product.value.price)

        const formData = new FormData()
        formData.append('name', product.value.name)
        formData.append('detail', product.value.detail)
        formData.append('price', product.value.price)
        formData.append('featured', product.value.featured)
        formData.append('url_key', product.value.url_key)
        formData.append('image', product.value.image)
        // Append selected categories as an array
        formData.append('categoryIds', JSON.stringify(selectedCategory.value))

        formData.append('_method', 'put')

        try {
          const response = await axios.post(`http://localhost:8000/api/products/${route.params.url_key}`, formData, {
            headers: { 'Content-Type': 'multipart/form-data' },
          })

          router.push('/Allproduct')
        } catch (error) {
          console.error('Error updating product:', error)
        }
      }

      const handleFileChange = event => {
        product.value.image = event.target.files[0]
      }

      onMounted(() => {
        fetchProducts()
      })
      return {
        product,

        category,

        saveProduct,
        handleFileChange,
        selectedCategory,
      }
    },
  }
  </script>

  <style scoped>
  .error-message {
    color: red;
  }
  </style>
