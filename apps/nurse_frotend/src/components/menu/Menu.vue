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
        description: "создавайте документ",
        urlImage: "img/nurse/profile.svg",
      },
      {
        to: "/docs_create",
        title: "Создать документ",
        description: "Создавайте документ",
        urlImage: "img/nurse/docAdd.svg",
      },
      {
        to: "/snippets",
        title: "Создать подсказку",
        description: "создавайте краткую запись длинного текста",
        urlImage: "img/nurse/doc.svg",
      },
      {
        to: "/template",
        title: "Посмотреть все шаблоны",
        description: "Посмотреть все шаблоны",
        urlImage: "img/nurse/template.svg",
      },
      {
        to: "/template_create",
        title: "Создать шаблон",
        description: "Создавайте переиспользуемый шаблон",
        urlImage: "img/nurse/icons8-prototype-100.png",
      },
      {
        to: "/docs",
        title: "Посмотреть все документы",
        description: "Просматривайте всё, что было создано",
        urlImage: "img/nurse/view.svg",
      },
      {
        to: "/chart",
        title: "График",
        description: "Графики",
        urlImage: "img/nurse/free-icon-profit-growth-4672328.png",
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