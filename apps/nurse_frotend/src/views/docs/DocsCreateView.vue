<template lang="">
    <h1 style="text-align: center;">Выберите шаблон</h1>
    <div class="grid">
        <a-template v-if="doc.length != 0" v-for="item in doc"
        :title="item.title"
        
        :anemesis="item.anemesis"
        :report_customer="item.report_customer"
        :exam="item.exam"
        :id="item.id"
        ></a-template>
        <h3 v-else > Нет созданных шаблонов</h3>


    </div>
</template>
<script>
import axios from "@/axios";
import { ref, onMounted, computed, inject } from "vue";
export default {
  setup() {
    const doc = ref([]);
    const isLoad = inject("isLoad");
    onMounted(async () => {
      isLoad.value = true;
      const data = await axios.get("/template");
      doc.value = data.data.data;
      console.log(doc.value);
      isLoad.value = false;
    });
    return {
      doc,
    };
  },
};
</script>
<style lang="scss" scoped >
@import "@/assets/scss/colors.scss";
.grid {
  display: grid;
  grid-template: 1fr/1fr 1fr 1fr;
  gap: 10px;
}
.tabs {
  position: fixed;
  width: 100%;
  z-index: 100;
  height: 50px;
  bottom: 30px;

  span {
    background: $bg-main;
    color: white;
    padding: 10px;
    font-weight: bold;

    &.isActive {
      color: black;
    }
  }
}
</style>