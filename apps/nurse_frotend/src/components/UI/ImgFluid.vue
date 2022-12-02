<template lang="">
    <span class="img" :style="parseStyle(Object.assign({},sx, {width , paddingTop: padTop}))">
        <img :src="src" alt=""  >
    </span>
</template>
<script>
import parseObjectToStyle from "@/helper/parseObjectToStyle";
export default {
  name: "img-fluid",
  props: {
    src: String,
    sx: Object,
    width: String,
    padTop: String,
  },
  setup() {
    return {
      parseStyle: parseObjectToStyle,
    };
  },
};
</script>
<style scoped lang="scss">
.img {
  display: block;
  width: 100%;
  position: relative;
  padding: 0px 0px 100% 0px;
  img {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    top: 0;
    border-radius: 0px;
    object-fit: cover;
  }
}
</style>