<template>
    <div class="custom__marker__container">
        <span class="custom__marker__container-coordinates">
            Coordinates: {{ coordinates }}
        </span>
        <span class="custom__marker-container-input-set">
            <label for="marker-label" class="custom__marker-container-input-label">Location name:</label>
            <input name="marker-label" type="text" class="custom__marker-container-input"
                placeholder="Enter location name" maxlength="50" v-model="customLocationName" />
        </span>
        <span class="custom__marker-container-input-set">
            <label for="marker-icon" class="custom__marker-container-input-label ">Location icon:</label>
            <button name="marker-icon" type="text" 
            class="custom__marker-container-input custom__marker-container-input-select"
            @click="dropdownRef?.toggleListVisibility()">
                <span v-if="!customLocationIcon">Select marker icon</span>
                <span v-else>{{ customLocationIconName }}</span>
            </button>
            
        </span>
        <Dropdown ref="dropdownRef" @itemSelected="handleItemSelected" />
        <span class="custom__marker-container-input-set">
            <label for="marker-img" class="custom__marker-container-input-label">Location img:</label>
            <input name="marker-img" type="text" class="custom__marker-container-input"
                placeholder="Enter location img link" v-model="customLocationImg" />
        </span>
        <span class="custom__marker-container-input-set">
            <label for="marker-description" class="custom__marker-container-input-label custom__marker-container-input-label--desc">Location description:</label>
            <textarea name="marker-description" type="text" class="custom__marker-container-input custom__marker-container-input--desc"
                placeholder="Enter location description"  v-model="customLocationDescription"></textarea>
        </span>

        <div class="custom__marker-button-container">
            <button class="custom__marker-button" @click="$emit('closeCords')">Close</button>
            <button class="custom__marker-button" @click="createMarker()">Save marker</button>
        </div>

    </div>
</template>

<script setup>
import { ref, reactive, computed } from 'vue';
import { useMarkersDataStore } from '../stores/markersDataStore';
import Dropdown from './Dropdown.vue'
const markersDataStore = useMarkersDataStore();

const customLocationName = ref('');
const customLocationDescription = ref('');
const customLocationIcon = ref('');
const customLocationIconName = ref('');
const customLocationImg = ref('');
const dropdownRef = ref(null);

const emit = defineEmits(['closeCords', 'toggleListVisibility']);


function handleItemSelected(item) {
    customLocationIcon.value = item.value;
    customLocationIconName.value = item.text;
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
    const customMarker = {
        marker_name: customLocationName.value,
        marker_lat: props.lat,
        marker_lng: props.lng,
        marker_desc: customLocationDescription.value,
        marker_icon: customLocationIcon.value,
        marker_img: customLocationImg.value,
        overlay_name: "Custom markers",
        note: null,
    };
    
    markersDataStore.createLocation(customMarker);
    customLocationName.value = '';
    customLocationDescription.value = '';
    customLocationIcon.value = '';
    customLocationIconName.value = '';
    customLocationImg.value = '';
    dropdownRef.value = null;
    emit('toggleListVisibility');
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
    color: $create-marker-placeholder-crl;
    display: block;
}

</style>