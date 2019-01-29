import $ from 'jquery'
import '../sass/reset.scss'
import '../sass/result.scss'
import {getData,getPrize,getLeZhongEndTime} from '../api/index'
import util from '../js/lib/util'

let doms = {
    tdContent: $('#tdContent'),
    lezhongxinxi: $('#lezhongxinxi'),
    tdNewUserContent: $('#tdNewUserContent')
}

$('.btn-watchPrize').on('click',function(){
    util.toTBX()
})

getPrize().then(res => {
    showContent(res)
}).catch(err => {
    if(err.responseJSON && err.responseJSON.code === 'USER_IS_NOLOGIN'){
        location.href = 'https://at.tuandai.com/huodong/newYearBox2019/index'
    }
})

function showContent(data){
    const {prizeName,telNo} = data
    if(prizeName.indexOf('加息券') > -1){
        getLeZhongEndTime().then(res => {
            $('#time').html('有效期至：' + res)
        })
        const number = prizeName.replace('%加息券','')
        $('#rate').html(number)
        $('#prizer').html('获奖人：' + telNo)
        doms.lezhongxinxi.show()
    }else{
        getData('userInfo/isNewUser',{
            activityCode: 'newYearBox2019'
        }).then(res => {
            const hbCount = prizeName.substring(0,prizeName.length-4)
            const hbNumber = hbCount.replace('元','')
            $('.hb-count').html(hbCount + '！')
            $('.hb-number').html(hbNumber)
            if(res){
                doms.tdNewUserContent.show()
            }else{
                doms.tdContent.show()
            }
        })
    }
}