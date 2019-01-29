import '../assets/sass/base.scss'
import Vue from 'vue'
import App from '../write.vue'

// window.urlPrefix=__DEV__?'开发':'生产'
Vue.config.productionTip = false

new Vue({
  el: '#app',
  render:(h=>h(App))
})
