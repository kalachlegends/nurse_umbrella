<template>
   <h3 class="text-align-center">Ваши последние документы</h3>
   <div class="docs">
      <div class="docs__body">
         <div class="docs__temp">
            <div class="docs__name">name</div>
            <div class="docs__rep">report</div>
            <div class="docs__date">{{doc.date}}</div>
         </div>
         <div class="docs__title">title</div>
      </div>

      <div class="docs__body">
         <div class="docs__temp">
            <div class="docs__name">name</div>
            <div class="docs__rep">report</div>
            <div class="docs__date">2022-20-10</div>
         </div>
         <div class="docs__title">title</div>
      </div>

      <div class="docs__body">
         <div class="docs__temp">
            <div class="docs__name">name</div>
            <div class="docs__rep">report</div>
            <div class="docs__date">2022-20-10</div>
         </div>
         <div class="docs__title">title</div>
      </div>

      <div class="docs__body">
         <div class="docs__temp">
            <div class="docs__name">name</div>
            <div class="docs__rep">report</div>
            <div class="docs__date">2022-20-10</div>
         </div>
         <div class="docs__title">title</div>
      </div>
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
            const data = await axios.get("/profile/" + user.login);
            doc.value = data.data.data;

            isLoad.value = false;
         });
         return {
            doc,
         };
      },
   };
</script>

<style lang="scss" scoped>
   @import "@/assets/scss/colors.scss";

   .docs {
      display: flex;
      justify-content: center;
      align-items: center;
      color: $black;

      &__body {
         font-size: 24px;
         margin: 0 20px;
      }

      &__temp {
         background-color: #fff;
         border: 1px solid $black;
         min-width: 225px;
         min-height: 300px;
         border-radius: 5px;
         padding: 20px;
         position: relative;
      }

      &__name {}

      &__rep {}

      &__date {
         font-size: 20px;
         position: absolute;
         bottom: 10px;
         right: 10px;
      }

      &__title {
         text-align: center;
      }
   }
</style>