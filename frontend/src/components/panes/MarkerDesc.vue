<template>

        <div class="sidebar__pane">
          <div class="sidebar__pane-header sidebar__pane-header--desc">
            <h1 class="sidebar__pane-title">{{ locationName }}</h1>
          </div>
          <div class="sidebar__pane-body sidebar__pane-body-container">
            <img class="sidebar__pane-img" alt="" :src="markersDataStore.targetMarker?.marker_img">
           <div class="marker-description" v-html="locationDesc"></div>
          </div>
        </div>

</template>

<script setup>
import { computed } from 'vue';
import { useMarkersDataStore } from '../../stores/markersDataStore';
import { storeToRefs } from 'pinia';
import MarkdownIt from 'markdown-it';
import DOMPurify from 'dompurify';
const markersDataStore = useMarkersDataStore();
const { markers } = storeToRefs(markersDataStore);
const md = new MarkdownIt();






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
  const markdown = markersDataStore.targetMarker?.marker_desc;
  if (!markdown || typeof markdown !== 'string' || markdown.trim() === '') {
    return 'No description available';
  }
  const html = md.render(markdown);
  const sanitized = DOMPurify.sanitize(html);
  return sanitized;
});



</script>

<style lang="scss" scoped>

.sidebar__pane-desc-buttons {
  width: 100%;
  display: flex;
  justify-content: flex-end;
  // margin-top: 1rem;
}

.sidebar__pane-body-container {
    // margin-top: 3.5rem;
}

.sidebar__pane-header--desc{
  
  margin-top: 1rem;
}

.button-desc{
  font-size: 1rem;
}

</style>