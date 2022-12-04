<template lang="">
  <div>
    <h1>Snippets</h1>
    <a-button class="btn-default" @click="() => show = true">Создать</a-button>

    <modal-window title="Создание подсказки" v-model:show="show">
      <a-input v-model:value="formSnippet.name" placeholder="Имя подсказки" />
      <a-input v-model:value="formSnippet.change" placeholder="Текс добавления подсказки" />
      <a-button class="btn-default" @click="handleClickAdd">Создать</a-button>
    </modal-window>
    <a-table :dataSource="doc" :columns="columns">
      <template #bodyCell="{ column, record }">

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
  import { Toast } from "@/helper/defaultAlert";
  export default {
    setup() {
      const doc = ref([]);
      const show = ref(false);
      const isLoader = ref(false);
      const formSnippet = ref({
        name: "",
        change: "",
      });
      const columns = [
        {
          title: "id",
          dataIndex: "id",
          key: "id",
        },
        {
          title: "Имя подсказки",
          dataIndex: "name",
          key: "name",
        },
        {
          title: "Изменение",
          dataIndex: "change",
          key: "change",
        },
      ];
      const handleClickAdd = async () => {
        const data = await axios
          .post("/snippets", formSnippet.value)
          .then(async () => {
            Toast.fire({
              icon: "success",
              title: "Успешно создали сниппет",
            });
            const data = await axios.get("/snippets");
            doc.value = data.data.snippets;
          })
          .catch(() => {
            Toast.fire({
              icon: "error",
              title: "Ошибка",
            });
          });
      };
      const isLoad = inject("isLoad");
      onMounted(async () => {
        isLoad.value = true;
        const data = await axios.get("/snippets");
        doc.value = data.data.snippets;
        console.log(data);
        isLoad.value = false;
      });
      return {
        columns,
        doc,
        show,
        formSnippet,
        handleClickAdd,
      };
    },
  };
</script>
<style lang="">
</style>