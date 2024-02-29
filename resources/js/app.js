
import { createApp } from 'vue';
import App from './App.vue';
import axios from 'axios';
import { createPinia } from 'pinia';
import setupRouter from './routes';
import vuetify from "./vuetify";
import '../css/app.css'; // Import the main.css file
import { myPlugin } from '/var/www/demo/src/plugins/myPlugin.js'; // Update the path accordingly
const pinia = createPinia();
const app = createApp(App);
import vue3GoogleLogin from 'vue3-google-login'
app.use(pinia);
setupRouter(app);

app.use(vue3GoogleLogin, {
    clientId: "472675017623-1f7c62rnjldvvkq4qcbpgavveb9khlvb.apps.googleusercontent.com"
  })


app.use('axios', axios);
app.use(vuetify);
app.use(myPlugin);


app.mount('#app');
