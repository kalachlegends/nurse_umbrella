<template lang="">
    <div class="docs">
        <div v-if="title" class="docs__title">
            {{title}}
        </div>
        <div v-if="body" class="docs__body">
            {{body}}
        </div>
        <div v-if="name" class="docs__name">
          {{name}}
      </div>
    </div>
</template>
<script>
export default {
  name: "a-template",
  props: {
    title: String,
    name: String,
  },
};
</script>
<style lang="scss" scoped>
.docs {
  background: #ffffff;
  &__title {
  }
  &__body {
  }
  &__name {
  }
}
</style>