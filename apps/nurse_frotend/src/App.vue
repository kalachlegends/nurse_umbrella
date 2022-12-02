<template>
  <AppLayoutVue>
    <router-view />
  </AppLayoutVue>
</template>

<script>
import AppLayoutVue from "./layout/AppLayout.vue";
export default {
  components: {
    AppLayoutVue,
  },
};
</script>
<style lang="scss">
@import "@/assets/scss/style.scss";
</style>
