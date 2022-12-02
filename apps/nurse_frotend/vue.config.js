const { defineConfig } = require('@vue/cli-service')
const path = require("path");

console.log(path.resolve(__dirname, "../../nurse_web/priv/app"), "<----------------------------------------------")
console.log("----->Start WEB PACK<------")
module.exports = defineConfig({
  //outputDir: path.resolve(__dirname, "../../apps/nurse_web/priv/app"),
  transpileDependencies: true
})

