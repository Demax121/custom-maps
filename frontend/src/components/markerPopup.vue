<template>
    <div class="custom__marker__popup">
        <div class="custom__marker__popup-content">
            <h3 class="custom__marker__popup-title">This is custom</h3>
            <div class="custom__marker__popup-coords">
                Latitude: {{ props.latitude }}, Longitude: {{ props.longitude }}
            </div>
    </div>
    </div>
</template>

<script setup>

const props = defineProps({
    latitude: {
        type: String,
        required: true,
    },
    longitude: {
        type: String,
        required: true,
    },
});

</script>

<style lang="scss" scoped>

</style>