import axios from "@/axios"
import { defineEmits, ref, onMounted } from 'vue'
export const usePagination = (callbackAction, callbackSetPage) => {
    const isLoad = ref(false)
    console.log(callbackAction)
    const callbackFunction = async () => {
        isLoad.value = true
        await callbackAction()
        isLoad.value = false
    }
    onMounted(async () => {

        await callbackFunction()
    })
    const changePage = async (page) => {
        isLoad.value = true
        callbackSetPage(page)
        await callbackFunction(page)
        isLoad.value = false
    }
    return {
        changePage,
        isLoad,
    }
}