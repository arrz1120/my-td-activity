import  '../sass/hb_hover.scss'
import {h,render,Component} from 'preact'
import Toast from "../js/components/toast/toast"

$(".mask-bg").on("click",function(){
  if(!$(this).hasClass("bg-unbind")){
    $(this).parent().hide();
  }
})
$(".close,.mask .btn").on("click",function(){
  $(this).parent().parent().hide();
})

render(
  <Toast />,
  document.body
)
