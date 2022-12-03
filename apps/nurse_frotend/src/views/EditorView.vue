<template>
  <h1>Editor</h1>
  <div class="tabs d-flex gap-10" v-for="tab in tabs">
    <span>{{ tab.name }}</span>
  </div>
  <textarea
    v-model="textArea"
    @input="handleChange"
    ref="textarea"
    @keydown="handleKey"
  >
  </textarea>
</template>
  
  <script>
import { ref } from "@vue/reactivity";
export default {
  setup() {
    const textArea = ref("");
    const tabs = ref([]);
    const regex = ref("");
    const lastElement = ref("");
    const arrayHints = [
      {
        name: "Хуй",
        change: "Хуй собаки в жопе",
      },
      {
        name: "Мой",
        change: "Мой собаки в жопе",
      },
      {
        name: "Ебал",
        change: "Ебал собак жопой",
      },
      {
        name: "Соси",
        change: "Соси",
      },
    ];
    const handleChange = (event) => {
      textArea.value = event.target.value;
      lastElement.value = event.target.value.split(" ").pop();
      console.log(lastElement.value == "");
      if (lastElement.value == "") {
        lastElement.value = "     ";
      }

      regex.value = new RegExp(`${lastElement.value}`, "gi");
      console.log(
        arrayHints.filter((el) => {
          lastElement.value == "";
          return regex.value.test(el.name);
        })
      );

      tabs.value = arrayHints.filter((el) => regex.value.test(el.name));
    };
    const handleKey = (e) => {
      if (e.keyCode == 17) {
        const array = textArea.value.split(" ");

        if (tabs.value != []) {
          array.splice(-1, 1, tabs.value[0].change);
        }
        tabs.value = [];
        textArea.value = array.join(" ");
      }
    };

    return {
      textArea,
      handleChange,
      tabs,
      handleKey,
    };
  },
};
</script>
  <style scoped lang="scss">
textarea {
  border: 1px solid black;
  width: 100%;
}
.tabs {
  span {
  }
}
</style>