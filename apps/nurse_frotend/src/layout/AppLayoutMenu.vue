<template lang="">
<loader-full-page>
<n-menu />
 <main class="wp-margin-90">
  <slot/>
 </main>
</loader-full-page>
</template>
<script>
import NMenu from "@/components/menu/Menu.vue";

export default {
  components: {
    NMenu,
  },
};
</script>
