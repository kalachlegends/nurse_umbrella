<template lang="">

<div class="dialog" v-if="show" @click.stop="hideDialog">
  <div class="dialog__body">
    <div @click.stop class="dialog__content">
      <img  @click.stop="hideDialog" class="exit" src="@/assets/img/icons/x.svg" alt="">
      <div class="dialog__title" v-if="title">{{title}}</div>

          <slot/>
        </div>
    </div>
</div>

 </template>
 <script>
export default {
  name: "modal-window",
  props: {
    show: {
      type: Boolean,
      default: false,
    },
    title: String,
  },
  methods: {
    hideDialog() {
      this.$emit("update:show", false);
    },
  },
};
</script>
 <style scoped lang="scss" >
.v-enter-active,
.v-leave-active {
  transition: opacity 0.1s ease;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}
.dialog {
  z-index: 10000000;
  position: fixed;
  display: block;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.3);
  top: 0;
  left: 0;
  overflow: auto;
  transition: all 0.4s ease 0s;
}
.dialog__title {
}
.dialog__body {
  min-height: 100%;
  background-color: rgba(0, 0, 0, 0.3);
  display: flex;

  align-items: center;

  justify-content: center;
  padding: 30px 10px;
  transition: all 0.4s ease 0s;
}

.dialog__content {
  position: relative;
  .exit {
    cursor: pointer;
    top: 5px;
    right: 10px;
    width: 38px;
    z-index: 100;
    height: 38px;
    position: absolute;
  }
  box-shadow: 0px 1px 39px 6px rgba(0, 0, 0, 0.25);
  border-radius: 5px;
  background: white;
  color: #000;
  max-width: 1400px;
  // min-width: 80%;
  padding: 40px 30px 30px 30px;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  gap: 10px;

  transition: all 0.4s;
}
</style>