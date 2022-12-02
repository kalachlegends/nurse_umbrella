<template lang="">
	<label class="input-file">
        <input @change="inputOnChange" type="file" name="file">		
        <span>Выберите файл</span>
  </label>
</template>
<script>
export default {
  name: "input-file",

  props: { file: String },
  methods: {
    inputOnChange(event) {
      this.$emit("inputOnChange", event);
    },
  },
};
</script>
<style lang="scss">
@import "@/assets/scss/colors.scss";
.input-file {
  position: relative;
  display: inline-block;
}
.input-file span {
  font-weight: bold;
  text-transform: uppercase;
  position: relative;
  display: inline-block;
  cursor: pointer;
  outline: none;
  text-decoration: none;
  font-size: 14px;
  vertical-align: middle;
  color: rgb(255 255 255);
  text-align: center;
  border-radius: 4px;
  background-color: $bg-black;

  line-height: 22px;
  height: 40px;
  padding: 10px 20px;
  box-sizing: border-box;
  border: none;
  margin: 0;
  transition: background-color 0.2s;
}
.input-file input[type="file"] {
  position: absolute;
  z-index: -1;
  opacity: 0;
  display: block;
  width: 0;
  height: 0;
}

/* Focus */
.input-file input[type="file"]:focus + span {
  box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

/* Hover/active */
.input-file:hover span {
  background-color: $bg-black-hover;
}
.input-file:active span {
  background-color: $bg-black-hover;
}

/* Disabled */
.input-file input[type="file"]:disabled + span {
  background-color: #eee;
}
</style>