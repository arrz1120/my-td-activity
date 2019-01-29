import '../assets/sass/reset.scss'
import '../assets/sass/land.scss'
import Vue from 'vue'
import '../api/global.js'
import App from '../landRegister.vue'

// window.urlPrefix=__DEV__?'开发':'生产'
Vue.config.productionTip = false

new Vue({
  el: '#app',
  render:(h=>h(App))
})
