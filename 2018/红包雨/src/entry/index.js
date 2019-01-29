import '../assets/sass/reset.scss'
import Vue from 'vue'
import '../api/global.js'
import App from '../index.vue'
import Promise from 'promise-polyfill'
// import VConsole from 'vconsole/dist/vconsole.min.js'

// window.VConsole = new VConsole()
window.Promise = Promise

window.AddMaiDian = function(name,target){
  try {
    sa.quick('trackHeatMap',target)
  } catch (error) {
  }
  try {
    MtaH5.clickStat(name)
  } catch (error) {
  }
}

// window.urlPrefix=__DEV__?'开发':'生产'
Vue.config.productionTip = false

new Vue({
  el: '#app',
  render:(h=>h(App))
})

document.querySelector('.maidian').addEventListener('click',function(e){
  AddMaiDian(e.target.getAttribute('mtaName'),e.target)
})