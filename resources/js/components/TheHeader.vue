<template>
    <nav class="bg-gray-200 p-2">
        <div class="container mx-auto flex justify-between items-center">
            <router-link to="/home" style="margin-left: 5%;">
                <img src="./1.png" width="110" height="130" class="navbar-brand" />
            </router-link>

            <div class="flex items-center space-x-4" style="margin-left: 5%;">
                <!-- <div id="google_translate_element"></div> -->
                <!-- <the-welcome></the-welcome> -->

                <v-text-field v-model="searchText" label="Search..." append-inner-icon="i-material-symbols-search-rounded"
                    hide-details variant="outlined" class="w-full" style="width: 150px;"
                    @keyup.enter="redirectToSearchResults"></v-text-field>

                <profilepage v-if="isLoggedIn"></profilepage>

                <router-link @click="redirectToCartOrLogin" to="/cart" class="text-black">
                    <v-icon color="black">mdi-cart</v-icon>
                  </router-link>
                  <router-link @click="redirectToCartOrLoginw" to="/wishlist" class="text-black">
                    <v-icon color="black">mdi-heart</v-icon>
                  </router-link>


                <router-link v-if="!isLoggedIn" to="/frontLogin" class="text-black">
                    Login
                </router-link>

                <router-link v-if="!isLoggedIn" to="/frontRegister" class="text-black">
                    Register
                </router-link>


            </div>
        </div>
    </nav>

    <v-container>
        <categorys></categorys>
    </v-container>

    <slot></slot>
</template>



<script setup>
import { ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import { useMainStore } from '../store/index';
import axios from 'axios';
import Profilepage from './Profilepage.vue';
import bus from '../plugins/eventBus';
import categorys from './categorys.vue';

const store = useMainStore();
const router = useRouter();
const searchText = ref('');
const isLoggedIn = computed(() => {
    return store.getToken !== null;
});

const redirectToCartOrLogin = () => {
  if (isLoggedIn.value) {
    // User is logged in, redirect to cart or wishlist
    router.push('/cart'); // or router.push('/wishlist');
  } else {
    // User is not logged in, redirect to login page
    router.push('/frontLogin');
  }
};

const redirectToCartOrLoginw = () => {
  if (isLoggedIn.value) {
    // User is logged in, redirect to cart or wishlist
    router.push('/wishlist'); // or router.push('/wishlist');
  } else {
    // User is not logged in, redirect to login page
    router.push('/frontLogin');
  }
};
const redirectToSearchResults = () => {
    // Check if searchText is not empty before emitting and redirecting
    if (searchText.value.trim() !== '' && searchText.value.trim().length >= 2) {
        bus.emit('search', searchText.value);
        router.push({ path: '/searched', query: { q: searchText.value } });
    }
};

const googleTranslateScript = document.createElement('script');
googleTranslateScript.src = 'https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit';
googleTranslateScript.async = true;
document.head.appendChild(googleTranslateScript);

window.googleTranslateElementInit = function () {
    new window.google.translate.TranslateElement({
        pageLanguage: 'en',
        includedLanguages: 'en,es,fr',
        // Remove the 'Powered by Google' attribution
        gaTrack: false,
        gaId: '',
        // Remove the layout, including the header
        autoDisplay: false,
    }, 'google_translate_element');
};

// const searchText = ref('');

// const searchProducts = () => {
//     bus.emit('search', searchText.value);
// };
// watch(() => searchText.value, searchProducts);


</script>

<style scoped>
/* Add any specific styles you need for the search field or other components */
</style>
