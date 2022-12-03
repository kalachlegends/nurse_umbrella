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
        to: "/",
        title: "Главная",
        description: "Сервис по созданию документов",
        urlImage: "img/logo.svg",
      },
      {
        to: "/profile/" + user.login,
        title: "Профиль",
        description: "создавайте документ",
        urlImage: "img/nurse/docAdd.svg",
      },
      {
        to: "/",
        title: "Создать документ",
        description: "создавайте краткую запись длинного текста",
        urlImage: "img/nurse/doc.svg",
      },
      {
        to: "/docs",
        title: "Документы",
        description: "Посмотреть документы",
        urlImage: "img/nurse/template.svg",
      },

      {
        to: "/",
        title: "Создать подсказку",
        description: "создавайте переиспользуемый шаблон",
        urlImage: "img/nurse/template.svg",
      },
      {
        to: "/",
        title: "Создать шаблон",
        description: "просматривайте созданные документы",
        urlImage: "img/nurse/view.svg",
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