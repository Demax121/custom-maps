<template>
  <div class="sidebar__pane">
    <div class="sidebar__pane-header">
      <h1 class="sidebar__pane-title">Viewer and Map Settings</h1>
    </div>
    <div class="sidebar__pane-body">

      <div class="sidebar__pane-settings-content sidebar__info-settings">
      <h2 class="settings-title">Information</h2>
      <p class="settings-description">
        Here you can adjust various settings related to the map viewer and overall application preferences.
      </p>
      </div>
      <div class="sidebar__mapViewer-settings sidebar__pane-settings-content">
          <h2 class="settings-title">Map Viewer Settings</h2>
      </div>

      <div class="sidebar__app-settings sidebar__pane-settings-content">
        <h2 class="settings-title">Application Settings</h2>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';


</script>

<style lang="scss" scoped>
@use '@/scss/colors' as *;

.settings{

  &-title {
  font-size: 1.25rem;
  margin-bottom: 0.5rem;
  margin-top: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.2);
  padding-bottom: 0.25rem;

  }

  &-description {
  font-size: 1rem;
  margin-bottom: 1rem;
  color: $font-crl-primary;
}

}

.sidebar{


  &__mapViewer-settings{
    
  }

  &__app-settings{

}
  &__pane-settings-content{
  margin: 4rem 0rem;
}

&__info-settings{
  margin-top: 0rem;
}

}

</style>