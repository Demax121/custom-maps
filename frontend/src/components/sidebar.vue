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
            <!-- <img src="/assets/icons/close-icon.svg" alt="Close"> -->
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
@use '@/scss/fonts.scss' as *;

$transition-speed: 0.5s;
$sidebar-sizing-desktop: 3rem;
$sidebar-sizing-desktop-small: 3rem;
$sidebar-sizing-desktop-large: 4.25rem;
$sidebar-sizing-mobile: 2.25rem;
$sidebar-sizing-tablet: 2.25rem;

$sidebar-button-size-desktop: 3rem;
$sidebar-button-size-desktop-small: 3rem;
$sidebar-button-size-desktop-large: 4.25rem;
$sidebar-button-size-mobile: 2.25rem;
$sidebar-button-size-tablet: 2.25rem;

$content-margin-desktop: 3rem;
$content-margin-desktop-small: 3rem;
$content-margin-desktop-large: 4.25rem;
$content-margin-mobile: 2.25rem;
$content-margin-tablet: 2.25rem;

$content-width-desktop: 26dvw;
$content-width-desktop-small: 420px;
$content-width-desktop-large: 32dvw;
$content-width-mobile: calc(100dvw - #{$content-margin-mobile});
$content-width-tablet: calc(100dvw - #{$content-margin-tablet});




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
  font-family: 'Cormorant Garamond';

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
      background-image: url('/assets/icons/bars-icon.svg');
    }
    &--marker-list{
      background-image: url('/assets/icons/map-icon.svg');
    }

    &--marker-desc{
      background-image: url('/assets/icons/marker-icon.svg');
    }
    &--saved-locations{
      background-image: url('/assets/icons/list-icon.svg');
    }
    &--settings-pane{
      background-image: url('/assets/icons/settings-icon.svg');
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
    background-color: rgba(0, 0, 0, 0);
    background-image: url('/assets/icons/close-icon.svg');
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
    width: 3rem;
    height: 3rem;
    background-size: 70%;
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
      max-width: $sidebar-sizing-mobile;
      width: $sidebar-sizing-mobile;
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
  .sidebar{
      max-width: $sidebar-sizing-tablet;
      width: $sidebar-sizing-tablet;

      &__btn {
      width: $sidebar-button-size-tablet;
      height: $sidebar-button-size-tablet;
    }

    &__content{
      left: $content-margin-tablet;
      width: $content-width-tablet;
    }
  }
}

@include respond-to-desktop-small {
  .sidebar {
    max-width: $sidebar-sizing-desktop-small;
    width: $sidebar-sizing-desktop-small;
    &__btn {
      width: $sidebar-button-size-desktop-small;
      height: $sidebar-button-size-desktop-small;
    }

    &__content{
      left: $content-margin-desktop-small;
      width: $content-width-desktop-small;
    }
  }

}

@include respond-to-desktop {
  .sidebar {
    max-width: $sidebar-sizing-desktop;
    width: $sidebar-sizing-desktop;

    &__content{
      width: $content-width-desktop;
      left: $content-margin-desktop;
    }

    &__btn {
      width: $sidebar-button-size-desktop;
      height: $sidebar-button-size-desktop;
    }

  }
}


@include respond-to-desktop-large {
  .sidebar {
    max-width: $sidebar-sizing-desktop-large;
    width: $sidebar-sizing-desktop-large;

    &__content{
      width: $content-width-desktop-large;
      left: $content-margin-desktop-large;
    }

    &__btn {
      width: $sidebar-button-size-desktop-large;
      height: $sidebar-button-size-desktop-large;
    }

  }
}


</style>