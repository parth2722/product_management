<template>
    <v-container>
        <v-card>
            <v-card-header>
                <v-row align="center">
                    <v-col>
                        <v-card-title>
                            <span class="blurred-text">Invoice list</span>
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
                <v-data-table :headers="columns" :items="filteredInvoice" class="mt-4" :loading="isLoading">
                    <template v-slot:item.status="{ item }">

                        <span if="item.status === 'shipped'"
                            class="inline-block px-2 py-1 text-xs font-semibold rounded bg-blue-100 text-blue-700"><span
                                class="inline-block w-3 h-3 mr-1 rounded-full bg-blue-700"></span>Shipped</span>

                    </template>
                    <template v-slot:item.actions="{ item }">
                        <v-btn icon @click="viewInvoice(item.id)">
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

const invoices = ref([]);
const isLoading = ref(true);

const search = ref('');
const filteredInvoice = ref([]);

export default {
    setup() {
        const router = useRouter();  // Create a router instance

        const viewInvoice = (id) => {
            console.log(id);
            router.push({ name: 'invoice-id', params: { id } });
        };

        const refreshData = () => {
            isLoading.value = true;
            fetchInvoice();
        };

        const filterInvoices = () => {
            filteredInvoice.value = invoices.value.filter((order) => {
                const searchLowerCase = search.value.toString();
                return (
                    (order.totalQty && order.totalQty.toString().includes(searchLowerCase)) ||
                    (order.shippingAmount && order.shippingAmount.toLowerCase().includes(searchLowerCase)) ||
                    (order.orderId && order.orderId.toLowerCase().includes(searchLowerCase)) ||
                    (order.id && order.id.toString().includes(searchLowerCase)) ||
                    (order.grandTotal && order.grandTotal.toString().includes(searchLowerCase)) ||
                    (order.orderAddressId && order.orderAddressId.toString().includes(searchLowerCase))
                );
            });
        };

        const columns = [
            { title: 'Id', value: 'id', sortable: true },
            { title: 'shippingAmount', value: 'shippingAmount', sortable: true },
            { title: 'totalQty', value: 'totalQty', sortable: true },
            { title: 'orderId', value: 'order_id', sortable: true },
            { title: 'grandTotal', value: 'grandTotal', sortable: true },
            { title: 'orderAddressId', value: 'orderAddress_id', sortable: true },
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


        const fetchInvoice = async () => {
            try {
                const response = await axios.get('http://127.0.0.1:8000/api/invoices');
                invoices.value = response.data;
                isLoading.value = false;
            } catch (error) {
                console.error('Error fetching invoices data:', error);
            }
        };

        watch(() => {
            filterInvoices();
        });

        onMounted(() => {
            fetchInvoice();
        });
        return {
            router,
            columns,
            refreshData,
            search,
            isLoading,
            filteredInvoice,
            viewInvoice,
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
