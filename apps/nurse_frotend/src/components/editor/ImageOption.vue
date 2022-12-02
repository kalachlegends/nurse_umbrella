<template lang="">
    <div class="optoins">
        <div class="optoins__body">
          <div class="optoins__title mb-16 d-flex">Image</div>
      
        <div class="d-flex jc-sp">
          
          <btn-plus @click="addNewImage">ADD NEW IMAGE</btn-plus>
        </div>
        </div>
      
      </div>
      <modal-window v-model:show="isShowModelAddNewImage">
     
  
      <all-image-view @get-all-images="addNewImage" v-model:isShowModel="isShowModelAddNewImage" />
    </modal-window>
   
</template>
<script>
import AllImageView from "@/components/editor/AllImageView.vue";
import { useUploadImage } from "@/hooks/editor/image/useUploadImage";
export default {
  name: "image-option",
  components: {
    AllImageView,
  },
  props: {},
  data() {
    return {
      isShowModelAddNewImage: false,
      isShowModelUpload: false,
    };
  },
  methods: {
    newUploadImage() {
      this.isShowModelUpload = true;
    },

    addNewImage() {
      this.isShowModelAddNewImage = true;
      console.log(this.isShowModelAddNewImage);
    },
  },
  setup() {
    const { isLoad, handleClickUploadImage, handleChangeFile, imgLink } =
      useUploadImage();
    return {
      isLoad,
      handleClickUploadImage,
      handleChangeFile,
      imgLink,
    };
  },
};
</script>
<style lang="">
</style>