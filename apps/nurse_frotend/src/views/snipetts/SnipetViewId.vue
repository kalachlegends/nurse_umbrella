<template lang="">
    <div>
      {{doc.id}}
      {{doc.name}}
    </div>
</template>
<script>
import axios from "@/axios";
import { ref, onMounted, computed, inject } from "vue";
import { useRouter, useRoute } from "vue-router";
export default {
  setup() {
    const doc = ref({});
    const isLoad = inject("isLoad");
    onMounted(async () => {
      isLoad.value = true;
      const route = useRoute();
      const data = await axios.get("/snippets/" + route.params.id);
      doc.value = data.data.data;

      isLoad.value = false;
    });
    return {
      doc,
    };
  },
};
</script>
<style lang="">
</style>