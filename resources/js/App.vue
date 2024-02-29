<template>
    <v-container>
        <div id="app">
            <!-- <div id="google_translate_element"></div> -->
            <!-- <button @click="callMyMethod">Call My Method</button> -->
            <router-view></router-view>

        </div>
    </v-container>
</template>
<script>
export default {
    methods: {
        callMyMethod() {
            this.$myMethod();
        },
    },
};
</script>
<style>
@import "bootstrap";
@import "datatables.net-bs5";
</style>
