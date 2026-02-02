<template>
  <div class="sidebar__pane">
    <div class="sidebar__pane-header">
      <h1 class="sidebar__pane-title">Marker List</h1>
    </div>
    <div class="sidebar__pane-body">
      <div class="sidebar__pane-search-container">
        <input type="text" v-model="searchQuery" class="sidebar__pane-search-input"
          placeholder="Search markers..."
          @input="showResult = true" ></input>
        <div class="sidebar__pane-search-result" v-show="showResult && searchQuery">
          <ul class="sidebar__overlay-list ">
            <template v-for="marker in filteredMarkers" :key="marker.marker_name">
              <li class="sidebar__overlay-list-item">
                <button class="sidebar__overlay-item-button item-button--search" @click="focusOnMarker(marker.marker_name);
                openMarkerDescription(marker.marker_name);">
                  {{ marker.marker_name }}
                </button>
                <span class="sidebar__overlay-item-buttons-group">
                <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action action-button--search add-bookmark-button"  
                @click="saveMarker(marker.marker_name)"
                v-show="!isLocationSaved(marker.marker_name)">
                </button>
                <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action action-button--search remove-bookmark-button"
                @click="removeSavedMarker(marker.marker_name)" title="Remove location from list"
                v-show="isLocationSaved(marker.marker_name)">
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
                <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action add-bookmark-button" 
                @click="saveMarker(marker.marker_name)"
                v-show="!isLocationSaved(marker.marker_name)">
                </button>
                <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action remove-bookmark-button"
                @click="removeSavedMarker(marker.marker_name)" title="Remove location from list"
                v-show="isLocationSaved(marker.marker_name)">
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
import { usePaneNavigation } from '../../composables/usePaneNavigation';

const emit = defineEmits(['changePane']);
const { navigateToPane } = usePaneNavigation(emit);

const overlaysDataStore = useOverlaysDataStore();
const markersDataStore = useMarkersDataStore();
const { overlays } = storeToRefs(overlaysDataStore);
const { markers } = storeToRefs(markersDataStore);

const openOverlays = reactive({});
const searchQuery = ref('');
const showResult = ref(false);

const isLocationSaved = (markerName) => {
  return markersDataStore.savedMarkers.some(m => m.marker_name === markerName);
};

const filteredMarkers = computed(() => {
  if (!searchQuery.value) return [];
  const query = searchQuery.value.toLowerCase();
  return markers.value.filter(marker => 
    marker.marker_name.toLowerCase().includes(query)
  );
});

const activeColor = reactive({
  backgroundColor: '$marker-list-active-bg-crl'
});

const toggleOverlay = (overlayId) => {
  openOverlays[overlayId] = !openOverlays[overlayId];
};

const focusOnMarker = (markerName) => {
  markersDataStore.focusMarker(markerName);
};

const openMarkerDescription = (markerName) => {
markersDataStore.selectedMarker(markerName);
navigateToPane('MarkerDesc');
};

const saveMarker = (markerName) => {
  markersDataStore.saveMarker(markerName);
};

const removeSavedMarker = (markerName) => {
  markersDataStore.removeSavedMarker(markerName);
  markersDataStore.targetMarker = null;
};


</script>

<style lang="scss" scoped>
@use '@/scss/colors.scss' as *;
@use '@/scss/mixins.scss' as *;

.sidebar__overlay {
  width: 100%;
  margin-bottom: 1rem;
}

.sidebar__overlay-list {
  @include list-reset;
  padding: 0.5rem;
  background-color: $marker-list-overlay-bg-crl;
  border-bottom: 2px solid $marker-list-border-heavy-crl;
}


.sidebar__overlay-list-item {
  padding: 0.5rem 0rem 0 0.5rem;
  border-bottom: 1px solid $marker-list-border-light-crl;
  @include flex-row(space-between, flex-start);
    

  &:last-child {
    border-bottom: none;
  }

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


.sidebar__pane-search-container {
  @include grid-row(1fr, 1fr, 0);
  margin-bottom: 1rem;

}

.sidebar__pane-search-input {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid $marker-list-input-border-crl;
  background-color: $marker-list-input-bg-crl;
  color: $font-crl-primary;
  display: block;
  max-height: fit-content;

  &::placeholder {
    color: $marker-list-placeholder-crl;
  }

  &:active,
  &:focus {
    outline: none;
    border: 1px solid $marker-list-input-border-crl;
  }
}

.sidebar__pane-search-result {
  color: $font-crl-primary;
  border: 1px solid $marker-list-input-border-crl;
  max-height: 15rem;
  overflow-y: auto;
  padding-right: 0.5rem;
  width: 100%;
  flex-shrink: 0;
  flex-grow: 0;
}

.item-button--search{
  font-size: 0.9rem;
}

.action-button--search{
  font-size: 0.8rem;
}




@include respond-to-mobile{


.item-button--search{
  font-size: 0.8rem;


}
}.action-button--search{
  font-size: 0.7rem;
}



</style>
