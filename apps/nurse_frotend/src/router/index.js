import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/auth/LoginView.vue'
import NotFound from '@/views/error/NotFound.vue'
import { Toast } from '@/helper/defaultAlert'
const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView,
    meta: {
      requiresAuth: true,
      layout: "AppLayoutMenu"
    },
  },
  {
    path: '/login',
    name: 'login',
    component: LoginView,

  },
  {
    path: '/about',
    name: 'about',
    component: () => import('../views/AboutView.vue'),
    meta: {
      requiresAuth: true,
      layout: 'AppLayoutAdmin'
    },
  },
  {
    path: '/profile/:login',
    name: 'profile',
    component: () => import('@/views/ProfileView.vue'),
    meta: {
      requiresAuth: true,
      layout: "AppLayoutMenu"
    },
  },
  {
    path: '/docs',
    name: 'docs',
    component: () => import('@/views/docs/DocsView.vue'),
    meta: {
      requiresAuth: true,
      layout: "AppLayoutMenu"
    },
  },
  {
    path: '/docs/:id',
    name: 'docs_id',
    component: () => import('@/views/docs/DocsViewId.vue'),
    meta: {
      requiresAuth: true,
      layout: "AppLayoutMenu"
    },
  },
  {
    path: '/editor',
    name: 'editor',
    component: () => import('@/views/EditorView.vue'),
    meta: {
      requiresAuth: true,
      layout: "AppLayoutMenu"
    },
  },
  {
    path: '/register',
    name: 'register',
    component: () => import('@/views/auth/RegisterView.vue'),
    meta: {
      requiresAuth: false,
    },
  },
  {
    name: "404",
    path: '/:pathMatch(.*)*', component: NotFound
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
    var token = localStorage.getItem("token");
    if (!token) {
      Toast.fire({
        title: "Вы не авторизованы",
        icon: "error"
      })
      next({
        path: '/login',
      })
    } else {
      next()
    }
  } else {
    next()
  }

})
export default router
