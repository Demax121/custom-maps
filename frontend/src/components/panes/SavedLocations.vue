<template>
  <div class="sidebar__pane">
    <div class="sidebar__pane-header">
      <h1 class="sidebar__pane-title">Saved Locations</h1>
      <span class="sidebar__pane-close"></span>
    </div>
    <div class="sidebar__pane-buttons-container">
      <button v-if="savedMarkers.length > 0" class="sidebar__pane-container-button"
        @click="markersDataStore.exportSavedMarkers()">
        Export Saved Locations
      </button>
      <input type="file" ref="fileInput" accept="application/json" @change="handleFileImport" style="display: none;" />
      <button class="sidebar__pane-container-button" @click="$refs.fileInput.click()">
        Import Saved Locations
      </button>
    </div>
    <div class="sidebar__pane-body">
      <p v-if="savedMarkers.length === 0">
        No saved locations.
      </p>
      <div class="sidebar__pane__locations-container" v-else>

        <button class="sidebar__overlay-button" @click="toggleSavedLocations()">
          Saved Locations
        </button>

      <Transition name="slide-fade" >
      <ul class="sidebar__overlay-list sidebar__overlay-list-saved" v-show="savedLocationsBtn">
        <template v-for="marker in savedMarkers" :key="marker.marker_name">
          <li class="sidebar__overlay-list-item">
            <button class="sidebar__overlay-item-button" @click="focusOnMarker(marker.marker_name);
            openMarkerDescription(marker.marker_name);">
              {{ marker.marker_name }}
            </button>
            <span class="sidebar__overlay-item-buttons-group">
              <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action" @click="openNoteDialog(marker.marker_name)" title="Add/View Note">
                <img src="/assets/note-icon.svg" alt="add note" class="note__icon"  />
              </button>
              <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action"
                @click="removeSavedMarker(marker.marker_name)" title="Remove location from list">
                Remove Saved
              </button>
            </span>
          </li>
          <NoteDialog v-show="showNoteDialog.includes(marker.marker_name)" @closeNoteDialog="closeNoteDialog(marker.marker_name)"
              :markerName = marker.marker_name
          />
        </template>
      </ul>
      </Transition>
        <button class="sidebar__overlay-button" v-if="customMarkers.length > 0" @click="toggleCreatedLocations()">
          Created Locations
        </button>
      <Transition name="slide-fade" >
        <ul class="sidebar__overlay-list sidebar__overlay-list-custom" v-show="createdLocationsBtn">
            <template v-for="marker in customMarkers" :key="marker.marker_name">
              <li class="sidebar__overlay-list-item">
                <button class="sidebar__overlay-item-button" @click="focusOnMarker(marker.marker_name);
                openMarkerDescription(marker.marker_name);">
                  {{ marker.marker_name }}
                </button>
                <span class="sidebar__overlay-item-buttons-group">
                  <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action" @click="openNoteDialog(marker.marker_name)" title="Add/View Note">
                    <img src="/assets/note-icon.svg" alt="add note" class="note__icon"  />
                  </button>
                  <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action"
                    @click="removeCreatedMarker(marker.marker_name)" title="Remove location from list">
                    Remove created
                  </button>
                </span>
              </li>
              <NoteDialog v-show="showNoteDialog.includes(marker.marker_name)" @closeNoteDialog="closeNoteDialog(marker.marker_name)"
                  :markerName = marker.marker_name
              />
            </template>
        </ul>
      </Transition>
</div>

    </div>
  </div>





</template>

<script setup>
import { storeToRefs } from 'pinia';
import { onMounted, ref, watch, reactive, computed } from 'vue';
import { useMarkersDataStore } from '../../stores/markersDataStore';
import { usePaneNavigation } from '../../composables/usePaneNavigation';
import NoteDialog from '../noteDialog.vue';

const markersDataStore = useMarkersDataStore();
const { savedMarkers } = storeToRefs(markersDataStore);
const { customMarkers } = storeToRefs(markersDataStore);
const showNoteDialog = ref([]);

const markerNote = ref('');

const savedLocationsBtn = ref(true);
const createdLocationsBtn = ref(false);

const emit = defineEmits(['changePane', 'closeNoteDialog']);
const { navigateToPane } = usePaneNavigation(emit);

const removeSavedMarker = (markerName) => {
  markersDataStore.removeSavedMarker(markerName);
};
const openMarkerDescription = (markerName) => {
  markersDataStore.selectedMarker(markerName);
  navigateToPane('MarkerDesc');
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


function openNoteDialog(markerName) {
  const marker = savedMarkers.value.find(marker => marker.marker_name === markerName);
  if (marker) {
    markerNote.value = markerName;
    markersDataStore.selectedMarker(markerName);
    if (showNoteDialog.value.includes(markerName)) {
      showNoteDialog.value = showNoteDialog.value.filter(name => name !== markerName);
    } else {
      showNoteDialog.value.push(markerName);
    }
  }
}
function closeNoteDialog(markerName) {
  showNoteDialog.value = showNoteDialog.value.filter(name => name !== markerName);
}


function toggleSavedLocations() {
  savedLocationsBtn.value = !savedLocationsBtn.value;
}

function toggleCreatedLocations() {
  createdLocationsBtn.value = !createdLocationsBtn.value;
}
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

.sidebar__pane-buttons-container {
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
  font-size: 1rem;
  background-color: rgba(124, 124, 124, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 0.25rem;
  flex-grow: 0;
  flex-shrink: 0;

  &:hover {
    text-decoration: none;
    background-color: rgba(124, 124, 124, 0.1);
  }
}

.note__icon {
  width: 1.25rem;
}


.sidebar__overlay-list-saved,
.sidebar__overlay-list-custom{
  border-bottom: 2px solid rgba(255, 255, 255, 0.5);
  padding-bottom: 1.25rem;
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