<template lang="">
  <h2>Создание документа по шаблону</h2>
  <div class="tabs d-flex gap-10" v-for="tab in tabs">
    <span :class="{ isActive: tab.selected }">{{ tab.name }}</span>
  </div>
  <div class="doc">
    <div class="date">
      <p v-if="doc.date"><b>Дата: {{doc.date}}</b></p>
      <p><i>Первичный осмотр</i></p>
    </div>
  
    <p v-if="doc.report_customer"><h3>Жалобы при поступлении</h3>
      <a-textarea @input="handleChange" @keydown="handleKey" v-model:value="doc.report_customer" placeholder="Basic usage" :rows="4" />
      
    </p>
    <p v-if="doc.anemesis"><h3>Анамнез заболевания</h3>      
      <a-textarea  @input="handleChange" v-model:value="doc.anemesis" placeholder="Basic usage" :rows="4" /> 
    </p>
    <p v-if="doc.exam"><h3>По данным последнего обследования</h3> 
      <a-textarea  @input="handleChange" v-model:value="doc.exam" placeholder="Basic usage" :rows="4" /> 
    </p>
    <p v-if="doc.anemesis_life"><h3>Анамнез жизни</h3> 
      <a-textarea  @input="handleChange" v-model:value="doc.anemesis_life" placeholder="Basic usage" :rows="4" /> 
      </p>
    <p v-if="doc.alergric_anamnes"><h3>Аллергологический анамнез</h3> 
      <a-textarea  @input="handleChange" v-model:value="doc.alergric_anamnes" placeholder="Basic usage" :rows="4" /> 
    </p>
    <p v-if="doc.object_data"><h3>Объективные данные</h3>  
      <a-textarea  @input="handleChange" v-model:value="doc.object_data" placeholder="Basic usage" :rows="4" /> </p>
    <p v-if="doc.survey"><h3>Обследование</h3>  
      <a-textarea  @input="handleChange" v-model:value="doc.survey" placeholder="Basic usage" :rows="4" /> </p>
    <p v-if="doc.plan"><h3>План лечения</h3>  
      <a-textarea  @input="handleChange" v-model:value="doc.plan" placeholder="Basic usage" :rows="4" /> </p>
    <p v-if="doc.etc"><h3>Прочее</h3>  
      <a-textarea  @input="handleChange" v-model:value="doc.etc" placeholder="Basic usage" :rows="4" /> </p>
    <p><b>Врач: </b> 
      {{doc.doctor}}
      </p>

      <a-button class="btn-default" width="100%"> Создать</a-button>
  </div>
</template>
<script>
import axios from "@/axios";
import { ref, onMounted, computed, inject } from "vue";
import { useRouter, useRoute } from "vue-router";
export default {
  setup() {
    const doc = ref({});
    const isLoad = inject("isLoad");
    onMounted(async () => {
      isLoad.value = true;
      const route = useRoute();
      const data = await axios.get("/template/" + route.params.id);
      doc.value = data.data.data;

      isLoad.value = false;
    });
    const textArea = ref("");
    const tabs = ref([]);
    const regex = ref("");
    const lastElement = ref("");
    const isTab = ref(false);
    const number = ref(0);
    const docs = ref({});

    let arrayHints = [];
    onMounted(async () => {
      isLoad.value = true;

      const data = await axios.get("/tab");
      console.log(data);
      docs.value = data.data.data;

      isLoad.value = false;
      arrayHints = doc.value;
    });

    const find = (el) => el.find((el) => el.selected);
    const handleChange = (event) => {
      textArea.value = event.target.value;
      console.log(textArea.value);
      lastElement.value = event.target.value.split(" ").pop();
      console.log(lastElement.value == "");
      if (lastElement.value == "") {
        lastElement.value = "  4125   ";
      }
      console.log(tabs.value),
        (regex.value = new RegExp(`${lastElement.value}`, "gi"));
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
      doc,
    };
  },
};
</script>
<style lang="scss" >
@import "@/assets/scss/colors.scss";

.doc {
  width: 100%;
  height: auto;
  background-color: #fff;
  border: 1px solid $black;
  padding: 20px 30px;
  font-size: 16px;
}
h3 {
  text-align: center;
}
.date {
  display: flex;
  justify-content: space-between;
  i {
    font-size: 18px;
  }
}
.btn-default {
  width: 100%;
  font-weight: bold;
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