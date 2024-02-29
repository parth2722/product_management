<template>
    <v-container class="mt-5">
        <v-card>

            <h4 class="mb-0">
                <v-btn to="/coupons" color="error" class="float-end">Back</v-btn>
            </h4>

            <v-card-body>
                <form @submit.prevent="saveCoupon" class="mt-3">
                    <!-- Coupon Code Entry Type -->
                    <div class="mb-3">
                        <label class="form-label">Coupon Code Entry</label>
                        <div class="form-check">
                            <input v-model="coupons.codeEntryType" class="form-check-input" type="radio" id="automatic"
                                value="automatic">
                            <label class="form-check-label" for="automatic">Automatic</label>
                        </div>
                        <div class="form-check">
                            <input v-model="coupons.codeEntryType" class="form-check-input" type="radio" id="manual"
                                value="manual">
                            <label class="form-check-label" for="manual">Manual</label>
                        </div>
                    </div>

                    <!-- Coupon Code (Automatic) -->
                    <div v-if="coupons.codeEntryType === 'automatic'" class="mb-3">
                        <!-- Automatically set the generated code as the input value -->
                        <input v-model="coupons.code" type="hidden" />
                    </div>

                    <!-- Coupon Code (Manual) -->
                    <div v-if="coupons.codeEntryType === 'manual'" class="mb-3">
                        <label for="code" class="form-label">Coupon Code</label>
                        <input v-model="coupons.code" type="text" class="form-control" id="code" required>
                    </div>

                    <!-- Discount Type -->
                    <div class="mb-3">
                        <label class="form-label">Discount Type</label>
                        <select v-model="coupons.discount_type" class="form-select" required>
                            <option value="percentage">Percentage</option>
                            <option value="fixed">Fixed</option>
                        </select>
                    </div>

                    <!-- Discount Amount -->
                    <div class="mb-3">
                        <label for="discountAmount" class="form-label">Discount Amount</label>
                        <input v-model="coupons.discount_amount" type="number" class="form-control" id="discountAmount"
                            step="0.01" required>
                    </div>

                    <!-- Start Date -->
                    <div class="mb-3">
                        <label for="startDate" class="form-label">Start Date</label>
                        <input v-model="coupons.start_date" type="date" class="form-control" id="startDate" required>
                    </div>

                    <!-- End Date -->
                    <div class="mb-3">
                        <label for="endDate" class="form-label">End Date</label>
                        <input v-model="coupons.end_date" type="date" class="form-control" id="endDate" required>
                    </div>

                    <!-- Max Uses -->
                    <div class="mb-3">
                        <label for="maxUses" class="form-label">Max Uses</label>
                        <input v-model="coupons.max_uses" type="number" class="form-control" id="maxUses" required>
                    </div>

                    <!-- Current Uses -->
                    <div class="mb-3">
                        <label for="currentUses" class="form-label">Current Uses</label>
                        <input v-model="coupons.current_uses" type="number" class="form-control" id="currentUses" required>
                    </div>


                    <button type="submit" class="btn btn-primary">update Coupon</button>
                </form>
            </v-card-body>
        </v-card>
    </v-container>
</template>


<script>
import axios from 'axios'
import { ref, onMounted, computed, watch } from 'vue';
import { useRouter, useRoute } from 'vue-router';
export default {
    name: 'CouponCreate',
    setup() {
        const router = useRouter()
        const coupons = ref({
            code: '',
            discount_type: '',
            discount_amount: '',
            start_date: '',
            end_date: '',
            max_uses: '',
            current_uses: ''
        })

        const route = useRoute()

        const fetchUser = async () => {
            try {
                const response = await axios.get(`http://localhost:8000/api/coupons/${route.params.code}`)
                coupons.value = response.data[0]
                console.log('res', response.data)
            } catch (error) {
                console.error('Error fetching user data:', error)
            }
        }

        const saveCoupon = async () => {

            try {
                await axios.put(`http://localhost:8000/api/coupons/${route.params.id}`, coupons.value, {
                    // headers: { 'Content-Type': 'multipart/form-data' },
                })

                router.push('/coupons')
            } catch (error) {
                console.error('Error saving user:', error)
            }
        }

        onMounted(fetchUser)
        return {
            coupons,
            saveCoupon,
        }
    },
}
</script>


<route lang="yaml">
    meta:

        layout: Dashboard
    </route>




<style scoped>
.error-message {
    color: red;
}
</style>
