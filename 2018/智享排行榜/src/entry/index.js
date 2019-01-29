import '../js/components/toast/toast'
import Swiper from 'swiper'
import {Login,Invest,ToAppTreasureChest} from '../js/components/bridge'

window.Swiper = Swiper

let baseUrl = window.webUrlPrefix + '/zxRanking201808/'

if(__DEV__){
    baseUrl = '/api' + baseUrl
}

let isGetMoneyData = false
let isGetAwardData = false
let moneyListData = []
let awardListData = []
let tabIndex = 0

function getData(api){
    return new Promise((resolve,reject) => {
        $.ajax({
            url: baseUrl + api,
            type: 'get',
            success:function(res){
                resolve(res)
            },
            error:function(){
                showErr()
            }
        })
    })
}

function beforeRender(){
    if(tabIndex === 0){
        if(isGetMoneyData){
            let data = moneyListData
            renderList(data)
        }else{
            getData('getReturnMoneyList').then(res => {
                if(res.code === 'SUCCESS'){
                    isGetMoneyData = true
                    moneyListData = res.data
                    renderList(res.data)
                }
                else if(res.code === 'FAIL'){
                    showErr()
                }
            })
        }
    }
    else if(tabIndex === 1){
        if(isGetAwardData){
            let data = awardListData
            renderList(data)
        }else{
            getData('getAwardList').then(res => {
                if(res.code === 'SUCCESS'){
                    isGetAwardData = true
                    awardListData = res.data
                    renderList(res.data)
                }
                else if(res.code === 'FAIL'){
                    showErr()
                }
            })
        }
    }
}

function showNoData(){
    let layout = `<div class="no-data"></div>`
    renderDom(layout)
}

function renderList(data){
    if(data.length === 0){
        $('.award-link').html('马上加入')
        showNoData()
    }else{
        $('.award-link').html('查看奖品')
        let row = ''
        for(var i = 0;i<data.length;i++){
            if(tabIndex === 0){
                row += `
                    <div class="row">
                        <div class="row-flex width210">${data[i].amountStr}</div>
                        <div class="row-flex red">${data[i].prizeDesc}</div>
                        <div class="row-flex">${data[i].rankDate}</div>
                    </div>
                `
            }
            else if(tabIndex === 1){
                row += `
                    <div class="row-type2">
                        <div class="row-flex">第${data[i].rankIndex}名</div>
                        <div class="row-flex">${data[i].rankDate}</div>
                        <div class="row-flex red">${data[i].prizeName}</div>
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

function showErr(){
    toast.show('网络异常, 请关闭页面后，重新打开')
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

    $('#goToLogin').on('click',function(){
        Login()
    })

    $('.js-inviteBtn').on('click',function(){
        Invest()
    })

    $('.alert-close').on('click',function(){
        $(this).parent().hide()
    })

    $('.award-btn').on('click',function(){
        if(window.isLogin){
            beforeRender(0)
            $('.award-modal').show()
        }else{
            $('.login-modal').show()
        }
    })

    $('.award-link').on('click',function(){
        if ($(this).html() === '查看奖品') {
            ToAppTreasureChest()
        } else {
            Invest()
        }
    })
})()