<template lang="">
  <h2 @click="handleClickPdf"> скачать документ</h2>
  <h2>Просмотр документа</h2>
  <div class="doc" id="asd">
    <div class="date">
      <p v-if="doc.date"><b>Дата: {{doc.date}}</b></p>
      <p><i>Первичный осмотр</i></p>
    </div>
    <p v-if="doc.report_customer"><h3>Жалобы при поступлении</h3>{{doc.report_customer}}</p>
    <p v-if="doc.anemesis"><h3>Анамнез заболевания</h3> {{doc.anemesis}}</p>
    <p v-if="doc.exam"><h3>По данным последнего обследования</h3> {{doc.exam}}</p>
    <p v-if="doc.anemesis_life"><h3>Анамнез жизни</h3> {{doc.anemesis_life}}</p>
    <p v-if="doc.alergric_anamnes"><h3>Аллергологический анамнез</h3> {{doc.alergric_anamnes}}</p>
    <p v-if="doc.object_data"><h3>Объективные данные</h3> {{doc.object_data}}</p>
    <p v-if="doc.survey"><h3>Обследование</h3> {{doc.survey}}</p>
    <p v-if="doc.plan"><h3>План лечения</h3> {{doc.plan}}</p>
    <p v-if="doc.etc"><h3>Прочее</h3> {{doc.etc}}</p>
    <p><b>Врач: </b>{{doc.doctor}}</p>
  </div>
</template>
<script>
import axios from "@/axios";
import { ref, onMounted, computed, inject } from "vue";
import { useRouter, useRoute } from "vue-router";
import FileDownload from "js-file-download";
const downloadFile = (blob, fileName) => {
  const link = document.createElement("a");
  // create a blobURI pointing to our Blob
  link.href = URL.createObjectURL(blob);
  link.download = fileName;
  // some browser needs the anchor to be in the doc
  document.body.append(link);
  link.click();
  link.remove();
  // in case the Blob uses a lot of memory
  setTimeout(() => URL.revokeObjectURL(link.href), 7000);
};

export default {
  methods: {
    async handleClickPdf() {
      const element = document.querySelector("#asd");
      console.log(document.documentElement.innerHTML);

      axios
        .post("/pdf_download", {
          doc_html: document.documentElement.innerHTML,
        })
        .then((response) => {
          console.log(response.data);
          downloadFile(
            new Blob([Base64.encode(response.data)], {
              type: "application/pdf",
            }),
            "myfile.pdf"
          );
        });
    },
  },
  setup() {
    const doc = ref({});
    const isLoad = inject("isLoad");
    onMounted(async () => {
      isLoad.value = true;
      const route = useRoute();

      const data = await axios.get("/doc/" + route.params.id);
      doc.value = data.data.data;
      console.log(doc.value);
      isLoad.value = false;
    });
    return {
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
</style>