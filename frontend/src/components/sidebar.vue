<template>
  <div id="sidebar" class="sidebar">
    <!-- Nav tabs -->
    <div class="sidebar__tabs">
      <ul role="tablist" class="sidebar__tab-list">
        <li class="sidebar__tab-item">
          <button class="sidebar__btn" :class="{ 'sidebar__btn--active': activePane === 'MapDesc' && isVisible }"
            @click="togglePane('MapDesc')">
            <img class="sidebar__btn-img" src="/assets/bars-icon.svg" alt="menu"></img>
          </button>
        </li>
        <li class="sidebar__tab-item">
          <button class="sidebar__btn" :class="{ 'sidebar__btn--active': activePane === 'MarkerList' && isVisible }"
            @click="togglePane('MarkerList')">
            <img class="sidebar__btn-img" src="/assets/map-icon.svg" alt="map"></img>
          </button>
        </li>
        <li class="sidebar__tab-item">
          <button class="sidebar__btn" :class="{ 'sidebar__btn--active': activePane === 'MarkerDesc' && isVisible }"
            @click="togglePane('MarkerDesc')">
            <img class="sidebar__btn-img" src="/assets/marker-icon.svg" alt="marker"></img>
          </button>
        </li>
        <li class="sidebar__tab-item">
          <button class="sidebar__btn" :class="{ 'sidebar__btn--active': activePane === 'SavedLocations' && isVisible }"
            @click="togglePane('SavedLocations')">
            <img class="sidebar__btn-img" src="/assets/list-icon.svg" alt="list"></img>
          </button>
        </li>
      </ul>
    </div>
    <!-- Tab panes -->

    <Transition name="slide">
      <div class="sidebar__content" v-show="isVisible">
        <div class="sidebar__content-header">
          <button class="sidebar__content-close" @click="togglePane(activePane)">
            <img src="/assets/close-icon.svg" alt="Close">
          </button>
        </div>
        <slot />
      </div>
    </Transition>


  </div>
</template>

<script setup>

import { ref, computed, defineProps } from 'vue';

const isVisible = ref(true)

const emit = defineEmits(['changePane']);

const props = defineProps({
  activePane: { type: String, default: 'MapDesc' }
});

const togglePane = (pane) => {
  if (props.activePane === pane && isVisible.value) {
    isVisible.value = false;
  } else {
    isVisible.value = true;
    emit('changePane', pane);
  }
};



</script>

<style lang="scss" scoped>
@use '@/scss/colors.scss' as *;

$sidebar-sizing-desktop: 3rem;
$sidebar-sizing-mobile: 2rem;
$transition-speed: 0.5s;

$sidebar-position-1200: 470px;
$sidebar-position-992: 400px;
$sidebar-position-768: 315px;

$sidebar-width-1200: 530px;
$sidebar-width-992: 390px;
$sidebar-width-768: 305px;




.sidebar {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  z-index: 2000;
  box-shadow: 0 1px 5px $box-shadow-sidebar;
  background-color: $sidebar-bg-crl-primary;
  padding: 2rem 0rem;
  color: $font-crl-primary;


  &__btn {
    cursor: pointer;
    background: none;
    border: none;
    padding: 0.25rem;
    margin-bottom: 1rem;


    &:hover {
      background-color: $active-hover-crl;
    }

    &--active {
      background-color: $active-hover-crl;
      border-left: 3px solid $font-crl-primary;
    }

  }

  &__tabs {
    display: flex;
    justify-content: space-between;
    align-items: center;

  }

  &__content {
    position: absolute;
    top: 0;
    bottom: 0;
    background-color: $sidebar-pane-crl-primary;
    overflow-x: hidden;
    overflow-y: hidden;

    &-close{
      max-width: 2.5rem;
      background: none;
      border: none;
      cursor: pointer;
      &:hover{
        opacity: 0.7;
      }
    }
    &-header{
      display: flex;
      justify-content: flex-end;
  }
  }
}

// Transition classes
.slide-enter-active,
.slide-leave-active {
  transition: transform $transition-speed ease, opacity $transition-speed ease;
}

.slide-enter-from {
  transform: translateX(-100%);
  opacity: 0;
}

.slide-leave-to {
  transform: translateX(-100%);
  opacity: 0;
}




@media (min-width: 768px) {
  .sidebar {
    top: 0;
    bottom: 0;
  }
}

@media (min-width: 768px) and (max-width: 991px) {
  .sidebar {
    width: $sidebar-width-768;
  }
}

@media (min-width: 992px) and (max-width: 1199px) {
  .sidebar {
    width: $sidebar-width-992;
  }

}

@media (min-width: 1200px) {
  .sidebar {
    top: 0;
    bottom: 0;
    max-width: $sidebar-sizing-desktop;

    &__pane {
      min-width: $pane-width-1200;
    }

    &__content{
      left: $sidebar-sizing-desktop;
    }
  }
}
</style>