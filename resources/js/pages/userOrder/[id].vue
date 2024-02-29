<template>
    <div class="container">

        <h1 class="yellow-text">Order Details</h1>
        <br>
        <h4 class="mb-0">
            <v-btn to="/Myorders" color="error" class="float-end">Back</v-btn>
        </h4>
        <div class="button-container">

        </div>
        <h3 style="font-size: 30px; font-weight: 500;">Address</h3>

        <div class="flex space-x-4 ">
            <div class="flex-1">
                <div class="bg-gray-100 p-2 rounded">
                    <div class="font-bold mb-2">Delivery Address</div>
                    <div class="mb-2">{{ addresses.fullName }}</div>
                    <div class="mb-2">{{ addresses.postCode }}</div>
                    <div class="mb-2">{{ addresses.country }}</div>
                    <div>
                        <span class="font-bold">Phone number</span>
                        <div>{{ addresses.phone }}</div>
                    </div>
                </div>
            </div>

            <!-- More Actions Section -->
            <div class="flex-1">
                <div class="bg-gray-100 p-2 rounded">
                    <div class="font-bold mb-2">More actions</div>
                    <div class="flex items-center mb-2">
                        <img src="https://static-assets-web.flixcart.com/fk-p-linchpin-web/fk-cp-zion/img/downloadInvoice_e0f744.png"
                            class="w-6 h-6 mr-2">
                        <div>
                            <span class="xQQowV">Download Invoice</span>
                        </div>
                    </div>
                    <div class="save-button left" v-if="orders.status === 'shipped' || orders.status === 'Refund'">
                        <v-btn color="blue"  @click="saveInvoice(id)">
                            <span>Download invoice</span>
                        </v-btn>
                    </div>
                    <br>
                    <div class="save-button right" v-if="orders.status == 'shipped'">
                        <v-btn color="red" @click="cancelOrder(id)">
                            <span>Cancel Order</span>
                        </v-btn>
                    </div>
                </div>
            </div>
        </div>


        <div class="flex bg-white p-4 border border-gray-200">
            <!-- Product Image Section -->
            <div class="col-4/12 Oqho6V flex items-center justify-center">
                <a :href="productDetails" target="_blank" rel="noopener noreferrer">
                    <!-- <div class="h-24 w-24">
                        <img :src="productDetails.image" loading="lazy" class="w-full h-full object-cover"
                            alt="Product Image">
                    </div> -->
                </a>
            </div>

            <!-- Product Details Section -->
            <div class="col-8/12">

                <div class="flex flex-col mb-2">
                    <!-- <span class="text-sm"><span class="font-bold">Color:</span> {{ productDetails.color }}</span> -->
                    <!-- <span class="text-sm"><span class="font-bold">Size:</span> {{ productDetails.size }}</span> -->
                    <!-- <span class="text-sm"><span class="font-bold">Seller:</span> {{ productDetails.seller }}</span> -->
                </div>
                <div class="flex items-center">
                    <!-- <div class="text-lg font-bold text-black mr-2">{{ productDetails.price }}</div> -->
                    <div class="flex items-center">
                        <span class="text-sm text-gray-500"> +</span>
                        <img src="//static-assets-web.flixcart.com/fk-p-linchpin-web/fk-cp-zion/img/lockinCoinNew_79b3fb.svg"
                            class="w-4 h-4 ml-1" alt="Coins Icon">
                        <!-- <span class="text-sm text-gray-500">{{ productDetails.coins }}</span> -->
                    </div>
                </div>
            </div>

            <!-- Tracking Status Section -->
            <div class="col-5/12">
                <div class="flex items-center">
                    <btn class="flex items-center" @click="viewOrder(orders.id)">
                        <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0nMTYnIGhlaWdodD0nMTknIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMTggMTgiPgoJPGcgZmlsbD0nbm9uZSc+CgkJPHBvbHlnb24gaWQ9IlNoYXBlIiBmaWxsPSIjMjg3NEYxIiBwb2ludHM9IjkgMTIuMDYyNSAxMy42Mzc1IDE1LjQzNzUgMTEuODYyNSA5Ljk4NzUgMTYuNSA2LjY4NzUgMTAuODEyNSA2LjY4NzUgOSAxLjA2MjUgNy4xODc1IDYuNjg3NSAxLjUgNi42ODc1IDYuMTM3NSA5Ljk4NzUgNC4zNjI1IDE1LjQzNzUiIC8+CgkJPHBvbHlnb24gaWQ9IlNoYXBlIiBwb2ludHM9IjAgMCAxOCAwIDE4IDE4IDAgMTgiIC8+Cgk8L2c+Cjwvc3ZnPg=="
                            alt="Review Product" class="w-8 h-8" />
                        <span class="ml-2">Rate & Review Product</span>
                    </btn>
                </div>
            </div>
        </div>





    </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axios from 'axios';
import jsPDF from 'jspdf';
import 'jspdf-autotable';


const route = useRoute();
const orders = ref([]);
const users = ref([]);
const addresses = ref([]);
const router = useRouter();  // Create a router instance
const cartItems = ref([]);

const fetchOrders = async () => {
    try {
        const response = await axios.get(`http://localhost:8000/api/showorders/${route.params.id}`);
        orders.value = response.data;
        console.log('order ID:', response.data);

        // Now you can use this paymentIntentId in your component logic
    } catch (error) {
        console.error('Error fetching orders data:', error);
    }
};

