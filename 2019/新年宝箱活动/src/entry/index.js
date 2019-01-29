import $ from 'jquery'
import '../sass/reset.scss'
import '../sass/index.scss'
import util from '../js/lib/util'
import {getStatus,lottery,getPrize,getTittleTime} from '../api/index'
import {initRegister} from '../js/lib/register'

util.setRefreshStorage()

let doms = {
    hand: $('.hand'),
    handLeft: $('.hand-left'),
    handRight: $('.hand-right'),
    homeBtn: $('.home-btn'),
    pai: $('.pai'),
    maskNotStart: $('#maskNotStart'),
    maskEnd: $('#maskEnd'),
    maskNoLogin: $('#maskNoLogin'),
    maskClose: $('.mask-close'),
    maskIsGetPrize: $('#maskIsGetPrize'),
    maskRegister: $('#maskRegister'),
    toLogin: $('.toLogin'),
    toResigter: $('.toResigter')
}

let state = {}

function animation(){
    return new Promise((resolve) => {
        doms.handLeft.addClass('hand-left-move')
        doms.handRight.addClass('hand-right-move')
        setTimeout(() => {
            doms.hand.css({
                'transform': `translate3d(0,${util.rem(60)}px,0)`,
                'webkitTransform': `translate3d(0,${util.rem(60)}px,0)`,
                'transition': 'all 1s'
            })
        },1000)
        setTimeout(() => {
            doms.hand.css({
                'transform': `translate3d(0,${util.rem(120)}px,0)`,
                'webkitTransform': `translate3d(0,${util.rem(120)}px,0)`,
                'transition': 'all 0.5s'
            })
            doms.handLeft.css({
                'transform': `rotateZ(40deg)`,
                'webkitTransform': `rotateZ(40deg)`,
                'transition': 'all 0.5s'
            })
            doms.handRight.css({
                'transform': `rotateZ(-40deg)`,
                'webkitTransform': `rotateZ(-40deg)`,
                'transition': 'all 0.5s'
            })
            doms.pai.css({
                'transform': `rotateZ(-75deg)`,
                'webkitTransform': `rotateZ(-75deg)`,
                'transition': 'all 0.5s'
            })
        },2000)
        setTimeout(() => {
            doms.pai.css({
                'transform': `rotateZ(0)`,
                'webkitTransform': `rotateZ(0)`,
                'transition': 'none'
            }).removeClass('pai1').addClass('pai2')
        },2500)
        setTimeout(() => {
            doms.hand.css({
                'transform': `translate3d(0,0,0)`,
                'webkitTransform': `translate3d(0,0,0)`,
                'transition': 'all 1s'
            })
            doms.pai.css({
                'transform': `translate3d(0,-${util.rem(120)}px,0)`,
                'webkitTransform': `translate3d(0,-${util.rem(120)}px,0)`,
                'transition': 'all 1s'
            })
        },3000)
        setTimeout(() => {
            resolve()
        },4000)
    })
}

$('.hasPrize-btn').on('click',function(){
    getPrize().then(res => {
        if(res.prizeName.indexOf('加息券') > -1){
            location.href = 'https://at.tuandai.com/huodong/newYearBox2019/result'
        }else{
            util.toTBX()
        }
    })
})
$('#contact').on('click',function(){
    if (window.sessionStorage) {
        sessionStorage.setItem("need-refresh", true);
    }
    location.href = 'https://contract.tuandai.com/p2p/weixin/contractagreement.aspx'
})
$('.home').on('touchmove',function(e){
    e.preventDefault()
})

$('input').on('blur',function(){
    $(window).scrollTop(0)
})

doms.toLogin.on('click',function(){
  util.login()  
})

doms.toResigter.on('click',function(){
    $('.mask').hide()
    doms.maskRegister.show()
})

doms.maskClose.on('click',function(){
    $(this).parent().hide()
})
doms.homeBtn.on('click',() => {

    if(state == {}) return
    if(state.activityTime === 0){
        doms.maskNotStart.show()
        return
    }
    if(state.activityTime === 2){
        doms.maskEnd.show()
        return
    }
    if(state.activityTime === 1){
        if(state.login === 0){
            doms.maskNoLogin.show()
            return
        }
        lottery().then(res => {
            if(res.isFirst){
                animation().then(res => {
                    location.href = 'https://at.tuandai.com/huodong/newYearBox2019/result'
                })
            }else{
                doms.maskIsGetPrize.show()
            }
        }).catch(err => {
            
        })
    }
})

getStatus().then(res => {
    state = res
    if(state.activityTime === 1 && state.login === 0){
        initRegister()
    }
})

getTittleTime().then(res => {
    $('#time').html('活动时间：' + res)
})

