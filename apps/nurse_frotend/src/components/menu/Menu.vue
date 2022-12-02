<template lang="">
   <wrap-menu> 
    <wrap-list-menu>
        <menu-item 
        v-for="item in routes" :key="item.to"
        :to="item.to" 
        :title="item.title"
        :urlImage="item.urlImage"
        :description="item.description"
         />
     </wrap-list-menu>
     <wrap-list-menu>
        <menu-item 
        @click="logout"
        sxClass=" bottom"
        to="/login" 
        title="Выйти"
        urlImage="img/icons/logout.svg"
        description="Выйти из своего профиля"
 
         />
    </wrap-list-menu>
   </wrap-menu>
  
</template>
<script>
import MenuItem from "@/components/menu/MenuItem.vue";
import WrapMenu from "@/components/menu/WrapMenu.vue";
import WrapListMenu from "@/components/menu/WrapListMenu.vue";
import { useLogout } from "@/hooks/auth/useLogout";
export default {
  name: "n-menu",
  components: {
    MenuItem,
    WrapMenu,
    WrapListMenu,
  },
  setup() {
    const user = JSON.parse(localStorage.getItem("user"));
    const routes = [
      {
        to: "/profile/" + user.login,
        title: "Профиль",
        description:
          "Ваша страничка профиля тут вы можете просматривать свой профиль",
        urlImage: "img/icons/profile.svg",
      },
      {
        to: "/editor",
        title: "Создание новел",
        description: "Здесь вы можете создать свою новеллу",
        urlImage: "img/icons/edit-box.svg",
      },
    ];
    return {
      routes,
      logout: useLogout,
    };
  },
};
</script>
<style lang="">
</style>