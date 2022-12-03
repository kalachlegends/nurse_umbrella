import { ref } from "vue";
import axios from "@/axios.js"
import { Toast } from "@/helper/defaultAlert";
import { useRouter } from 'vue-router'
import { useValidate } from "../errors/useValidate";
import * as yup from 'yup';
export const useLogin = () => {
    const formData = ref({
        login: "",
        password: ""
    })
    let schema = yup.object().shape({
        login: yup.string().required(),
        password: yup.string().required(),
    });
    const { validate, getKeyError, errors } = useValidate(schema, formData.value)
    const isLoad = ref(false)
    const router = useRouter()
    const handleClickAuth = async () => {
        isLoad.value = true
        await validate()
        if (errors.value.isValid)
            await axios.post("/auth/login", formData.value)
                .then((res) => {
                    axios.defaults.headers.common['Authorization'] = res.data.token
                    localStorage.setItem("token", res.data.token)
                    localStorage.setItem("user", JSON.stringify(res.data.user))
                    console.log(res)

                    Toast.fire({
                        icon: 'success',
                        title: 'Вы вошли'
                    })
                    router.push("/")
                })
                .catch((err) => {
                    Toast.fire({
                        icon: 'error',
                        title: 'Неправильный логин или пароль'
                    })
                })
        isLoad.value = false
    }

    return {
        formData,
        handleClickAuth,
        isLoad,
        getKeyError,
        errors
    }
}