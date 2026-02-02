<template>
  <div class="sidebar__pane">
    <div class="sidebar__pane-header">
      <h1 class="sidebar__pane-title">Saved Locations</h1>
      <span class="sidebar__pane-close"></span>
    </div>
    <div class="sidebar__pane-buttons-container">
      <button v-if="savedMarkers.length > 0 " class="sidebar__pane-container-button"
        @click="markersDataStore.exportSavedMarkers()">
        Export Saved
      </button>
      <input type="file" ref="fileInput" accept="application/json" @change="handleFileImport" style="display: none;" />
      <button class="sidebar__pane-container-button" @click="$refs.fileInput.click()">
        Import Locations
      </button>
    </div>
    <div class="sidebar__pane-body">
      <p v-if="savedMarkers.length === 0 ">
        No saved locations.
      </p>
      <div class="sidebar__pane__locations-container" v-else>

      <Transition name="slide-fade" >
      <ul class="sidebar__overlay-list sidebar__overlay-list-saved" v-show="savedLocationsBtn">
        <template v-for="marker in savedMarkers" :key="marker.marker_name">
          <li class="sidebar__overlay-list-item">
            <button class="sidebar__overlay-item-button" @click="focusOnMarker(marker.marker_name);
            openMarkerDescription(marker.marker_name);">
              {{ marker.marker_name }}
            </button>
            <span class="sidebar__overlay-item-buttons-group">
              <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action note__button" @click="openNoteDialog(marker.marker_name)" title="Add/View Note">
              </button>
              <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action remove-bookmark-button"
                @click="removeSavedMarker(marker.marker_name)" title="Remove location from list">
                
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
const showNoteDialog = ref([]);

const markerNote = ref('');

const savedLocationsBtn = ref(true);
const createdLocationsBtn = ref(false);

const emit = defineEmits(['changePane', 'closeNoteDialog']);
const { navigateToPane } = usePaneNavigation(emit);

const removeSavedMarker = (markerName) => {
  markersDataStore.removeSavedMarker(markerName);
  markersDataStore.targetMarker = null;
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
  const marker = savedMarkers.value.find(marker => marker.marker_name === markerName) 
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
@use '@/scss/colors' as *;
@use '@/scss/mixins' as *;

.sidebar__overlay-list {
  @include list-reset;
  padding: 0.5rem;
  background-color: $saved-locations-overlay-bg-crl;
}

.sidebar__overlay-list-item {
  padding: 0.5rem 0rem 0 0.5rem;
  border-bottom: 1px solid $saved-locations-border-light-crl;
  @include flex-row(space-between, flex-start);
}

.sidebar__pane-buttons-container {
  @include flex-row(space-around, center, 0.5rem);
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
  background-color: $saved-locations-button-bg-crl;
  border: 1px solid $saved-locations-button-border-crl;
  border-radius: 0.25rem;
  flex-grow: 0;
  flex-shrink: 0;

  &:hover {
    text-decoration: none;
    background-color: $saved-locations-button-hover-crl;
  }
}


.note__button {
    background-image: url('/assets/icons/note-icon.svg');
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
    width: 2rem;
    height: 2rem;
    background-size: 70%;
}



.sidebar__overlay-list-saved{
  @include grid-row(1fr, 1fr, 0);
}

/* Transition styles */
.slide-fade-enter-active,
.slide-fade-leave-active {
  @include transition-slide-fade(0.3s);
}

.slide-fade-enter-from {
  @include slide-fade-enter;
}

.slide-fade-leave-to {
  @include slide-fade-enter;
}


@include respond-to-mobile{

    .sidebar__pane-container-button{
        font-size: 0.8rem;
        padding: 0.25rem 0.5rem;
    }
}



</style>