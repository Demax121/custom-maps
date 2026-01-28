<template>
        <div class="sidebar__pane">
          <div class="sidebar__pane-header">
            <h1 class="sidebar__pane-title">Marker List</h1>
          </div>
          <div class="sidebar__pane-body">

            <div class="sidebar__overlay" v-for="overlay in overlays" :key="overlay.overlay_name">
              <button class="sidebar__overlay-button" @click="toggleOverlay(overlay.overlay_name)" :style=" openOverlays[overlay.overlay_name] ? activeColor : {}">
                {{ overlay.overlay_name }}
              </button>
              <Transition name="slide-fade">
                <ul class="sidebar__overlay-list" v-show="openOverlays[overlay.overlay_name]">
                    <template  v-for="marker in markers" :key="marker.marker_name">
                      <li 
                        class="sidebar__overlay-list-item" 
                        v-if="marker.overlay_name === overlay.overlay_name">
                       <button class="sidebar__overlay-item-button"
                       @click="focusOnMarker(marker.marker_name);
                       openMarkerDescription(marker.marker_name);"> 
                        {{ marker.marker_name }}
                       </button>
                      </li>
                    </template>



                </ul>
              </Transition>
            </div>

          </div>
        </div>
</template>

<script setup>
import { onMounted, ref, watch, reactive } from 'vue';
import { storeToRefs } from 'pinia';
import { useOverlaysDataStore } from '../../stores/overlaysDataStore';
import { useMarkersDataStore } from '../../stores/markersDataStore';

const emit = defineEmits(['changePane']);

const overlaysDataStore = useOverlaysDataStore();
const markersDataStore = useMarkersDataStore();
const { overlays } = storeToRefs(overlaysDataStore);
const { markers } = storeToRefs(markersDataStore);

const openOverlays = reactive({});
const activeColor = reactive({
backgroundColor: 'rgba(124, 124, 124, 0.5)'
});

const toggleOverlay = (overlayId) => {
  openOverlays[overlayId] = !openOverlays[overlayId];
};

const focusOnMarker = (markerName) => {
  markersDataStore.focusMarker(markerName);
};

const openMarkerDescription = (markerName) => {
  markersDataStore.selectedMarker(markerName);
  emit('changePane', 'MarkerDesc');
}

</script>

<style lang="scss" scoped>
@use '@/scss/colors.scss' as *;

.sidebar__overlay {
  width: 100%;
  margin-bottom: 1rem;
}

.sidebar__overlay-button {
  width: 100%;
  height: 3rem;
  background-color: rgba(0, 0, 0, 0);
  color: $font-crl-primary;
  cursor: pointer;
  border: none;
  padding: 0.75rem;
  text-align: left;
  
  &:hover {
    background-color: rgba(124, 124, 124, 0.3);
  }
}

.sidebar__overlay-list {
  list-style: none;
  padding: 0.5rem;
  margin: 0;
  background-color: rgba(0, 0, 0, 0.2);
  border-bottom: 2px solid rgba(255, 255, 255, 0.2);
}


.sidebar__overlay-list-item {
  padding: 0.5rem 0rem 0 0.5rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);

  &:last-child {
    border-bottom: none;
  }
}

.sidebar__overlay-item-button {
  width: 100%;
  background-color: rgba(0, 0, 0, 0);
  color: $font-crl-primary;
  cursor: pointer;
  border: none;
  padding: 0;
  text-align: left;

  &:hover {
    text-decoration: underline;
  }
}

/* Transition styles */
.slide-fade-enter-active,
.slide-fade-leave-active {
  transition: all 0.3s ease;
}

.slide-fade-enter-from {
  transform: translateY(-10px);
  opacity: 0;
}

.slide-fade-leave-to {
  transform: translateY(-10px);
  opacity: 0;
}

</style>