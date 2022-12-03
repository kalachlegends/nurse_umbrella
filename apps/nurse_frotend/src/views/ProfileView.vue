<template lang="">
  <!-- {{user.login}}
{{user.id}} -->
  <div class="profile">
    <div class="profile__img-rounted">
      <img class="profile__img img-fluid" src="{{user.data.img}}" alt="">
    </div>
    <p class="profile__name">Имя Фамилия</p>
    <p class="profile__text">Ваш логин&nbsp;<div class="profile__text-fw">{{user.login}}</div></p>
    <p class="profile__text">Ваш email&nbsp;<div class="profile__text-fw">{{user.email}}</div></p>
  </div>


</template>
<script>
  import { useGetProfile } from "@/hooks/user/useGetProfile";
  export default {
    setup() {
      const { user } = useGetProfile();
      console.log(user);
      return {
        user,
      };
    },
  };
</script>
<style lang="scss">
  @import "@/assets/scss/colors.scss";

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
      &-fw{
        font-weight: 700;
      }
    }
  }
</style>