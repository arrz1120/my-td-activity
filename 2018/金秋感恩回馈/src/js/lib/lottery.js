import $ from 'jquery'
import {postData,showErr} from './api'
import {ToAppTreasureChest} from './bridge'

function lotteryFail(code) {
    switch(code){
        case 'ACTIVITY_NO_START_TIME':
            //活动未开始
            $('#notStartAlert').show()
            break
        case 'ACTIVITY_IS_END_TIME':
            //活动已结束
            $('#isEndAlert').show()
            break
        case 'FUDAI_DRAW_COUNT_NOT_ENOUGH':
            //今天你的抽奖次数为0
            $('#todayNoChance').show()
            break
        case 'FORBIDDEN':
            //未登录
            $('#loginAlert').show()
            break
        case 'FUDAI_DRAW_COUNT_SHARED':
            $('#noChance').show()
            break 
        default:
            showErr() 
            break
    }
}

$('.fd').on('click',function(){
    if(window.isLogin){
        let type = $(this).attr('data-type')
        postData('/toFuDaiDraw',{type: type}).then(res => {
            if(res){
                let {typeId,prizeName,leftDrawCount} = res
                let domClass = '.award-'
                let domHideClass = ''
                if(typeId === 1){
                    domHideClass = '.award-jxq'
                    domClass += 'hb'
                } else {
                    domHideClass = '.award-hb'
                    domClass += 'jxq'
                }
                $('#awardTxt').html(prizeName)
                $(domHideClass).addClass('d-hide')
                $(domClass).removeClass('d-hide')
                $('#awardAlert').show()
                $('.state-chance').html(leftDrawCount + '次') 
                if(leftDrawCount === 0){
                    $('.finger').hide()
                }else{
                    $('.finger').show()
                }
                window.isGetMoneyData = false
                window.isGetAwardData = false
                window.isGetZxData = false
                window.moneyListData = []
                window.awardListData = []
                window.zxListData = []
            }else{
                // showErr()
            }
        }).catch(err => {
            lotteryFail(err)
        })
    }else{
        $('#loginAlert').show()
    }
})

$('.seeWatch').on('click',function(){
    $('#awardAlert').hide()
    ToAppTreasureChest()
})