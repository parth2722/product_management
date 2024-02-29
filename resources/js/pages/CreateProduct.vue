<template>
    <v-container class="mt-5">
        <v-card>
            <v-card-title>
                <h4 class="mb-0">
                    Add product
                    <router-link to="/Allproduct" class="btn btn-danger float-end">Back</router-link>
                </h4>
                <input id="fileInput" type="file" ref="fileInput" style="display: none" @change="importProducts">
                <v-btn @click="triggerFileInput" color="info">Import Products</v-btn>
            </v-card-title>
            <v-card-text>
                <v-form @submit.prevent="saveProduct">
                    <v-text-field v-model="product.name" label="Name" required></v-text-field>
                    <br />
                    <v-text-field v-model="product.detail" label="Details" required></v-text-field>
                    <br />
                    <v-text-field v-model="product.price" label="Price" type="number" required></v-text-field>
                    <br />
                    <v-text-field v-model="product.featured" label="featured" type="number" required></v-text-field>
                    <br />
                    <v-text-field v-model="product.url_key" label="url_key" required></v-text-field>
                    <br />
                    <v-file-input @change="handleFileChange" label="Image" required></v-file-input>
                    <br />
                    <v-select v-model="selectedCategory" label="Categories" :items="category" outlined multiple chips
                        :error-messages="errorList.categories ? [errorList.categories[0]] : []"></v-select>
                    <br />
                    <v-btn type="submit" color="danger">SAVE</v-btn>
                </v-form>
            </v-card-text>
        </v-card>
    </v-container>
</template>

<script>
import axios from 'axios'
import { ref, onMounted, computed, watch } from 'vue';
import { useRouter } from 'vue-router';
import Papa from 'papaparse';
export default {
    name: 'productCreate',
    setup() {
        const router = useRouter()
        const selectedCategory = ref(null)
        const category = ref([])
        const product = ref({
            name: '',
            detail: '',
            price: '',
            featured: '',
            url_key: '',
            image: null,
        })
        const validationError = ref({})
        const errorList = ref({ categories: [] })

        const fetchCategoryId = async () => {
            try {
                const response = await axios.get('http://127.0.0.1:8000/api/category/')
                category.value = response.data.map(item => item.name)

                const selectedCategoryIds = selectedCategory.value.map(
                    categoryName => response.data.find(item => item.name === categoryName)?.id,
                )

                console.log(selectedCategoryIds)

                return selectedCategoryIds
            } catch (error) {
                console.error('Error fetching categories:', error)
                return null
            }
        }

        const saveProduct = async () => {
            const categoryIds = await fetchCategoryId()

            const formData = new FormData()
            formData.append('name', product.value.name)
            formData.append('detail', product.value.detail)
            formData.append('price', product.value.price)
            formData.append('featured', product.value.featured)
            formData.append('url_key', product.value.url_key)
            formData.append('image', product.value.image)

            // Append multiple category IDs to the FormData
            categoryIds.forEach(category_id => {
                formData.append('categoryIds[]', category_id)
            })

            try {
                const res = await axios.post('http://localhost:8000/api/products', formData)
                console.log(res)

                router.push({ path: '/Allproduct' })
            } catch (error) {
                console.error('Error saving product:', error)
            }
        }

        const handleFileChange = event => {
            product.value.image = event.target.files[0]
        }

        const triggerFileInput = () => {
            const fileInput = document.getElementById('fileInput');
            fileInput.click();
        };

        const importProducts = async () => {
            const fileInput = document.getElementById('fileInput');
            const file = fileInput.files[0];

            if (file) {
                try {
                    const fileExtension = file.name.split('.').pop().toLowerCase();

                    if (fileExtension === 'json') {
                        // Handle JSON file
                        const fileData = await readFileAsync(file);
                        const importedProducts = JSON.parse(fileData);

                        for (const importedProduct of importedProducts) {
                            // Set product values based on imported product data
                            product.value.name = importedProduct.name;
                            product.value.detail = importedProduct.detail;
                            product.value.price = importedProduct.price;
                            product.value.featured = importedProduct.featured;
                            product.value.url_key = importedProduct.url_key;
                            product.value.image = importedProduct.image;

                            // Set category (if available in imported product data)
                            selectedCategory.value = importedProduct.categories || [];

                            // Save the product
                            await saveProduct();
                        }
                    } else if (fileExtension === 'csv') {
                        // Handle CSV file
                        Papa.parse(file, {
                            complete: async (result) => {
                                const importedProducts = result.data;

                                for (const importedProduct of importedProducts) {
                                    // Set product values based on imported product data
                                    product.value.name = importedProduct.name;
                                    product.value.detail = importedProduct.detail;
                                    product.value.price = importedProduct.price;
                                    product.value.featured = importedProduct.featured;
                                    product.value.url_key = importedProduct.url_key;
                                    product.value.image = importedProduct.image;

                                    // Set category (if available in imported product data)
                                    selectedCategory.value = importedProduct.categories || [];

                                    // Save the product
                                    await saveProduct();
                                }

                                console.log('Products imported successfully!');
                            },
                            header: true, // Assumes the first row contains headers
                        });
                    } else {
                        console.error('Unsupported file format. Please use JSON or CSV.');
                    }
                } catch (error) {
                    console.error('Error importing products:', error);
                }
            }
        };

        const readFileAsync = (file) => {
            return new Promise((resolve, reject) => {
                const reader = new FileReader();

                reader.onload = (event) => {
                    resolve(event.target.result);
                };

                reader.onerror = (error) => {
                    reject(error);
                };

                reader.readAsText(file);
            });
        };


        onMounted(fetchCategoryId)

        return {
          product,
            saveProduct,
            handleFileChange,
            triggerFileInput,
            importProducts,
            selectedCategory,
            category,
            errorList,
        }
    },
}
</script>

<style scoped>
.error-message {
    color: red;
}
</style>
