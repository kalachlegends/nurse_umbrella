
/* 
CLASS DRAGON DROP
Takes in array ELEMENTS and Take Element Parent


HANGS A MOUSE DOWN EVENT ON EVERY ELEMENT

sets the absolute position for a specific area

*/
import { addTypeToElement } from './addTypeToElement'
export default class DragonDrop {
    constructor(params) {
        this.elements = params.elements
        this.parentElement = params.parentElement
        this.isResize = true




        this.start()
    }
    start() {
        this.elements.forEach(element => {
            this.addEventToElement(element)
            this.makeResizableDiv(element)

        });
    }
    addEventToElement(element) {
        addTypeToElement(element, "DragonDrop")

        element.onmousedown = (e) => {


            let coords = getCoords(element);
            let shiftX = e.pageX - coords.left;
            let shiftY = e.pageY - coords.top;
            element.style.position = 'absolute';


            moveAt(e);



            element.style.zIndex = 50;

            function moveAt(e, boxParenElem) {


                element.style.left = e.pageX - shiftX + 'px';
                element.style.top = e.pageY - shiftY + 'px';


            }

            this.parentElement.onmousemove = (e) => {

                if (this.isResize) {
                    let boxElement = element.getBoundingClientRect(),
                        boxParenElem = this.parentElement.getBoundingClientRect()
                    moveAt(e)
                }


            };

            element.onmouseup = (e) => {
                this.parentElement.onmousemove = null;
                element.onmouseup = null;

            };

            this.parentElement.onmouseup = (e) => {
                this.parentElement.onmousemove = null;
                element.onmouseup = null;

            };


        }

        element.ondragstart = function () {
            return false;
        };

    }
    pushInElements(newElem) {
        // If a new element is added
        this.elements.push(newElem)
        this.addEventToElement(newElem)
        this.makeResizableDiv(newElem)
    }

    makeResizableDiv(element) {

        const resizers = element.querySelectorAll('.resizer')
        const minimum_size = 20;
        let original_width = 0;
        let original_height = 0;
        let original_x = 0;
        let original_y = 0;
        let original_mouse_x = 0;
        let original_mouse_y = 0;
        for (let i = 0; i < resizers.length; i++) {
            const currentResizer = resizers[i];

            currentResizer.addEventListener('mousedown', (e) => {


                this.isResize = false

                e.preventDefault()
                original_width = parseFloat(getComputedStyle(element, null).getPropertyValue('width').replace('px', ''));
                original_height = parseFloat(getComputedStyle(element, null).getPropertyValue('height').replace('px', ''));
                original_x = element.getBoundingClientRect().left;
                original_y = element.getBoundingClientRect().top;
                original_mouse_x = e.pageX;
                original_mouse_y = e.pageY;
                window.addEventListener('mousemove', resize)

                window.addEventListener('mouseup', (e) => {

                    this.isResize = true
                    window.removeEventListener('mousemove', resize)
                })

            })

            function resize(e) {


                if (currentResizer.classList.contains('bottom-right')) {
                    const width = original_width + (e.pageX - original_mouse_x);
                    const height = original_height + (e.pageY - original_mouse_y)
                    if (width > minimum_size) {
                        element.style.width = width + 'px'
                    }
                    if (height > minimum_size) {
                        element.style.height = height + 'px'
                    }
                }
                else if (currentResizer.classList.contains('bottom-left')) {
                    const height = original_height + (e.pageY - original_mouse_y)
                    const width = original_width - (e.pageX - original_mouse_x)
                    if (height > minimum_size) {
                        element.style.height = height + 'px'
                    }
                    if (width > minimum_size) {
                        element.style.width = width + 'px'
                        element.style.left = original_x + (e.pageX - original_mouse_x) + 'px'
                    }
                }
                else if (currentResizer.classList.contains('top-right')) {
                    const width = original_width + (e.pageX - original_mouse_x)
                    const height = original_height - (e.pageY - original_mouse_y)
                    if (width > minimum_size) {
                        element.style.width = width + 'px'
                    }
                    if (height > minimum_size) {
                        element.style.height = height + 'px'
                        element.style.top = original_y + (e.pageY - original_mouse_y) + 'px'
                    }
                }
                else {
                    const width = original_width - (e.pageX - original_mouse_x)
                    const height = original_height - (e.pageY - original_mouse_y)
                    if (width > minimum_size) {
                        element.style.width = width + 'px'
                        element.style.left = original_x + (e.pageX - original_mouse_x) + 'px'
                    }
                    if (height > minimum_size) {
                        element.style.height = height + 'px'
                        element.style.top = original_y + (e.pageY - original_mouse_y) + 'px'
                    }
                }
            }


        }
    }
}
function getCoords(elem) {
    var box = elem.getBoundingClientRect();
    return {
        top: box.top + window.scrollY - 12,
        left: box.left + window.scrollX - 12
    };
}