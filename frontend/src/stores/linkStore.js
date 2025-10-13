import { defineStore } from 'pinia';

// Odczytujemy prefixy zdefiniowane w plikach .env.*
const phpPrefix = import.meta.env.VITE_BACKEND_URL_PREFIX;
const cdnPrefix = import.meta.env.VITE_CDN_URL_PREFIX;

export const useLinkStore = defineStore('linkStore', {
  // State nie jest już potrzebny do przechowywania bazowych URLi
  state: () => ({}),
  
  getters: {

    getPHP: () => (phpFileName) => {
      if (!phpFileName || typeof phpFileName !== 'string') {
        console.warn('PHP filename must be a non-empty string.');
        // Zwracamy sam prefix, jeśli nazwa pliku jest niepoprawna
        return phpPrefix;
      }
      // Łączymy prefix z nazwą pliku, np. "/api/login.php"
      return `${phpPrefix}/${phpFileName}`;
    },

    getAssets: () => (assetPath) => {
      if (!assetPath || typeof assetPath !== 'string') {
        console.warn('Asset path must be a non-empty string.');
        return cdnPrefix;
      }
      // Łączymy prefix ze ścieżką do zasobu, np. "/assets/images/logo.png"
      return `${cdnPrefix}/${assetPath}`;
    }
  },
});