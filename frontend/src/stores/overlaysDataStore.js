import { defineStore } from 'pinia';

export const useOverlaysDataStore = defineStore('overlaysData', {
  
    state: () => {
        return  {
        overlays: [],
        }
     },
    getters: { 
    },
    actions: {
      async getOverlaysData() {
        try {
          const response = await fetch('http://127.0.0.1:8884/getOverlaysData.php?map_name=Barovia');
          
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
            const data = await response.json();
            this.overlays = data;
            return data;
        } catch (error) {
          console.error('Error fetching overlays data:', error);
          throw error;
        }
        },
    },
})