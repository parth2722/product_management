<template>
    <v-container class="justify-center">
      <v-row align="center" justify="center">
        <v-col>
          <div class="confirmation">
            <div class="confirmation-header">
              <h1 style="color: brown; font-size: 40px; font-weight: 500;">{{ confirmationHeader }}</h1>
            </div>
            <br>
            <div class="confirmation-details">
              <h2 style="font-size: 20px;">{{ confirmationMessage }}</h2>
              <br>
              <p>Your order has been successfully placed.</p>
              <p style="font-weight: 500;">Order Number: <span>{{ orderNumber }}</span></p>
            </div>
            <br>
            <div class="confirmation-actions">
              <v-btn @click="trackOrder" color="primary">Track Order</v-btn>
            </div>
          </div>
        </v-col>
      </v-row>
      <hr>
    </v-container>
  </template>

  <script setup>
  import { ref } from 'vue';

  const confirmationHeader = ref('Order Confirmed!');
  const confirmationMessage = ref('Thank you for your order.');
  const orderNumber = ref(Math.floor(100000 + Math.random() * 900000));

  const trackOrder = () => {
    // You can add your tracking logic here, e.g., redirect to a tracking page
    alert('Order tracking feature is not implemented in this demo.');
  };


  </script>

<route lang="yaml">
    meta:

        layout: Parth
    </route>



  <style scoped>

  .confirmation {
    text-align: center;
    padding: 20px;
    margin-top: 2%;
margin-left: 30%;
    max-width: 400px;
    width: 100%;
  }
  </style>
