<template>
        <div class="sidebar__pane">
          <div class="sidebar__pane-header">
            <h1 class="sidebar__pane-title">{{ mapDataStore.mapName }}</h1>
          </div>
          <div class="sidebar__pane-body">
            <img class="sidebar__pane-img" :src="mapDataStore.mapImg" alt="">
            <p>{{ mapDataStore.mapDescription }}</p>
          </div>
        </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useMapDataStore } from '../../stores/mapDataStore';
const mapDataStore = useMapDataStore();


</script>

<style lang="scss" scoped>




</style>