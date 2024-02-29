import { defineStore } from 'pinia';

export const useCartStore = defineStore('cart', {
    state: () => ({
        cartItems: getStoredCartItems(),
        coupon: 0,
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
        updateTotalPrice(discountAmount) {
            // Update the coupon and then save to localStorage
            this.coupon = discountAmount;
            this.saveCartToStorage();
        },
    },
    getters: {
        totalItems() {
            return this.cartItems.reduce((total, item) => total + item.quantity, 0);
        },
        totalPrice() {
            const totalPriceBeforeDiscount = this.cartItems.reduce((total, item) => total + item.price * item.quantity, 0);
            const discountAmount = this.coupon ? this.coupon : 0;

            // Apply the discount amount
            const totalPriceAfterDiscount = totalPriceBeforeDiscount - discountAmount;

            // Make sure the total price is non-negative
            return Math.max(0, totalPriceAfterDiscount);
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
