<template lang="">
   <div class="d-flex jc-sp w-100p">
    <div class="d-flex gap-10">
      <btn-default @click="changeTab('images')">Все</btn-default>
      <!-- <btn-default>избранные</btn-default> -->
    </div>

    <input-def-img urlImage="img/icons/search.svg" :inputProps="{placeholder: 'ПОИСК'}" />
  </div>
  <file-dragon @on-change="onChange" v-if="isTab('image')"></file-dragon>

  <loader v-if="isLoad" theme="dark"/>
  <!-- <input-file @inputOnChange="handleChangeFile" />
  <btn-default @click="handleClickUploadImage">
    загрузить картинку
  </btn-default>  -->

   <div class="grid" v-if="isTab('images')"> 
      <div v-for="item in images">
        <img-fluid  :src="item.image_url" alt="" />   
      </div>
  </div> 
  <div class="d-flex jc-sp w-100p">
    <div class="d-flex gap-10 mr-15">
      <btn-default @click="changeTab('image')">Загрузить картинки</btn-default>
      <btn-default v-if="isTab('images')" >Импорт в страницу</btn-default>
      
    </div>
    <pagination v-if="isTab('images')" :callbackChange="changePage" :currentPage="page" :totalPage="totalPage" />
    <btn-default  @click="handleClick" v-if="isTab('image')">сохранить</btn-default>
  </div>


</template>
<script>
import { useUploadImage } from "@/hooks/editor/image/useUploadImage";
import { useGetAllImage } from "@/hooks/editor/image/useGetAllImage";
import { useTab } from "@/hooks/useTab";
import { ref } from "vue";
import Pagination from "../UI/Pagination.vue";
import FileDragon from "@/components/other/FileDragon.vue";

export default {
  name: "all-image-view",

  setup(props) {
    const { page, isLoad, totalPage, changePage, images } = useGetAllImage();
    const { currentTab, changeTab, isTab } = useTab("images");

    const handleClick = ref(null);
    const onChange = (fn) => (handleClick.value = fn);

    return {
      isLoad,
      images,
      page,
      totalPage,
      changePage,
      currentTab,
      changeTab,
      isTab,
      onChange,
      handleClick,
    };
  },
  components: { Pagination, FileDragon },
  methods: {},
};
</script>
<style scoped lang="scss">
.grid {
  margin-bottom: 15px;
  display: grid;
  gap: 20px;
  width: 100%;

  grid-template: 2fr/2fr 2fr 2fr;
}
</style>