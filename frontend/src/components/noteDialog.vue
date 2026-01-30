<template>
    <div class="note__dialog">
        <p>Location: <span> {{ markerName }} </span></p>


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
.note {

    &__icon {
        max-width: 1.25rem;
    }

    $box-shadow-dialog: 0px 17px 49px 13px rgba(5, 5, 5, 1);

    &__dialog {

        background-color: $sidebar-pane-crl-primary;
        padding: 1rem;
        z-index: 1000;
        -webkit-box-shadow: $box-shadow-dialog;
        -moz-box-shadow: $box-shadow-dialog;
        box-shadow: $box-shadow-dialog;


        &-content {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            margin: 1rem 0rem;
        }

        &-input-set {
            display: flex;
            flex-direction: row;
            gap: 0.25rem;
        }

        &-input {
            flex-grow: 1;
            padding: 0.25rem 0.5rem;
            border: none;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            background-color: rgba(0, 0, 0, 0.3);
            color: $font-crl-primary;

            &::placeholder {
                color: rgba(255, 255, 255, 0.5);
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
            display: flex;
            gap: 0.5rem;
            justify-content: flex-end;
        }

        &-button {
            padding: 0.5rem 0.25rem;
            width: fit-content;
            font-size: 1rem;
            background-color: rgba(124, 124, 124, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 0.25rem;
            color: $font-crl-primary;
            cursor: pointer;

            &:hover {
                background-color: rgba(124, 124, 124, 0.5);
            }
        }

    }
}
</style>