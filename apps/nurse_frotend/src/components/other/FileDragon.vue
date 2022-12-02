<template lang="">
  <loader theme="dark" v-if="isLoad"/>
    <div class="file-block" @dragover="dragover" @dragleave="dragleave" @drop="drop">
      <input type="file" multiple name="fields[assetsFieldHandle][]" 
        class="d-none" id="assetsFieldHandle" @change="onChange" ref="file" accept=".jpg,.jpeg,.png,.svg" />
    
      <label for="assetsFieldHandle" class="file-block_text">
        <div class="text"> Explain to our users they can drop files in here 
          or <span class="underline">click here</span> to upload their files
        </div>
        <img class="file-block_img" src="@/assets/img/icons/download.svg" alt="">
        
      </label>
      <ul class="file-block_items" v-if="this.filelist.length">
        <li class="file-block_item" v-for="file in filelist">
          {{ file.name }}<btn-default  @click="remove(filelist.indexOf(file))" title="Remove file">remove</btn-default>
        </li>
      </ul>
    </div>

  
  
</template>
<script>
import { useUploadImage } from "@/hooks/editor/image/useUploadImage";
export default {
  data() {
    return {
      file: {},
    };
  },
  name: "file-dragon",
  methods: {
    onChange() {
      this.filelist = [...this.$refs.file.files];

      this.handleChangeFile(this.filelist);

      this.$emit("onChange", this.handleClickUploadImage);
    },
    remove(i) {
      this.filelist.splice(i, 1);
    },
    dragover(event) {
      event.preventDefault();
      // Add some visual fluff to show the user can drop its files
      if (!event.currentTarget.classList.contains("bg-green-300")) {
        event.currentTarget.classList.remove("bg-gray-100");
        event.currentTarget.classList.add("bg-green-300");
      }
    },
    dragleave(event) {
      event.currentTarget.classList.add("bg-gray-100");
      event.currentTarget.classList.remove("bg-green-300");
    },
    drop(event) {
      event.preventDefault();
      this.$refs.file.files = event.dataTransfer.files;
      this.onChange();

      event.currentTarget.classList.add("bg-gray-100");
      event.currentTarget.classList.remove("bg-green-300");
    },
  },
  setup() {
    const { isLoad, handleClickUploadImage, handleChangeFile, imgLink, file } =
      useUploadImage("array");

    return {
      isLoad,
      handleClickUploadImage,
      handleChangeFile,
      imgLink,
      filelist: file,
    };
  },
};
</script>
<style scoped lang="scss">
.file-block {
  background: #2c2c2c;
  /* shadow_modal */
  color: white;
  padding: 30px;
  width: 100%;
  box-shadow: 0px 1px 39px 6px rgba(0, 0, 0, 0.25);
  &.bg-green-300 {
    background: #1b0b0b;
  }
  &.bg-gray-100 {
    background: #3a3737;
  }
  &_items {
    display: grid;
    grid-template: 1fr/1fr 1fr;
    gap: 10px;
    position: relative;
    z-index: 1;
  }
  &_item {
    font-size: 16px;
    font-weight: bold;
    padding: 5px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
  }
  &_text {
    .text {
      position: relative;
      z-index: 10;
    }
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    font-weight: bold;
    padding: 10px;
    min-height: 200px;
    z-index: 0;
  }
  &_img {
    position: absolute;
    top: 40%;
    z-index: 1;
  }
}
</style>