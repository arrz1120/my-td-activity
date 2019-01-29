import '../sass/index.scss'
import '../js/components/toast/src/toast'
import BScroll from 'better-scroll'
import {h,render} from 'preact';
window.BScroll = BScroll;

require('../js/lib/index') 
require('../js/lib/api') 

$('.alert-bg').on('click',function(){
    $(this).parent().hide()
}).on('touchmove',function(e){
    e.preventDefault()
})

$('.iknow,.gl-close').on('click',function(){
    $(this).parent().parent().hide()
})

$('.alert-btn-l').on('click',function(){
    $(this).parent().parent().parent().hide()
})


