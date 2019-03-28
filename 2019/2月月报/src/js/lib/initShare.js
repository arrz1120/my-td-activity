import appShare from './appShare.js'
import wxShare from './wxShare.js'

let defaultShare = {
  title: '团贷网2019年2月运营报告',
  content: '截至2019年2月28日，团贷网累计出借用户978218人。',
  icon: 'https://at.tuandai.com/201903/reports/weixin/images/share-icon.jpg',
  shareUrl: 'https://at.tuandai.com/201903/reports/weixin/index.aspx',
  cover: {
    src: require('../../assets/images/wx-share.png'),
    style: {
      width: '12rem',
      top: '1rem',
      left: '1rem'
    }
  }
}


export default {
  set(conf = {}) {
    for (let i in conf) {
      defaultShare[i] = conf[i]
    }
    appShare.set(defaultShare)
    wxShare(defaultShare)
  },
  show() {
    appShare.show()
  }
}