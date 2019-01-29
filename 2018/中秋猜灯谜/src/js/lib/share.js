import './jsbridge3.1.6'
import './appShare'
import {WeiXinShare} from './wxConfig'
import {getData,getCookie} from '../lib/api'

let urlPrefix = __DEV__? `${location.origin}/` : `http://at.tuandai.com/activity/riddlegame/`

let shareUrl = urlPrefix + 'index.html'
let vtitle = '猜灯谜，赢588元紅包奖励'
let vcontent = '团贷网中秋猜灯谜，即有机会获得588元紅包奖励'
let icoUrl = 'https://at.tuandai.com/activity/riddlegame/images/share-icon.jpg'
let coverSrc =  __DEV__? '../../images/share-bg.png' : urlPrefix + 'images/share-bg.png'

WeiXinShare(shareUrl, vtitle, vcontent, icoUrl, ShareCallBack)

appShare.set({
    icon: icoUrl,
    title: vtitle,
    content: vcontent,
    shareUrl: shareUrl,
    cover: {
        src: coverSrc,
        style: {
            width: '65%',
            left: '1rem',
            top: '1rem'
        },
        callback(){
            window.location.reload()
        }
    },
    callback: function (res) {
        ShareCallBack()
    }
})

export function ShareShow() {
    appShare.show()
}

export function ShareCallBack() {
    let userId = getCookie('userId')
    getData('/shareActivity',{userId:userId}).then(res => {
        console.log(res)
        if(window.isInIndex){
            $('#overtime').hide()
            location.reload()
        }else{
            location.href = urlPrefix + 'afterShare.html'
        }
    })
}
