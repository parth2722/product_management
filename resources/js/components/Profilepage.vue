<template>
    <VBadge dot location="bottom right" offset-x="3" offset-y="3" color="success" bordered>
        <VAvatar class="cursor-pointer" color="primary" variant="tonal">
            <VImg
                :src="'https://c4.wallpaperflare.com/wallpaper/622/941/214/jujutsu-kaisen-satoru-gojo-hd-wallpaper-preview.jpg'" />

            <VMenu activator="parent" width="130" location="bottom end">
                <VList>
                    <router-link to="/profile">
                        <VListItem link v-if="store.isLoggedIn">
                            <VListItemTitle>My Profile</VListItemTitle>
                        </VListItem>
                    </router-link>
                    <router-link to="/MyOrders">
                        <VListItem link v-if="store.isLoggedIn">
                            <VListItemTitle>My Orders</VListItemTitle>
                        </VListItem>
                    </router-link>
                    <!-- Other menu items -->

                    <VListItem v-if="isLoggedIn" @click="logout">
                        <VListItemTitle>Logout</VListItemTitle>
                    </VListItem>
                </VList>
            </VMenu>
        </VAvatar>
    </VBadge>
</template>

<script setup>
import { ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import { useMainStore } from '../store/index';

const store = useMainStore();
const router = useRouter();

const isLoggedIn = computed(() => {
    return store.getToken !== null;
});


const logout = () => {
    store.removeToken();
    store.removeUser();
    localStorage.removeItem('customerId');
    localStorage.removeItem('selectedAddress');
    localStorage.removeItem('orderId');
    router.push({ name: 'home' });
};
</script>
