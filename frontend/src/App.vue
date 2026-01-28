<script setup>
import MapViewer from './components/mapViewer.vue'
import Sidebar from './components/sidebar.vue'
import MapDesc from './components/panes/MapDesc.vue'
import MarkerDesc from './components/panes/MarkerDesc.vue'
import MarkerList from './components/panes/MarkerList.vue'
import SavedLocations from './components/panes/SavedLocations.vue'

import { ref, onMounted } from 'vue'
import { useMapDataStore } from './stores/mapDataStore'
import { useOverlaysDataStore } from './stores/overlaysDataStore'
import { useMarkersDataStore } from './stores/markersDataStore'

const currentPane = ref('MapDesc');
const panes = {
    MapDesc,
    MarkerDesc,
    MarkerList,
    SavedLocations
};

const handlePaneChange = (paneName) => {
    currentPane.value = paneName;
};

const mapDataStore = useMapDataStore();
const overlaysDataStore = useOverlaysDataStore();
const markersDataStore = useMarkersDataStore();
onMounted(async () => {
    await mapDataStore.getMapData();
    await overlaysDataStore.getOverlaysData();
    await markersDataStore.getMarkersData();
});

</script>

<template>
    <MapViewer />
    <Sidebar :activePane="currentPane" @changePane="handlePaneChange">

        <KeepAlive>
            <component :is="panes[currentPane]" />
        </KeepAlive>


    </Sidebar>
</template>

<style lang="scss"></style>
