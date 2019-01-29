import './appShare'
import {WeiXinShare} from './weixinapi'
import {getShareTicket, getFlag} from '../api/api'
import {isWeixin} from '../js/bridge'


export function setShare(isLogin) {
    let shareUrl = ''
    let vtitle = '来自牛郎织女的紅包'
    let vcontent = '牛郎织女悄悄塞给你一个紅包请您帮助他们重逢～'
    let icoUrl = window.location.origin + window.webUrlPrefix + '/chinaValentineDay2018/images/app/shareIcon.jpg'
    if(isLogin){
        getFlag().then(res => {
            let flag = res.data
            shareUrl = window.location.origin + window.webUrlPrefix + '/chinaValentineDay2018/valentinelanding?flag=' + flag
            setConfig(shareUrl, vtitle, vcontent, icoUrl, ShareCallBack)
        })
    }else{
        shareUrl = window.location.origin + window.webUrlPrefix + '/valentine2018/coverPage'
        setConfig(shareUrl, vtitle, vcontent, icoUrl, ShareCallBack)
    }
}

function setConfig(shareUrl, vtitle, vcontent, icoUrl, ShareCallBack) {
    WeiXinShare(shareUrl, vtitle, vcontent, icoUrl, ShareCallBack)
    appShare.set({
        icon: icoUrl,
        title: vtitle,
        content: vcontent,
        shareUrl: shareUrl,
        cover: {
            src: require('../assets/images/app/alert/wxShare.png'),
            style: {
                width: '100%',
            }
        },
        callback: function (res) {
            if (res === 'onComplete') {
                pageReload('v',new Date().getTime())
            }
        }
    })
}

export function ShareShow() {
    appShare.show()
}

export function ShareCallBack() {
    getShareTicket().then(res => {
        if (res.code === 'SUCCESS') {
        if (res.data === 'SUCCESS_ACQUIRE') {
            if(isWeixin){
                window.location.reload()
            }
        }
      } else {
        toast.show('服务器繁忙，请稍后再试')
      }
    })
  }

  function pageReload() {
    // window.location.reload()
    var oUrl = location.href.toString();
    var re=eval('/('+ paramName+'=)([^&]*)/gi');
    var nUrl = oUrl.replace(re,paramName+'='+replaceWith);
    location = nUrl;
    window.location.href=nUrl
}

