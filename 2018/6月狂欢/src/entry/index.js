import 'swiper'
import $ from 'jquery'
import {h,render} from 'preact'
import '../sass/reset.scss'
import '../sass/swiper-3.4.2.scss'
import '../sass/index.scss'
import '../js/lib/lottery'
import '../js/lib/marquee'
import Msgbox from '../js/components/msgbox/msgbox'
import Toast from '../js/components/toast/toast'

window.$=window.Q=$

render(
  <Msgbox/>,
  document.body
)

render(
  <Toast/>,
  document.body
)
