<template>
    <div style="margin-left: 1%;">
        <button @click="login" class="github-login-button">
            <div>
                <img src="../git.png" alt="GitHub Icon" class="github-icon" height="30" width="30">
            </div> GitHub
        </button>

    </div>
</template>

<script>
import axios from "axios";
import { useMainStore } from '../store/';
const authStore = useMainStore();

export default {
    data() {
        return {
            userDetails: null
        };
    },
    methods: {
        async login() {
            // GitHub OAuth parameters
            const clientId = "db7d892a6aad7b6bb4fe";
            const redirectUri = "http://127.0.0.1:8000/home";
            window.location.href = `https://github.com/login/oauth/authorize?client_id=${clientId}&redirect_uri=${redirectUri}`;
        },

    },

};
</script>

<style>
.github-login-button {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 10px;
    background-color: #24292e;
    color: #ffffff;
    border: none;
    cursor: pointer;
}

.github-icon {
    width: 20px;
    height: 20px;
    margin-right: 10px;
}
</style>
