<template>
    <v-container class="mt-5">

        <v-card v-for="address in filteredAddresses" :key="address.id">
            <v-card-title>
                <h2 class="blurred-textt">ADDRESS</h2>
            </v-card-title>

            <!-- Display address information using Vuetify components -->
            <v-card-text>
                <v-row>
                    <v-col>
                        <v-row>
                            <v-col>
                                <v-subheader class="custom-span">Full Name:</v-subheader>
                                <v-text>{{ address.fullName }}</v-text>
                            </v-col>
                            <v-col>
                                <v-subheader class="custom-span">Postcode:</v-subheader>
                                <v-text>{{ address.postcode }}</v-text>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col>
                                <v-subheader class="custom-span">City:</v-subheader>
                                <v-text>{{ address.city }}</v-text>
                            </v-col>
                            <v-col>
                                <v-subheader class="custom-span">State:</v-subheader>
                                <v-text>{{ address.state }}</v-text>
                            </v-col>
                        </v-row>
                        <v-row>
                            <v-col>
                                <v-subheader class="custom-span">Email:</v-subheader>
                                <v-text>{{ address.email }}</v-text>
                            </v-col>
                            <v-col>
                                <v-subheader class="custom-span">Phone:</v-subheader>
                                <v-text>{{ address.phone }}</v-text>
                            </v-col>
                        </v-row>
                    </v-col>
                </v-row>
            </v-card-text>

            <v-divider></v-divider>

            <v-card-actions>
                <v-btn @click="editAddress(address)" color="primary">EDIT</v-btn>
            </v-card-actions>
        </v-card>
    </v-container>
</template>


<script>
import axios from 'axios'
import { useRouter, useRoute } from 'vue-router'
import { ref, onMounted, computed, watch } from 'vue';
export default {

    setup() {
        const router = useRouter()
        const address = ref({
            id: '',
            name: '',
            type: '',
            phone: '',
            address: '',
            readonly: true,
            checked: true,
        });
        const route = useRoute()
        const fetchAddress = async () => {
            try {
                const response = await axios.get(`http://localhost:8000/api/address/${route.params.id}`)
                address.value = response.data
            } catch (error) {
                console.error('Error fetching category data:', error)
            }
        }
        const editAddress = async (address) => {
            // Handle the edit address action
            console.log('Editing address:', address);
            try {
                await axios.post(`http://localhost:8000/api/address/${route.params.id}`, address.value, {
                    // headers: { 'Content-Type': 'multipart/form-data' },
                })
                router.push('/checkout')
            } catch (error) {
                console.error('Error saving category:', error)
            }
        };

        onMounted(fetchAddress)
        return {
            address,
            editAddress,
        }
    },
}
</script>

<style scoped>
.error-message {
    color: red;
}
</style>



