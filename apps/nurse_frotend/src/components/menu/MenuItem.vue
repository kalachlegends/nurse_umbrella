<template lang="">
    <li :class="`nav-item ` + sxClass" :style="parseObjectToStyle(sx)">
        <router-link :to="to">
          <div class="nav__img ">
            <img :src="require('@/assets/' + urlImage)" :alt="alt">
          </div>
          <div class="nav__content">
            <div class="nav__title">
                {{title}}
            </div>
            <div class="nav__sub-title">
              {{description}}
            </div>
          </div>
        </router-link>
      </li>
</template>
<script>
import parseObjectToStyle from "@/helper/parseObjectToStyle";
export default {
  name: "menu-item",
  props: {
    to: String,
    urlImage: String,
    title: String,
    description: String,
    alt: String,
    sx: Object,
    sxClass: {
      type: String,
      default: "",
    },
  },
  setup() {
    return {
      parseObjectToStyle,
    };
  },
};
</script>
