<template lang="">
    <router-link :to="'/template/' + id" class="docs">
        <div v-if="title" class="docs__title">
        
            {{obrez(title)}}
        </div>
       
        <div v-if="anemesis" class="docs__name">
          <h3>Амнезиз</h3>
          {{obrez(anemesis)}}
      </div>
      <div v-if="report_customer" class="docs__name">
        <h3>Жалобы пациента</h3>
        {{obrez(report_customer)}}
    </div>
    <div v-if="exam" class="docs__name">
      <h3>Жалобы пациента</h3>
      {{obrez(exam)}}
  </div>
    <div v-if="survey" class="docs__name">
      <h3>По данным последним обследованиям</h3>
    {{obrez(survey)}}
    </div>
    <div v-if="etc" class="docs__name">
      <h3>Прочее</h3>
      {{obrez(etc)}}
      </div>
   
    </router-link >
</template>
<script>
export default {
  name: "a-template",
  props: {
    id: Number,
    title: String,
    name: String,
    report_customer: String,
    anemesis: String,
    exam: String,
    survey: String,
    alergric_anamnes: String,
    etc: String,
  },
  methods: {
    obrez(string) {
      if (string.length > 25) {
        return string.slice(25, 100) + "...";
      }
      return string;
    },
  },
};
</script>
<style lang="scss" scoped>
@import "@/assets/scss/colors.scss";
.docs {
  background: #ffffff;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  flex-direction: column;
  padding: 20px;
  &:hover {
    box-shadow: 0px 0px 11px rgba(0, 57, 83, 0.55);
  }
  box-shadow: $box-shadow-default;
  &__title {
    font-size: 30px;
    font-weight: bold;
  }
  &__body {
  }
  &__name {
  }
}
</style>