// import FastClick from 'fastclick'
import '../lib/jsbridge3.1.6'
import '../lib/toast'
import Promise from 'promise-polyfill'

window.Promise = Promise

// FastClick.attach(document.body)

let isApp = Jsbridge.isApp()
export default {
  rem(px){
    const rem=mobileUtils.rem
    const ratio=16/750
    return px*ratio*rem
  },
  login(){
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
  setRefreshStorage(){
    if(window.sessionStorage){
      if(sessionStorage.getItem("need-refresh")){
          sessionStorage.removeItem("need-refresh") 
          location.href = location.href
      }
    }
  },
  showError(){
    toast.show('网络异常，请稍后重试')
  }
}

// window.AddMaiDian = function(name,target){
//   try {
//     sa.quick('trackHeatMap',target)
//     MtaH5.clickStat(name)
//   } catch (error) {}
// }

{
  let _mtac = {"performanceMonitor":1,"senseQuery":1}
  let mta = document.createElement("script")
  mta.src = "//pingjs.qq.com/h5/stats.js?v2.0.4"
  mta.setAttribute("name", "MTAH5")
  mta.setAttribute("sid", "500666493")
  mta.setAttribute("cid", "500666494")
  document.querySelector('body').appendChild(mta)
}

// {
//   let nodeScript = document.createElement('script')
//   nodeScript.async = true
//   nodeScript.src = ((("https:") == document.location.protocol) ? "https://" : "http://") + 'bilog.niiwoo.com/js/webaccess.js'
//   document.querySelector('body').appendChild(nodeScript)
// }