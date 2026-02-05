import { defineStore } from 'pinia';

export const useIconsDataStore = defineStore('iconsData', {
  
    state: () => {
        return  {
        icons: [],
        defaultIcon: null,
        selectedIcon: null,
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
        async getDefaultIcon() { 
          this.defaultIcon = this.icons.find(icon => icon.icon_name === 'default-icon');
          this.selectedIcon = this.defaultIcon;
        },
        setSelectedIcon(icon) {
          const targetIcon = this.icons.find(i => i.icon_name === icon.icon_name);
          this.selectedIcon = targetIcon;
        },
    },
})