import appShare from './appShare.js'
import wxShare from './wxShare.js'
import {shareAddCount} from '../../api/api'

let imgUrl = `https://at.tuandai.com${window.webUrlPrefix}/redEnvelopeRain/images/`
// console.log(iconUrl)

let defaultShare={
  title:'团贷网红包雨来袭，天天豪礼送不停',
  content:'1218红包雨来袭，百分百中奖，多重豪礼等你来戳~',
  icon: `${imgUrl}share-icon.jpg`,
  shareUrl:`${window.router.index}`,
  cover:{
    src: `${imgUrl}wx-share.png`,
    style:{
      width:'89%',
      top:'1rem',
      left: '1rem'
    }
  },
  callback(){
    shareAddCount().then(res => {
      if(!Jsbridge.isApp()){
        appShare.hide()
      }
      window.location.href = window.location.href
    }).catch(err => {
      if(!Jsbridge.isApp()){
        appShare.hide()
      }
      window.location.href = window.location.href
    })
  }
}

export default {
  set(){
    appShare.set(defaultShare)
    wxShare(defaultShare)
  },
  show(){
    appShare.show()
  },
  hide(){
    appShare.hide()
  }
}