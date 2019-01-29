import "../sass/land.scss"
import {h,render,Component} from 'preact'
import "../js/lib/flipclock.min.js"
import Share from "../js/components/appShare/appShare"
import Toast from "../js/components/toast/toast"
// import Msgbox from "../js/components/msgbox/msgbox"

$(".mask-bg").on("click",function(){
    if(!$(this).hasClass("bg-unbind")){
        $(this).parent().hide();
    }
})
$(".close").on("click",function(){
    $(this).parent().parent().hide();
})


render(
    <Toast />,
    document.body
)

render(
    <Share />,
    document.body
)

// render(
//     <Msgbox />,
//     document.body
// )