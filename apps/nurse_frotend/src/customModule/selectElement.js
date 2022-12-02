import { addTypeToElement } from "./addTypeToElement"


export default class SelectElement {
    constructor(params) {
        this.elements = params.elements
        this.prevElementSelect = null


        this.start()
    }

    start() {
        this.elements.forEach(element => {
            this.addEventToElement(element)
        });
    }

    pushInElements(newElem) {
        // If a new element is added
        this.elements.push(newElem)
        this.addEventToElement(newElem)
    }
    addEventToElement(element) {
        addTypeToElement(element, "SelectElement")

        element.addEventListener("mousedown", (e) => {

            this.selectCurrent(element)
        })
    }


    selectCurrent(element) {
        if (this.prevElementSelect) {
            this.prevElementSelect.setAttribute('data-select-el', "")
            element.setAttribute('data-select-el', "selected")
            this.prevElementSelect = element
        }
        else {
            element.setAttribute('data-select-el', 'selected')
            this.prevElementSelect = element
        }
    }

}