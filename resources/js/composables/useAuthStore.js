// composables/useAuthStore.js
import { useAuthStore } from '../stores/index';

export default function useAuthStoreComposable() {
    const authStore = useAuthStore();

    const getUserInfo = () => {
        console.log('isLoggedIn:', authStore.isLoggedIn);  // Log for debugging

        if (authStore.isLoggedIn) {
            return authStore.userData;
        } else {
            // If not logged in, try to get user data from local storage
            const storedUserData = localStorage.getItem('userData');
            return storedUserData ? JSON.parse(storedUserData) : null;
        }
    };

    return {
        authStore,
        getUserInfo,
    };
}
