import appShare from './appShare.js'
import wxShare from './wxShare.js'

let defaultShare={
  title:'团贷网第6届1218网贷爱心日，百万壕礼等你来',
  content:'网贷爱心日活动开启，最高加息5%+iPhone XS Max+50g金元宝，百万壕礼等你来！',
  icon:`https://at.tuandai.com/huodong/mainHall/mobile/images/shareLogo.jpg`,
  shareUrl:window.location.href,
  cover:{
    src:require('../../assets/images/common/12.png'),
    style:{
      width:'12rem',
      top:'1rem',
      left:'1rem'
    }
  }
}


export default {
  set(conf={}){
    for(let i in conf){
      defaultShare[i]=conf[i]
    }
    appShare.set(defaultShare)
    wxShare(defaultShare)
  },
  show(){
    appShare.show()
  }
}