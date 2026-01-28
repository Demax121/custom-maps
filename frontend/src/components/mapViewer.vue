

<script setup>

import { onMounted, shallowRef, watch } from 'vue';
import L from 'leaflet';
import { useMapDataStore } from '../stores/mapDataStore';
import { useOverlaysDataStore } from '../stores/overlaysDataStore';
import { storeToRefs } from 'pinia';

const overlaysDataStore = useOverlaysDataStore();
const { overlays } = storeToRefs(overlaysDataStore);
const mapDataStore = useMapDataStore();
const { mapTilesLink, mapMinZoom, mapMaxZoom } = storeToRefs(mapDataStore);

const map = shallowRef(null);
let mapTiles = null;
const layerControl = shallowRef(null);

function createOverlay(overlayMap, layerControl) {
  if (!overlayMap || !layerControl || !overlays.value || overlays.value.length === 0) {
    return;
  }
  
  for (const overlay of overlays.value) {
    const newLayerGroup = L.layerGroup([]).addTo(overlayMap);
    layerControl.addOverlay(newLayerGroup, overlay.overlay_name);
  }
}

const createCustomIcon = (shape) =>
  new L.Icon({
    iconUrl: `http://127.0.0.1:8885/icons/${shape}`,
    iconSize: [38, 95],
    shadowSize: [50, 64],
    iconAnchor: [22, 94],
    shadowAnchor: [4, 62],
    popupAnchor: [-3, -76],
  });

const initializeMap = () => {
  if (!mapTilesLink.value || !mapMinZoom.value || !mapMaxZoom.value) {
    return;
  }

  mapTiles = L.tileLayer(`${mapTilesLink.value}`, {
    minZoom: mapMinZoom.value,
    maxZoom: mapMaxZoom.value,
    continuousWorld: false,
    noWrap: true,
  });

  map.value = L.map('map', {
    layers: [mapTiles],
    zoomSnap: 0.25,
    zoomControl: false,
  }).setView([0, 0], mapMinZoom.value);

  L.marker([0, 0], { icon: createCustomIcon('leaf-green.png') })
    .addTo(map.value)
    .bindPopup('Działa');

  L.control.zoom({position: "topright",}).addTo(map.value);
  layerControl.value = L.control
  .layers(null, null, { collapsed: false })
  .addTo(map.value);  
};




onMounted(() => {
  // Try to initialize immediately if data is already loaded
  if (mapTilesLink.value) {
    initializeMap();
    
  }
});

// Watch for when the data becomes available
watch(mapTilesLink, (newValue) => {
  if (newValue && !map.value) {
    initializeMap();
    
  }
})
watch(overlays, (newValue) => {
  if (newValue && map.value && layerControl.value) {
    createOverlay(map.value, layerControl.value);
  }
});

</script>


<template>
    <div id="map">

    </div>
</template>



<style lang="scss" scoped>
#map{
    width: 100%;
    height: 100dvh;
    background-color: #1F1F1F;
}


.leaflet-control-zoom-in,
.leaflet-control-zoom-out {
  width: 3rem !important;
  height: 3rem !important;
  line-height: 3rem !important;
  font-size: 1.75rem !important;
}



</style>