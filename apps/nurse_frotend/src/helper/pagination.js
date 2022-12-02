import { array } from "yup"

export const paginationObject = (page, limit, totalPage = null) => {
    return {
        page,
        limit,
        totalPage
    }
}
export function paginateArray(page_size, page_number, totalPage) {

    let arr = []
    if (page_number > page_size) {
        if (totalPage - page_size >= page_number)

            for (let i = page_number - page_size / 2; i < page_number + page_size; i++) {

                arr.push(i)
            }
        else
            for (let i = totalPage - page_size; i <= totalPage; i++) {
                arr.push(i)
            }
    }
    else
        if (totalPage <= page_size)
            for (let i = 1; i <= totalPage; i++) {
                arr.push(i)
            }
        else {
            for (let i = 1; i <= page_size + 1; i++) {
                arr.push(i)
            }
        }




    return arr;
}
export const setPaginationFunc = (name) => {
    let obj = {}
    const page = `set${name}PagePagination`,
        limit = `set${name}LimitPagination`,
        totalPage = `set${name}TotalPagePagination`

    obj[page] = (state, item) => state.page = item


    obj[limit] = (state, item) => state.limit = item
    obj[totalPage] = (state, item) => state.totalPage = item
    console.log(obj)
    return obj
}



export const getPaginationFunc = (name) => {
    let obj = {}
    const page = `get${name}PagePagination`,
        limit = `get${name}LimitPagination`,
        totalPage = `get${name}TotalPagePagination`

    obj[page] = (state) => state.page
    obj[limit] = (state) => state.limit
    obj[totalPage] = (state) => state.totalPage
    return obj
}



