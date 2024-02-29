<template>
    <div>

        <h1 class="yellow-text">Inovice Details</h1>
        <br>
        <div class="save-button">
            <v-btn color="orange" @click="saveInvoice(id)">
                <span>Print</span>
            </v-btn>
        </div>

        <br>
        <h4 class="mb-0">
            <v-btn to="/invoices" color="error" class="float-end">Back</v-btn>
        </h4>
        <h3 style="font-size: 30px; font-weight: 500;">Order And Account:</h3>

        <div class="card-body d-flex">
            <div class="sku w-50 ng-star-inserted">
                <div class="order-description-main">
                    <h5 style="font-size: 20px; font-weight: 500;">Order Information</h5>
                    <p>Order ID: {{ invoice.order_id }}</p>
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
                        <td class="px-4 py-2">{{ invoice.grandTotal }}</td>
                    </tr>
                </tbody>

            </table>


        </div>

    </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import jsPDF from 'jspdf';
import 'jspdf-autotable';
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

    orderAddressId: '',
    transactionId: '',
})

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

        // Update the order status to 'completed'
        await axios.put(`http://localhost:8000/api/orderupdate/${orders.value.id}`, {
            status: 'completed',
        });

    } catch (error) {
        console.error('Error generating or downloading invoice:', error);
    }
};



const createInvoicePDF = (order, addresses) => {
    try {


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
        const grandTotal = invoice.value.grandTotal;
        pdf.text(`Grand Total: ${grandTotal}`, 10, pdf.autoTable.previous.finalY + 10);


        // Save the PDF content to a variable
        const pdfContent = pdf.output();

        return pdfContent;
    } catch (error) {
        console.error('Error creating PDF:', error);
        throw error; // Rethrow the error to propagate it
    }
};


const fetchOrders = async () => {
    try {
        const response = await axios.get(`http://localhost:8000/api/showorders/${route.params.id}`);
        orders.value = response.data;
        console.log('Orders:', response.data.orderitem);
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

const fetchInvoiceData = async () => {
    try {
        const response = await axios.get(`http://localhost:8000/api/invoicesdata/${route.params.id}`);
        invoice.value = response.data; // assuming the API returns the necessary data
        console.log('invoice', response.data)
    } catch (error) {
        console.error('Error fetching invoice data:', error);
    }
};

onMounted(() => {
    fetchOrders();
    fetchUsers();
    fetchAddress();
    fetchInvoiceData(); // Fetch additional data for the invoice
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
    margin-left: 1%;
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

