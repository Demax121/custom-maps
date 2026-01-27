<template>
  <div id="sidebar" class="sidebar">
    <!-- Nav tabs -->
    <div class="sidebar__tabs">
      <ul role="tablist" class="sidebar__tab-list">
        <li class="sidebar__tab-item">
          <button class="sidebar__btn" @click="toggle">
            <img class="sidebar__btn-img" src="/assets/bars-icon.svg" alt="menu"></img>
          </button>
        </li>
        <li class="sidebar__tab-item">
          <button class="sidebar__btn" @click="toggle">
            <img class="sidebar__btn-img" src="/assets/map-icon.svg" alt="menu"></img>
          </button>
        </li>
        <li class="sidebar__tab-item">
          <button class="sidebar__btn" @click="toggle">
            <img class="sidebar__btn-img" src="/assets/marker-icon.svg" alt="menu"></img>
          </button>
        </li>
        <li class="sidebar__tab-item">
          <button class="sidebar__btn" @click="toggle">
            <img class="sidebar__btn-img" src="/assets/list-icon.svg" alt="menu"></img>
          </button>
        </li>
      </ul>
      <!-- 
      <ul role="tablist" class="sidebar__tab-list">
        <li class="sidebar__tab-item sidebar__tabs-item--disabled"></li>
      </ul> -->
    </div>
    <!-- Tab panes -->

    <Transition name="slide">
      <div class="sidebar__content" v-show="isVisible">
        <div class="sidebar__pane">
          <div class="sidebar__pane-header">
            <h1 class="sidebar__pane-title"></h1>
            <span class="sidebar__pane-close"></span>
          </div>
          <div class="sidebar__pane-body">
            <p> </p>
          </div>
        </div>
      </div>










      
    </Transition>


  </div>
</template>

<script setup>

import { ref } from 'vue'

const isVisible = ref(true)

function toggle() {
  isVisible.value = !isVisible.value
}




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
  background-color: $sidebar-crl-primary;
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
    background-color: $sidebar-crl-primary;
    overflow-x: hidden;
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