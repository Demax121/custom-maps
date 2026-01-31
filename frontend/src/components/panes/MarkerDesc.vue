<template>

        <div class="sidebar__pane">
          <div class="sidebar__pane-header sidebar__pane-header--desc">
            <h1 class="sidebar__pane-title">{{ locationName }}</h1>
            <div class="sidebar__pane-desc-buttons">
            <span class="sidebar__overlay-item-buttons-group sidebar__overlay-item-buttons-group--desc">
                <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action button-desc" 
                @click="saveMarker(locationName)"
                v-show="!isLocationSaved(locationName)">
                  Save Location
                </button>
                <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action button-desc"
                @click="removeSavedMarker(locationName)" title="Remove location from list"
                v-show="isLocationSaved(locationName)">
                Remove Saved
              </button>
            </span>
            </div>
          </div>
          <div class="sidebar__pane-body sidebar__pane-body--desc">
            <img class="sidebar__pane-img" alt="" :src="markersDataStore.targetMarker?.marker_img">
            <p>{{ locationDesc }}</p>
          </div>
        </div>

</template>

<script setup>
import { computed } from 'vue';
import { useMarkersDataStore } from '../../stores/markersDataStore';
import { storeToRefs } from 'pinia';
const markersDataStore = useMarkersDataStore();
const { markers } = storeToRefs(markersDataStore);



const isLocationSaved = (markerName) => {
  return markersDataStore.savedMarkers.some(m => m.marker_name === markerName);
};


const removeSavedMarker = (markerName) => {
  markersDataStore.removeSavedMarker(markerName);
  const marker = markers.value.find(m => m.marker_name === markerName);
  if (!marker) {
    markersDataStore.targetMarker = null;
  }

};

const saveMarker = (markerName) => {
  markersDataStore.saveMarker(markerName);
};


const locationName = computed(() => {
  return markersDataStore.targetMarker?.marker_name || 'Select a marker to see its name';
});

const locationDesc = computed(() => {
  if (!markersDataStore.targetMarker) {
    return 'Select a marker to see its description';
  }
  const desc = markersDataStore.targetMarker.marker_desc;
  return (desc && desc.trim() !== '') ? desc : 'No description available';
});




</script>

<style lang="scss" scoped>

.sidebar__pane-desc-buttons {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  margin-top: 1rem;
}

.sidebar__pane-body--desc {
    margin-top: 3.5rem;
}

.sidebar__pane-header--desc{
  
  margin-top: 1rem;
}

.button-desc{
  font-size: 1rem;
}

</style>