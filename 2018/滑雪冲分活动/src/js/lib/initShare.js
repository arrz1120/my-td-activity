import appShare from './appShare.js'
import wxShare from './wxShare.js'

let defaultShare={
  title:'朋友，敢不敢跟我battle滑雪？',
  content:'好玩又刺激，冲分还能赢3888元现金',
  icon:`${router.baseUrl}/images/shareIcon.jpg`,
  shareUrl:`${router.index}`,
  cover:{
    src:require('../../assets/images/shareCover.png'),
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