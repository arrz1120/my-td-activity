import $ from 'jquery'
import '../sass/reset.scss'
import '../sass/index.scss'
import { getData, postData, getCookie ,showErr } from '../js/lib/api'
import {ShareShow,ShareCallBack} from '../js/lib/share'
import {isApp,Login} from '../js/lib/bridge'
import Promise from 'promise-polyfill'

window.Promise = Promise

window.$=window.Q=$

let time
let timer = null
let isOvertime
let isActivity = false
let isLogin = false
let userState = null;
let q1 = ''
let q2 = ''
let isSubmiting = false
let isAnswer = false

function startTimer(){
    let $timeWord = $('.time-word')
    let $timeLeft = $('.time-left')
    timer = setInterval(function(){
        if(time <= 0){
            clearInterval(timer)
            isOvertime = true
            timer = null
            if(!isAnswer){
                $('#overtime').show()
                $('#input').blur()
            }
            methods.submitAnswer('')
        }else{
            time--
            isOvertime = false
        }
        $timeLeft.css('width',(time/20)*100 + '%');
        $timeWord.html(time + 's')
    },1000)
}

let methods = {
    init(){
        this.getInitStatus()
    },
    setQ(){
        $('.q1').html(q1)
        let q = q2 === ''? '  ' : `（${q2}）`
        $('.q2').html(q)
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
            methods.toSubmit()
            methods.initEvents()
            if(!isActivity){
                $('#at-close').show()
                return
            }
            if(!isLogin){
                $('#loginAlert').show()
                return
            }
            let state = userState && userState.attendStatus
            if(state === -1){
                $('#reward-all').show()
                return
            }
            if(state === -2 ){
                methods.getLastRiddle()
                $('#once-wrong').show()
                return
            }
            if(state === -3){
                methods.getLastRiddle()
                $('#overtime').show()
                return
            }
            methods.getQuestion()
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
    getQuestion(){
        let userId = getCookie('userId')
        getData('/getQuestion',{userId: userId}).then(res => {
            let code = res.code
            if(code === 500){
                showErr()
                return
            }
            else if(code === 600){
                $('#once-wrong').show()
                return
            }
            else if(code === 601){
                $('#overtime').show()
                return
            }
            else if(code === 602){
                $('#quzi-all').show()
                return
            }
            else{
                let {question,tips} = res.data
                time = res.data.time || 21
                q1 = question
                q2 = tips
                methods.setQ()
                startTimer()
            }
        }).catch(code => {
            console.log(code)
        })
    },
    submitAnswer(a){
        postData('/submitAnswer',{answer: a}).then(res => {
            isAnswer = true
            time = 0
            let {answer,correct,drawn,timeout} = res.data
            $('.q3').html('谜底：' + answer)
            if(timeout){
                $('#overtime').show()
            }else{
                if(correct){
                    $('#reward-get').show()
                    if(drawn){
                        $('#answerAgain').show()
                    }else{
                        $('#getPrize').show()
                    }
                }else{
                    methods.setQ()
                    $('#reward-wrong').show()
                }
            }
            isSubmiting = false
        })
    },
    toSubmit(){
        $('.submit').on('click',function(){
            if(isSubmiting) return 
            isSubmiting = true
            var answer = $('#input').val()
            if(answer === ""){
                $('.warning').show()
                setTimeout(function(){
                    $('.warning').hide()
                },2000)
            }else{
                if(isOvertime === true){
                    answer = ''
                    // $('#overtime').show()
                }
                // time = 0
                methods.submitAnswer(answer)
            }
        })
    },
    showPrize(prizeId){
        $('.alert').hide()
        let prizeName = ''
        let prizeSrc = ''
        switch (prizeId) {
            case 1:
            prizeName = '8元投资红包'
            prizeSrc = 'touzi'
            break;
            case 2:
            prizeName = '18元投资红包'
            prizeSrc = 'touzi'
            break;
            case 3:
            prizeName = '3元现金红包'
            prizeSrc = '3'
            break;
            case 4:
            prizeName = '5元现金红包'
            prizeSrc = '5'
            break;
            case 5:
            prizeName = '88团币'
            prizeSrc = 'tuanbi88'
            break;
            case 6:
            prizeName = '188团币'
            prizeSrc = 'tuanbi188'
            break;
            case 7:
            prizeName = '38团币'
            prizeSrc = 'tuanbi38'
            break;
            default:
            break;
        }
        $('.reward-con').html(prizeName)
        $('.reward-icon img').attr('src',`./images/${prizeSrc}.png`)
        $('#reward-con').show()
    },
    initEvents(){
        $('.closeIcon').on('click', function() {
            $(this).parent().parent().hide();
        })
        $('#getPrize').on('click',function(){
            postData('/lotteryDraw').then(res => {
                let prizeId = res.data
                methods.showPrize(prizeId)
            })
        })
        $('.answerAgain').on('click',function(){
            $('.alert').hide()
            window.location.reload()
            // $('#input').val('')
            // methods.getInitStatus()
        })
        $('.toShare').on('click',function(){
            $('.alert').hide()
            ShareShow()
        })
        $('.toLogin').on('click',function(){
            $('.alert').hide()
            Login()
        })
        $('.toIndex').on('click',function(){
            $('.alert').hide()
            location.href = 'index.html'
        })
        $('#input').on('focus',function(){
            if(mobileUtils.isAndroid && isApp){
                $('.main').css({
                    'webkitTransform': 'translateY(-35px)',
                    'transform': 'translateY(-35px)'
                })
            }
        })
    }
}

methods.init()