import $ from 'jquery'
import '../sass/reset.scss'
import '../sass/index.scss'
import '../sass/swiper-3.4.2.scss'
import Swiper from 'swiper'
import {getData} from '../js/lib/api'
import {ShareShow,ShareCallBack} from '../js/lib/share'
import {isApp, Login} from '../js/lib/bridge'
import Promise from 'promise-polyfill'

window.Promise = Promise

window.$=window.Q=$

let isActivity = false
let isLogin = false
let userState 
let isGetState = false

let methods = {
    init(){
        this.getInitStatus()
        this.getLotteryRecordList()
        this.findRankList()
    },
    getInitStatus(){
        if(isApp){
            $('.app-tips').show()
        }else{
            $('.app-tips').hide()
        }
        getData('/getInitStatus').then(res => {
            isLogin = res.data.login,
            isActivity = res.data.underway,
            userState = res.data.userResultDTO
            isGetState = true
            methods.toAnswer()
            methods.initEvents()
            if(!isLogin){
                $('#dmCount').hide()
            }else{
                if(userState){
                    $('.score-number').html(userState.score)
                }else{
                    $('#dmCount').hide()
                }
            }
            let state = userState && userState.attendStatus
            if(state === -2 || state === -3){
                methods.getLastRiddle()
            }
        }).catch(err => {

        })
    },
    getLastRiddle(){
        getData('/getLastRiddle').then(res => {
            if(res){
                let {question,tips,answer} = res.data
                $('.q1').html(question)
                $('.q2').html(`（${tips}）`)
                $('.q3').html('谜底：' + answer)
            }
        })
    },
    getLotteryRecordList() {
        getData('/getLotteryRecordList').then(res => {
            let data = res.data
            let layout = ''
            for(var i=0; i<data.length; i++){
                layout += `<li class="swiper-slide swiper-no-swiping LotteryRecordItem">
                    <div>${data[i].phone}</div>
                    <div>${data[i].prizeName}</div>
                </li>`
            }
            $('.info-ul').html(layout);
            // 抽奖记录轮播
            var oSwiper = new Swiper('#section1-swiper',{
                direction : 'vertical',
                mousewheelControl: false,
                autoplay: 2000,
                // loop: true,
                noSwiping : true,
            });
        }).catch(err => {
            
        })
    },
    findRankList(){
        let findRankList;
        getData('/findRankList').then(res => {
            findRankList = res.data
            if(findRankList == '') {
                $('.section2-nodata').show();
                $('#section2-swiper').hide();
            }
            var RankListCon = '';
            for(var RankListCount=0;RankListCount<findRankList.length;RankListCount++) {
                var listNum = RankListCount + 1;
                RankListCon = RankListCon + '<li><h2>'
                                    + listNum + '</h2><h3>'
                                    + findRankList[RankListCount].phone + '</h3><h4>'
                                    + findRankList[RankListCount].score + '</h4></li>'; 
            }
            $('#findRankList').html(RankListCon);

            // 排行榜
            // var swiper = new Swiper('#section2-swiper', {
            //     scrollbar: '.swiper-scrollbar',
            //     direction: 'vertical',
            //     slidesPerView: 'auto',
            //     mousewheelControl: true,
            //     freeMode: true,
            //     resistanceRatio :0,
            //     roundLengths : true, //防止文字模糊
            // });
        }).catch(err => {

        })
    },
    toAnswer(){
        $('.light-click').on('click',function(){
            if(!isGetState) return
            if(!isActivity){
                $('#at-close').show()
                return
            }
            if(!isLogin){
                $('#reg').show()
                return
            }
            let state = userState && userState.attendStatus
            if(state === -1){
                $('#quzi-all').show()
                return
            }
            if(state === -2 ){
                $('#once-wrong').show()
                return
            }
            if(state === -3){
                $('#overtime').show()
                return
            }
            if(state === 0 || state === undefined){
                location.href = 'quiz.html'
            }
        })
    },
    initEvents(){
        // 弹窗
        $('.closeIcon').on('click', function() {
            $(this).parent().parent().hide();
        })
        // 活动规则
        $('.rule-click').on('click', function() {
            $('.rule').show();
        })
        $('.toShare').on('click',function(){
            if(isApp){
                ShareCallBack()
            }
            ShareShow()
        })
        $('.toLogin').on('click',function(){
            Login()
        })
    }

}
methods.init()



