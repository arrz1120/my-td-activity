
import '../assets/sass/reset.scss'
import Vue from 'vue'
import App from '../myInvite.vue'

Vue.config.productionTip = false
new Vue({
  el: '#app',
  render:(h=>h(App))
})
  