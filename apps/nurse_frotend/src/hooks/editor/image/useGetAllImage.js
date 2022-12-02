import { useStore, defineEmits } from 'vuex'
import { computed, ref, onMounted } from 'vue'
import { usePagination } from '@/hooks/usePagination'
export const useGetAllImage = () => {
    const store = useStore()

    const { changePage, isLoad } = usePagination(
        async () => await store.dispatch("fecthAllImages")
        , (page) => store.commit("setImagePagePagination", page))

    console.log(store.dispatch("fecthAllImages"))
    return {
        isLoad,
        images: computed(() => store.getters.getAllImages),
        page: computed(() => store.getters.getImagePagePagination),
        totalPage: computed(() => store.getters.getImageTotalPagePagination),
        changePage
    }
} 