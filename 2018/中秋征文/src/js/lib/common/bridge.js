/*
 * 代理与jsbridge相关的方法
 */

import '../jsbridge3.1.6'

export const isWeixin = isWx()

export const isApp = Jsbridge.isApp()

if(isApp){
  Jsbridge.appLifeHook(null,null,null,function(){
    setRefreshStorage()
  })
}else{
  setRefreshStorage()
}

function setRefreshStorage() {
  if(window.sessionStorage){
      if(sessionStorage.getItem("need-refresh")){
          sessionStorage.removeItem("need-refresh");
          location.reload();
      }
  }
}

export function Login(isToWrite) {
  if (isApp) {
    Jsbridge.toAppLogin()
  } else {
    let retUrl = isToWrite ? 'https://at.tuandai.com/huodong/midAutumnSolicitArticle/write.html' : window.location.href
    window.location.href=`//passport.tuandai.com/2login?ret=${retUrl}`
  }
}

export function Invest() {
  if (isApp) {
    Jsbridge.toAppP2p()
  } else {
    window.location.href = "//www.tuandai.com/app/install.aspx"
  }
}

export function ToAppTreasureChest(giftType) {
  if (giftType === 'tb') {
    window.location.href='https://mvip.tuandai.com/member/mall/tuanbiDetail.aspx'
  } else {
    if (isApp) {
      Jsbridge.exec('ToAppTreasureChest')
    } else {
      window.location.href='//m.tuandai.com/Member/UserPrize/Index.aspx'
    }
  }
}

function isWx() {
  var ua = navigator.userAgent.toLowerCase();
  if (ua.match(/MicroMessenger/i) == 'micromessenger') {
    return true;
  } else {
    return false;
  }
}
