<template>
  <div class="optoins">
    <div class="optoins__body">
      <div class="optoins__title mb-16">Text</div>

      <DropDown
        class=""
        :title="titleText"
        @select="select"
        :childrens="childrensText"
      />

      <div class="d-flex">
        <DropDown
          class="w-100p"
          :title="titleWeT"
          @select="selectWeT"
          :childrens="childrensWeT"
        />
        <InputEditor
          v-model:title="titleFz"
          @select="selectFz"
          :childrens="childrensFz"
        />
      </div>
      <btn-plus @click="newEditor">ADD NEW DIALOG</btn-plus>
    </div>
    <iframe ref="edtitor" height="50px" src="" frameborder="0"></iframe>
  </div>
</template>

<script>
import TextEditor from "@/customModule/textEditor";

export default {
  name: "TextEditor",

  props: {
    TextEditors: Array,
  },
  data() {
    return {
      titleText: "Times New Roman",
      childrensText: [
        "Monseratt",
        "Times New Roman",
        "Roboto",
        "Arial",
        "Lucida Console",
      ],
      titleFz: 16,
      childrensFz: [15, 18, 20, 24, 32],
      titleWeT: "Normal",
      childrensWeT: ["Regular", "Bold", "italic", "Underline"],
      currentEditor: {},
      textEditors: [],
    };
  },
  methods: {
    newEditor(event) {
      this.$emit("newEditorClick");
      this.currentEditor.text = "";
    },
    onChangeText() {
      this.$emit("onChangeText", this.currentEditor.text);
    },
    select(event) {
      this.titleText = event.target.dataset.title;
      this.currentEditor.changeFont(event.target.dataset.title);
    },
    selectFz(event) {
      this.titleFz = event.target.dataset.title;
      this.currentEditor.changeSize(event.target.dataset.title);
    },
    selectWeT(event) {
      console.log(event);

      this.titleWeT = event.target.dataset.title;
      this.currentEditor.changeStyle(this.titleWeT);
    },
  },
  mounted() {
    this.currentEditor = new TextEditor({
      iframeElem: this.$refs.edtitor,
      fontFamily: "regular",
      sizeFont: "14",
      callBackKeyUp: this.onChangeText,
    });
  },
  watch: {
    // эта функция запускается при любом изменении вопроса
    titleFz: function (newFZ, oldFZ) {
      this.currentEditor.changeSize(newFZ);
    },
  },
};
</script>

<style scoped lang="scss">
@import "@/assets/scss/colors.scss";

.optoins {
  padding: 15px 15px;
  border-bottom: 1px solid $p-grey;

  &__body {
    display: flex;
    flex-direction: column;
  }

  &__title {
    font-size: 16px;
  }
}
</style>
