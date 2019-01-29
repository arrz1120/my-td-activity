import '../assets/sass/base.scss'
import Vue from 'vue'
import App from '../index.vue'

// window.urlPrefix=__DEV__?'开发':'生产'
Vue.config.productionTip = false
window.vm = new Vue({
  el: '#app',
  render:(h=>h(App))
})
