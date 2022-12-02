import { useRouter, useRoute } from "vue-router";
import { useStore } from 'vuex'
import { ref, onMounted, computed, inject } from 'vue'

export const useGetProfile = () => {
    const route = useRoute()
    const isLoad = inject('isLoad')

    const store = useStore()
    onMounted(async () => {
        console.log(isLoad)
        isLoad.value = true

        await store.dispatch("fetchProfileByUserId", route.params.login)
        isLoad.value = false

    })


    return {
        user: computed(() => store.getters.getProfile)
    }
}
