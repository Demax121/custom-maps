import { defineStore } from 'pinia';
export const useAppSettingsStore = defineStore('appSettings', {
  
    state: () => {
        return  {
        automaticPaneChange: true,
        }
     },
    getters: { 
    },
    actions: {
        setAutomaticPaneChange(value) {
            this.automaticPaneChange = value;
        }
    },
});