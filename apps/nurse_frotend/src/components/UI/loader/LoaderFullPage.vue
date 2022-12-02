<template lang="">
<Transition>
    <div class="page" v-if="isLoad">
        <img ref="muha" class="muha" src="@/assets/img/icons/muha.svg"/>
      <loader class="govno" theme="dark" />
    </div>
</Transition>
<slot/>
</template>
<script>
import anime from "animejs";
import { ref, provide } from "vue";
export default {
  name: "loader-full-page",

  methods: {},
  computed: {},
  watch: {
    isLoad: function (value) {
      anime({
        targets: this.$refs.muha,
        keyframes: [
          { rotate: -50, translateX: -400 },
          { rotate: -90, translateX: -500 },
          { rotate: 90, translateY: 300 },
          { rotate: 90, translateY: 300 },
          { rotate: 190, translateX: 300 },
          { rotate: 190, translateY: 300 },
          { rotate: -180 },
          { rotate: 20, translateY: -100 },
          { rotate: 50, translateX: 300 },
          { rotate: -50, translateX: 300 },
          { rotate: -50, translateX: -400 },
          { rotate: -90, translateX: -500 },
          { rotate: -90, translateY: 300 },
          { rotate: -90, translateY: 300 },
          { rotate: 190, translateX: 300 },
          { rotate: 190, translateY: 300 },
          { rotate: 10, translateX: 300 },
          { rotate: 10, translateY: 300 },
          { rotate: 160, translateX: 300 },
        ],
        duration: 10000,
        direction: "alternate",
        easing: "cubicBezier(.3, .06, .1, .3)",
        loop: true,
      });
    },
  },
  mounted() {},

  setup() {
    const isLoad = ref(false);

    provide("isLoad", isLoad);
    provide("setIsLoad", (value) => (isLoad.value = value));
    return {
      isLoad,
    };
  },
};
</script>
<style scoped lang="scss">
.muha {
  position: absolute;
  top: 50%;
  left: 50%;
}
.govno {
  div {
  }
}
.v-enter-active,
.v-leave-active {
  transition: opacity 1.5s ease;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}
.page {
  pointer-events: none;
  z-index: 100;
  position: fixed;
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: white;
  top: 0;
  left: 0;
}
</style>