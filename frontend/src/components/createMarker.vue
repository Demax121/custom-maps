<template>
    <div class="custom__marker__container">
        <span class="custom__marker__container-coordinates">
            Coordinates: {{ coordinates }}
        </span>
        <span class="custom__marker-container-input-set">
            <label for="marker-label" class="custom__marker-container-input-label">Location name:</label>
            <input name="marker-label" type="text" class="custom__marker-container-input"
                placeholder="Enter location name" maxlength="50" 
                v-model="customLocationName"
                />
        </span>

        <div class="custom__marker-button-container">
            <button class="custom__marker-button" @click="$emit('closeCords')">Close</button>
            <button class="custom__marker-button" @click="saveMarker">Save marker</button>
        </div>

    </div>
</template>

<script setup>
import { ref, reactive } from 'vue';
import { useMarkersDataStore } from '../stores/markersDataStore';
const markersDataStore = useMarkersDataStore();

const emit = defineEmits(['closeCords']);

const props = defineProps({
    coordinates: {
        type: String,
        required: true
    }
});


</script>

<style lang="scss" scoped>
$box-shadow-custom-marker: 0px 17px 49px 13px rgba(5, 5, 5, 1);

.custom__marker__container {
    color: $font-crl-primary;
    bottom: 10%;
    right: 5%;
    position: absolute;
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    margin: 1rem 0rem;

    background-color: $custom-marker-bg-crl-primary;
    padding: 1rem;
    z-index: 1000;
    -webkit-box-shadow: $box-shadow-custom-marker;
    -moz-box-shadow: $box-shadow-custom-marker;
    box-shadow: $box-shadow-custom-marker;
}

.custom__marker-container-input-set {
    display: flex;
    flex-direction: row;
    gap: 0.25rem;
}


.custom__marker-button {
    width: fit-content;
    padding: 0.5rem 0.25rem;
    width: fit-content;
    font-size: 1rem;
    background-color: rgba(124, 124, 124, 0.3);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 0.25rem;
    color: $font-crl-primary;
    cursor: pointer;

    &:hover {
        background-color: rgba(124, 124, 124, 0.5);
    }

    &-container {
        display: flex;
        gap: 0.5rem;
        justify-content: flex-end;
    }
}


.custom__marker-container-input {
    flex-grow: 1;
    padding: 0.25rem 0.5rem;
    border: none;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    background-color: rgba(0, 0, 0, 0.3);
    color: $font-crl-primary;

    &::placeholder {
        color: rgba(255, 255, 255, 0.5);
    }
    &:focus{
        outline: none;
        border-bottom: 1px solid rgba(255, 255, 255, 0.5);
    }
}
</style>