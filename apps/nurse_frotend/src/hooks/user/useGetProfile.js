import { useRouter, useRoute } from "vue-router";
import { useStore } from 'vuex'
import { ref, onMounted, computed, inject } from 'vue'
import axios from "@/axios";
export const useGetProfile = () => {
    const route = useRoute()
    const isLoad = inject('isLoad')
    const doc = ref([])
    const store = useStore()
    onMounted(async () => {
        console.log(isLoad)
        isLoad.value = true



        await store.dispatch("fetchProfileByUserId", route.params.login)
        const data = await axios.get("/doc/last_six_docs");
        console.log(data)
        doc.value = data.data.doc_list;
        isLoad.value = false

    })


    return {
        user: computed(() => store.getters.getProfile),
        doc
    }
}
