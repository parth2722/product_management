<template>
    <div>
        <!-- <button @click="login" class="google-login-button">
            <div>
                <img src="../2.jpg" alt="Google Icon" class="google-icon" height="30" width="40">
            </div> Google
        </button> -->
        <GoogleLogin :callback="callback" />
        <!-- <div v-if="userDetails">
            <h2>User Details</h2>
            <p>Name: {{ userDetails.name }}</p>
            <p>Email: {{ userDetails.email }}</p>
            <p>Profile Picture: <img :src="userDetails.picture" alt="Profile Picture"></p>
        </div> -->
    </div>
</template>

<script>
import { googleSdkLoaded } from "vue3-google-login";
import axios from "axios";
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
        login() {
            googleSdkLoaded(google => {
                google.accounts.oauth2
                    .initCodeClient({
                        client_id:
                            "472675017623-1f7c62rnjldvvkq4qcbpgavveb9khlvb.apps.googleusercontent.com",
                        scope: "email profile openid",
                        redirect_uri: "http://localhost:4000/auth/callback",
                        callback: response => {
                            if (response.code) {
                                this.sendCodeToBackend(response.code);
                            }
                        }
                    })
                    .requestCode();
            });
        },
        async sendCodeToBackend(code) {
            try {
                const response = await axios.post(
                    "https://oauth2.googleapis.com/token",
                    {
                        code,
                        client_id:
                            "472675017623-1f7c62rnjldvvkq4qcbpgavveb9khlvb.apps.googleusercontent.com",
                        client_secret: "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",
                        redirect_uri: "postmessage",
                        grant_type: "authorization_code"
                    }
                );
                const accessToken = response.data.access_token;
                console.log(accessToken);

                authStore.setToken(accessToken);
                // authStore.setUser(accessToken);

                const userResponse = await axios.get(
                    "https://www.googleapis.com/oauth2/v3/userinfo",
                    {
                        headers: {
                            Authorization: `Bearer ${accessToken}`
                        }
                    }
                );

                if (userResponse && userResponse.data) {
                    // Set the userDetails data property to the userResponse object
                    this.userDetails = userResponse.data;
                    authStore.setUser(userResponse.data);
                    this.$router.push('/home');
                } else {
                    // Handle the case where userResponse or userResponse.data is undefined
                    console.error("Failed to fetch user details.");
                }
            } catch (error) {
                console.error("Token exchange failed:", error.response.data);
            }
        }
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
