import axios from "@/axios"
import { useRoute, useRouter } from 'vue-router'

import { setPaginationFunc, paginationObject, getPaginationFunc } from "@/helper/pagination"
export default {
    state: {
        images: [],
        ...paginationObject(1, 6)
    },
    getters: {
        getAllImages(state) {
            return state.images
        },
        ...getPaginationFunc("Image")
    },
    mutations: {
        setAllImages(state, images) {
            state.images = images
        },
        ...setPaginationFunc("Image")
    },
    actions: {
        async fecthAllImages({ commit, state }) {
            const { page, limit } = state

            const result = await axios.get("/image/get_all", {
                params: {
                    page,
                    limit
                }
            })

            state.totalPage = Math.ceil(result.data.count / limit)

            commit("setAllImages", result.data.images)

            console.log(state.page)
        }
    },
}