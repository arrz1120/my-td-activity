import '../assets/sass/reset.scss'
import '../assets/sass/swiper-3.4.2.scss'
import Vue from 'vue'
import '../api/global.js'
import App from '../inviteRecord.vue'

// window.urlPrefix=__DEV__?'开发':'生产'
Vue.config.productionTip = false

new Vue({
  el: '#app',
  render:(h=>h(App))
})
