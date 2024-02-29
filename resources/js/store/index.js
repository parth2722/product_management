import { defineStore } from 'pinia';

export const useMainStore = defineStore('main', {
    state: () => ({
        token: localStorage.getItem('token') || null,
        user: JSON.parse(localStorage.getItem('user')) || null,
        isLoggedIn: localStorage.getItem('token') !== null,
    }),

    actions: {
        setToken(token) {
            localStorage.setItem('token', token);
            this.$patch({ token, isLoggedIn: true });
        },
        removeToken() {
            localStorage.removeItem('token');
            this.token = null;
            this.isLoggedIn = false; // Set isLoggedIn to false
        },
        setUser(user) {
            localStorage.setItem('user', JSON.stringify(user));
            this.user = user;
        },
        removeUser() {
            localStorage.removeItem('user');
            this.user = null;
        },
        logout() {

            this.removeToken();
            this.removeUser();
            this.isLoggedIn = false;
        },
    },
    getters: {
        getToken: (state) => state.token,
        getUser: (state) => state.user,
    },
});
