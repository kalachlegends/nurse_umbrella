<template lang="">
    <div>
        <h1>Snippets</h1> 
     <a-table :dataSource="doc" :columns="columns"> 
        <template #bodyCell="{ column, record }">
            <template v-if="column.key === 'id'">
              <router-link :to="'/snippets/' + record.id">
                {{ record.id }}
              </router-link>
              
              
            </template>
    <template v-if="column.key === 'title'">
  <router-link :to="'/snippets/' + record.id">
    {{ record.name }}
  </router-link>
</template>
        </template>
     </a-table>
    </div>
</template>
<script>
import axios from "@/axios";
import { ref, onMounted, computed, inject } from "vue";
export default {
  setup() {
    const doc = ref([]);

    const columns = [
      {
        title: "id",
        dataIndex: "id",
        key: "id",
      },
      {
        title: "name",
        dataIndex: "name",
        key: "name",
      },
      {
        title: "change",
        dataIndex: "change",
        key: "change",
      },
    ];

    const isLoad = inject("isLoad");
    onMounted(async () => {
      isLoad.value = true;
      const data = await axios.get("/snippets");
      doc.value = data.data.data;

      isLoad.value = false;
    });
    return {
      columns,
      doc,
    };
  },
};
</script>
<style lang="">
</style>