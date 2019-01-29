import FastClick from 'fastclick'
import '../lib/jsbridge3.1.6'
import Promise from 'promise-polyfill'
window.Promise = Promise

FastClick.attach(document.body)

let isApp = Jsbridge.isApp()

module.exports={
  rem(px){
    const rem=mobileUtils.rem
    const ratio=16/750
    return px*ratio*rem
  },
  toLogin(){
    if(isApp){
      Jsbridge.toAppLogin()
    }else{
      window.location.href=`//passport.tuandai.com/2login?ret=${window.location.href}`
    }
  },
  toTBX(){
    if(isApp){
      Jsbridge.exec('ToAppTreasureChest')
    }else{
      window.location.href='//m.tuandai.com/Member/UserPrize/Index.aspx'
    }
  },
  toTB(){
    window.location.href='//mvip.tuandai.com/member/mall/tuanbiDetail.aspx'
  },
  toP2P() {
    if(isApp){
      Jsbridge.exec('ToAppP2p');
    }else{
      window.location.href=`https://sj.qq.com/myapp/detail.htm?apkName=com.junte` //应用宝
    }
    
  },
  toVerified(){
    if(isApp){
      Jsbridge.exec('ToAppInvestmentReserve')
    }else{
      window.location.href = 'https://m.tuandai.com/pages/downopenapp.aspx?type=weixinapp'
    }
  }
}

window.AddMaiDian = function(name,target){
  try {
    sa.quick('trackHeatMap',target)
    MtaH5.clickStat(name)
  } catch (error) {}
}

{
  let _mtac = {"performanceMonitor":1,"senseQuery":1}
  let mta = document.createElement("script")
  mta.src = "//pingjs.qq.com/h5/stats.js?v2.0.4"
  mta.setAttribute("name", "MTAH5")
  mta.setAttribute("sid", "500661016")
  mta.setAttribute("cid", "500661017")
  document.querySelector('body').appendChild(mta)
}

{
  let nodeScript = document.createElement('script')
  nodeScript.async = true
  nodeScript.src = ((("https:") == document.location.protocol) ? "https://" : "http://") + 'bilog.niiwoo.com/js/webaccess.js'
  document.querySelector('body').appendChild(nodeScript)
}