<template>
    <div class="dropdown__container">
        <ul class="dropdown__combobox" v-show="overlaysListVisible">
            <li class="dropdown__combobox-item" v-for="overlay in filteredOverlays" :key="overlay.overlay_name" @click="selectOverlay(overlay)">
                {{ overlay.overlay_name }}
            </li>
        </ul>

    </div>
</template>

<script setup>
import { ref, reactive, computed } from 'vue';
import { useOverlaysDataStore } from '../stores/overlaysDataStore';
const overlaysDataStore = useOverlaysDataStore();
import { storeToRefs } from 'pinia';
const { overlays } = storeToRefs(overlaysDataStore);

const props = defineProps({
    searchQueryOverlays: {
        type: String,
        default: ''
    }
});

const emit = defineEmits(['toggleOverlaysList', 'overlaySelected',]);
defineExpose({ toggleOverlaysList });

const overlaysListVisible = ref(false);
const selectedOverlay = ref(null);
const filteredOverlays = computed(() => {
    if (!props.searchQueryOverlays) return overlays.value;
    const query = props.searchQueryOverlays.toLowerCase();
    return overlays.value.filter(overlay => overlay.overlay_name.toLowerCase().includes(query));
});


function toggleOverlaysList(force) {
    if (typeof force === 'boolean') {
        overlaysListVisible.value = force;
    } else {
        overlaysListVisible.value = !overlaysListVisible.value;
    }
}

function selectOverlay(overlay) {
    overlaysDataStore.setSelectedOverlay(overlay);
    selectedOverlay.value = overlay;
    emit('overlaySelected', selectedOverlay.value);
    toggleOverlaysList(false);
}


</script>

<style lang="scss" scoped>
</style>