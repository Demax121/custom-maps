import { defineStore } from 'pinia';
export const useMarkersDataStore = defineStore('markersData', {
  
    state: () => {
        return  {
        markers: [],
        }
     },
    getters: { 
    },
    actions: {
        async getMarkersData() {
        try {
          const response = await fetch('http://127.0.1:8884/getMarkersData.php?map_name=Barovia');
          
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
            const data = await response.json();
            this.markers = data;
            return data;
        } catch (error) {
          console.error('Error fetching markers data:', error);
          throw error;
        }
        },
    },
});