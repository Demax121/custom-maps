<template>
        <div class="sidebar__pane">
          <div class="sidebar__pane-header">
            <h1 class="sidebar__pane-title">{{ mapDataStore.mapName }}</h1>
          </div>
          <div class="sidebar__pane-body">
            <img class="sidebar__pane-img" :src="mapDataStore.mapImg" alt="">
           
              <div class="sidebar__pane-body-container">
                <div class="sidebar__pane-body-description" v-html="mapDescription"></div>
              </div>

          </div>
        </div>
</template>

<script setup>
import { onMounted, ref, computed } from 'vue';
import { useMapDataStore } from '../../stores/mapDataStore';
const mapDataStore = useMapDataStore();
import MarkdownIt from 'markdown-it';
import DOMPurify from 'dompurify';
const md = new MarkdownIt({
  linkify: true,
  typographer: true
})

const mapDescription = computed(() => {
  if (!mapDataStore.mapDescription) {
    return 'No description available for this map.';
  }
  const markdown = mapDataStore.mapDescription;
  if (!markdown || typeof markdown !== 'string' || markdown.trim() === '') {
    return 'No description available';
  }
  const html = md.render(markdown);
  const sanitized = DOMPurify.sanitize(html);
  return sanitized;
});


</script>

<style lang="scss" scoped>
@use '@/scss/_markdown.scss';

</style>