<template lang="">
    <input class="input-default">
</template>
<script>
export default {
  name: "input-default",
  props: {
    danger: Boolean,
  },
};
</script>
<style scoped lang="scss" >
@import "@/assets/scss/mixins/adaptive-font.scss";
@import "@/assets/scss/mixins/rem.scss";
@import "@/assets/scss/colors.scss";

.input-default {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: rem(10) rem(25);
  background: #2c2c2c;
  box-shadow: $box-shadow-default;
  border-radius: 7px;
  color: white;

  transition: all 0.3s;
  &.danger {
    color: $text-shadow-danger;
    box-shadow: $box-shadow-danger;
  }

  @include adaptiv-font(15, 14);
}
</style>