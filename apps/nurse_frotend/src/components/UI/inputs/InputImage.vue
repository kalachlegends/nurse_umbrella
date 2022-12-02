<template lang="">
        <div class="input-block icon ">
            <input v-model="value" @input="onChangeInput" :placeholder="placeholder" class="input" :class="{ 'shadow-danger': error}">
            <img :src="require('@/assets/' + urlImage)" :alt="alt">
        </div>
        <p v-if="error" class="mt-10 text-danger">{{ error }}</p>

</template>
<script>
import { useUploadImage } from "@/hooks/editor/image/useUploadImage";
export default {
  name: "input-image",
  model: {
    prop: "modelValue",
    event: "change",
  },
  props: {
    modelValue: String,
    alt: String,
    placeholder: String,
    urlImage: String,
    error: String,
  },
  methods: {
    onChangeInput(e) {
      this.$emit("update:modelValue", e.target.value);
    },
  },
};
</script>
<style lang="scss" scoped>
.text-danger {
  color: rgb(255, 85, 85);
}
.shadow-danger {
  box-shadow: 0px 1px 16px rgba(255, 0, 0, 0.5);
}
.input-block {
  position: relative;

  &.icon {
    .input {
      padding: 20px 20px 20px 60px;
    }

    img {
      position: absolute;
      top: 32%;
      left: 20px;
    }
  }
}
</style>