<template>
    <v-container>


        <v-row align="center">
            <v-col>
                <v-card-title>
                    <span class="blurred-text">Order list</span>
                </v-card-title>
            </v-col>
        </v-row>
        <div v-for="order in orders" :key="order.product.id" class="order-details">

            <router-link :to="{ name: 'userOrder-id', params: { id: order.orderID } }">
                <div class="product-container">
                    <!-- Product Image -->
                    <router-link :to="`/store/${order.product.url_key}`">
                        <div class="product-image">
                            <img loading="lazy" :src="order.product.image" alt="Product Image" class="product-image">
                        </div>
                    </router-link>
                    <!-- Product Details and Price -->
                    <div class="product-details-container">
                        <div class="product-details">
                            <span class="product-name">{{ order.product.name }}</span>
                            <div class="product-info">
                                <span class="product-color">Order-id: {{ order.orderID }}</span>
                            </div>
                        </div>
                    </div>
                    <div class="product-price">
                        ₹{{ order.product.price }}
                    </div>

                    <router-link :to="{ name: 'reviewRate-url_key', params: { url_key: order.product.url_key } }">
                        <div class="flex"  @click="viewOrder(order.product.url_key)">
                            <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0nMTYnIGhlaWdodD0nMTknIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMTggMTgiPgoJPGcgZmlsbD0nbm9uZSc+CgkJPHBvbHlnb24gaWQ9IlNoYXBlIiBmaWxsPSIjMjg3NEYxIiBwb2ludHM9IjkgMTIuMDYyNSAxMy42Mzc1IDE1LjQzNzUgMTEuODYyNSA5Ljk4NzUgMTYuNSA2LjY4NzUgMTAuODEyNSA2LjY4NzUgOSAxLjA2MjUgNy4xODc1IDYuNjg3NSAxLjUgNi42ODc1IDYuMTM3NSA5Ljk4NzUgNC4zNjI1IDE1LjQzNzUiIC8+CgkJPHBvbHlnb24gaWQ9IlNoYXBlIiBwb2ludHM9IjAgMCAxOCAwIDE4IDE4IDAgMTgiIC8+Cgk8L2c+Cjwvc3ZnPg=="
                                alt="Review Product" class="w-8 h-8" />
                            <span class="ml-2" style="color: rgba(35, 79, 201, 0.884);">Rate & Review Product</span>
                        </div>
                    </router-link>
                </div>
            </router-link>
        </div>

    </v-container>
</template>

<script>
import { ref, onMounted, watch } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';
import { useMainStore } from '../store/index';
const Userorders = ref([]);
const orders = ref([]);
const mainStore = useMainStore();
const orderItems = ref([]);
const search = ref('');
const products = ref([]);

export default {
    setup() {
        const router = useRouter();  // Create a router instance

        const refreshData = () => {

            fetchOrders();
        };

        const viewOrder = (url_key) => {
            console.log('id', url_key);
            router.push({ name: 'reviewRate-url_key', params: { url_key } });
        };


        const fetchOrders = async () => {
            try {
                const customerId = mainStore.user.id; // Get the logged-in user's ID
                console.log(customerId);

                const response = await axios.get(`http://127.0.0.1:8000/api/Userorders/${customerId}`);
                Userorders.value = response.data;

                console.log('order', response.data);
                orderItems.value = Userorders.value.flatMap((order) => order.orderitem);
                console.log('bas', orderItems.value)
                products.value = orderItems.value.flatMap(
                    (orderItem) => orderItem.product
                );

                orders.value = orderItems.value.map((orderItem) => {
                    return {
                        orderID: orderItem.order.id, // Assuming 'order' has an 'id' property
                        product: orderItem.product
                    };
                });

                console.log('orders.value', orders.value)
            } catch (error) {
                console.error('Error fetching orders data:', error);

            }
        };

        watch(() => {
            // console.log('userOrders:', Userorders.value);
        });


        onMounted(() => {
            fetchOrders();
        });
        return {
            router,
            refreshData,
            search,
            Userorders,
            orders,
            products,
            viewOrder,  // Expose the viewOrder method
        };

    },
};
</script>


<route lang="yaml">
    meta:

        layout: Parth
    </route>



<style scoped>
.blurred-text {
    color: rgb(247, 160, 0);
    backdrop-filter: blur(5px);
    font-size: 40px;
    font-weight: 550;
    padding: 8px;
    display: inline-block;
}

.order-details {
    display: block;
    padding: 1rem;
    /* Equivalent to p-4 in Tailwind */
    background-color: #fff;
    /* Equivalent to bg-white in Tailwind */
    border: 1px solid #ccc;
    /* Equivalent to border border-gray-200 in Tailwind */
    border-radius: 0.375rem;
    /* Equivalent to rounded in Tailwind */
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    /* Equivalent to shadow-md in Tailwind */
    transition: box-shadow 0.3s ease-in-out;
    /* Equivalent to transition duration-300 ease-in-out in Tailwind */
    margin-bottom: 1%;
}

.order-details:hover {
    box-shadow: 0 8px 12px -1px rgba(0, 0, 0, 0.1), 0 4px 8px -1px rgba(0, 0, 0, 0.06);
    /* Equivalent to hover:shadow-lg in Tailwind */
}


.product-container {
    display: flex;
    align-items: center;
    /* Align items vertically in the center */
    gap: 20px;
    /* Adjust the gap between image and details */
}

.product-details-container {
    display: flex;
    flex-direction: column;
    /* Display details and price in a column */
}

.product-image {
    width: 100px;
    height: 100px;
}

.product-price {
    font-weight: 600;
    margin-left: 450px;
    margin-right: 151px;
}
</style>
