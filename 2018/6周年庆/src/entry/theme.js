import '../sass/theme.scss'
import Swiper from 'swiper'
import {h,render} from 'preact'
import lazyLoad from '../js/lib/lazyLoad.js'
import Toast from '../js/components/toast/toast'

render(
  <Toast/>,
  document.body
)

window.winH=window.innerHeight
window.rem=mobileUtils.rem

let doms={
  sections:Q('.theme-section'),
  arrow:Q('.down-arrow')
}

// let ukVideo
// let themeSwiperIdx=0

new Swiper('.swiper-theme',{
  initialSlide:0,
  direction:'vertical',
  onInit(swiper){
    let idx=swiper.realIndex
    Q('.swiper-theme').css({
      height:`${winH}px`
    })
    lazyLoad('.section-1st').then(arr=>{
      doms.sections.eq(idx).addClass('on')
    })
    // ukVideo=new YKU.Player('js-video', {
    //   client_id: '52b3fa57e9fe17cf',
    //   autoplay: false,
    //   vid: 'XMzY3NTA4MTQ4NA==',
    //   show_related: false,
    // })
  },
  onTransitionEnd(swiper){
    let idx=swiper.realIndex
    let isEnd=swiper.isEnd
    // if(idx!==themeSwiperIdx){
    //   ukVideo.pauseVideo()
    // }
    // themeSwiperIdx=idx
    doms.arrow.removeClass('hide')
    doms.sections.removeClass('on').eq(idx).addClass('on')
    isEnd&&doms.arrow.addClass('hide')
  }
})

new Swiper('.swiper-process',{
  effect: 'coverflow',
  centeredSlides: true,
  slidesPerView: 'auto',
  // loop:true,
  pagination : '.swiper-process-indicator',
  coverflow: {
      rotate: 0,
      stretch: 1.15*rem,
      depth: 200,
      modifier: 1,
      slideShadows : false
  }
})

new Swiper('.swiper-fans',{
  effect: 'coverflow',
  centeredSlides: true,
  slidesPerView: 'auto',
  loop:true,
  pagination : '.swiper-fans-indicator',
  autoplayDisableOnInteraction:false,
  // autoplay: 4500,
  coverflow: {
      rotate: 0,
      stretch: .35*rem,
      depth: 200,
      modifier: 1,
      slideShadows : false
  }
})
