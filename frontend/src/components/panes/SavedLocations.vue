<template>
  <div class="sidebar__pane">
    <div class="sidebar__pane-header">
      <h1 class="sidebar__pane-title">Saved Locations</h1>
      <span class="sidebar__pane-close"></span>
    </div>
    <div class="sidebar__pane-buttons-container">
      <button v-if="savedMarkers.length > 0" class="sidebar__pane-container-button" @click="markersDataStore.exportSavedMarkers()">
        Export Saved Locations
      </button>
      <input
        type="file" 
        ref="fileInput" 
        accept="application/json" 
        @change="handleFileImport" 
        style="display: none;"
      />
      <button class="sidebar__pane-container-button" @click="$refs.fileInput.click()">
        Import Saved Locations
      </button>
    </div>
    <div class="sidebar__pane-body">
      <p v-if="savedMarkers.length === 0">
        No saved locations.
      </p>
      <ul class="sidebar__overlay-list" v-else>
        <template v-for="marker in savedMarkers" :key="marker.marker_name">
          <li class="sidebar__overlay-list-item">
            <button class="sidebar__overlay-item-button" @click="focusOnMarker(marker.marker_name);
            openMarkerDescription(marker.marker_name);">
              {{ marker.marker_name }}
            </button>
            <span class="sidebar__overlay-item-buttons-group">
              <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action"
                @click="removeSavedMarker(marker.marker_name)">
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
import { useAppSettingsStore } from '../../stores/appSettingsStore';

const markersDataStore = useMarkersDataStore();
const { savedMarkers } = storeToRefs(markersDataStore);

const appSettingsStore = useAppSettingsStore();

const emit = defineEmits(['changePane']);
const removeSavedMarker = (markerName) => {
  markersDataStore.removeSavedMarker(markerName);
};
const openMarkerDescription = (markerName) => {
  markersDataStore.selectedMarker(markerName);
  if (appSettingsStore.automaticPaneChange === true) {
    emit('changePane', 'MarkerDesc');
  }
};
const focusOnMarker = (markerName) => {
  markersDataStore.focusMarker(markerName);
};

const handleFileImport = (event) => {
  const file = event.target.files[0];
  if (file) {
    const reader = new FileReader();
    reader.onload = (e) => {
      try {
        markersDataStore.importSavedMarkers(e.target.result);
      } catch (error) {
        console.error('Error reading file:', error);
        alert('Failed to import file. Please check the file format.');
      }
    };
    reader.readAsText(file);
  }
  // Reset input so same file can be selected again
  event.target.value = '';
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

.sidebar__pane-buttons-container{
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  justify-content: space-around;
  gap: 0.5rem;
  margin-top: 0.5rem;
  padding: 0.5rem;
}

.sidebar__pane-container-button {
  width: fit-content;
  background-color: rgba(0, 0, 0, 0);
  color: $font-crl-primary;
  text-align: left;
  cursor: pointer;
  border: none;
  padding: 0.25rem 0.5rem;
  font-size: 12pt;
  background-color: rgba(124, 124, 124, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 0.25rem;
  flex-grow: 0;

  &:hover {
    text-decoration: none;
    background-color: rgba(124, 124, 124, 0.1);
  }

}



</style>