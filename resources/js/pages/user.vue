<template>
    <dashboard>
  <div class="container mt-5">
    <div class="card-header">
        <div class="hi">
            <span class="blurred-textt">User list</span>
        </div>
        <router-link
          to="/users/create"
          class="btn btn-primary float-end"
          >Add Users</router-link
        >

    </div>
    <div class="card-body">
      <div v-if="isLoading">
        <Loading title="Loading" />
      </div>
      <div v-else>
        <table
          class="table table-striped table-bordered"
          id="productTable"
        ></table>
      </div>
    </div>

    <DataTable
      :data="users"
      :columns="columns"
      class="display"
    />
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

const users = ref([])
const isLoading = ref(true)
const router = useRouter()

const columns = [
  { data: 'id', title: 'Id' },
  { data: 'name', title: 'Name' },
  { data: 'email', title: 'Email' },
  {
    data: null,
    title: 'Actions',
    render: function (data, type, row) {
      window.handleEdit = function (user_id) {
        router.push({
            name: 'users-id',
          params: { id: user_id },
        })
      }
      window.handleDelete = deleteUser
      return `<v-btn class="btn btn-primary" onclick="handleEdit(${row.id})">Edit</v-btn>
                    <v-btn class="btn btn-danger" onclick="handleDelete(${row.id})">Delete</v-btn>`
    },
  },
]

const fetchUsers = async () => {
  isLoading.value = true
  try {
    const response = await axios.get('http://127.0.0.1:8000/api/user')
    users.value = response.data

    isLoading.value = false
  } catch (error) {
    console.error('Error fetching user data:', error)
  }
}

const deleteUser = async id => {
  alert('Are you sure you want to delete this user!')
  axios
    .delete(`http://127.0.0.1:8000/api/user/${id}`)
    .then(response => {
      console.log('users has been deleted')
      fetchUsers()
    })
    .catch(error => {
      console.error(error)
    })
}

onMounted(fetchUsers)

// useHead({
//   title: 'users List',
// })

// definePageMeta({
//   middleware: 'auth',
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
