import { ref } from "vue"
export default class CrudElements {

    #optoinsDefault = {
        selected: true,
        dragonDrop: true,
        textOptoin: false,
    }
    constructor(elements, name) {
        this.elements = elements
        this.id = 0
        this.allElements = []


        this.start()
    }

    start() {
        this.elements.forEach(element => {
            addNewElement(element)
        });
    }

    addNewElement(element, optoins) {
        const id = this.newID()
        const newElem = { id, element, ...optoins }

        this.allElements.push(newElem)
        element.setAttribute("data-id", id)
        return newElem
    }

    newID() {
        return this.id += 1
    }
    getElemById(id) {
        return this.allElements.filter(el => el.id == id)
    }
    removeElement(id) {
        this.allElements.filter(el => el.id == id)
    }


}