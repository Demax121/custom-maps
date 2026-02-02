<template>
    <div class="note__dialog">
        <!-- <p class="note__dialog-location-name">Location: <span> {{ markerName }} </span></p> -->


        <div class="note__dialog-content">
            <span class="note__dialog-input-set">
                <label for="note-tag" class="note__dialog-input-label">Tag:</label>
                <input name="note-tag" type="text" class="note__dialog-input note__dialog-input-tag"
                    placeholder="Enter tag" maxlength="40"
                    v-model="markerNote.note_tag" />
            </span>
            <span class="note__dialog-input-set">
                <label for="note-title" class="note__dialog-input-label">Title:</label>
                <input name="note-title" type="text" class="note__dialog-input note__dialog-input-title"
                    placeholder="Enter title" maxlength="40" v-model="markerNote.note_title" />
            </span>
            <span class="note__dialog-input-set">
                <label for="note-content" class="note__dialog-input-label">Note:</label>
                <textarea name="note-content" class="note__dialog-input note__dialog-input-note"
                    placeholder="Enter note content" v-model="markerNote.note_content">
                    
                </textarea>
            </span>
        </div>

        <div class="note__dialog-button-container">
            <button @click="$emit('closeNoteDialog')" class="note__dialog-button">Close</button>
            <button class="note__dialog-button" @click="saveMarkerNote(props.markerName, markerNote)">Save note</button>
            <button class="note__dialog-button" @click="deleteMarkerNote(props.markerName)">Delete note</button>
        </div>

    </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import { useMarkersDataStore } from '../stores/markersDataStore';
const markersDataStore = useMarkersDataStore();


const emit = defineEmits(['closeNoteDialog']);
const props = defineProps({
    markerName: {
        type: String,
        required: true,
    },
});

const marker = markersDataStore.savedMarkers.find(m => m.marker_name === props.markerName);
const markerNote = reactive({
  note_tag: marker?.note?.note_tag || '',
  note_title: marker?.note?.note_title || '',
  note_content: marker?.note?.note_content || '',
});



const deleteMarkerNote = (markerName) => {
    markersDataStore.deleteMarkerNote(markerName);
    markerNote.note_tag = '';
    markerNote.note_title = '';
    markerNote.note_content = '';
};

const saveMarkerNote = (markerName, noteData) => {
    markersDataStore.saveMarkerNote(markerName, noteData);

};



</script>

<style lang="scss" scoped>

@use '@/scss/colors' as *;
@use '@/scss/mixins' as *;

.note {

    &__icon {
        max-width: 1.25rem;
    }

    &__dialog {

        background-color: $note-dialog-bg-crl-primary;
        padding: 1rem;
        z-index: 1000;
        // @include box-shadow-dialog;
        border-bottom: 2px solid $note-dialog-border-light-crl;
        margin-bottom: 1rem;

        &-content {
            @include flex-column(flex-start, stretch, 0.5rem);
            margin-bottom: 1rem;
        }

        &-input-set {
            @include flex-row(flex-start, center, 0.25rem);
        }

        &-input {
            flex-grow: 1;
            font-size: 1rem;
            padding: 0.25rem 0.5rem;
            border: none;
            border-bottom: 1px solid $note-dialog-border-light-crl;
            background-color: $note-dialog-input-bg-crl;
            color: $font-crl-primary;

            &::placeholder {
                color: $note-dialog-placeholder-crl;
            }

            &-tag {}

            &-title {}

            &-note {
                min-height: 5rem;
                max-height: 15rem;
                resize: vertical;
            }
        }

        &-button-container {
            @include flex-row(flex-end, center, 0.5rem);
        }

        &-button {
            padding: 0.25rem 0.25rem;
            width: fit-content;
            font-size: 0.9rem;
            background-color: $note-dialog-button-bg-crl;
            border: 1px solid $note-dialog-input-border-crl;
            border-radius: 0.25rem;
            color: $font-crl-primary;
            cursor: pointer;

            &:hover {
                background-color: $note-dialog-button-hover-crl;
            }
        }

    }
}


@include respond-to-mobile{
    .note__dialog-button{
        font-size: 0.8rem;
        padding: 0.25rem 0.25rem;
    }

    .note__dialog-location-name{
        font-size: 0.8rem;
    }

    .note__dialog-input-label{
        font-size: 0.9rem;
    }

    .note__dialog-input {
        font-size: 0.9rem;
    }
}

</style>