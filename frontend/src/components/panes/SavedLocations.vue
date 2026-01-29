<template>
        <div class="sidebar__pane">
          <div class="sidebar__pane-header">
            <h1 class="sidebar__pane-title">Saved Locations</h1>
            <span class="sidebar__pane-close"></span>
          </div>
          <div class="sidebar__pane-body">
            <div v-if="savedMarkers.length === 0">
              No saved locations.
            </div>
            <ul class="sidebar__overlay-list" v-else>
              <template v-for="marker in savedMarkers" :key="marker.marker_name">
                <li class="sidebar__overlay-list-item">
                  <button class="sidebar__overlay-item-button" @click="focusOnMarker(marker.marker_name);
                  openMarkerDescription(marker.marker_name);">
                    {{ marker.marker_name }}
                  </button>
                  <span class="sidebar__overlay-item-buttons-group">
                  <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action" @click="removeSavedMarker(marker.marker_name)">
                    Remove Saved
                  </button>
                  </span>
                </li>
              </template>
            </ul>
          </div>
        </div>
</template>

<script setup>
import { storeToRefs } from 'pinia';
import { onMounted, ref, watch, reactive, computed } from 'vue';
import { useMarkersDataStore } from '../../stores/markersDataStore';
const markersDataStore = useMarkersDataStore();
const { savedMarkers } = storeToRefs(markersDataStore);

const emit = defineEmits(['changePane']);
const removeSavedMarker = (markerName) => {
  markersDataStore.removeSavedMarker(markerName);
};
const openMarkerDescription = (markerName) => {
markersDataStore.selectedMarker(markerName);
  emit('changePane', 'MarkerDesc');
};
const focusOnMarker = (markerName) => {
  markersDataStore.focusMarker(markerName);
};


</script>

<style lang="scss" scoped>


.sidebar__overlay-list {
  list-style: none;
  padding: 0.5rem;
  margin: 0;
  background-color: rgba(0, 0, 0, 0.2);
}
.sidebar__overlay-list-item {
  padding: 0.5rem 0rem 0 0.5rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: flex-start;
}



</style>