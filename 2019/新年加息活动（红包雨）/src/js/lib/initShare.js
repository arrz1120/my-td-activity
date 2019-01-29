import appShare from './appShare.js'
import wxShare from './wxShare.js'
import {pageHost} from '../../api/config'
import {share} from '../../api/api'

const imgUrl = `${pageHost}/huodong/newYearsRaiseInterest2019/images/`

const defaultShare={
  title:'新年翻薪季，加息享不停，紅包滚滚来',
  content:'团贷网新年福利，普惠加息最高1%，天天玩紅包雨领紅包+加息券！',
  icon: `${imgUrl}share-icon.jpg`,
  shareUrl:`${pageHost}/huodong/newYearsRaiseInterest2019/index.html`,
  cover:{
    src: require('../../assets/images/wx-share.png'),
    style:{
      width:'78%',
      top:'1rem',
      left: '1.5rem'
    }
  },
  callback(){
    share().then(res => {
      location.href = location.href
    })
  }
}

export function initShare(){
  appShare.set(defaultShare)
  wxShare(defaultShare)
}

export function shareShow(){
  appShare.show()
}

export function shareHide(){
  appShare.hide()
}