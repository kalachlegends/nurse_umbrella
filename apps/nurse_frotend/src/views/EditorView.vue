<template>
  <div class="draw">
    <div class="draw-row">
      <div class="draw__body">
        <div class="workspace" ref="workspace">
          <div class="items-dragon" ref="itemsDragonDrop">
            <div
              v-for="(item, index) in elementsText"
              class="iframe-position resizer"
              data-types=""
              data-select-el=""
              :key="index"
            >
              <div class="resizers">
                <div class="resizer top-left"></div>
                <div class="resizer top-right"></div>
                <div class="resizer bottom-left"></div>
                <div class="resizer bottom-right"></div>
                <div v-html="htmlReturn(index)"></div>
              </div>
            </div>
          </div>
        </div>
        <div class="workspace__exit">
          <img src="@/assets/img/icons/exit_wkl.svg" alt="" />
        </div>
      </div>

      <div class="draw__body">
        <right-menu>
          <text-optoin
            @on-change-text="onChangeText"
            @new-editor-click="editorRender"
          />
          <image-option />
        </right-menu>
      </div>
    </div>
  </div>
</template>
  
  <script>
import TextOptoin from "@/components/editor/TextOptoin";
import ImageOption from "@/components/editor/ImageOption";
import NovellaDesigner from "@/customModule/NovellDesigner";
import CrudElements from "@/customModule/CrudElement";
import { findBySelect, findById } from "@/helper/find";
import { ref } from "vue";
export default {
  name: "HomeView",
  data() {
    return {
      elementsText: [],
      NovellaDesigner: {},
      innerHtml: [],
    };
  },
  components: { TextOptoin, ImageOption },
  methods: {
    editorRender(arrayEditor) {
      this.elementsText.push("");
      setTimeout(() => {
        const newElem = [...this.$refs.itemsDragonDrop.children].slice(-1)[0];

        this.NovellaDesigner.pushInElements(newElem);
        const elem = this.CrudElements.addNewElement(newElem, {
          html: ref(""),
        });

        this.innerHtml.push(elem);
      }, 10);
    },
    onChangeText(text) {
      if ([...this.$refs.itemsDragonDrop.children].length != 0) {
        const selectedEl = findBySelect([
            ...this.$refs.itemsDragonDrop.children,
          ]),
          id = selectedEl.dataset.id;

        findById(this.innerHtml, id).html = text.outerHTML.replace(
          "body",
          "div"
        );
      }
    },
    htmlReturn(index) {
      if (this.innerHtml[index]) {
        return this.innerHtml[index].html;
      }
      return "";
    },
  },
  computed: {},
  mounted() {
    const workspaceElem = this.$refs.workspace,
      elements = [...this.$refs.itemsDragonDrop.children];

    this.NovellaDesigner = new NovellaDesigner({
      dragonDrop: {
        elements: elements,
        parentElement: workspaceElem,
      },
      selectElement: {
        elements: elements,
      },
    });
    this.CrudElements = new CrudElements(elements);
  },
};
</script>
  <style scoped lang="scss">
@import "@/assets/scss/colors.scss";

.draw {
  height: 100%;

  &-row {
    display: flex;
    height: 100%;
  }

  &__body {
    position: relative;

    &:nth-child(1) {
      flex: 1 1 70%;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    &:nth-child(2) {
      flex: 1 1 15%;
      position: relative;
      z-index: 100;
    }

    height: 100%;
  }
}

.workspace {
  position: relative;
  width: 98%;
  height: 98%;
  border: 1px solid $p-grey;
  overflow: auto;

  &__exit {
    position: absolute;
    top: 10px;
    right: 10px;
  }
}
</style>