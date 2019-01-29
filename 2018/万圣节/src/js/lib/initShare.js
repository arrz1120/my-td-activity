import appShare from './appShare.js'
import wxShare from './wxShare.js'
// import {shareAdd} from '../../api/api'

let defaultShare={
  title:'送你一个万圣节紅包',
  content:'一起“鬼混”鸭～',
  icon:`${window.router.baseUrl}/images/shareIcon.png`,
  shareUrl:`${window.router.index}`,
  cover:{
    src: require('../../assets/images/wx-share.png'),
    style:{
      width:'68%',
      top:'1rem',
      left: '2rem'
    }
  },
  // callback(str){
  //   shareAdd().then(res => {
  //   }).catch(err => {
  //     if(err.response){
  //       toast.show(err.response.data.message)
  //     }
  //   })
  // }
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
  },
  hide(){
    appShare.hide()
  }
}