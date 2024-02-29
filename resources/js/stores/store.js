import { defineStore } from 'pinia';

export const useCartStore = defineStore('cart', {
    state: () => ({
        cartItems: getStoredCartItems(),
    }),
    actions: {
        addToCart(productId, product) {
            const existingItem = this.cartItems.find(item => item.id === productId);

            if (existingItem) {
                existingItem.quantity += 1;
            } else {
                this.cartItems.push({ ...product, quantity: 1 });
            }

            this.saveCartToStorage();
        },
        removeFromCart(productId) {
            this.cartItems = this.cartItems.filter(item => item.id !== productId);
            this.saveCartToStorage();
        },
        clearCart() {
            this.cartItems = [];
            this.saveCartToStorage();
        },
        saveCartToStorage() {
            if (typeof localStorage !== 'undefined') {
                localStorage.setItem('cartItems', JSON.stringify(this.cartItems));
            }
        },
    },
    getters: {
        totalItems() {
            return this.cartItems.reduce((total, item) => total + item.quantity, 0);
        },
        totalPrice() {
            return this.cartItems.reduce((total, item) => total + item.price * item.quantity, 0);
        },
    },
});

function getStoredCartItems() {
    if (typeof localStorage !== 'undefined') {
        const storedItems = localStorage.getItem('cartItems');
        return storedItems ? JSON.parse(storedItems) : [];
    }
    return [];
}
