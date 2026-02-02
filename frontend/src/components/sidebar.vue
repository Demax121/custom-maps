<template>
  <div id="sidebar" class="sidebar">
    <!-- Nav tabs -->
    <div class="sidebar__tabs">
      <ul role="tablist" class="sidebar__tab-list">
        <li class="sidebar__tab-item">
          <button class="sidebar__btn sidebar__btn--map-desc" :class="{ 'sidebar__btn--active': activePane === 'MapDesc' && isVisible }"
            @click="togglePane('MapDesc')">
          </button>
        </li>
        <li class="sidebar__tab-item">
          <button class="sidebar__btn sidebar__btn--marker-list" :class="{ 'sidebar__btn--active': activePane === 'MarkerList' && isVisible }"
            @click="togglePane('MarkerList')" >
          </button>
        </li>
        <li class="sidebar__tab-item">
          <button class="sidebar__btn sidebar__btn--marker-desc" :class="{ 'sidebar__btn--active': activePane === 'MarkerDesc' && isVisible }"
            @click="togglePane('MarkerDesc')">
          </button>
        </li>
        <li class="sidebar__tab-item">
          <button class="sidebar__btn sidebar__btn--saved-locations" :class="{ 'sidebar__btn--active': activePane === 'SavedLocations' && isVisible }"
            @click="togglePane('SavedLocations')">
          </button>
        </li>
         <li class="sidebar__tab-item">
          <button class="sidebar__btn sidebar__btn--settings-pane" :class="{ 'sidebar__btn--active': activePane === 'SettingsPane' && isVisible }"
            @click="togglePane('SettingsPane')">->
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
@use '@/scss/mixins.scss' as *;

$sidebar-sizing-desktop: 3rem;
$sidebar-sizing-mobile: 2.25rem;
$transition-speed: 0.5s;

$sidebar-position-1200: 470px;
$sidebar-position-992: 400px;
$sidebar-position-768: 315px;

$sidebar-width-1200: 400px;
$sidebar-width-992: 390px;
$sidebar-width-768: 305px;

$sidebar-button-size-desktop: 3rem;
$sidebar-button-size-mobile: 2.25rem;

$content-width-1200: 470px;
$content-width-992: 350px;
$content-width-768: 265px;
$content-margin-desktop: 3rem;
$content-margin-mobile: 2.25rem;
$content-width-mobile: calc(100dvw - #{$content-margin-mobile});


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
    background-size: 70%;
    background-repeat: no-repeat;
    background-position: center;


    &--map-desc{
      background-image: url('/assets/bars-icon.svg');
    }
    &--marker-list{
      background-image: url('/assets/map-icon.svg');
    }

    &--marker-desc{
      background-image: url('/assets/marker-icon.svg');
    }
    &--saved-locations{
      background-image: url('/assets/list-icon.svg');
    }
    &--settings-pane{
      background-image: url('/assets/settings-icon.svg');
    }


    &:hover {
      background-color: $active-hover-crl;
    }

    &--active {
      background-color: $active-hover-crl;
      border-left: 3px solid $font-crl-primary;
    }
    &--disabled {
      cursor: not-allowed;
      opacity: 0.5;
    }

  }

  &__tabs {
    display: grid;
    grid-template-rows: auto;
    align-content: space-between;
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
  @include transition-slide-horizontal($transition-speed);
}

.slide-enter-from {
  @include slide-horizontal-enter;
}

.slide-leave-to {
  @include slide-horizontal-enter;
}



@include respond-to-mobile{
  .sidebar{

      &__btn {
      width: $sidebar-button-size-mobile;
      height: $sidebar-button-size-mobile;
    }

    &__content{
      left: $content-margin-mobile;
      width: $content-width-mobile;
    }
  }
}


@include respond-to-tablet {
  .sidebar {
    top: 0;
    bottom: 0;
  }
}

@include respond-to-tablet-only {
  .sidebar {
    width: $sidebar-width-768;
  }
}

@include respond-to-desktop-small {
  .sidebar {
    width: $sidebar-width-992;
  }

}

@include respond-to-desktop {
  .sidebar {
    top: 0;
    bottom: 0;
    max-width: $sidebar-sizing-desktop;
    width: $sidebar-sizing-desktop;

    &__content{
      left: $sidebar-sizing-desktop;
      width: $content-width-1200;
      left: $content-margin-desktop;
    }

    &__btn {
      width: $sidebar-button-size-desktop;
      height: $sidebar-button-size-desktop;
    }

  }
}
</style>