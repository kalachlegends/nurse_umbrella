<template lang="">

        <div class="drop-down ">
            <div class="drop-down__title df-aic" @click="openDropDown" :data-select="title">{{ title }} 
                <span class="df-aic-jcc ml-16" >
                    <img src="@/assets/img/icons/arrow.svg" alt="">
                </span>
            </div>
      
            <div class="drop-down__children" v-if="isOpen">
              <div class="drop-down__item-child" @click="selectet" v-for="children in childrens" :data-title="children">

                {{ children }}
              </div>
            </div>

         </div>


</template>
<script>
export default {
  name: "DropDown",
  props: {
    title: String,
    childrens: Array,
  },
  data() {
    return {
      isOpen: false,
    };
  },
  methods: {
    openDropDown() {
      if (this.isOpen) this.isOpen = false;
      else this.isOpen = true;
    },
    selectet(event) {
      this.openDropDown();
      this.$emit("select", event);
    },
  },
  watch: {},
};
</script>
<style scoped lang="scss">
@import "@/assets/scss/colors.scss";
</style>