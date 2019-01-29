import Vue from 'vue'
import App from './App'
Vue.config.productionTip = false
// window.abcdefg = 'abc'

window.vm = new Vue({
  el: '#app',
  components: { App },
  template: '<App/>'
})