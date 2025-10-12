import { defineStore } from 'pinia';

// Odczytujemy prefixy zdefiniowane w plikach .env.*
const backendPrefix = import.meta.env.VITE_BACKEND_URL_PREFIX;
const cdnPrefix = import.meta.env.VITE_CDN_URL_PREFIX;

export const useLinkStore = defineStore('linkStore', {
  // State nie jest już potrzebny do przechowywania bazowych URLi
  state: () => ({}),
  
  getters: {
    /**
     * Konstruuje pełny URL do API PHP.
     * @param {object} state - Stan store'a (nieużywany tutaj)
     * @returns {function(string): string} - Funkcja, która przyjmuje nazwę pliku PHP i zwraca pełny URL.
     */
    getPhpApiUrl: () => (phpFileName) => {
      if (!phpFileName || typeof phpFileName !== 'string') {
        console.warn('PHP filename must be a non-empty string.');
        // Zwracamy sam prefix, jeśli nazwa pliku jest niepoprawna
        return backendPrefix;
      }
      // Łączymy prefix z nazwą pliku, np. "/api/login.php"
      return `${backendPrefix}/${phpFileName}`;
    },

    /**
     * Konstruuje pełny URL do zasobu w CDN.
     * @param {object} state - Stan store'a (nieużywany tutaj)
     * @returns {function(string): string} - Funkcja, która przyjmuje ścieżkę do zasobu i zwraca pełny URL.
     */
    getCdnUrl: () => (assetPath) => {
      if (!assetPath || typeof assetPath !== 'string') {
        console.warn('Asset path must be a non-empty string.');
        return cdnPrefix;
      }
      // Łączymy prefix ze ścieżką do zasobu, np. "/assets/images/logo.png"
      return `${cdnPrefix}/${assetPath}`;
    }
  },
});