<template lang="">
    <div class="main-clean">
        <div class="login-block">
    
    
            <a href="/" class=" logo-vertical">
                <div class="logo-vertical__image img-fluid">
                    <img src="@/assets/img/logo.svg" alt="">
                </div>
                
                <span class="black-text">AnamnesisDoc</span>
            </a>
    
                <form class="login-block__body">
        
                  <loader v-if="isLoad" :sx="{alignSelf: 'center'}" />
                  <input-image v-model="dataForm.email" :placeholder="'Емайл'"  urlImage="img/icons/baseline-email.svg" :error="getKeyError(errors.errors, 'email')" />
                  <input-image v-model="dataForm.login"  :placeholder="'Логин'" urlImage="img/icons/user.svg" :error="getKeyError(errors.errors, 'login')" />
                  <input-image v-model="dataForm.password" :placeholder="'Пароль'"  urlImage="img/icons/lock-password.svg" :error="getKeyError(errors.errors, 'password')" />
                  <input-image v-model="dataForm.repassword" :placeholder="'Повторите пароль'"  urlImage="img/icons/lock-password.svg" :error="getKeyError(errors.errors, 'repassword')" />
               
                    <button @click.prevent="handleClickRegister" type="submit" class="btn-grey">
                        Войти
                    </button>
                    <div class="df-aic-jc-fx-c gap-10">
                        <router-link to="/login" class="text-align-center width-80 black-text">У вас уже есть аккаунт? Тогда войдите!</router-link>
                    </div>
                </form>
            </div> 
    </div>
    </template>
<script>
import { ref } from "vue";
import { useRegister } from "@/hooks/auth/useRegister";
export default {
  setup() {
    const { dataForm, handleClickRegister, isLoad, getKeyError, errors } =
      useRegister();

    return {
      dataForm,
      handleClickRegister,
      isLoad,
      getKeyError,
      errors,
    };
  },
};
</script>
<style lang="scss" scoped>
@import "@/assets/scss/mixins/mixins.scss";
.main-clean {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f3f3f3;
}

.login-block {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;

  gap: 40px;
  &__body {
    gap: 12px;
    width: 50%;
    display: flex;

    flex-direction: column;
    a {
      font-weight: 500;
      text-decoration: underline;
      @include adaptiv-font(14, 13);
    }
  }
}
.logo-vertical {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  gap: 10px;
  span {
    font-style: normal;
    font-weight: 600;
    @include adaptiv-font(40, 24);
  }
  &__image {
    width: 58%;
    position: relative;
    padding: 0px 0 60% 0;
  }
}
</style>