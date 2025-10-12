<script setup>
import { ref, onMounted } from 'vue'
import { useLinkStore } from '../stores/linkStore'

const databaseStatus = ref('Loading...')
const imageLoaded = ref(false)
const linkStore = useLinkStore()

const handleImageLoad = () => {
  imageLoaded.value = true
}

onMounted(async () => {
  try {
    const databaseApiUrl = linkStore.getPhpApiUrl('test.php')
    const response = await fetch(databaseApiUrl)
    const data = await response.json()
    databaseStatus.value = data.success ? 'Connected' : 'Error'
  } catch (error) {
    databaseStatus.value = 'Error'
  }
})
</script>

<template>
  <main class="container">
    <h1>HELLO WORLD</h1>
    <h2>Database status: <span :class="{ connected: databaseStatus === 'Connected' }">{{ databaseStatus }}</span></h2>
    <div class="image-wrapper">
<img 
  :src="linkStore.getCdnUrl('images/placeholder.webp')" 
  alt="Placeholder image"
  @load="handleImageLoad"
/>
      <h3 v-if="imageLoaded" class="image__loaded">This image has been fetched from dockerized CDN</h3>
    </div>
  </main>
</template>

<style lang="scss" scoped>
.container {
  min-height: 100vh;
  padding: 2rem;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2rem;
  background-color: $background-crl-primary;

  h1 {
    color: $title-crl-primary;
    font-size: 2.5rem;
  }

  h2 {
    color: $title-crl-secondary;
    font-size: 1.5rem;

    span.connected {
      color: #4caf50;
    }
  }
}

.image-wrapper {
  max-width: 500px;
  width: 100%;
  
  img {
    width: 100%;
    height: auto;
    border-radius: 8px;
  }
}
.image__loaded {
  font-size: 1.2rem;
  margin-top: 1rem;
  text-align: center;
}

</style>