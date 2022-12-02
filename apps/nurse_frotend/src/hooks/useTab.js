import { ref, computed } from 'vue'

export const useTab = (defaultImage) => {
    const currentTab = ref(defaultImage)
    const changeTab = (tab) => currentTab.value = tab
    const isTab = (tab) => currentTab.value == tab
    return {
        currentTab,
        changeTab,
        isTab
    }
}