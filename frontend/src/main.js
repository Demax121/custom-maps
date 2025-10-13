import { createApp } from 'vue';


import PrimeVue from 'primevue/config';
import Aura from '@primevue/themes/aura';

import App from './App.vue';
import { createPinia } from 'pinia'
import '@/main.scss'  // Add this line to import the CSS reset
import 'leaflet/dist/leaflet.css';

const pinia = createPinia();
const app = createApp(App);
app.use(PrimeVue, {
    theme: {
        preset: Aura
    }
});



app.use(pinia);
app.mount('#app');

