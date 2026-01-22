<template>
    <div id="map">

    </div>
</template>

<script setup>
import { onMounted, shallowRef } from 'vue';
import L from 'leaflet';

const map = shallowRef(null)

const fullmap = L.tileLayer('http://127.0.0.1:8885/maps/Barovia/{z}/{y}/{x}.webp', {
  minZoom: 1,
  maxZoom: 5,
  continuousWorld: false,
  noWrap: true,
})

const createCustomIcon = (shape) =>
  new L.Icon({
    iconUrl: `http://127.0.0.1:8885/icons/${shape}`,
    iconSize: [38, 95],
    shadowSize: [50, 64],
    iconAnchor: [22, 94],
    shadowAnchor: [4, 62],
    popupAnchor: [-3, -76],
  })

onMounted(() => {
  map.value = L.map('map', {
    layers: [fullmap],
    zoomSnap: 0.25,
    zoomControl: false,
  }).setView([0, 0], 2)

  L.marker([0, 0], { icon: createCustomIcon('leaf-green.png') })
    .addTo(map.value)
    .bindPopup('Działa')
})
</script>

<style lang="scss" scoped>
#map{
    width: 100%;
    height: 100vh;
    background-color: #1F1F1F;
}

</style>