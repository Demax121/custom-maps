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
        <p class="settings-description">
          Here you can adjust measurement units and values. - Future work
        </p>
      </div>

      <div class="sidebar__app-settings sidebar__pane-settings-content">
        <h2 class="settings-title">Application Settings</h2>
        <p class="settings-description">
          Here you can adjust application-wide settings.
        </p>
        <p class="settings-description">
          <b>Automatic pane change</b><br> It allows the sidebar pane to change based on your interactions with the map
          automatically (e.g., selecting a marker on map or in the sidebar marker list pane will open the Marker
          Description pane).
        </p>
        <div class="checkbox-container">
          <label class="checkbox-label" for="automatic__pane__switch">Automatic pane change: </label>
          <input type="checkbox" name="automatic__pane__switch" class="automatic__pane__switch-checkbox"
            :checked="appSettingsStore.automaticPaneChange" @change="appSettingsStore.setAutomaticPaneChange($event.target.checked)" />
        </div>

      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useAppSettingsStore } from '../../stores/appSettingsStore';
const appSettingsStore = useAppSettingsStore();

</script>

<style lang="scss" scoped>
@use '@/scss/colors' as *;
@use '@/scss/mixins' as *;

.settings {

  &-title {
    font-size: 1.25rem;
    margin-bottom: 0.5rem;
    margin-top: 1rem;
    border-bottom: 1px solid $settings-border-crl;
    padding-bottom: 0.25rem;

  }

  &-description {
    font-size: 1rem;
    margin-bottom: 1rem;
    color: $font-crl-primary;

    b,
    strong {
      font-weight: bold;
    }
  }

}

.sidebar {


  &__mapViewer-settings {}

  &__app-settings {}

  &__pane-settings-content {
    margin: 4rem 0rem;
  }

  &__info-settings {
    margin-top: 0rem;
  }

}

.automatic__pane__switch-checkbox {
  width: 1.25rem;
  height: 1.25rem;
  margin-left: 1rem;
  cursor: pointer;
}

.checkbox-container {
  @include flex-row(flex-start, center);
}

.checkbox-label {
  font-size: 1rem;
  color: $font-crl-primary;
}
</style>