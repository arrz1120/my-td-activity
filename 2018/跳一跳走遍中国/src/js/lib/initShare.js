import './jsbridge3.1.6'
import appShare from './appShare.js'
import wxShare from './wxShare.js'

let vueComponent

let defaultShare={
  title:'跳一跳，免费拿2019年彩头',
  content:'回顾2018年骄傲国民的大事件，答题免费领2019年祝福礼',
  icon:'https://at.tuandai.com/huodong/aroundChina2018/images/share-icon.jpg',
  shareUrl:window.location.href,
  cover:{
    src: require('../../assets/images/wx-share.png'),
    style:{
      width:'67%',
      top:'1rem',
      left:'1rem'
    }
  },
  callback(){
    vueComponent.shareCallback()
    if(!Jsbridge.isApp()){
      appShare.hide()
    }
  }
}


export default {
  set(vm){
    vueComponent = vm
    appShare.set(defaultShare)
    wxShare(defaultShare)
  },
  show(){
    appShare.show()
  }
}