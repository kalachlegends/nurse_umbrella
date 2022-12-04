<template lang="">
  <div>
    <h1>Шаблоны</h1>
    <a-table :dataSource="doc" :columns="columns">
      <template #bodyCell="{ column, record }">
        <template v-if="column.key === 'id'">
          <router-link :to="'/template/' + record.id">
            {{ record.id }}
          </router-link>


        </template>
        <template v-if="column.key === 'title'">
          <router-link :to="'/template/' + record.id">
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
          title: "title",
          dataIndex: "title",
          key: "title",
        },
        {
          title: "name",
          dataIndex: "name",
          key: "name",
        },
      ];

      const isLoad = inject("isLoad");
      onMounted(async () => {
        isLoad.value = true;
        const data = await axios.get("/template");
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