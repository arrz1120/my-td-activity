import '../sass/index.scss'
import $ from 'jquery'
import '../js/components/toast/toast'
import Swiper from 'swiper'
import raf from 'raf'
import {Login,Invest,ToAppTreasureChest} from '../js/lib/bridge'
import {getData,showErr} from '../js/lib/api'
import awardLayout from '../js/lib/data'
import '../js/lib/lottery'
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
    },
    initAwardSwiper: function () {
        $('.awards-swiper .swiper-wrapper').html(awardLayout)
        awardSwiper = new Swiper('.awards-swiper', {
          effect: 'coverflow',
          grabCursor: true,
          centeredSlides: true,
          slidesPerView: 'auto',
          initialSlide: 0,
          autoplay : 2000,
          autoplayDisableOnInteraction : false,
          loop:true,
          coverflow: {
            rotate: 0,
            stretch: -20,
            depth: 300,
            modifier: 1,
            slideShadows: false
          },
          prevButton: '.awards-prev',
          nextButton: '.awards-next',
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
            direction : 'vertical',
            loop: true,
            autoplay : 2000,
            noSwiping : true
        })
    }    
}

methods.init()

/*
    弹窗数据交互
*/

window.isGetMoneyData = false
window.isGetAwardData = false
window.moneyListData = []
window.awardListData = []
let tabIndex = 0

function showNoData(){
    let layout = `<div class="no-data"></div>`
    renderDom(layout)
}

function beforeRender(){
    if(tabIndex === 0){
        if(isGetMoneyData){
            let data = moneyListData
            renderList(data)
        }else{
            getData('/getUserFuDaiList').then(res => {
                isGetMoneyData = true
                moneyListData = res
                renderList(res)
            }).catch(err => {
                console.log(err)
                showErr()
            })
        }
    }
    else if(tabIndex === 1){
        if(isGetAwardData){
            let data = awardListData
            renderList(data)
        }else{
            getData('/weRank/getAwardList').then(res => {
                if(res.code === 'SUCCESS'){
                    isGetAwardData = true
                    awardListData = res.data
                    renderList(res.data)
                }
                else if(res.code === 'FAIL'){
                    showErr()
                }
            }).catch(err => {
                console.log(err)
                showErr()
            })
        }
    }
}

function renderList(data){
    let awardLink = $('.award-link')
    if(data.length === 0){
        if(tabIndex === 0){
            awardLink.html('我知道了')
        }else{
            awardLink.html('马上加入').attr({
                'name': '马上加入_日榜',
                'mtaName': '10a'
            })
        }
        showNoData()
    }else{
        awardLink.html('查看奖品')
        let row = ''
        for(var i = 0;i<data.length;i++){
            if(tabIndex === 0){
                awardLink.attr({
                    'name': '查看奖品_福袋',
                    'mtaName': '8a'
                })
                row += `
                    <div class="row">
                        <div class="row-fd">抽中<span>${data[i].prizeDesc}</span></div>
                        <div class="row-fd">${data[i].drawDate}</div>
                    </div>
                `
            }
            else if(tabIndex === 1){
                awardLink.attr({
                    'name': '查看奖品_日榜',
                    'mtaName': '9a'
                })
                row += `
                    <div class="row">
                        <div class="row-rank n${data[i].rankIndex}">${data[i].rankIndex}</div>
                        <div class="row-rank">${data[i].rankDate}</div>
                        <div class="row-rank">${data[i].prizeName}</div>
                    </div>
                `
            }
        }
        let layout = `<div class="data">${row}</div>`
        renderDom(layout)
    }
}

function renderDom(layout){
    $('.award-ranking-con').html(layout)
}

// 奖励弹窗相关的js
(function(){
    var content = $('.award-ranking-con .item')
    $('.tab .item').on('click',function(){
        if($(this).hasClass('active')) return
        tabIndex = $(this).index()
        $(this).siblings().removeClass('active')
        $(this).addClass('active')
        beforeRender()
    })

    $('.goToLogin').on('click',function(){
        $('#loginAlert').hide();
        Login()
    })

    $('.alert-close').on('click',function(){
        $(this).parent().hide()
    })

    $('.award-btn').on('click',function(){
        if(window.isLogin){
            beforeRender()
            $('.award-modal').show()
        }else{
            $('#loginAlert').show()
        }
    })

    $('.award-link').on('click',function(){
        let html = $(this).html()
        $('.award-modal').hide()
        if (html === '查看奖品') {
            ToAppTreasureChest()
        } 
        else if(html === '马上加入'){
            Invest()
        }
    })

    $('.rule-btn').on('click',function(){
        $('#ruleAlert').show()
    })
})()