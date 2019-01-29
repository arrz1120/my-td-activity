import '../sass/index.scss'
import Share from "../js/components/appShare/appShare"
import Rule from "../js/components/rule/rule"
import {h,render,Component} from 'preact'

let winW = $(window).width();
let winH = window.innerHeight;

let dom = document.querySelectorAll('.content')
dom = [].slice.apply(dom)
dom.forEach((item, i) => {
    let conHei = item.getBoundingClientRect().height
    let per = winH * .91 / conHei
    if (per < 1) {
        item.style.webkitTransform = item.style.transform = `scale(${per},${per})`
    }
})

render(
    <Share />,
    document.body
)

render(
    <Rule index="0" />,
    document.body
)



