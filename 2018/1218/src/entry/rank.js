import Vue from 'vue'
import '../js/lib/common.js'
import App from '../rank.vue'

// window.urlPrefix=__DEV__?'开发':'生产'
Vue.config.productionTip = false

new Vue({
  el: '#app',
  render:(h=>h(App))
})
