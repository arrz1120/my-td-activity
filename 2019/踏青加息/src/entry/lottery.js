
import Vue from 'vue'
import '../js/lib/common.js'
import App from '../lottery.vue'

Vue.config.productionTip = false
new Vue({
  el: '#app',
  render:(h=>h(App))
})
  