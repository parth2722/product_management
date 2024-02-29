<template>
    <div>

        <h1 class="yellow-text">Inovice Details</h1>
        <br>
        <div class="save-button">
            <v-btn color="orange" @click="saveInvoice(id)">
                <span>save</span>
            </v-btn>
        </div>

        <h3 style="font-size: 30px; font-weight: 500;">Order And Account:</h3>

        <div class="card-body d-flex">
            <div class="sku w-50 ng-star-inserted">
                <div class="order-description-main">
                    <h5 style="font-size: 20px; font-weight: 500;">Order Information</h5>
                    <p>Order ID: {{ orders.id }}</p>
                    <p>Order Date: {{ orders.created_at }}</p>
                    <p>Status: {{ orders.status }}</p>
                </div>
            </div>

            <div class="sku mr-3 ng-star-inserted">
                <div class="order-description-main">
                    <h5 style="font-size: 20px; font-weight: 500;">Account Information</h5>
                    <p>Name: {{ orders.user?.name }}</p>
                    <p>Email: {{ orders.user?.email }}</p>

                </div>

            </div>
        </div>
        <br>
        <h3 style="font-size: 30px; font-weight: 500;">Address</h3>

        <div class="card-body d-flex">
            <div class="sku w-50 ng-star-inserted">
                <div class="order-description-main">
                    <h5 style="font-size: 20px; font-weight: 500;">Billing Address</h5>
                    <p>Name: {{ addresses.fullName }}</p>
                    <p>Post Code: {{ addresses.postCode }}</p>
                    <p>City: {{ addresses.city }}</p>
                    <p>State: {{ addresses.state }}</p>
                    <p>Country: {{ addresses.country }}</p>
                    <p>Contact: {{ addresses.phone }}</p>
                </div>

            </div>

            <div class="sku mr-3 ng-star-inserted">
                <div class="order-description-main">
                    <h5 style="font-size: 20px; font-weight: 500;">Shipping Address</h5>
                    <p>Name: {{ addresses.fullName }}</p>
                    <p>Post Code: {{ addresses.postCode }}</p>
                    <p>City: {{ addresses.city }}</p>
                    <p>State: {{ addresses.state }}</p>
                    <p>Country: {{ addresses.country }}</p>
                    <p>Contact: {{ addresses.phone }}</p>

                </div>
            </div>
        </div>
        <br>
        <h3 style="font-size: 30px; font-weight: 500;">Payment and Shipping</h3>

        <div class="card-body d-flex">
            <div class="sku w-50 ng-star-inserted">
                <div class="order-description-main">
                    <h5 style="font-size: 20px; font-weight: 500;">Payment Information</h5>
                    <p>Payment Method:{{ orders.payment?.method }}</p>
                    <p>Currency: USD</p>
                </div>
            </div>

            <div class="sku mr-3 ng-star-inserted">
                <div class="order-description-main">
                    <h5 style="font-size: 20px; font-weight: 500;">Shipping Information</h5>
                    <p>Shipping Method: {{ orders.shippingMethod }}</p>
                    <p>Shipping Price: Free </p>
                </div>


            </div>
        </div>
        <br>
        <h3 style="font-size: 30px; font-weight: 500;">Products Ordered</h3>

        <div class="card-body flex">
            <table id="invoice-table" class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">SKU</th>
                        <th class="px-4 py-2">Product Name</th>
                        <th class="px-4 py-2">Quantity</th>
                        <th class="px-4 py-2">Price</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="item in orders.orderitem" :key="item">
                        <td class="px-4 py-2">{{ item.sku }}</td>
                        <td class="px-4 py-2">{{ item.name }}</td>
                        <td class="px-4 py-2">{{ orders.totalQtyOrdered }}</td>
                        <td class="px-4 py-2">{{ item.price }}</td>
                    </tr>
                    <tr>
                        <td colspan="2"></td>
                        <td class="px-4 py-2">Grand Total</td>
                        <td class="px-4 py-2">{{ orders.grandTotal }}</td>
                    </tr>
                </tbody>

            </table>


        </div>

    </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';



const route = useRoute();
const orders = ref([]);
const users = ref([]);
const addresses = ref([]);
const router = useRouter();  // Create a router instance
const cartItems = ref([]);

const invoice = ref({
    totalQty: '',
    grandTotal: '',
    shippingAmount: '',
    order_id: '',
    orderAddress_id: '',
    transaction_id: '',
})

const saveInvoice = async () => {
    try {
        // Ensure addresses are fetched before proceeding
        await fetchAddress();

        const formData = new FormData();
        const firstOrder = orders.value;
        const orderAddress = addresses.value;

        formData.append('totalQty', firstOrder.totalQtyOrdered);
        formData.append('grandTotal', firstOrder.grandTotal);
        formData.append('shippingAmount', '50.00');
        formData.append('orderAddress_id', orderAddress.id); // Use orderAddress.id
        formData.append('order_id', firstOrder.id);

        // Create shipment
        const invoiceResponse = await axios.post('http://localhost:8000/api/invoice', formData);
        console.log('invoice response:', invoiceResponse.data);

        // Update order status to 'shipped'
        await axios.put(`http://localhost:8000/api/orderupdate/${firstOrder.id}`, {
            status: 'processing',
        });
        console.log('Order status updated successfully.');

        // Redirect to the orders page or perform any other necessary action
        router.push({ path: '/orders' });
    } catch (error) {
        console.error('Error saving shipment or updating order status:', error);
    }
};

const fetchOrders = async () => {
    try {
        console.log('?')
        const response = await axios.get(`http://localhost:8000/api/showorders/${route.params.id}`);
        orders.value = response.data;
        console.log('fetchorders', response.data)
    } catch (error) {
        console.error('Error fetching orders data:', error);
    }
};


onMounted(() => {
    const storedItems = localStorage.getItem('cartItems');
    cartItems.value = storedItems ? JSON.parse(storedItems) : [];
});

const fetchAddress = async () => {
    try {
        const response = await axios.get(`http://localhost:8000/api/orderAddressShow/${route.params.id}`);
        addresses.value = response.data
        console.log("add" ,response.data)
    } catch (error) {
        console.error('Error fetching address data:', error);
    }
};

const fetchUsers = async () => {
    try {
        const response = await axios.get(`http://127.0.0.1:8000/api/user/${route.params.id}`);
        users.value = response.data;
    } catch (error) {
        console.error('Error fetching user data:', error);
    }
};


onMounted(() => {
    fetchOrders();
    fetchUsers();
    fetchAddress();

});
</script>


<route lang="yaml">
    meta:

        layout: Dashboard
    </route>

<style scoped>
.yellow-text {
    color: orange;
    text-align: center;
    margin: 0;
    font-size: 40px;
    font-weight: 600;
}


.save-button {

    margin-left: 88%;

}

.placed {
    background-color: orange;
    font-size: 20px;
    padding: 1%;
    border-radius: 8%;
}

.card-body {
    border: 1px solid #ddd;
    /* Add border style as per your design */
    padding: 10px;
    /* Add padding to provide space between the content and the border */
    margin: 10px 0;
    /* Add margin for spacing */
}
</style>

