<template>
    <div>
        <GoogleLogin :callback="callback" />

    </div>
</template>

<script>

import { useMainStore } from '../store/';

const authStore = useMainStore();
export default {
    data() {
        return {
            userDetails: null
        };
    },

    name: "YourComponent",
    methods: {
        callback(response) {
            console.log("Handle the response", response);
        },
    }
};
</script>
<style>
.google-login-button {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 10px;
    background-color: #4285f4;
    color: #ffffff;
    border: none;
    cursor: pointer;
}

.google-icon {
    width: 20px;
    height: 20px;
    margin-right: 10px;
}
</style>
