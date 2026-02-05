<template>
    <div class="dropdown__container">
        <ul class="dropdown__combobox" v-show="listIsVisible">
            <li class="dropdown__combobox-item" v-for="icon in filteredIcons" :key="icon.icon_name" @click="selectItem(icon)">
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
    searchQuery: {
        type: String,
        default: ''
    }
});

const emit = defineEmits(['toggleListVisibility', 'itemSelected',]);
defineExpose({ toggleListVisibility });

const listIsVisible = ref(false);
const selectedItem = ref(null);

const filteredIcons = computed(() => {
    if (!props.searchQuery) return icons.value;
    const query = props.searchQuery.toLowerCase();
    return icons.value.filter(icon => icon.icon_name.toLowerCase().includes(query));
});


function toggleListVisibility(force) {
    if (typeof force === 'boolean') {
        listIsVisible.value = force;
    } else {
        listIsVisible.value = !listIsVisible.value;
    }
}

function selectItem(item) {
    iconsDataStore.setSelectedIcon(item);
    selectedItem.value = item;
    emit('itemSelected', selectedItem.value);
    toggleListVisibility(false);
}







</script>

<style lang="scss" scoped>
@use '@/scss/colors' as *;

.dropdown {
    &__container {

        position: relative;
        color: $font-crl-primary;
        margin-left: 5rem;
        

    }

    &__combobox {
        list-style: none;
        overflow-y: auto;
        background-color: $create-marker-dropdown-bg-crl;
        
        width: 100%;
        max-height: 6rem;

        &-item {
            text-align: left;
            width: 100%;
            &:hover{
                
                background-color: $create-marker-dropdown-hover-crl;
                cursor: pointer;
            }
        }
    }
}




</style>