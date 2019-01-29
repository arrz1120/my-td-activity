import '../sass/index.scss'
import $ from 'jquery'
import '../js/components/toast/toast'
import '../js/lib/share'
import Swiper from 'swiper'
import raf from 'raf'
import {Login,Invest} from '../js/lib/bridge'
import {getData,showErr} from '../js/lib/api'
import awardLayout from '../js/lib/data'
import '../js/lib/lottery'
import '../js/lib/alert'
import Promise from 'promise-polyfill'

window.Promise = Promise

window.$ = window.Q = $

window.raf = raf

window.Swiper = Swiper
let awardSwiper

let methods = {
    init() {
        this.getUserDrawCount()
        this.getFuDaiList()
        this.initAwardSwiper()
        this.initAlertEvents()
    },
    initAlertEvents() {
        $('.alert-bg').on('touchmove',function(e){
            e.preventDefault()
        }).on('click',function(){
            $(this).parent().hide()
        })
        $('.iKnow').on('click',function(){
            $(this).parent().parent().hide()
        })
        $('.close').on('click',function(){
            $(this).parent().hide()
        })
        $('.rule-btn').on('click',function(){
            $('#ruleAlert').show()
        })
        $('.goToLogin').on('click',function(){
            $('#loginAlert').hide();
            Login()
        })
        $('.join-btn').on('click',function(){
            Invest()
        })
        $('.page-tab .item').on('click',function(){
            if($(this).hasClass('active')){
                return
            }
            $('.page-tab .item').removeClass('active')
            $(this).addClass('active')
            location.href = `${window.location.origin}${window.webUrlPrefix}/thanksgivingAutumn/zxRank/index`
        })
    },
    initAwardSwiper: function () {
        $('.awards-swiper .swiper-wrapper').html(awardLayout)
            awardSwiper = new Swiper('.awards-swiper', {
              effect: 'coverflow',
            //   grabCursor: true,
              centeredSlides: true,
            //   spaceBetween : 30,
              slidesPerView: 'auto',
            //   initialSlide: 0,
             loop: true,
              autoplay : 2000,
              autoplayDisableOnInteraction : false,
              coverflow: {
                rotate: 0,
                stretch: -20,
                depth: 300,
                modifier: 1,
                slideShadows: false
              },
              prevButton: '.awards-prev',
              nextButton: '.awards-next'
            })
            $(window).on('resize',function(){
              setTimeout(function(){
                awardSwiper.update()
                awardSwiper.onResize()
              },1000)
            })
    },
    //获取初始状态
    getUserDrawCount(){
        if(window.isLogin){
            getData('/getUserDrawCount').then( res => {
                if(res) {
                    let {shared,userDrawCount} = res
                    $('.state-chance').html(userDrawCount+'次') 
                    if(userDrawCount === 0){
                        $('.finger').hide()
                    }else{
                        $('.finger').show()
                    }
                    if(shared){
                        $('#state_lottery').show()
                    }else{
                        $('#state_share').show()
                    }
                }
            }).catch(err => {
                console.log(err)
                showErr()
            })
        }else{
            $('#state_nologin').show()
        }
    },
    getFuDaiList() {
        getData('/getFuDaiList').then( res => {
            if(res && res.length){
                this.renderFuDaiList(res)
            }else{
                $('.fd-swiper').hide()
            }
        }).catch(err => {
            console.log(err)
            showErr()
        })
    },
    renderFuDaiList(list) {
        let layout = ''
        list.forEach(item => {
            layout += `<div class="swiper-slide swiper-no-swiping">
               <div class="row">
                    <div class="item">${item.name}</div>
                    <div class="item"><span>${item.prizeDesc}</span></div>
                </div>
            </div>`
        })
        $('.fd-swiper .swiper-wrapper').html(layout)

        new Swiper('.fd-swiper',{
            // direction : 'vertical',
            speed: 1000,
            loop: true,
            autoplay : 2000,
            noSwiping : true
        })
    }    
}

methods.init()
