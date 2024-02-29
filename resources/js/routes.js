import { createRouter, createWebHistory } from 'vue-router';
import { useMainStore } from './store/index';
import routes from '~pages';
import { setupLayouts } from 'virtual:generated-layouts'
console.log(routes)
export default function setupRouter(app) {
    const router = createRouter({
        history: createWebHistory(),
        routes: [
            // { path: '/', redirect: { name: 'Login' } },
            ...setupLayouts(routes)
        ]
    });

    router.beforeEach((to, from, next) => {
        const mainStore = useMainStore();
        const isAuthenticated = mainStore.getToken !== null;

        if (to.meta.requiresAuth && !isAuthenticated) {
            next({ name: 'Login' });
        } else {
            next();
        }
    });

    app.use(router);
}
