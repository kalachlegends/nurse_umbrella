import * as yup from 'yup';
import { ref } from 'vue'
export const useValidate = (schema, formData) => {
    const errors = ref({
        isValid: false,
        errors: {}
    })
    const validate = async () => {

        await schema.validate(formData, { abortEarly: false }).then(() => {
            errors.value.isValid = true
            errors.value.errors = {}
        }).catch(function (err) {
            errors.value.isValid = false
            console.log(yupErrorToErrorObject(err))
            errors.value.errors = yupErrorToErrorObject(err)
        })

        return true
    }
    return {
        errors,
        validate,
        getKeyError
    }
}

export default function getKeyError(object, key) {
    if (object[key])
        return object[key][0]
    else
        return ""
}
function yupErrorToErrorObject(err) {
    const object = {};

    err.inner.forEach((x) => {
        if (x.path !== undefined) {
            object[x.path] = x.errors;
        }
    });

    return object;
}