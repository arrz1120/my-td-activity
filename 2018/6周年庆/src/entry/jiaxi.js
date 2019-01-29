import '../sass/jiaxi.scss'
import Swiper from 'swiper'
import Toast from "../js/components/toast/toast";
import {h,render} from 'preact';


var rem = (20 * ($(window).width() / 320)),
  stretch_rem = 50 / 23.4375 / 2 * rem,
  depth_rem = 120 / 23.4375 / 2 * rem;

var swiper = new Swiper('#swiper-container-main', {
  pagination: '#swiper-pagination-main',
  effect: 'coverflow',
  grabCursor: true,
  centeredSlides: true,
  slidesPerView: 'auto',
  loop : true,
  coverflow: {
    rotate: 0,
    stretch: -stretch_rem,
    depth: depth_rem,
    modifier: 1,
    slideShadows : false
  }
});


window.pageSwiper = swiper;



render(
  <Toast />,
  document.body
);

