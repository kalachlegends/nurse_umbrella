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
        <h3 v-else > Нету шаблонов</h3>


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
<style lang="scss" scoped>
.grid {
  display: grid;
  grid-template: 1fr/1fr 1fr 1fr;
  gap: 10px;
}
</style>