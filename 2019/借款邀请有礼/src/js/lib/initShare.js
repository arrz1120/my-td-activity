// import appShare from './appShare.js'
import wxShare from './wxShare.js'

let extenderKey = ''

let defaultShare={
  title:'友情推荐！我最近在用的借款神器>>',
  content:'邀你一起用团贷网借款，最高5万可借1-24个月，年化利率低至6%，当天到帐',
  icon:'https://loan.tuandai.com/loan/loan201903/images/share-icon.jpg',
  shareUrl: `https://loan.tuandai.com/loan/loan201903/landPage?extenderKey=${extenderKey}`,
  // cover:{
  //   src:'微信分享遮罩层',
  //   style:{
  //     width:'12rem',
  //     top:'1rem',
  //     left:'1rem'
  //   }
  // }
}


export default {
  set(key){
    if(key){
      extenderKey = key
    }
    // for(let i in conf){
    //   defaultShare[i]=conf[i]
    // }
    // appShare.set(defaultShare)
    wxShare(defaultShare)
  }
}