<template>
    <v-app>
    <the-header

    >
</the-header>
      <!-- Main content -->
      <v-main class="custom">
        <router-view></router-view>
        <slot></slot>
      </v-main>

      <!-- Footer -->

        <the-footer></the-footer>

    </v-app>
  </template>

  <script setup>
import TheHeader from '../components/TheHeader.vue';
import TheFooter from '../components/TheFooter.vue';
</script>
