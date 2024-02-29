<template>
    <v-container>
        <v-card>
            <v-card-header>
                <v-row align="center">
                    <v-col>
                        <v-card-title>
                            <span class="blurred-text">Shipments list</span>
                        </v-card-title>
                    </v-col>
                    <v-col>
                        <v-text-field v-model="search" append-icon="mdi-magnify" label="Search" single-line
                            hide-details></v-text-field>
                    </v-col>
                    <v-col class="text-right">
                        <v-btn @click="refreshData" icon>
                            <v-icon>mdi-refresh</v-icon>
                        </v-btn>
                    </v-col>
                </v-row>
            </v-card-header>
            <v-card-body>
                <v-data-table :headers="columns" :items="filteredOrders" class="mt-4" :loading="isLoading">
                    <template v-slot:item.status="{ item }">

                        <span if="item.status === 'shipped'"
                            class="inline-block px-2 py-1 text-xs font-semibold rounded bg-blue-100 text-blue-700"><span
                                class="inline-block w-3 h-3 mr-1 rounded-full bg-blue-700"></span>Shipped</span>

                    </template>
                    <template v-slot:item.actions="{ item }">
                        <v-btn icon @click="viewOrder(item.id)">
                            <v-icon>mdi-eye</v-icon>
                        </v-btn>
                    </template>
                </v-data-table>

            </v-card-body>
        </v-card>
    </v-container>
</template>

<script>
import { ref, onMounted, watch } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';

const orders = ref([]);
const isLoading = ref(true);

const search = ref('');
const filteredOrders = ref([]);

export default {
    setup() {
        const router = useRouter();  // Create a router instance

        const viewOrder = (id) => {
            console.log(id);
            router.push({ name: 'shipment-id', params: { id } });
        };

        const refreshData = () => {
            isLoading.value = true;
            fetchOrders();
        };

        const filterOrders = () => {
            filteredOrders.value = orders.value.filter((order) => {
                const searchLowerCase = search.value.toLowerCase();
                return (
                    (order.totalQty && order.totalQty.toString().includes(searchLowerCase)) ||
                    (order.trackNumber && order.trackNumber.toLowerCase().includes(searchLowerCase)) ||
                    (order.carrierTitle && order.carrierTitle.toLowerCase().includes(searchLowerCase)) ||
                    (order.id && order.id.toString().includes(searchLowerCase)) ||
                    (order.totalQtyOrdered && order.totalQtyOrdered.toString().includes(searchLowerCase)) ||
                    (order.orderAddressId && order.orderAddressId.toString().includes(searchLowerCase))
                );
            });
        };

        const columns = [
            { title: 'Order Id', value: 'id', sortable: true },
            { title: 'Status', value: 'status', sortable: true },
            { title: 'totalQty', value: 'totalQty', sortable: true },
            { title: 'trackNumber', value: 'trackNumber', sortable: true },
            { title: 'carrierTitle', value: 'carrierTitle', sortable: true },
            { title: 'orderAddressId', value: 'orderAddressId', sortable: true },
            {
                title: 'Order Date',
                value: 'created_at',
                sortable: true,
                align: 'center',
                format: (val) => new Date(val).toLocaleDateString(),
            },
            {
                title: 'Actions',
                value: 'actions',
                sortable: false,

                slot: 'actions',
            },
        ];


        const fetchOrders = async () => {
            try {
                const response = await axios.get('http://127.0.0.1:8000/api/shipmentitems');
                orders.value = response.data;
                isLoading.value = false;
            } catch (error) {
                console.error('Error fetching orders data:', error);
            }
        };

        watch(() => {
            filterOrders();
        });

        onMounted(() => {
            fetchOrders();
        });
        return {
            router,
            columns,
            refreshData,
            search,
            isLoading,
            filteredOrders,
            viewOrder,  // Expose the viewOrder method
        };

    },
};
</script>


<route lang="yaml">
    meta:

        layout: Dashboard
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
</style>
