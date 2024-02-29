import { defineStore } from 'pinia';
import { ref } from 'vue';

export const useAuthStore = defineStore('auth', () => {
    const accessToken = ref(localStorage.getItem('accessToken') || null);
    const userData = ref(JSON.parse(localStorage.getItem('userData')) || null);
    const isLoggedIn = ref(!!accessToken.value);

    function setToken(token) {
        accessToken.value = token;
        isLoggedIn.value = true;
        localStorage.setItem('accessToken', token);
    }

    function removeToken() {
        accessToken.value = null;
        isLoggedIn.value = false;
        localStorage.removeItem('accessToken');
    }

    function setUser(user) {
        userData.value = user;
        localStorage.setItem('userData', JSON.stringify(user));
    }

    function removeUser() {
        userData.value = null;
        localStorage.removeItem('userData');
    }

    return {
        accessToken,
        userData,
        isLoggedIn,
        setToken,
        removeToken,
        setUser,
        removeUser,
    };
});
