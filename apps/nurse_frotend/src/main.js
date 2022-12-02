import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

import 'sweetalert2/src/sweetalert2.scss'
import UI from '@/components/UI/index'


console.log(UI)
const app = createApp(App)

UI.forEach(uicomp => {
    app.component(uicomp.name, uicomp)
})
app.use(store).use(router).use()

app.mount('#app')