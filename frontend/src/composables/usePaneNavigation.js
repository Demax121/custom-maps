import { useAppSettingsStore } from '../stores/appSettingsStore';

export function usePaneNavigation(emit) {
  const appSettingsStore = useAppSettingsStore();

  const navigateToPane = (paneName) => {
    if (appSettingsStore.automaticPaneChange) {
      emit('changePane', paneName);
    }
  };

  return {
    navigateToPane
  };
}