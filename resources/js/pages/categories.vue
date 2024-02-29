<template>
    <dashboard>
    <div class="container mt-5">
        <div class="card-header">
            <div class="hi">
                <span class="blurred-textt">Category list</span>
            </div>
            <router-link :to="{ name: 'CreateCategory' }">
                <!-- Use v-btn to create a Vuetify button -->
                <v-btn color="primary">Create Category</v-btn>
            </router-link>

        </div>
        <div class="card-body">
            <div>
                <table class="table table-striped table-bordered" id="productTable"></table>
            </div>
        </div>

        <DataTable :data="category" :columns="columns" class="display" />
    </div>
</dashboard>
</template>

<script setup>
import Dashboard from '../layouts/Dashboard.vue'
import { ref, onMounted, computed,watch } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios'
import DataTablesCore from 'datatables.net'
import DataTable from 'datatables.net-vue3'
DataTable.use(DataTablesCore)
// import DataTable from "vue-datatables-net";

const category = ref([])
const isLoading = ref(true)
const router = useRouter()

const columns = [
    { data: 'id', title: 'Id' },
    { data: 'name', title: 'name' },
    { data: 'slug', title: 'slug' },
    { data: 'description', title: 'description' },
    { data: 'position', title: 'position' },
    { data: 'status', title: 'status' },
    {
        data: null,
        title: 'Actions',
        render: function (data, type, row) {
            window.handleEdit = slug => {
                // Add your edit logic here
                console.log(`Editing category with slug: ${slug}`)

                // Redirect to the admin-category-slug page
                router.push({ name: 'slug', params: { slug } })
            }

            window.handleDelete = deleteCategory
            return `<v-btn class="btn btn-primary" onclick="handleEdit('${row.slug}')">Edit</v-btn>
            <v-btn class="btn btn-danger" onclick="handleDelete('${row.slug}')">Delete</v-btn>`
        },
    },
]

const fetchCategory = async () => {
    try {
        const response = await axios.get('http://127.0.0.1:8000/api/category/')
        category.value = response.data
        isLoading.value = false
    } catch (error) {
        console.error('Error fetching category data:', error)
    }
}

const deleteCategory = async slug => {
    const confirmDelete = confirm('Are you sure you want to delete this Category!')

    if (confirmDelete) {
        try {
            await axios.delete(`http://127.0.0.1:8000/api/category/${slug}`)
            console.log('Category has been deleted')
            fetchCategory()
        } catch (error) {
            console.error('Error deleting category:', error)
        }
    }
}

onMounted(fetchCategory)

</script>

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

