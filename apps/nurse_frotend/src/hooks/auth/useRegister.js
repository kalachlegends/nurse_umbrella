import { ref } from "vue";
import axios from "@/axios.js"
import { Toast } from "@/helper/defaultAlert";
import { useRouter } from 'vue-router'
import { useValidate } from "../errors/useValidate";
import * as yup from 'yup';
export const useRegister = () => {
    const dataForm = ref({
        email: "",
        login: "",
        password: "",
        repassword: "",
        data: {
            name: ""
        }
    })

    const isLoad = ref(false)
    const router = useRouter()

    let schema = yup.object().shape({
        login: yup.string().required(),
        email: yup.string().required().email(),
        password: yup.string().required(),
        repassword: yup.string().required().oneOf([yup.ref('password'), null], 'Passwords must match')
    });
    const { errors, validate, getKeyError } = useValidate(schema, dataForm.value)
    const handleClickRegister = async () => {
        isLoad.value = true
        await validate()
        if (errors.value.isValid) {
            await axios.post("/auth/register", dataForm.value)
                .then((res) => {
                    axios.defaults.headers.common['Authorization'] = res.data.token
                    localStorage.setItem("token", res.data.token)
                    localStorage.setItem("user", JSON.stringify(res.data.user))
                    console.log(res)

                    Toast.fire({
                        icon: 'success',
                        title: 'Вы успешно зарегистирировали намаз'
                    })
                    router.push("/")
                })
                .catch((err) => {
                    Toast.fire({
                        icon: 'error',
                        title: Object.values(err.response.data.error)[0]
                    })
                })
        }
        isLoad.value = false
    }

    return {
        dataForm,
        handleClickRegister,
        isLoad,
        getKeyError,
        errors
    }
}