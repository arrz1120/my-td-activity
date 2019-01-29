import '../sass/jiaxi.scss'
import {h,render,Component} from 'preact'
import Footer from "../js/components/footer/footer"
import Rule from "../js/components/rule/rule"
import Toast from "../js/components/toast/toast"

var mySwiper = new Swiper ('.invest-swiper', {
  loop: true,
  pagination: '.paging',
  nextButton: '.next',
  prevButton: '.prev'
})  

render(
  <Rule index="0" />,
  document.body
)

render(
  <Footer index="0" />,
  document.body
)

render(
  <Toast />,
  document.body
)