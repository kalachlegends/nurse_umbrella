<template>
  <h1>Editor</h1>
  <div class="tabs d-flex gap-10" v-for="tab in tabs">
    <span :class="{ isActive: tab.selected }">{{ tab.name }}</span>
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
import { is } from "@babel/types";
import { ref } from "@vue/reactivity";
import { onMounted } from "@vue/runtime-core";
export default {
  setup() {
    const textArea = ref("");
    const tabs = ref([]);
    const regex = ref("");
    const lastElement = ref("");
    const isTab = ref(false);
    const number = ref(0);
    const arrayHints = [
      {
        name: "со слов пациента",
        change: "со слов пациента считает себя больным с 2017 года,",
        selected: false,
      },
      {
        name: "появился",
        change: "появился учащенный стул с кровью, проведена ВКС от 13.11.17",
        selected: false,
      },
      {
        name: "обратилс",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "фыв",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "сячс",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "лорлор",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "паврпааппр",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "ыфвыфввыф",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "123213",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "авппап",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "папап",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "пап",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "фвывап",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "ыфввыф",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "ывф",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "вц14312312",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
      {
        name: "выфывфвыфвыф",
        change:
          "Обратился к проктологу, параректальный свищ? при аноскопии-слизистая с эрозированной поверхностью, контактно кровоточит.",
        selected: false,
      },
    ];
    const find = (el) => el.find((el) => el.selected);
    const handleChange = (event) => {
      textArea.value = event.target.value;
      lastElement.value = event.target.value.split(" ").pop();
      console.log(lastElement.value == "");
      if (lastElement.value == "") {
        lastElement.value = "  4125   ";
      }

      regex.value = new RegExp(`${lastElement.value}`, "gi");
      console.log(
        arrayHints.filter((el) => {
          lastElement.value == "";
          return regex.value.test(el.name);
        })
      );

      tabs.value = arrayHints.filter((el) => regex.value.test(el.name));

      if (tabs.value.length != 0) {
        tabs.value.filter((el) => {
          if (el.selected) el.selected = false;
        });
        isTab.value = true;
        tabs.value[0].selected = true;
        number.value = 0;
      } else {
        isTab.value = false;
      }
    };
    onMounted(() => {
      window.addEventListener("keydown", (e) => {
        if (e.keyCode == 40) {
          if (isTab.value && tabs.value.length - 1 != number.value) {
            console.log(number.value);
            tabs.value[number.value].selected = false;
            number.value = number.value + 1;
            tabs.value[number.value].selected = true;
          }
        }
        if (e.keyCode == 38)
          if (isTab.value && number.value != 0) {
            tabs.value[number.value].selected = false;
            number.value = number.value - 1;
            tabs.value[number.value].selected = true;
          }
      });
    });

    const handleKey = (e) => {
      console.log(isTab.value, "Istab");
      if ([37, 38, 39, 40].indexOf(e.keyCode) > -1 && isTab.value) {
        e.preventDefault();
      }

      if (e.keyCode == 17) {
        const array = textArea.value.split(" ");

        if (tabs.value.length != 0) {
          console.log(find(tabs.value), "AADSASD");
          array.splice(-1, 1, find(tabs.value).change);
        }
        tabs.value = [];
        textArea.value = array.join(" ");
        number.value = 0;
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
@import "@/assets/scss/colors.scss";
textarea {
  border: 1px solid black;
  width: 100%;
}

.tabs {
  height: 30px;
  span {
    background: $bg-main;
    color: white;
    padding: 10px;
    font-weight: bold;

    &.isActive {
      color: black;
    }
  }
}
</style>