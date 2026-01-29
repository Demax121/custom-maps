<template>

        <div class="sidebar__pane">
          <div class="sidebar__pane-header">
            <h1 class="sidebar__pane-title">{{ locationName }}</h1>
            <span class="sidebar__pane-close"></span>
          </div>
          <div class="sidebar__pane-body">
            <img class="sidebar__pane-img" alt="" :src="markersDataStore.targetMarker?.marker_img">
            <p>{{ locationDesc }}</p>
          </div>
        </div>

</template>

<script setup>
import { computed } from 'vue';
import { useMarkersDataStore } from '../../stores/markersDataStore';
const markersDataStore = useMarkersDataStore();

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

</style>