<template>

        <div class="sidebar__pane">
          <div class="sidebar__pane-header">
            <h1 class="sidebar__pane-title">{{ markersDataStore.targetMarker?.marker_name }}</h1>
            <span class="sidebar__pane-close"></span>
          </div>
          <div class="sidebar__pane-body">
            <img class="sidebar__pane-img" alt="" :src="markersDataStore.targetMarker?.marker_img">
            <p>{{ markersDataStore.targetMarker?.marker_desc }}</p>
          </div>
        </div>

</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useMarkersDataStore } from '../../stores/markersDataStore';
const markersDataStore = useMarkersDataStore();


</script>

<style lang="scss" scoped>

</style>