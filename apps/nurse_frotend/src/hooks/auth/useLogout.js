import { ref, useRouter } from "vue";
import axios from "@/axios.js"
import { Toast } from "@/helper/defaultAlert";
export const useLogout = (e) => {
    console.log(e)
    localStorage.removeItem("token")
    localStorage.removeItem("user")
}