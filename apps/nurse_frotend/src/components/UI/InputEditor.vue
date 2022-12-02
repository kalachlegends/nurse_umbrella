<template lang="">

        <div class="drop-down " >
            <div class="drop-down__title df-aic"  @click="openDropDown">
                <input class="input-default" type="number"  min="1"  max="100" maxlength="100" v-model="title"  @input="changeTitle"  :placeholder="title" />
          
                <span class="arrow-drop df-aic-jcc ml-16">
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
  name: "InputEditor",
  model: {
    prop: "title",
    event: "change",
  },
  emits: ["update:title"],
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
    openDropDown(event) {
      if (event.path[0].className != "input-default") {
        if (this.isOpen) this.isOpen = false;
        else this.isOpen = true;
      }
    },
    selectet(event) {
      this.openDropDown(event);
      this.$emit("select", event);
    },
    changeTitle(e) {
      if (e.target.value.length > 2)
        e.target.value = e.target.value.slice(0, 2);
      this.$emit("update:title", e.target.value); // раньше было `this.$emit('input', title)`
    },
  },
  watch: {},
};
</script>
<style scoped lang="scss">
@import "@/assets/scss/colors.scss";

.drop {
  &-down {
    &:hover {
      outline: 1px solid $p-grey;

      .arrow-drop {
        opacity: 1;
        visibility: visible;
      }
    }
  }

  &-down__title {
  }

  &-down__children {
  }

  &-down__item-child {
  }
}

.input-default {
  width: 40px;
}

.arrow-drop {
  opacity: 0;
  visibility: hidden;
}
</style>