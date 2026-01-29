import { createApp } from 'vue';

import App from './App.vue';
import { createPinia } from 'pinia'
import '@/main.scss'  // Add this line to import the CSS reset
import 'leaflet/dist/leaflet.css';
import 'leaflet.fullscreen/dist/Control.FullScreen.css';

const pinia = createPinia();
const app = createApp(App);



app.use(pinia);


app.mount('#app');

