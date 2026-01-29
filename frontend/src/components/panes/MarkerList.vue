<template>
  <div class="sidebar__pane">
    <div class="sidebar__pane-header">
      <h1 class="sidebar__pane-title">Marker List</h1>
    </div>
    <div class="sidebar__pane-body">
      <div class="sidebar__pane-search-container">
        <input type="text" v-model="searchQuery" class="sidebar__pane-search-input"
          placeholder="Search markers..."
          @focus="showResult = true" @blur="showResult = false"></input>
        <div class="sidebar__pane-search-result" v-show="showResult && searchQuery">
          <ul class="sidebar__overlay-list">
            <template v-for="marker in filteredMarkers" :key="marker.marker_name">
              <li class="sidebar__overlay-list-item sidebar__overlay-list-item">
                <button class="sidebar__overlay-item-button item-button--search" @mousedown="focusOnMarker(marker.marker_name);
                openMarkerDescription(marker.marker_name);">
                  {{ marker.marker_name }}
                </button>
                <span class="sidebar__overlay-item-buttons-group">
                <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action action-button--search" @click="saveMarker(marker.marker_name)">
                  Save Location
                </button>
                <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action action-button--search" @click="removeSavedMarker(marker.marker_name)">
                  Remove Saved
                </button>
                </span>
              </li>
            </template>
          </ul>
        </div>
      </div>
      <div class="sidebar__overlay" v-for="overlay in overlays" :key="overlay.overlay_name">
        <button class="sidebar__overlay-button" @click="toggleOverlay(overlay.overlay_name)"
          :style="openOverlays[overlay.overlay_name] ? activeColor : {}">
          {{ overlay.overlay_name }}
        </button>
        
        <Transition name="slide-fade">
          <ul class="sidebar__overlay-list" v-show="openOverlays[overlay.overlay_name]">
            <template v-for="marker in markers" :key="marker.marker_name">
              <li class="sidebar__overlay-list-item" v-if="marker.overlay_name === overlay.overlay_name">
                <button class="sidebar__overlay-item-button" @click="focusOnMarker(marker.marker_name);
                openMarkerDescription(marker.marker_name);">
                  {{ marker.marker_name }}
                </button>
                <span class="sidebar__overlay-item-buttons-group">
                <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action" @click="saveMarker(marker.marker_name)">
                  Save Location
                </button>
                <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action" @click="removeSavedMarker(marker.marker_name)">
                  Remove Saved
                </button>
                </span>
              </li>
            </template>



          </ul>
        </Transition>
      </div>

    </div>
  </div>
</template>

<script setup>
import { onMounted, ref, watch, reactive, computed } from 'vue';
import { storeToRefs } from 'pinia';
import { useOverlaysDataStore } from '../../stores/overlaysDataStore';
import { useMarkersDataStore } from '../../stores/markersDataStore';

const emit = defineEmits(['changePane']);

const overlaysDataStore = useOverlaysDataStore();
const markersDataStore = useMarkersDataStore();
const { overlays } = storeToRefs(overlaysDataStore);
const { markers } = storeToRefs(markersDataStore);

const openOverlays = reactive({});
const searchQuery = ref('');
const showResult = ref(false);

const filteredMarkers = computed(() => {
  if (!searchQuery.value) return [];
  const query = searchQuery.value.toLowerCase();
  return markers.value.filter(marker => 
    marker.marker_name.toLowerCase().includes(query)
  );
});

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
};

const saveMarker = (markerName) => {
  markersDataStore.saveMarker(markerName);
};

const removeSavedMarker = (markerName) => {
  markersDataStore.removeSavedMarker(markerName);
};


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
  font-size: 14pt;

  &:hover {
    background-color: rgba(124, 124, 124, 0.3);
  }

}

.sidebar__overlay-item-buttons-group {
  display: flex;
  flex-direction: row;
  gap: 0.25rem;
  margin-left: 1rem;

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
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: flex-start;
    

  &:last-child {
    border-bottom: none;
  }

}

.sidebar__overlay-item-button {
  width: 100%;
  background-color: rgba(0, 0, 0, 0);
  color: $font-crl-primary;
  text-align: left;
  cursor: pointer;
  border: none;
  padding: 0.25rem 0.5rem;
  font-size: 12pt;
  width: fit-content;
  &:hover {
    text-decoration: underline;
  }
    &--action{
    align-self: flex-end;
    font-size: 10pt;
    background-color: rgba(124, 124, 124, 0.3);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 0.25rem;
    flex-grow: 0;
    &:hover {
      background-color: rgba(124, 124, 124, 0.1);
      text-decoration: none;
    }
  }

}
.action-button--search{
    font-size: 10pt;
    flex-grow: 0;
    flex-shrink: 0;
  }
.item-button--search{
  font-size: 11pt;
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


.sidebar__pane-search-container {
  justify-content: space-between;
  margin-bottom: 1rem;
}

.sidebar__pane-search-input {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid rgba(255, 255, 255, 0.2);
  background-color: rgba(0, 0, 0, 0.3);
  color: $font-crl-primary;

  &::placeholder {
    color: rgba(255, 255, 255, 0.5);
  }

  &:active,
  &:focus {
    outline: none;
    border: 1px solid rgba(255, 255, 255, 0.2);
  }
}

.sidebar__pane-search-result {
  color: $font-crl-primary;
  border: 1px solid rgba(255, 255, 255, 0.2);
  padding: 0.5rem;
}
</style>
