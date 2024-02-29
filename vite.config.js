import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import Vue from '@vitejs/plugin-vue';
import Pages from 'vite-plugin-pages';
import Layouts from "vite-plugin-vue-layouts";
// import Vuetify from 'vuetify';

export default defineConfig({
    plugins: [
        Vue(),
        // Vuetify(),
        Pages({
            dirs: ['resources/js/pages', 'resources/js/components']
        }),
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
        Layouts({
            layoutsDirs: "resources/js/layouts"
        })
    ],
});
