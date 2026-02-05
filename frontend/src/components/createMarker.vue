<template>
    <div class="custom__marker__container">
        <span class="custom__marker__container-coordinates">
            Coordinates: {{ coordinates }}
        </span>
        <span v-if="showWarningNoName" class="custom__marker-warning">
            <b>Please provide a location name</b>
        </span>
        <span v-if="showWarningNameExists" class="custom__marker-warning">
            <b>Location name already exists</b>
        </span>
        <span class="custom__marker-container-input-set">
            <label for="marker-label" class="custom__marker-container-input-label">Location name:</label>
            <input name="marker-label" type="text" class="custom__marker-container-input"
                placeholder="Enter location name" maxlength="50" v-model="customLocationName" />
        </span>



        <span class="custom__marker-container-input-set">
            <label for="marker-icon" class="custom__marker-container-input-label ">Location icon:</label>
            <input type="text" name="marker-icon" 
            class="custom__marker-container-input custom__marker-container-input-select" placeholder="Select location icon"
            @focus="iconsDropdownRef?.toggleIconsList(true)" @blur="handleInputBlur"
            v-model="customLocationIconName">  
            </input>
        </span>
        <iconsDropdown ref="iconsDropdownRef" @iconSelected="handleIconSelected" :searchQueryIcons="customLocationIconName" />


        <span class="custom__marker-container-input-set">
            <label for="marker-overlay" class="custom__marker-container-input-label">Overlay:</label>
            <input name="marker-overlay" type="text" class="custom__marker-container-input custom__marker-container-input-select"
                placeholder="Enter location overlay"
                @focus="overlaysDropdownRef?.toggleOverlaysList(true)" @blur="handleInputBlur"
                v-model="customLocationOverlay" />
        </span>
        <OverlaysDropdown ref="overlaysDropdownRef" @overlaySelected="handleOverlaySelected" :searchQueryOverlays="customLocationOverlay" />
        
        
        
        <span class="custom__marker-container-input-set">
            <label for="marker-description" class="custom__marker-container-input-label custom__marker-container-input-label--desc">Location description:</label>
            <textarea name="marker-description" type="text" class="custom__marker-container-input custom__marker-container-input--desc"
                placeholder="Enter location description"  v-model="customLocationDescription"></textarea>
        </span>

        <div class="custom__marker-button-container">
            <button class="custom__marker-button custom__marker-button--close " @click="$emit('closeMarkerCreationDialog')">Close</button>
            <button class="custom__marker-button" @click="$emit('closeCords')">Cancel creation</button>
            <button class="custom__marker-button" @click="createMarker()">Save marker</button>
        </div>
    </div>
</template>

<script setup>
import { ref, reactive, computed, watch, onMounted } from 'vue';
import { useMarkersDataStore } from '../stores/markersDataStore';
import { useIconsDataStore } from '../stores/iconsDataStore';
import { useOverlaysDataStore } from '../stores/overlaysDataStore';
import iconsDropdown from './iconsDropdown.vue'
import OverlaysDropdown from './overlaysDropdown.vue'
const markersDataStore = useMarkersDataStore();
const iconsDataStore = useIconsDataStore();
const overlaysDataStore = useOverlaysDataStore();


const customLocationName = ref('');
const customLocationDescription = ref('');
const customLocationIcon = ref('');
const customLocationIconName = ref('');
const customLocationOverlay = ref('');
const iconsDropdownRef = ref(null);
const overlaysDropdownRef = ref(null);
const showWarningNoName = ref(false);
const showWarningNameExists = ref(false);

onMounted(() => {
    if (iconsDataStore.selectedIcon) {
        customLocationIconName.value = iconsDataStore.selectedIcon.icon_name;
    }
    if (!overlaysDataStore.selectedOverlay) {
        overlaysDataStore.selectedOverlay = overlaysDataStore.defaultOverlay.overlay_name;
    }
});

watch(() => iconsDataStore.selectedIcon, (newIcon) => {
    if (newIcon) {
        customLocationIconName.value = newIcon.icon_name;
    }
});

watch(()=> overlaysDataStore.selectedOverlay, (newOverlay) => {
    if(newOverlay){
        customLocationOverlay.value = newOverlay.overlay_name;
    }
});

