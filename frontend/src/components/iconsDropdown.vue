<template>
    <div class="dropdown__container">
        <ul class="dropdown__combobox" v-show="iconListVisible">
            <li class="dropdown__combobox-item" v-for="icon in filteredIcons" :key="icon.icon_name" @click="selectIcon(icon)">
                {{ icon.icon_name }}
            </li>
        </ul>

    </div>
</template>

<script setup>
import { ref, reactive, computed } from 'vue';
import { useIconsDataStore } from '../stores/iconsDataStore';
const iconsDataStore = useIconsDataStore();
import { storeToRefs } from 'pinia';
const { icons } = storeToRefs(iconsDataStore);

const props = defineProps({
    searchQueryIcons: {
        type: String,
        default: ''
    }
});

const emit = defineEmits(['toggleIconsList', 'iconSelected',]);
defineExpose({ toggleIconsList });

const iconListVisible = ref(false);
const selectedIcon = ref(null);

const filteredIcons = computed(() => {
    if (!props.searchQueryIcons) return icons.value;
    const query = props.searchQueryIcons.toLowerCase();
    return icons.value.filter(icon => icon.icon_name.toLowerCase().includes(query));
});


function toggleIconsList(force) {
    if (typeof force === 'boolean') {
        iconListVisible.value = force;
    } else {
        iconListVisible.value = !iconListVisible.value;
    }
}

function selectIcon(icon) {
    iconsDataStore.setSelectedIcon(icon);
    selectedIcon.value = icon;
    emit('iconSelected', selectedIcon.value);
    toggleIconsList(false);
}


</script>

<style lang="scss" scoped>
</style>