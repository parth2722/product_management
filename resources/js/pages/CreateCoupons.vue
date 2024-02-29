<!-- src/components/CreateCoupons.vue -->

<template>
    <div class="container mt-4">
        <span class="blurred-textt">Create Coupons</span>
        <form @submit.prevent="createCoupon" class="mt-3">
            <!-- Coupon Code Entry Type -->
            <div class="mb-3">
                <label class="form-label">Coupon Code Entry</label>
                <div class="form-check">
                    <input v-model="codeEntryType" class="form-check-input" type="radio" id="automatic" value="automatic">
                    <label class="form-check-label" for="automatic">Automatic</label>
                </div>
                <div class="form-check">
                    <input v-model="codeEntryType" class="form-check-input" type="radio" id="manual" value="manual">
                    <label class="form-check-label" for="manual">Manual</label>
                </div>
            </div>

            <!-- Coupon Code (Automatic) -->
            <div v-if="codeEntryType === 'automatic'" class="mb-3">
                <!-- Automatically set the generated code as the input value -->
                <input v-model="code" type="hidden" />
            </div>

            <!-- Coupon Code (Manual) -->
            <div v-if="codeEntryType === 'manual'" class="mb-3">
                <label for="code" class="form-label">Coupon Code</label>
                <input v-model="code" type="text" class="form-control" id="code" required>
            </div>
            <!-- Discount Type -->
            <div class="mb-3">
                <label class="form-label">Discount Type</label>
                <select v-model="discountType" class="form-select" required>
                    <option value="percentage">Percentage</option>
                    <option value="fixed">Fixed</option>
                </select>
            </div>

            <!-- Discount Amount -->
            <div class="mb-3">
                <label for="discountAmount" class="form-label">Discount Amount</label>
                <input v-model="discountAmount" type="number" class="form-control" id="discountAmount" step="0.01" required>
            </div>

            <!-- Start Date -->
            <div class="mb-3">
                <label for="startDate" class="form-label">Start Date</label>
                <input v-model="startDate" type="date" class="form-control" id="startDate" required>
            </div>

            <!-- End Date -->
            <div class="mb-3">
                <label for="endDate" class="form-label">End Date</label>
                <input v-model="endDate" type="date" class="form-control" id="endDate" required>
            </div>

            <!-- Max Uses -->
            <div class="mb-3">
                <label for="maxUses" class="form-label">Max Uses</label>
                <input v-model="maxUses" type="number" class="form-control" id="maxUses" required>
            </div>

            <!-- Current Uses -->
            <div class="mb-3">
                <label for="currentUses" class="form-label">Current Uses</label>
                <input v-model="currentUses" type="number" class="form-control" id="currentUses" required>
            </div>


            <button type="submit" class="btn btn-primary">Create Coupon</button>
        </form>
    </div>
</template>

<script setup>
import { ref } from 'vue';
import axios from 'axios';
import { useRouter, useRoute } from 'vue-router';
const code = ref('');
const codeEntryType = ref('automatic'); // Default to automatic
const discountType = ref('percentage');
const discountAmount = ref(null);
const startDate = ref(null);
const router = useRouter();
const endDate = ref(null);
const maxUses = ref(null);
const currentUses = ref(null);

const generateCouponCode = async () => {
    // Your actual code generation logic (replace this placeholder)
    const generatedCode = 'CPN' + Math.floor(Math.random() * 1000);

    // Set the generated code to the code variable
    code.value = generatedCode;
};

const createCoupon = async () => {
    // If the entry type is automatic, ensure the code is set before making the API request
    if (codeEntryType.value === 'automatic') {
        await generateCouponCode();
    }

    // Check if the code is null before making the API request
    if (code.value === null) {
        console.error('Error creating coupon: Code cannot be null.');
        return;
    }

    // Example: use axios or fetch to make a POST request to your API
    await axios.post('/api/coupons', {
        code: code.value,
        discount_type: discountType.value,
        discount_amount: discountAmount.value,
        start_date: startDate.value,
        end_date: endDate.value,
        max_uses: maxUses.value,
        current_uses: currentUses.value,
    })
        .then(response => {
            console.log('Coupon created successfully:', response.data);
            router.push({ name: 'Home' });
        })
        .catch(error => {
            console.error('Error creating coupon:', error);
        });
};

</script>

<style scoped>
.blurred-textt {
    color: rgb(247, 160, 0);
    backdrop-filter: blur(5px);
    font-size: 40px;
    font-weight: 550;
    padding: 8px;
    display: inline-block;
}

/* Add more styles as needed */
</style>

<route lang="yaml">
  meta:
    layout: Dashboard
</route>
