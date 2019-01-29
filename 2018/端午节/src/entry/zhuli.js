import '../sass/zhuli.scss'
import {h,render} from 'preact'
import Timr from 'timrjs'
import raf from 'raf'
import Rule from  "../js/components/rule/rule"
import Footer from '../js/components/footer/footer'
import Msgbox from "../js/components/msgbox/msgbox"
import Toast from '../js/components/toast/toast'

window.Timr=Timr
window.winH=window.innerHeight
window.raf=raf
window.rem=mobileUtils.rem

render(
  <Footer index="2"/>,
  document.body
)

render(
  <Toast/>,
  document.body
)

render(
  <Rule index="2"/>,
  document.body
)

render(
  <Msgbox/>,
  document.body
)