<template>
    <!-- <dashboard> -->

    <div class="hi">
        <span class="blurred-textt">Product list</span>
    </div>
    <v-btn @click="exportProducts" color="success">Export Products</v-btn>

    <!-- Add dropdown for file format -->
    <v-select v-model="selectedFormat" :items="fileFormats" label="Select File Format" style="max-width: 150px;"></v-select>


    <router-link :to="{ name: 'CreateProduct' }">
        <!-- Use v-btn to create a Vuetify button -->
        <v-btn color="primary">Create Product</v-btn>
    </router-link>

    <v-data-table :headers="columns" :items="products" :items-per-page="10" class="elevation-1">
        <template v-slot:item.image="{ item }">
            <v-img :src="item.image" width="100" height="100" class="img img-responsive"></v-img>
        </template>

        <template v-slot:item.actions="{ item }">
            <v-btn @click="deleteProduct(item.url_key)" color="red">Delete</v-btn>
            <v-btn @click="handleEdit(item.url_key)" color="primary">Edit</v-btn>
        </template>
    </v-data-table>

    <!-- </dashboard> -->
</template>

<script>
import axios from 'axios';
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
// import Dashboard from '../layouts/Dashboard.vue';

export default {
    components: {},
    setup() {
        const products = ref([]);
        const router = useRouter();
        const fileFormats = ['CSV', 'JSON'];
        const selectedFormat = ref('JSON'); // Default selected format
        const columns = [
            { title: 'ID', value: 'id' },
            { title: 'Name', value: 'name' },
            { title: 'Detail', value: 'detail' },
            { title: 'Image', value: 'image' },
            { title: 'Price', value: 'price' },
            { title: 'Actions', value: 'actions', sortable: false },
        ];

        const handleEdit = (url_key) => {
            router.push({ name: 'EditProduct-url_key', params: { url_key } });
        };

        const deleteProduct = async (url_key) => {
            try {
                await axios.delete(`http://localhost:8000/api/products/${url_key}`);
                alert('Deleted');
                fetchProducts();
            } catch (error) {
                console.error('Error deleting product:', error);
            }
        };

        const fetchProducts = async () => {
            try {
                const response = await axios.get('http://localhost:8000/api/products/');
                products.value = response.data;
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        };
        const exportProducts = () => {
            const dataToExport = selectedFormat.value === 'CSV' ? convertToCsv(products.value) : JSON.stringify(products.value, null, 2);
            const blob = new Blob([dataToExport], { type: selectedFormat.value === 'CSV' ? 'text/csv' : 'application/json' });
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = `products.${selectedFormat.value.toLowerCase()}`;
            link.click();
        };

        const convertToCsv = (data) => {
            // Check if the data array is not empty
            if (data.length === 0) {
                return ''; // Return an empty string if there is no data
            }

            // Extract headers from the first item in the array
            const headers = Object.keys(data[0]).join(',');

            // Convert each item to a comma-separated string and join with newline
            const csvContent = data.map(item => {
                // Extract values from each property and handle special characters
                const values = Object.values(item).map(value => {
                    if (typeof value === 'string' && value.includes(',')) {
                        // If the value contains a comma, wrap it in double quotes
                        return `"${value}"`;
                    }
                    return value;
                });
                return values.join(',');
            }).join('\n');

            // Combine headers and content with newline and return the final CSV string
            return `${headers}\n${csvContent}`;
        };


        onMounted(() => {
            fetchProducts();
        });

        return {
            router,
            columns,
            products,
            fileFormats,
            selectedFormat,
            exportProducts,
            deleteProduct,
            handleEdit,
        };
    },
};
</script>



<route lang="yaml">
    meta:

        layout: Dashboard
    </route>



<style scoped>
.hi {
    text-align: center;
    /* Add any other styles you need for the container */
}

.blurred-textt {
    color: rgb(247, 160, 0);
    backdrop-filter: blur(5px);
    font-size: 40px;
    font-weight: 550;
    padding: 8px;
    display: inline-block;
    /* To ensure backdrop-filter works properly */
}
</style>

<route lang="yaml">
  meta:
    layout: Dashboard
  </route>
