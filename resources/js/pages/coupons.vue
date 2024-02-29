<template>
    <dashboard>
        <div class="container mt-5">
            <div class="card-header">
                <div class="hi">
                    <span class="blurred-textt">Coupans list</span>
                </div>
                <router-link :to="{ name: 'CreateCoupons' }">
                    <!-- Use v-btn to create a Vuetify button -->
                    <v-btn color="primary">Create Coupans</v-btn>
                </router-link>

            </div>
            <div class="card-body">
                <div>
                    <table class="table table-striped table-bordered" id="productTable"></table>
                </div>
            </div>

            <DataTable :data="coupans" :columns="columns" class="display" />
        </div>
    </dashboard>
</template>

<script setup>
import Dashboard from '../layouts/Dashboard.vue'
import { ref, onMounted, computed, watch } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios'
import DataTablesCore from 'datatables.net'
import DataTable from 'datatables.net-vue3'
DataTable.use(DataTablesCore)
// import DataTable from "vue-datatables-net";

const coupans = ref([])
const isLoading = ref(true)
const router = useRouter()

const columns = [
    { data: 'id', title: 'Id' },
    { data: 'code', title: 'code' },
    { data: 'discount_type', title: 'discount_type' },
    { data: 'discount_amount', title: 'discount_amount' },
    { data: 'end_date', title: 'end_date' },
    { data: 'max_uses', title: 'max_uses' },
    {
        data: null,
        title: 'Actions',
        render: function (data, type, row) {
            window.handleEdit = code => {
                // Add your edit logic here
                console.log(`Editing coupans with id: ${code}`)

                router.push({ name: 'coupon-code', params: { code } })
            }

            window.handleDelete = deleteCoupon
            return `<v-btn class="btn btn-primary" onclick="handleEdit('${row.code}')">Edit</v-btn>
                    <v-btn class="btn btn-danger" onclick="handleDelete(${row.id})">Delete</v-btn>`
        },
    },
]

const fetchCategory = async () => {
    try {
        const response = await axios.get('http://127.0.0.1:8000/api/coupons/')
        coupans.value = response.data
        isLoading.value = false
    } catch (error) {
        console.error('Error fetching category data:', error)
    }
}


const deleteCoupon = async id => {
    const confirmDelete = confirm('Are you sure you want to delete this coupon!')

    if (confirmDelete) {
        try {
            await axios.delete(`http://127.0.0.1:8000/api/coupons/${id}`)

            console.log('coupon has been deleted')
            fetchCategory()
        } catch (error) {
            console.error('Error deleting coupon:', error)
        }
    }
}


onMounted(fetchCategory)

// useHead({
//     title: 'Category List',
// })

// definePageMeta({
//     middleware: 'auth',
// })
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

