import $ from 'jquery'
import '../sass/reset.scss'
import '../sass/index.scss'
import { getData} from '../js/lib/api'
import {Login} from '../js/lib/bridge'
import Promise from 'promise-polyfill'

window.Promise = Promise

window.$=window.Q=$

let isActivity = false
let isLogin = false

let methods = {
    init(){
        this.getInitStatus()
        this.initEvents()
    },
    getInitStatus(){
        getData('/getInitStatus').then(res => {
            isLogin = res.data.login
            isActivity = res.data.underway
            if(!isActivity){
                $('#at-close').show()
                return
            }
            if(!isLogin){
                $('#reg').show()
                return
            }
            methods.getLastRiddle()
        }).catch(err => {

        })
    },
    getLastRiddle(){
        getData('/getLastRiddle').then(res => {
            if(res && res.code === 500){
                location.href = 'index.html'
            }
            let {question,tips,answer} = res.data
            $('.q1').html(question)
            $('.q2').html(`（${tips}）`)
            $('.q3').html('谜底：' + answer)
        })
    },
    initEvents(){
        $('.closeIcon').on('click', function() {
            $(this).parent().parent().hide();
        })
        $('.toLogin').on('click',function(){
            Login()
        })
        $('.toIndex').on('click',function(){
            location.href = 'index.html'
        })
        $('.submit').on('click',function(){
            location.href = 'quiz.html'
        })
    }
}

methods.init()