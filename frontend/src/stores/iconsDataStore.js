import { defineStore } from 'pinia';

export const useIconsDataStore = defineStore('iconsData', {
  
    state: () => {
        return  {
        icons: [],
        }
     },
    getters: { 
    },
    actions: {
      async getIconsData() {
        try {
          const iconsDataUrl = `${import.meta.env.VITE_ICONS_DATA_ENDPOINT}`;
          const response = await fetch(iconsDataUrl);
          
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
            const data = await response.json();
            this.icons = data;
            return data;
        } catch (error) {
          console.error('Error fetching icons data:', error);
          throw error;
        }
        },
    },
})