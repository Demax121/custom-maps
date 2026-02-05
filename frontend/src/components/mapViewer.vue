<script setup>

import { onMounted, shallowRef, watch, ref } from 'vue';
import L from 'leaflet';
import { useMapDataStore } from '../stores/mapDataStore';
import { useOverlaysDataStore } from '../stores/overlaysDataStore';
import { storeToRefs } from 'pinia';
import { useMarkersDataStore } from '../stores/markersDataStore';
import { FullScreen } from 'leaflet.fullscreen';
import { usePaneNavigation } from '../composables/usePaneNavigation';
import CreateMarker from './createMarker.vue'


const emit = defineEmits(['changePane', 'closeCords', 'closeMarkerCreationDialog' ]);
const { navigateToPane } = usePaneNavigation(emit);

const overlaysDataStore = useOverlaysDataStore();
const { overlays } = storeToRefs(overlaysDataStore);
const mapDataStore = useMapDataStore();
const { mapTilesLink, mapMinZoom, mapMaxZoom } = storeToRefs(mapDataStore);
const markersDataStore = useMarkersDataStore();
const { markers, focusedMarker, savedMarkers } = storeToRefs(markersDataStore);

const map = shallowRef(null);
let mapTiles = null;
const layerControl = shallowRef(null);
const overlayGroups = shallowRef({});
const createMarkerDialog = ref(false);
let Cords = null;
let coordinates = ref('');
let lat = ref('0');
let lng = ref('0');
let latLng = ref(null);

const myLayers = L.Control.extend({
  options: {
    position: 'topright',
  },
  onAdd: function (map) {
    const container = L.DomUtil.create('div', 'leaflet-bar leaflet-control');
    const btn = L.DomUtil.create('a', 'my-layers-toggle', container);
    btn.href = '#';
    btn.title = 'Show/hide map layers container';
    btn.setAttribute('role', 'button');
    btn.setAttribute('aria-label', 'Toggle map layers');
    
    L.DomEvent.disableClickPropagation(container);
    L.DomEvent.on(btn, 'click', function(e) {
      L.DomEvent.preventDefault(e);
      if (layerControl.value) {
        const controlContainer = layerControl.value.getContainer();
        const isExpanded = controlContainer.classList.contains('leaflet-control-layers-expanded');
        isExpanded ? layerControl.value.collapse() : layerControl.value.expand();
      }
    });

    return container;
  }
});
const myLayersControl = new myLayers();


const getLocation = L.Control.extend({
  options: {
    position: 'topright',
  },
  onAdd: function (map) {
    const container = L.DomUtil.create('div', 'leaflet-bar leaflet-control');
    const btn = L.DomUtil.create('a', 'get-location-toggle', container);
    btn.href = '#';
    btn.title = 'Create a custom marker ';
    btn.setAttribute('role', 'button');
    btn.setAttribute('aria-label', 'Get current location');
    
    L.DomEvent.disableClickPropagation(container);
    L.DomEvent.on(btn, 'click', function(e) {
    L.DomEvent.preventDefault(e);
      
      if (Cords) {
        // If marker exists, remove it
        map.removeLayer(Cords);
        Cords = null;
        createMarkerDialog.value = false;
        toggleCreate.remove(map);
      } else {
        // If marker doesn't exist, create it
        Cords = L.marker([0, 0], {
          icon: createCustomIcon('/assets/icons/dead-eye-icon.svg'),
          draggable: true,
          zIndexOffset: 9998,
          interactive: true,
          
        });
        toggleCreate.addTo(map);
        Cords.bindPopup("Get location");
        Cords.bindTooltip('I`m draggable', {
          permanent: false,
        });

          latLng = Cords.getLatLng();
          lat.value = latLng.lat.toFixed(2);
          lng.value = latLng.lng.toFixed(2);
          coordinates.value = `Lat: ${lat.value}, Lng: ${lng.value}`;

        Cords.on("dragend", () => {
          latLng = Cords.getLatLng();
          lat.value = latLng.lat.toFixed(2);
          lng.value = latLng.lng.toFixed(2);
          coordinates.value = `Lat: ${lat.value}, Lng: ${lng.value}`;
          Cords.getPopup()
          .setContent(coordinates.value)
          .openOn(map);
        });
        Cords.on('mouseover', () => Cords.openTooltip());
        Cords.on('mouseout', () => Cords.closeTooltip());
        Cords.addTo(map);
        createMarkerDialog.value = true;
      }
    });

    return container;
  }
});
const getLocationControl = new getLocation();

function closeCords() {
  if (Cords) {
   map.value.removeLayer(Cords);
    Cords = null;
    createMarkerDialog.value = false;
    toggleCreate.remove(map.value);
  }
}

function closeMarkerCreationDialog() {
  if(Cords){
    createMarkerDialog.value = false;
  }
}

const resetMap= L.Control.extend({
  options: {
    position: 'topright',
  },
  onAdd: function (map) {
    const container = L.DomUtil.create('div', 'leaflet-bar leaflet-control');
    const btn = L.DomUtil.create('a', 'reset-map-toggle', container);
    btn.href = '#';
    btn.title = 'Reset map view, remove visual bugs';
    btn.setAttribute('role', 'button');
    btn.setAttribute('aria-label', 'Reset map');
    
    L.DomEvent.disableClickPropagation(container);
    L.DomEvent.on(btn, 'click', function(e) {
      L.DomEvent.preventDefault(e);
      map.setView([0, 0], mapMinZoom.value);
    });

    return container;
  }
});
const resetMapControl = new resetMap();


