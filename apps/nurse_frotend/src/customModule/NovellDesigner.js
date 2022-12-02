import TextOptoin from '@/components/editor/TextOptoin'
import CrudElements from '@/customModule/CrudElement'
import DragonDrop from '@/customModule/DragonDrop'
import SelectElement from '@/customModule/selectElement'
export default class NovellaDesigner {

    constructor({ dragonDrop, selectElement }) {
        this.DragonDrop = new DragonDrop(dragonDrop)
        this.SelectElement = new SelectElement(selectElement)

    }

    pushInElements(newElem) {
        this.DragonDrop.pushInElements(newElem)
        this.SelectElement.pushInElements(newElem)
    }


}