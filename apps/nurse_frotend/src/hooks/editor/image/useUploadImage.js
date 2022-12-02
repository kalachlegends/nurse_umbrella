import { ref } from "vue";
import { Toast } from "@/helper/defaultAlert";
import axios from '@/axios'
import { useStore, defineEmits } from 'vuex'
import { array } from "yup";
export const useUploadImage = (type) => {
    const store = useStore()
    const isLoad = ref(false)
    let file = ref(null)
    if (type == "array") file = ref([])
    const imgLink = ref(null)
    const uploadImage = async fileInput => {
        try {

            const formData = new FormData();
            if (type == "array") {
                if (fileInput.length > 6)
                    throw "No more than 6 files , please delete"
                fileInput.forEach(element => {
                    errorHandler(element)
                    formData.append("img[]", element);
                });
            }
            else {
                errorHandler(fileInput)
                formData.append("img", fileInput);
            }


            const config = {
                headers: {
                    "Content-Type": "multipart/form-data"
                }
            };

            const result = await axios.post("/upload_img", formData, config);

            store.dispatch("fecthAllImages")

            let message = "Success upload 1"
            if (type == "array") {
                message = `Success upload ${fileInput.length}`
                file.value = []
            }


            Toast.fire({
                title: message,
                icon: "success"
            })

            // imgLink.value = result.data.image.image_url
            // console.log(imgLink.value)
        } catch (error) {
            console.error(error);
            Toast.fire({
                title: error,
                icon: "error"
            })
        }
    };

    const handleClickUploadImage = async () => {
        isLoad.value = true
        if (file.value)
            await uploadImage(file.value);
        else
            Toast.fire({
                title: "File is empty",
                icon: "error"
            })
        isLoad.value = false
    }
    const handleChangeFile = (e) => {
        console.log(e)
        if (type == "array")
            file.value = e;
        else
            file.value = e.target.files[0];
    }
    return {
        isLoad,
        file,
        handleClickUploadImage,
        handleChangeFile,
        imgLink
    }
}

const errorHandler = (file) => {
    if (!/image/.test(file.type))
        throw "The file must be an image"

    if (file.size > 10_000_000)
        throw "File size large"
}