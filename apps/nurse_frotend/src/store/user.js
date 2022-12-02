import axios from "@/axios"
import { useRoute, useRouter } from 'vue-router'


export default {
    state: {
        user: {
            login: ""
        }
    },
    getters: {
        getProfile(state) {
            return state.user
        }
    },
    mutations: {
        setUser(state, user) {
            state.user = user
        }
    },
    actions: {
        async fetchProfileByUserId({ state, commit }) {

            const router = useRouter()
            const route = useRoute()

            await axios.get("/user/profile/" + route.params.login).then((res) => {
                commit("setUser", res.data.user)
            }).catch((e) => {
                router.push({
                    name: "404"
                })
            })
        }
    },
}