/*
    弹窗数据交互
*/
import $ from 'jquery'
import {Invest,ToAppTreasureChest,ToAppAutoBid} from './bridge'
import {getData,showErr} from './api'

window.isGetMoneyData = false
window.isGetAwardData = false
window.isGetZxData = false
window.moneyListData = []
window.awardListData = []
window.zxListData = []

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
    else if(tabIndex === 2){
        if(isGetZxData){
            let data = zxListData
            renderList(data)
        }else{
            getData('/zxRank/getAwardList').then(res => {
                if(res.code === 'SUCCESS'){
                    isGetZxData = true
                    zxListData = res.data
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
        }
        else if(tabIndex === 1){
            awardLink.html('马上加入').attr({
                'name': '马上加入_弹窗',
                'mtaName': '0c'
            })
        }
        else if(tabIndex === 2){
            awardLink.html('设置自动投标').attr({
                'name': '设置自动投标_弹窗',
                'mtaName': '0d'
            })
        }
        showNoData()
    }else{
        awardLink.html('查看奖品').attr({
            'name': '查看奖品0',
            'mtaName': '0b'
        })
        let row = ''
        for(var i = 0;i<data.length;i++){
            if(tabIndex === 0){
                row += `
                    <div class="row">
                        <div class="row-fd">抽中<span>${data[i].prizeDesc}</span></div>
                        <div class="row-fd">${data[i].drawDate}</div>
                    </div>
                `
            }
            else if(tabIndex === 1){
                row += `
                    <div class="row">
                        <div class="row-rank n${data[i].rankIndex}">${data[i].rankIndex}</div>
                        <div class="row-rank">${data[i].rankDate}</div>
                        <div class="row-rank">${data[i].prizeName}</div>
                    </div>
                `
            }
            else if(tabIndex === 2){
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

// function 

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
        $(this).parent().parent().hide()
        if (html === '查看奖品') {
            ToAppTreasureChest()
        } 
        else if(html === '马上加入'){
            Invest()
        } 
        else if(html === '设置自动投标'){
            ToAppAutoBid()
        }
    })
})()