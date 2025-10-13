
<template>
    <div id="map">
        
    </div>
</template>



<script setup>
import L from 'leaflet';
import { ref, onMounted } from 'vue';
import { useLinkStore } from '@/stores/linkStore.js';
const linkStore = useLinkStore();
let tiles_url = linkStore.getAssets('tiles/Test-Zoom-6-tiles-google/{z}/{y}/{x}.webp');



onMounted(() => {
    const map = L.map('map').setView([0, 0], 3);

    L.tileLayer(tiles_url, {
        minZoom: 3,
        maxZoom: 6,
        continuousWorld: false,
        noWrap: true,
    }).addTo(map);

    L.marker([0, 0]).addTo(map)
        .bindPopup('A pretty CSS3 popup.<br> Easily customizable.')
        .openPopup();
});


</script>


<style lang="scss" scoped>

#map {
    height: 100vh;
    width: 100%;
}


</style>