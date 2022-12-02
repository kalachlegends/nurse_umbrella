<template lang="">
    <button class="btn-default" :class="{ 'danger': danger}">
        <slot/>
    </button>
</template>
<script>
export default {
  name: "btn-default",
  props: {
    danger: Boolean,
  },
};
</script>
<style scoped lang="scss">
@import "@/assets/scss/mixins/adaptive-font.scss";
@import "@/assets/scss/mixins/rem.scss";
@import "@/assets/scss/colors.scss";

.btn-default {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 8px 15px;
  background: #2c2c2c;
  box-shadow: $box-shadow-default;
  border-radius: 7px;
  color: white;
  font-weight: 500;
  text-transform: uppercase;
  transition: all 0.3s;
  &.danger {
    color: $text-shadow-danger;
    box-shadow: $box-shadow-danger;
    &:hover {
      color: $text-shadow-danger;
      box-shadow: $box-shadow-danger;
    }
  }
  &:hover {
    color: rgb(221, 221, 221);
    box-shadow: $box-shadow-default;
    background: #222222;
  }
  @include adaptiv-font(16, 14);
}
</style>