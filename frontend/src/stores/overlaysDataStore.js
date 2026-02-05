import { defineStore } from 'pinia';

export const useOverlaysDataStore = defineStore('overlaysData', {
  
    state: () => {
        return  {
        overlays: [],
        defaultOverlay: { overlay_name: 'Custom Locations' },
        selectedOverlay: null,
        }
     },
    getters: { 
    },
    actions: {
      async getOverlaysData() {
        try {
          const overlaysDataUrl = `${import.meta.env.VITE_OVERLAYS_DATA_ENDPOINT}`;
          const response = await fetch(overlaysDataUrl);
          
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
            const data = await response.json();
            this.overlays = data;
            this.overlays.push(this.defaultOverlay);
            return data;
        } catch (error) {
          console.error('Error fetching overlays data:', error);
          throw error;
        }
        },
        async setDefaultOverlay(){
          this.selectedOverlay = this.defaultOverlay;
        },
        setSelectedOverlay(overlay) {
            this.selectedOverlay = overlay;
        },
    },
})