const toggleCreateInputDialog = L.Control.extend({
  options: {
    position: 'topright',
  },
  onAdd: function (map) {
    const container = L.DomUtil.create('div', 'leaflet-bar leaflet-control');
    const btn = L.DomUtil.create('a', 'marker-create-input-dialog-toggle', container);
    btn.href = '#';
    btn.title = 'Toggle create marker input dialog';
    btn.setAttribute('role', 'button');
    btn.setAttribute('aria-label', 'Toggle create marker input dialog');
    
    L.DomEvent.disableClickPropagation(container);
    L.DomEvent.on(btn, 'click', function(e) {
      L.DomEvent.preventDefault(e);
      createMarkerDialog.value = !createMarkerDialog.value;
    });

    return container;
  }
});

const toggleCreate = new toggleCreateInputDialog();


function createOverlay(overlayMap, layerControl) {
  if (!overlayMap || !layerControl || !overlays.value || overlays.value.length === 0) {
    return;
  }
  // Don't reset overlayGroups to preserve Custom markers layer
  for (const overlay of overlays.value) {
    // Only add if not already added
    if (!overlayGroups.value[overlay.overlay_name]) {
      const newLayerGroup = L.featureGroup([]).addTo(overlayMap);
      layerControl.addOverlay(newLayerGroup, overlay.overlay_name);
      overlayGroups.value[overlay.overlay_name] = newLayerGroup;
    }
  }
}


const createCustomIcon = (url) =>
  new L.Icon({
    iconUrl: url,
    iconSize: [40, 40],
    iconAnchor: [24, 24],
    popupAnchor: [0, -24],
});







const initializeMap = () => {
  if (!mapTilesLink.value || !mapMinZoom.value || !mapMaxZoom.value) {
    return;
  }

  mapTiles = L.tileLayer(`${mapTilesLink.value}`, {
    minZoom: mapMinZoom.value,
    maxZoom: mapMaxZoom.value,
    continuousWorld: false,
    attribution: ' <a href="https://leafletjs.com/" target="_blank" rel="noopener">Leaflet</a> | <a href="https://github.com/Demax121/custom-maps" target="_blank" rel="noopener">Custom maps project</a>',
    noWrap: true,
  });

  map.value = L.map('map', {
    layers: [mapTiles],
    zoomSnap: 0.5,
    zoomControl: false,
    
  }).setView([0, 0], mapMinZoom.value);

  L.control.zoom({position: "topright",}).addTo(map.value);
    map.value.addControl(new FullScreen({
		position: 'topright',
		fullscreenElement: document.getElementById('app-container')
	}));
  resetMapControl.addTo(map.value);
  getLocationControl.addTo(map.value);
  myLayersControl.addTo(map.value);
  
  layerControl.value = L.control
  .layers(null, null, { collapsed: true})
  .addTo(map.value)  
  
  map.value.attributionControl.setPrefix(false);

  const newLayerGroup = L.featureGroup([]).addTo(map.value);
  layerControl.value.addOverlay(newLayerGroup, "Custom markers");
  overlayGroups.value["Custom markers"] = newLayerGroup;
  

};


function clearLayerMarkers(layerName) {
  const targetGroup = overlayGroups.value[layerName];
  if (targetGroup) {
    targetGroup.clearLayers();
  }
}

function addMarkersToMap(mapOverlay, markersTable) {
  if (!markersTable || markersTable.length === 0) {
    return;
  }

  for (const marker of markersTable) {
    const markerIcon = createCustomIcon(marker.icon_link);
    const newMarker = L.marker([marker.marker_lat, marker.marker_lng], {
      interactive: true,
      icon: markerIcon,
      draggable: false,
    });

    // Add marker to the correct feature group based on overlay_name
    const targetGroup = overlayGroups.value[marker.overlay_name];
    if (targetGroup) {
      newMarker.addTo(targetGroup);
    } 

    newMarker.bindPopup(marker.marker_name || "No name available.");
    newMarker.bindTooltip(marker.marker_name || "No name available.", {permanent: false});
    
    // Add click event listener to marker
    newMarker.on('click', () => {
      markersDataStore.selectedMarker(marker.marker_name);
      navigateToPane('MarkerDesc');
    });

  newMarker.on('mouseover', () => newMarker.openTooltip());
  newMarker.on('mouseout', () => newMarker.closeTooltip());

    // Store reference to the marker
    markersDataStore.setMarkerRef(marker.marker_name, newMarker);
  }
}


onMounted(() => {
  // Try to initialize immediately if data is already loaded
  if (mapTilesLink.value) {
    initializeMap();
    addMarkersToMap(map.value);
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
    addMarkersToMap(map.value, markers.value);
  }
});
watch(markers, (newValue) => {
  if (newValue && map.value && Object.keys(overlayGroups.value).length > 0) {
    addMarkersToMap(map.value, markers.value);
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


watch(savedMarkers, (newValue) => {
  if (map.value && overlayGroups.value["Custom markers"]) {
    // Clear all existing custom markers from the layer
    clearLayerMarkers("Custom markers");
    
    // Re-add all custom markers
    if (newValue && newValue.length > 0) {
      addMarkersToMap(map.value, savedMarkers.value);
    }
  }
}, { deep: true });

</script>


<template>
    <div id="map">
    </div>
   <CreateMarker v-show="createMarkerDialog" @close-cords="closeCords" @closeMarkerCreationDialog="closeMarkerCreationDialog" :lat="lat" :lng="lng" />
</template>



<style lang="scss" scoped>
@use '@/scss/colors.scss' as *;

#map{
    width: 100%;
    height: 100dvh;
    background-color: $background-crl-primary;
}

</style>