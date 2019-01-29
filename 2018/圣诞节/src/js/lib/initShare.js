import appShare from './appShare.js'
import wxShare from './wxShare.js'

let vueComponent

let imgUrl = 'https://at.tuandai.com/huodong/christmas/images/'

let defaultShare={
  title:'圣诞礼遇加息，瓜分万元现金紅包',
  content:'团贷网圣诞节最高加息1.5%，猜数天天瓜分现金紅包！',
  icon: `${imgUrl}share-icon.jpg`,
  shareUrl:window.location.href,
  cover:{
    src: `${imgUrl}share.png`,
    style:{
      width:'12rem',
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