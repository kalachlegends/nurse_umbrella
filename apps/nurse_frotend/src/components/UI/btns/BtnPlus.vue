<template lang="">
    <button class="btn">
       <span>
        <slot class="mr-10">
            
        </slot>
       </span>
        <img class="ml-10" src="@/assets/img/icons/plus.svg" alt="">

    </button>
</template>
<script>
export default {
  name: "btn-plus",
};
</script>
<style scoped lang="scss">
@import "@/assets/scss/colors.scss";

.btn {
  display: flex;
  align-items: center;
  font-weight: 300;
  padding: 5px;
  font-size: 16px;
  background: none;
}
</style>