const viewOrder = (id) => {
    console.log('id', id);
    router.push({ name: 'reviewRate-id', params: { id } });
};


const cancelOrder = async () => {
    const stripeSecretKey = 'sk_test_51OernzJ7YilluosL0ywVK3wCinCaN76pMK2CXMQZNtlVIECHUPTMlUdX55aRZFhS9bSJ5bsUvuECx81u793HUAQg00UmTsa3JH';
    const paymentIntentId = 'pi_3Ojf4JJ7YilluosL0WLMKSaS';
    const amountToRefund = 100;
    const firstOrder = orders.value;

    try {
        // Make the refund request to Stripe
        const response = await fetch('https://api.stripe.com/v1/refunds', {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${stripeSecretKey}`,
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `payment_intent=${paymentIntentId}&amount=${amountToRefund}`,
        });

        const refund = await response.json();
        console.log('Refund created:', refund);

        // Update the order status in your database using Axios
        await axios.put(`http://localhost:8000/api/orderupdate/${firstOrder.id}`, {
            status: 'Refund',
        });

        // Save additional refund details to your API
        const refundDetails = {
            totalQty: firstOrder.totalQtyOrdered,
            grandTotal: firstOrder.grandTotal,
            shippingAmount: '50',
            order_id: firstOrder.id,
        };

        await axios.post('http://localhost:8000/api/refundCreate', refundDetails);

    } catch (error) {
        console.error('Error creating refund:', error);
        // Handle the error as needed
    }
};



const saveInvoice = async () => {
    try {
        // Fetch data needed for the invoice content
        const invoiceData = {
            orderId: orders.value.id,
            orderDate: orders.value.created_at,
            // Add other data properties as needed
        };

        const pdfContent = createInvoicePDF(orders.value, addresses.value);


        const blob = new Blob([pdfContent], { type: 'application/pdf' });

        // Create a link element and trigger a download
        const link = document.createElement('a');
        link.href = window.URL.createObjectURL(blob);
        link.download = 'Invoice.pdf';
        link.click();

    } catch (error) {
        console.error('Error generating or downloading invoice:', error);
    }
};



const createInvoicePDF = (order, addresses) => {
    try {

        console.log('OrdASDeASDrs:', orders.value);
        console.log('Order Items:', orders.value.orderitem);
        // Create a new instance of jsPDF
        const pdf = new jsPDF();

        // Add text to the PDF using the provided data
        pdf.text(`INVOICE:`, 10, 10);

        // Add invoice number and date
        const invoiceNumber = Math.floor(Math.random() * (999999 - 100000 + 1)) + 100000;
        const currentDate = new Date().toLocaleDateString();
        pdf.text(`Invoice Number: ${invoiceNumber}`, 10, 20);
        pdf.text(`Date: ${currentDate}`, 10, 30);

        // Add Order and Account Information
        pdf.text(`Order ID: ${order.id}\nOrder Date: ${order.created_at}\nOrder Status: ${order.status}`, 10, 50);

        // Add Company Information
        pdf.text('Company:', 10, 80);
        pdf.text('Mango IT Solutions\n15/3, Near Mehta Marketing, Old Palasia\nIndore, MP\nIndia, 452001', 10, 90);

        // Add Client Information
        pdf.text('Client:', 10, 120);
        pdf.text(`Name: ${addresses.fullName}\nAddress: ${addresses.country}\nPost code: ${addresses.postcode}\nContact: ${addresses.phone}\n\nShipping Method: ${order.shippingMethod}`, 10, 130);

        // Add Ship To Information
        pdf.text('Ship To:', 10, 170);
        pdf.text(`Name: ${addresses.fullName}\nAddress: ${addresses.country}\nPost code: ${addresses.postcode}\nContact: ${addresses.phone}`, 10, 180);

        // Add Table with Product Details
        const startY = 220; // Adjust the starting Y-coordinate as needed
        const columnWidths = [80, 40, 40, 40]; // Adjust column widths as needed
        const rowHeight = 10;
        const tableHeaders = ['Product Name', 'SKU', 'Price'];

        pdf.autoTable({
            startY,
            head: [tableHeaders],
            body: orders.value.orderitem.map(item => [item.name, item.sku, item.price]),
            columnStyles: {
                0: { cellWidth: columnWidths[0] },
                1: { cellWidth: columnWidths[1] },
                2: { cellWidth: columnWidths[2] },
                3: { cellWidth: columnWidths[3] },
            },
        });

        // Add Grand Total
        // Calculate Grand Total
        const grandTotal = orders.value.orderitem.reduce((total, item) => 0 + item.total, 0);
        pdf.text(`Grand Total: ${grandTotal}`, 10, pdf.autoTable.previous.finalY + 10);


        // Save the PDF content to a variable
        const pdfContent = pdf.output();

        return pdfContent;
    } catch (error) {
        console.error('Error creating PDF:', error);
        throw error; // Rethrow the error to propagate it
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
    } catch (error) {
        console.error('Error fetching address data:', error);
    }
};


const calculateTotalAmount = () => {
    return cartItems.value.reduce((total, item) => {
        return total + item.price * item.quantity;
    }, 0);
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

        layout: Parth
    </route>

<style scoped>
.yellow-text {
    color: orange;
    text-align: center;
    margin: 0;
    font-size: 40px;
    font-weight: 600;
}

.button-container {
    display: flex;

}

.left {
    margin-right: 2%;
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

