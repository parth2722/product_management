<template>
    <v-app>
        <!-- Sidebar -->
        <v-navigation-drawer app v-model="drawer">
            <v-list>
                <v-list-item link to="/adminPanel">
                    <v-list-item-icon>
                        <v-icon>mdi-view-dashboard</v-icon>
                    </v-list-item-icon>
                    <br>
                    <br>
                    <br>
                    <br>
                    <ul class="menu-list">
                        <li class="py-4">
                            <router-link to="/adminPanel">Admin Panel</router-link>
                        </li>
                        <hr>
                        <li class="py-4">
                            <router-link to="/AllProduct">All products</router-link>
                        </li>
                        <hr>
                        <li class="py-4">
                            <router-link to="/categories">Category</router-link>
                        </li>
                        <hr>
                        <li class="py-4">
                            <router-link to="/orders">Orders</router-link>
                        </li>
                        <hr>
                        <li class="py-4">
                            <router-link to="/shipments">Shipments</router-link>
                        </li>
                        <hr>
                        <li class="py-4">
                            <router-link to="/invoices">Invoices</router-link>
                        </li>
                        <hr>
                        <li class="py-4">
                            <router-link to="/refund">refund</router-link>
                        </li>
                        <hr>
                        <li class="py-4">
                            <router-link to="/coupons">Coupans</router-link>
                        </li>
                        <hr>
                        <li class="py-4">
                            <router-link to="/user">Users</router-link>
                        </li>
                        <hr>
                    </ul>
                </v-list-item>
            </v-list>
        </v-navigation-drawer>

        <!-- App bar (header) -->
        <v-app-bar app>
            <v-app-bar-nav-icon @click.stop="drawer = !drawer"></v-app-bar-nav-icon>
            <v-toolbar-title>Admin Dashboard</v-toolbar-title>

            <v-spacer></v-spacer>
            <v-btn icon @click="logout">
                <v-icon>mdi-logout</v-icon>
            </v-btn>
        </v-app-bar>

        <!-- Main content -->
        <v-main class="custom">
            <router-view></router-view>
            <slot></slot>

        </v-main>
    </v-app>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useMainStore } from '../store/index';

const store = useMainStore();
const drawer = ref();
const router = useRouter();

const logout = () => {
    store.removeToken();
    store.removeUser();
    // Redirect to the login page after logout
    router.push({ name: 'Login' });
};
</script>

<style scoped>
.custom {
    --v-layout-left: 0px;
    --v-layout-right: 0px;
    --v-layout-top: 0px;
    --v-layout-bottom: 0px;
}
</style>
