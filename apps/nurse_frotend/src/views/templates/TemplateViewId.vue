<template lang="">
  <h2>Создание документа по шаблону</h2>
  <div class="tabs d-flex gap-10">
    <span  v-for="tab in tabs" :class="{ isActive: tab.selected }">{{ tab.name }}</span>
  </div>
  <p><h3>Название документа</h3>
    <a-input v-model:value="doc.title" placeholder="Имя документа"  />
  </p>
  <div class="doc">
    
    <div class="date">
      <p v-if="doc.date"><b>Дата: {{doc.date}}</b></p>
      <p><i>Первичный осмотр</i></p>
    </div>
    <p><h3>Имя пациента</h3>
      <a-textarea @input="handleChange" @keydown="handleKey(doc.name, $event, 'name')" v-model:value="doc.name" placeholder="Basic usage" :rows="4" />
    </p>
    <p v-if="doc.report_customer"><h3>Жалобы при поступлении</h3>
      <a-textarea @input="handleChange" @keydown="handleKey(doc.report_customer, $event, 'report_customer')" v-model:value="doc.report_customer" placeholder="Basic usage" :rows="4" />
    </p>
    <h3 v-if="!doc.report_customer" @click="() => doc.report_customer = ' '">Жалобы при поступлении <img src="@/assets/img/nurse/plus.svg" alt=""></h3>
    <p v-if="doc.anemesis"><h3>Анамнез заболевания</h3>      
      <a-textarea  @input="handleChange" @keydown="handleKey(doc.anemesis, $event, 'anemesis')" v-model:value="doc.anemesis" placeholder="Basic usage" :rows="4" /> 
    </p>
    <h3 v-if="!doc.anemesis" @click="() => doc.anemesis = ' '">Анамнез заболевания<img src="@/assets/img/nurse/plus.svg" alt=""></h3>
    <p v-if="doc.exam"><h3>По данным последнего обследования</h3> 
      <a-textarea  @input="handleChange"  @keydown="handleKey(doc.exam, $event, 'exam')" v-model:value="doc.exam" placeholder="Basic usage" :rows="4" /> 
    </p>
    <h3 v-if="!doc.exam" @click="() => doc.exam = ' '">По данным последнего обследования <img src="@/assets/img/nurse/plus.svg" alt=""></h3>

    <p v-if="doc.anemesis_life"><h3>Анамнез жизни</h3> 
      <a-textarea  @input="handleChange" v-model:value="doc.anemesis_life" @keydown="handleKey(doc.exam, $event, 'anemesis_life')" placeholder="Basic usage" :rows="4" /> 
    </p>
    <h3 v-if="!doc.anemesis_life" @click="() => doc.anemesis_life = ' '">Анамнез жизни <img src="@/assets/img/nurse/plus.svg" alt=""></h3>
    <p v-if="doc.alergric_anamnes"><h3>Аллергологический анамнез</h3> 
      <a-textarea  @input="handleChange" v-model:value="doc.alergric_anamnes"  @keydown="handleKey(doc.alergric_anamnes, $event, 'alergric_anamnes')" placeholder="Basic usage" :rows="4" /> 
    </p>
    
    <p v-if="doc.object_data"><h3>Объективные данные</h3>  
      <a-textarea  @input="handleChange" v-model:value="doc.object_data"  @keydown="handleKey(doc.object_data, $event, 'object_data')" placeholder="Basic usage" :rows="4" /> </p>
      <h3 v-if="!doc.object_data" @click="() => doc.object_data = ' '">Объективные данные <img src="@/assets/img/nurse/plus.svg" alt=""></h3>
    <p v-if="doc.survey"><h3>Обследование</h3>  
      <a-textarea  @input="handleChange" v-model:value="doc.survey" @keydown="handleKey(doc.survey, $event, 'survey')" placeholder="Basic usage" :rows="4" /> </p>
   
      <h3 v-if="!doc.survey" @click="() => doc.survey = ' '">Обследование<img src="@/assets/img/nurse/plus.svg" alt=""></h3>
    <p v-if="doc.plan"><h3>План лечения</h3>  
      <a-textarea  @input="handleChange" v-model:value="doc.plan" @keydown="handleKey(doc.plan, $event, 'plan')"  placeholder="Basic usage" :rows="4" /> </p>
      <h3 v-if="!doc.plan" @click="() => doc.survey = ' '">План лечения<img src="@/assets/img/nurse/plus.svg" alt=""></h3>
    <p v-if="doc.etc"><h3>Прочее</h3>  
      <a-textarea  @input="handleChange" v-model:value="doc.etc" @keydown="handleKey(doc.etc, $event, 'etc')"  placeholder="Basic usage" :rows="4" /> </p>
      <h3 v-if="!doc.etc">Прочее <img src="@/assets/img/nurse/plus.svg" alt=""></h3>
     
    <p><b>Врач: </b> 
      {{doc.doctor}}
      </p>
      <loader theme="dark" v-if="isLoader" />
      <a-button @click="handleClickUpload" class="btn-default" width="100%"> Создать</a-button>
  </div>
</template>
<script>
import axios from "@/axios";
import { ref, onMounted, computed, inject } from "vue";
import { useRouter, useRoute } from "vue-router";
import { Toast } from "@/helper/defaultAlert";
export default {
  setup() {
    const doc = ref({});
    const user = JSON.parse(localStorage.getItem("user"));
    const isLoad = inject("isLoad");
    console.log(user);
    doc.value.doctor = user.data.name;
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
    const isLoader = ref(false);
    let arrayHints = [];
    onMounted(async () => {
      isLoad.value = true;

      const data = await axios.get("/tab");
      console.log(data);
      docs.value = data.data.data;

      isLoad.value = false;
      arrayHints = docs.value;
    });

    const find = (el) => el.find((el) => el.selected);
    const handleChange = (event) => {
      textArea.value = event.target.value;

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

    const handleKey = (value, e, key_doc) => {
      console.log(value, e);
      console.log(isTab.value, "Istab");
      if ([37, 38, 39, 40].indexOf(e.keyCode) > -1 && isTab.value) {
        e.preventDefault();
      }

      if (e.keyCode == 17) {
        const array = value.split(" ");

        if (tabs.value.length != 0) {
          console.log(find(tabs.value), "AADSASD");
          array.splice(-1, 1, find(tabs.value).change);
        }
        tabs.value = [];
        doc.value[key_doc] = array.join(" ");
        number.value = 0;
      }
    };
    const handleClickUpload = async () => {
      isLoader.value = true;
      delete doc.value.id;
      await axios
        .post("/doc", doc.value)
        .then(() => {
          Toast.fire({
            title: "Успешно создали новый документ",
            icon: "sucsess",
          });
        })
        .catch(() => {
          Toast.fire({
            title: "Успешно создали новый документ",
            icon: "error",
          });
        });
      isLoader.value = false;
    };
    return {
      textArea,
      isLoader,
      handleChange,
      tabs,
      handleKey,
      doc,
      handleClickUpload,
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
  position: fixed;
  width: 100%;
  z-index: 100;

  bottom: 30px;
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