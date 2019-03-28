import appShare from './appShare.js'
import wxShare from './wxShare.js'
import { pageReload } from './util'
import { share } from '../../api/baseAPI'

const pageHost = 'https://at.tuandai.com'

const imgUrl = `${pageHost}/huodong/springOutInterestRates2019/images/`

const defaultShare={
  title:'踏春加息季，积分兑出游好礼！',
  content:'踏春季出借即享加息，再赢积分兑出游好礼，齐享双重福利！',
  icon: `${imgUrl}share-icon.jpg`,
  shareUrl:`${pageHost}/huodong/springOutInterestRates2019/index.html`,
  cover:{
    src: require('../../assets/images/wx-share.png'),
    style:{
      width:'79%',
      top:'1rem',
      left: '4%'
    }
  },
  callback(){
    share().then(res => {
      pageReload()
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