<template>
  <div class="profile">
    <div class="profile__img-rounted">
      <img class="profile__img img-fluid" src="{{user.data.img}}" alt="">
    </div>
    <p class="profile__name">{{user.data.name}}</p>
    <div class="profile__text">Ваш логин&nbsp;
      <p class="profile__text-fw">{{user.login}}</p>
    </div>
    <div class="profile__text">Ваш email&nbsp;
      <p class="profile__text-fw">{{user.email}}</p>
    </div>
  </div>
  <div class="content">
    Lorem ipsum dolor sit amet consectetur adipisicing elit. Ullam debitis veritatis rem vero harum alias! In modi voluptate dolorum excepturi nostrum dicta eum dignissimos amet vel ad dolor sapiente sunt suscipit nihil quam inventore, consectetur quidem animi sed quisquam fugiat molestiae eos possimus? Minus, vero totam velit iure necessitatibus recusandae sit ea. Ipsa eveniet ut qui doloribus fugiat repudiandae ex excepturi corporis inventore officiis recusandae voluptate, optio, animi natus nihil similique. Esse voluptate harum eum neque ut. Quam repellat porro commodi, dolore cum ea, labore recusandae laborum totam odit, illo eligendi obcaecati ducimus? Rem odio cupiditate eius molestiae illum aspernatur.
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
<style lang="scss" scoped>
  @import "@/assets/scss/colors.scss";

  p{
    margin: 0;
    padding: 0;
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

  .content{
    margin: 20px 0 0 0;
    width: 100%;
    color: #fff;
    background-color: $black;
  }
</style>