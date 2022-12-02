import { ref } from "vue"
export default class TextEditor {
    constructor({ iframeElem, fontFamily, sizeFont, callBackKeyUp }) {
        this.iframeElem = iframeElem
        this.fontFamily = fontFamily
        this.sizeFont = sizeFont
        this.text = ref("")
        this.iframeElem.contentDocument.designMode = "On"
        this.callBackKeyUp = callBackKeyUp
        // ADD CSS LINK
        var cssLink = document.createElement("link");
        cssLink.href = "css/editor.css";
        cssLink.rel = "stylesheet";
        cssLink.type = "text/css";
        this.iframeElem.contentDocument.head.appendChild(cssLink);
        this.start(fontFamily, sizeFont)

    }
    start(fontFamily, sizeFont) {
        this.changeFont(fontFamily)
        this.changeSize(sizeFont)
        this.eventOnChange()
    }
    changeFont(FontFamily) {
        this.iframeElem.contentDocument.body.className = to_snake_case(FontFamily)
        this.fontFamily = FontFamily
        this.callBackKeyUp()
    }
    changeSize(size) {
        this.iframeElem.contentDocument.body.style.fontSize = size + "px"
        this.fontFamily = size
        this.callBackKeyUp()
    }
    changeStyle(style) {
        if (style == "Regular") style = ""
        this.iframeElem.contentDocument.execCommand(style)
        this.callBackKeyUp()
    }
    eventOnChange() {
        this.iframeElem.contentDocument.body.addEventListener('keyup', (event) => {
            this.text.value = this.iframeElem.contentDocument.body
            this.callBackKeyUp()
        });
    }
}



function to_snake_case(str) {
    return str.replace(/\s/g, m => "_").toLowerCase()
}