const handleInputBlur = () => {
    setTimeout(() => {
        iconsDropdownRef.value?.toggleIconsList(false);
        overlaysDropdownRef.value?.toggleOverlaysList(false);
    }, 200);
}

const emit = defineEmits(['closeCords', 'toggleIconsList', 'closeMarkerCreationDialog', 'markerCreated']);


function handleIconSelected(icon) {
    customLocationIcon.value = icon.icon_link;
    customLocationIconName.value = icon.icon_name;
}

function handleOverlaySelected(overlay) {
    customLocationOverlay.value = overlay.overlay_name;
}

const props = defineProps({
    lat: {
        type: String,
        required: true
    },
    lng: {
        type: String,
        required: true
    }
});

const coordinates = computed(() => `Lat: ${props.lat}, Lng: ${props.lng}`);

const createMarker = () => {

if(!customLocationName.value){
    showWarningNoName.value = true;
    return;
}else{
    showWarningNoName.value = false;
}
if(markersDataStore.checkMarkerNameExists(customLocationName.value)){
    showWarningNameExists.value = true;
    return;
}else{
    showWarningNameExists.value = false;
}

    const customMarker = {
        marker_name: customLocationName.value,
        marker_lat: props.lat,
        marker_lng: props.lng,
        marker_desc: customLocationDescription.value,
        icon_name: iconsDataStore.selectedIcon.icon_name,
        icon_link: iconsDataStore.selectedIcon.icon_link,
        marker_img: null,
        overlay_name: overlaysDataStore.selectedOverlay.overlay_name,
        note: null,
    };
    markersDataStore.createLocation(customMarker);
    emit('markerCreated', customMarker);
    customLocationName.value = '';
    customLocationDescription.value = '';
    iconsDataStore.selectedIcon = iconsDataStore.defaultIcon;
    overlaysDataStore.selectedOverlay = overlaysDataStore.defaultOverlay;
    iconsDropdownRef.value = null;
    emit('toggleIconsList');
}


</script>

<style lang="scss" scoped>
@use '@/scss/colors' as *;
@use '@/scss/mixins' as *;

.custom__marker__container {
    color: $font-crl-primary;
    bottom: 10%;
    right: 5%;
    position: absolute;
    @include flex-column(flex-start, stretch, 0.5rem);
    margin: 1rem 0rem;

    background-color: $custom-marker-bg-crl-primary;
    padding: 1rem;
    z-index: 1000;
    @include box-shadow-dialog;
}

.custom__marker-container-input-set {
    @include flex-row(flex-start, center, 0.25rem);
}


.custom__marker-button {
    width: fit-content;
    padding: 0.5rem 0.25rem;
    width: fit-content;
    font-size: 1rem;
    background-color: $create-marker-button-bg-crl;
    border: 1px solid $create-marker-input-border-crl;
    border-radius: 0.25rem;
    color: $font-crl-primary;
    cursor: pointer;

    &:hover {
        background-color: $create-marker-button-hover-crl;
    }

    &-container {
        @include flex-row(flex-end, center, 0.5rem);
    }
}


.custom__marker-container-input {
    flex-grow: 1;
    padding: 0.25rem 0.5rem;
    border: none;
    border-bottom: 1px solid $create-marker-border-light-crl;
    background-color: $create-marker-input-bg-crl;
    color: $font-crl-primary;

    &::placeholder {
        color: $create-marker-placeholder-crl;
    }

    &:focus {
        outline: none;
        border-bottom: 1px solid $create-marker-input-focus-border-crl;
    }

    &-label{
        width: min-content;
        padding-right: 1rem;
        height: fit-content;

        &--desc{
            padding-right: 0rem;
        }
    }

    &--desc{
        max-width: 19rem;
        max-height: 19rem;
        min-height: 5rem;
        min-width: 12.5rem;
    }
}

.custom__marker-container-input-select{
    cursor: pointer;
    text-align: left;
    display: block;
}

.custom__marker-button-container{
    margin-top: 0.5rem;
}

.custom__marker-warning{
    color: rgb(176, 255, 29);
    font-size: 1rem;
}

</style>