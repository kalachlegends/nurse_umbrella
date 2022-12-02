
const types = ["DragonDrop", "TextEditor", "SelectElement"]



/**
* Add dataset to element with type
* @param {HTMLElement} element
* @param {string} type
*/
export const addTypeToElement = (element, type) => {
    const dataSet = element.dataset.types
    const typeFind = findType(type)
    console.log(dataSet)
    if (dataSet == "") {
        element.setAttribute("data-types", typeFind)
    }
    else {
        element.setAttribute("data-types", dataSet + `, ${typeFind}`)
    }

}
// export const parseType = (element) => element.dataset.types.split(",")

export const deleteType = (element, type) => {
    const regex = new RegExp(`(\\s|,)?${type}`)
    element.dataset.types = element.dataset.types.replace(regex, "")
}

const findType = (type) => {
    const typeFind = types.find((elType) => type == elType)
    if (typeFind)
        return typeFind
    else throw new Error("TYPE UNDIFINED")
}