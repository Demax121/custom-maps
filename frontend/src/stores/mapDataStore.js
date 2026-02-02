import { defineStore } from 'pinia';


export const useMapDataStore = defineStore('mapData', {
  
    state: () => { 
        return  {
        mapName: null,
        mapDescription: null,
        mapMinZoom: null,
        mapMaxZoom: null,
        mapTilesLink: null,
        mapImg: null,
        }
     },
  getters: {
    
  },
  actions: {
    async getMapData() {
      try {
        const response = await fetch('http://192.168.1.2:8884/getMapData.php?map_name=Barovia');
        
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        
        if (!data || !Array.isArray(data) || data.length === 0) {
          throw new Error('No data returned from server');
        }
        
        // PHP returns an array, get the first element
        const mapData = data[0];
        
        this.mapName = mapData.map_name;
        this.mapDescription = mapData.map_description;
        this.mapMinZoom = mapData.map_min_zoom;
        this.mapMaxZoom = mapData.map_max_zoom;
        this.mapTilesLink = mapData.map_tiles_link;
        this.mapImg = mapData.map_img;
        
        return data;
      } catch (error) {
        console.error('Error fetching map data:', error);
        throw error;
      }
    },
  },
})