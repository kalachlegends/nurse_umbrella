<template>
  <div class="profile">
    <div class="profile__img-rounted">
      <img class="profile__img img-fluid" :src="user.data.img" alt="">
    </div>
    <p class="profile__name">{{user.data.name}}</p>
    <div class="profile__text">Ваш логин&nbsp;
      <p class="profile__text-fw">{{user.login}}</p>
    </div>
    <div class="profile__text">Ваш email&nbsp;
      <p class="profile__text-fw">{{user.email}}</p>
    </div>
  </div>
  <div class="grid">
    <a-template v-if="doc.length != 0" v-for="item in doc" :name="item.name" :title="item.title"
      :anemesis="item.anemesis" :to="'/docs/'" :report_customer="item.report_customer" :exam="item.exam" :id="item.id">
    </a-template>
    <h3 v-else> Нету Документов</h3>


  </div>
</template>
<script>

  import { ref, onMounted, computed, inject } from "vue";
  import { useGetProfile } from "@/hooks/user/useGetProfile";
  export default {
    setup() {
      const { user, doc } = useGetProfile();


      return {
        user,
        doc,
      };
    },
  };
</script>
<style lang="scss" scoped>
  @import "@/assets/scss/colors.scss";

  p {
    margin: 0;
    padding: 0;
  }

  .grid {
    display: grid;
    grid-template: 1fr/1fr 1fr 1fr;
    gap: 10px;
  }

  .profile {
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    flex-direction: column;
    color: $black;

    &__img {
      width: 150px;
      height: 150px;
      border-radius: 100px;
    }

    &__img-rounted {
      display: flex;
      justify-content: center;
      align-items: center;
      border-radius: 100px;
      width: 150px;
      height: 150px;
      background-color: $black;
      margin: 0 0 10px 0;
    }

    &__name {
      font-size: 20px;
      font-weight: 700;
      margin: 0 0 10px 0;
    }

    &__text {
      display: flex;
      font-size: 18px;

      &-fw {
        font-weight: 700;
      }
    }
  }

  .content {
    margin: 20px 0 0 0;
    width: 100%;
    color: #fff;
  }

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