import { defineStore } from 'pinia';
export const useMarkersDataStore = defineStore('markersData', {
  
    state: () => {
        return  {
        markers: [],
        markerRefs: {},
        focusedMarker: null,
        targetMarker: null,
        savedMarkers: [],
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
        setMarkerRef(markerName, leafletMarker) {
          this.markerRefs[markerName] = leafletMarker;
        },
        focusMarker(markerName) {
          this.focusedMarker = markerName;
        },
        selectedMarker(markerName) {
          this.targetMarker = this.markers.find(marker => marker.marker_name === markerName);
          return this.targetMarker;
        },
        saveMarker(markerName) {
          const marker = this.markers.find(marker => marker.marker_name === markerName);
          if (marker && !this.savedMarkers.includes(marker))
          this.savedMarkers.push(marker);
        },
        removeSavedMarker(markerName) {
          const marker = this.savedMarkers.find(marker => marker.marker_name === markerName);
          if (marker) {
            const index = this.savedMarkers.indexOf(marker);
            this.savedMarkers.splice(index, 1);
          }

        }
    },
});