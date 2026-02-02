<template>

        <div class="sidebar__pane">
          <div class="sidebar__pane-header sidebar__pane-header--desc">
            <h1 class="sidebar__pane-title">{{ locationName }}</h1>
            <span class="sidebar__overlay-item-buttons-group sidebar__overlay-item-buttons-group--desc" v-show="markersDataStore.targetMarker !== null">
              <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action button-desc add-bookmark-button" 
                @click="saveMarker(locationName)"
                v-show="!isLocationSaved(locationName)">
                </button>
                <button class="sidebar__overlay-item-button sidebar__overlay-item-button--action button-desc remove-bookmark-button" 
                @click="removeSavedMarker(locationName)" title="Remove location from list"
                v-show="isLocationSaved(locationName)">
              </button>
            </span>
          </div>
           <!-- <div class="sidebar__pane-desc-buttons">
            
            </div> -->
          <div class="sidebar__pane-body sidebar__pane-body--desc">
            <img class="sidebar__pane-img" alt="" :src="markersDataStore.targetMarker?.marker_img"></img>
            <div class="sidebar__pane-body-container">
           <div class="sidebar__pane-body-description" v-html="locationDesc"></div>
           </div>
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
const md = new MarkdownIt({
  linkify: true,
  typographer: true
})






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
@use '@/scss/_markdown.scss';


.sidebar__pane-desc-buttons {
  width: 100%;
  display: flex;
  justify-content: flex-end;
}

.sidebar__pane-header--desc{
  margin-top: 1rem;
  display: flex;
}

.button-desc{
  margin-top: 0.5rem;
}


.sidebar__pane-body--desc{
  padding-top: 0rem;
}

.sidebar__pane-body-description{
  padding-bottom: 1.25rem;
}

.sidebar__overlay-item-buttons-group--desc{
  display: inline-block;
}


</style>