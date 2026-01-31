import { defineStore } from 'pinia';
export const useMarkersDataStore = defineStore('markersData', {
  
    state: () => {
        return  {
        markers: [],
        markerRefs: {},
        focusedMarker: null,
        targetMarker: null,
        savedMarkers: [],
        savedMarkersSet: new Set(),
        customMarkers: [],
        customMarkersSet: new Set(),
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
          // Search in regular markers first
          this.targetMarker = this.markers.find(marker => marker.marker_name === markerName);
          
          // If not found, search in custom markers
          if (!this.targetMarker) {
            this.targetMarker = this.customMarkers.find(marker => marker.marker_name === markerName);
          }
          
          return this.targetMarker;
        },
        saveMarker(markerName) {
          const marker = this.markers.find(marker => marker.marker_name === markerName);
          if (marker && !this.savedMarkersSet.has(markerName))
          Object.defineProperty(marker, 'note', {
            value: '',
            writable: true,
            enumerable: true,
          });
          this.savedMarkers.push(marker);
          this.savedMarkersSet.add(markerName);

        },
        removeSavedMarker(markerName) {
          const marker = this.savedMarkers.find(marker => marker.marker_name === markerName);
          if (marker) {
            const index = this.savedMarkers.indexOf(marker);
            this.savedMarkers.splice(index, 1);
            this.savedMarkersSet.delete(markerName);
          }
        },


exportSavedMarkers() {
  if (this.savedMarkers.length > 0) {
    const data = {
      savedMarkers: this.savedMarkers,
      createdMarkers: this.customMarkers
    }

    const jsonString = JSON.stringify(data, null, 2)
    const blob = new Blob([jsonString], { type: 'application/json' })
    const url = URL.createObjectURL(blob)

    const link = document.createElement('a')
    link.href = url
    link.download = 'saved_locations.json'
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)

    URL.revokeObjectURL(url)
  }
},



importSavedMarkers(jsonString) {
  try {
    const data = JSON.parse(jsonString)

    if (!data || typeof data !== 'object') {
      throw new Error('Invalid format: expected object')
    }

    const { savedMarkers = [], createdMarkers = [] } = data

    if (!Array.isArray(savedMarkers) || !Array.isArray(createdMarkers)) {
      throw new Error('Invalid format: markers must be arrays')
    }

    const isValidSaved = savedMarkers.every(m =>
      m && typeof m === 'object' && m.marker_name
    )

    const isValidCreated = createdMarkers.every(m =>
      m && typeof m === 'object' && m.marker_name
    )

    if (!isValidSaved || !isValidCreated) {
      throw new Error('Invalid marker format in imported data')
    }

    const existingNames = new Set(this.savedMarkers.map(m => m.marker_name))
    const newSaved = savedMarkers.filter(m => !existingNames.has(m.marker_name))

    this.savedMarkersSet = new Set([
      ...this.savedMarkersSet,
      ...newSaved.map(m => m.marker_name)
    ])

    this.savedMarkers = [...this.savedMarkers, ...newSaved]
    this.customMarkers = [...this.customMarkers, ...createdMarkers]

  } catch (error) {
    console.error('Error importing saved markers:', error)
    throw error
  }
},





        saveMarkerNote(markerName, noteData) {
          const marker = this.savedMarkers.find(marker => marker.marker_name === markerName);
          if (marker) {
            marker.note = noteData;
          }
        },
        deleteMarkerNote(markerName) {
          const marker = this.savedMarkers.find(marker => marker.marker_name === markerName);
          if (marker && marker.note) {
            marker.note = '';
          }
        },
        createLocation(marker){
          if (marker && !this.customMarkersSet.has(marker.marker_name)) {
            this.customMarkers.push(marker);
            this.customMarkersSet.add(marker.marker_name);
          }else{
            console.warn(`Marker with name ${marker.marker_name} already exists in custom markers.`);
          }
        },
        deleteLocation(markerName){
          const marker = this.customMarkers.find(marker => marker.marker_name === markerName);
          if (marker) {
            const index = this.customMarkers.indexOf(marker);
            this.customMarkers.splice(index, 1);
            this.customMarkersSet.delete(markerName);
          }
        },

    },
});