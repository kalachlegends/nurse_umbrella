<template lang="">
    <div class="d-flex gap-10" >
     <btn-default v-if="isButton" @click="callbackChange(1)">
        &lt&lt
     </btn-default>
     <btn-default  v-for="page in getPages" @click="callbackChange(page)" :class="{ active:  page == currentPage}">
        {{page}}
     </btn-default>
     <btn-default v-if="isButton"  @click="callbackChange(totalPage)">
        &gt&gt
     </btn-default>
    </div>
</template>
<script>
import { paginateArray } from "@/helper/pagination";

export default {
  name: "pagination",
  props: {
    callbackChange: Function,
    currentPage: Number,
    totalPage: Number,
  },
  computed: {
    getPages() {
      return paginateArray(2, this.currentPage, this.totalPage);
    },
    isButton() {
      return this.totalPage >= 2;
    },
  },
};
</script>
<style scoped  lang="scss">
.active {
  background: #007bb1;
  // box-shadow: 0px 0px 15px rgb(0 0 0 / 105%);
}
</style>