<template lang="">
    <div class="input-image">
        <input-default v-bind="inputProps" />
        <img :src="require('@/assets/' + urlImage)" v-bind="imgProps"> 
    </div>
</template>
<script>
export default {
  name: "input-def-img",
  props: {
    urlImage: String,
    inputProps: Object,
    imgProps: Object,
  },
};
</script>
<style scoped lang="scss">
.input-image {
  position: relative;
  img {
    position: absolute;
    top: 14%;
    right: 16px;
  }
}
</style>