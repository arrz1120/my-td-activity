import './jsbridge3.1.6'
import './toast'
import Promise from 'promise-polyfill'

window.Promise = Promise

export const isApp = Jsbridge.isApp()

export function rem(px){
    const rem=mobileUtils.rem
    const ratio=16/750
    return px*ratio*rem
}

export function toLogin(){
    if(isApp){
        Jsbridge.toAppLogin()
        return
    }
    window.location.href=`//passport.tuandai.com/2login?ret=${location.href}`
}

export function toTBX(){
    if(isApp){
        Jsbridge.exec('ToAppTreasureChest')
    }else{
        window.location.href='//m.tuandai.com/Member/UserPrize/Index.aspx'
    }
}

export function toAppP2p(){
    if(isApp){
        Jsbridge.exec('ToAppP2p');
    }else{
        window.location.href='https://sj.qq.com/myapp/detail.htm?apkName=com.junte'
    }
}

export function sessionStorageRefresh(){
    if(window.sessionStorage){
        if(sessionStorage.getItem("need-refresh")){
            sessionStorage.removeItem("need-refresh");
            location.href = location.href
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
    mta.setAttribute("sid", "500667080")
    mta.setAttribute("cid", "500667081")
    document.querySelector('body').appendChild(mta)
}
  
{
    let nodeScript = document.createElement('script')
    nodeScript.async = true
    nodeScript.src = ((("https:") == document.location.protocol) ? "https://" : "http://") + 'bilog.niiwoo.com/js/webaccess.js'
    document.querySelector('body').appendChild(nodeScript)
}