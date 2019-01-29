import '../../assets/sass/reset.scss'
import '../../js/lib/toast.js'
import '../../js/lib/jsbridge3.1.5.js'
import Promise from 'promise-polyfill'
window.Promise=Promise


const baseUrl=__DEV__?
  window.location.origin:
  'https://at.tuandai.com/huodong/mainHall/mobile'

const devRouter={
  baseUrl,
  index:`${baseUrl}/index.html`,
  jiaxi:`${baseUrl}/jiaxi.html`,
  carveRedpacket:`${baseUrl}/carveRedpacket.html`,
  lottery:`${baseUrl}/lottery.html`,
  rank:`${baseUrl}/rank.html`,
}

const prodRouter={
  baseUrl,
  index:`${baseUrl}/index.html`,
  jiaxi:`${baseUrl}/jiaxi.html`,
  carveRedpacket:`${baseUrl}/carveRedpacket.html`,
  lottery:`${baseUrl}/lottery.html`,
  rank:`${baseUrl}/rank.html`,
}

window.router=__DEV__?devRouter:prodRouter

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
  mta.setAttribute("sid", "500657100")
  mta.setAttribute("cid", "500657101")
  document.querySelector('body').appendChild(mta)
}

{
  let nodeScript = document.createElement('script')
  nodeScript.async = true
  nodeScript.src = ((("https:") == document.location.protocol) ? "https://" : "http://") + 'bilog.niiwoo.com/js/webaccess.js'
  document.querySelector('body').appendChild(nodeScript)
}