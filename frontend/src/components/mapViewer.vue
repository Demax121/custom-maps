

<script setup>

import { onMounted, shallowRef, watch } from 'vue';
import L from 'leaflet';
import { useMapDataStore } from '../stores/mapDataStore';
import { useOverlaysDataStore } from '../stores/overlaysDataStore';
import { storeToRefs } from 'pinia';
import { useMarkersDataStore } from '../stores/markersDataStore';

const emit = defineEmits(['changePane']);

const overlaysDataStore = useOverlaysDataStore();
const { overlays } = storeToRefs(overlaysDataStore);
const mapDataStore = useMapDataStore();
const { mapTilesLink, mapMinZoom, mapMaxZoom } = storeToRefs(mapDataStore);
const markersDataStore = useMarkersDataStore();
const { markers, focusedMarker } = storeToRefs(markersDataStore);

const map = shallowRef(null);
let mapTiles = null;
const layerControl = shallowRef(null);
const overlayGroups = shallowRef({});

function createOverlay(overlayMap, layerControl) {
  if (!overlayMap || !layerControl || !overlays.value || overlays.value.length === 0) {
    return;
  }
  overlayGroups.value = {};
  for (const overlay of overlays.value) {
    const newLayerGroup = L.featureGroup([]).addTo(overlayMap);
    layerControl.addOverlay(newLayerGroup, overlay.overlay_name);
    overlayGroups.value[overlay.overlay_name] = newLayerGroup;
  }
}

const createCustomIcon = (shape) =>
  new L.Icon({
    iconUrl: `http://127.0.0.1:8885/icons/${shape}.png`,
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

  L.control.zoom({position: "topright",}).addTo(map.value);
  layerControl.value = L.control
  .layers(null, null, { collapsed: false })
  .addTo(map.value);  
};


let Cords = L.marker([7, 7], {
  icon: createCustomIcon('leaf-red'),
  draggable: true,
  zIndexOffset: 9998,
});

Cords.bindPopup("");

Cords.on("dragend", () => {
  let latLng = Cords.getLatLng();
  let lat = latLng.lat.toFixed(2);
  let lng = latLng.lng.toFixed(2);
  let coordinates = `Latitude: ${lat}, Longitude: ${lng}`;
   Cords.getPopup().setContent(coordinates).openOn(map.value);
});


function addMarkersToMap(mapOverlay) {
  if (!markers.value || markers.value.length === 0) {
    return;
  }

  for (const marker of markers.value) {
    const markerIcon = createCustomIcon(marker.marker_icon);
    const newMarker = L.marker([marker.marker_lat, marker.marker_lng], {
      title: marker.marker_name,
      icon: markerIcon,
      draggable: false,
    });

    // Add marker to the correct feature group based on overlay_name
    const targetGroup = overlayGroups.value[marker.overlay_name];
    if (targetGroup) {
      newMarker.addTo(targetGroup);
    } 

    newMarker.bindPopup(marker.marker_name || "No name available.");
    
    // Add click event listener to marker
    newMarker.on('click', () => {
      markersDataStore.selectedMarker(marker.marker_name);
      emit('changePane', 'MarkerDesc');
    });
    
    // Store reference to the marker
    markersDataStore.setMarkerRef(marker.marker_name, newMarker);
  }
}


onMounted(() => {
  // Try to initialize immediately if data is already loaded
  if (mapTilesLink.value) {
    initializeMap();
    Cords.addTo(map.value);
    addMarkersToMap(map.value);
  }
});

// Watch for when the data becomes available
watch(mapTilesLink, (newValue) => {
  if (newValue && !map.value) {
    initializeMap();
    Cords.addTo(map.value);
  }
})
watch(overlays, (newValue) => {
  if (newValue && map.value && layerControl.value) {
    createOverlay(map.value, layerControl.value);
    addMarkersToMap(map.value);
  }
});

watch(markers, (newValue) => {
  if (newValue && map.value && Object.keys(overlayGroups.value).length > 0) {
    addMarkersToMap(map.value);
  }
});

watch(focusedMarker, (markerName) => {
  if (markerName && map.value && markersDataStore.markerRefs[markerName]) {
    const marker = markersDataStore.markerRefs[markerName];
    const latLng = marker.getLatLng();
    map.value.flyTo(latLng, Math.max(map.value.getZoom(), 3), {
      duration: 1.5
    });
    marker.openPopup();
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