<template>
    <div class="dropdown__container">
        <ul class="dropdown__combobox" v-show="listIsVisible">
            <li class="dropdown__combobox-item" v-for="item in items" :key="item.value" @click="selectItem(item)">
                {{ item.text }}
            </li>
        </ul>

    </div>
</template>

<script setup>
import { ref, reactive } from 'vue';

const listIsVisible = ref(false);
const selectedItem = ref(null);



function toggleListVisibility() {
    listIsVisible.value = !listIsVisible.value;
}

function selectItem(item) {
    emit('itemSelected', item);
    toggleListVisibility();
}

defineExpose({ toggleListVisibility });

const emit = defineEmits(['toggleListVisibility', 'itemSelected']);

let items = [
    { value: 'leaf-green.png', text: 'Leaf green' },
    { value: 'leaf-red.png', text: 'Leaf red' },
    { value: 'leaf-orange.png', text: 'Leaf orange' },
];


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