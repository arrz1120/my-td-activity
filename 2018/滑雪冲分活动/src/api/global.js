import '../assets/sass/reset.scss'
import '../js/lib/toast.js'
import '../js/lib/jsbridge3.1.5.js'

let baseUrl=__DEV__?
  window.location.origin:
  'https://at.tuandai.com/inviteActivity/skiing201811'

let devRouter={
  baseUrl,
  index:`${baseUrl}/index.html`,
  game:`${baseUrl}/game.html`,
  ranking:`${baseUrl}/ranking.html`,
  inviteRecord:`${baseUrl}/inviteRecord.html`,
  landRegister:`${baseUrl}/landRegister.html`,
  landResult:`${baseUrl}/landResult.html`,
  land:`${baseUrl}/land.html`,
}

let prodRouter={
  baseUrl,
  index:`${baseUrl}/index`,
  game:`${baseUrl}/gameIndex`,
  ranking:`${baseUrl}/ranking`,
  inviteRecord:`${baseUrl}/inviteRecordPage`,
  landRegister:`${baseUrl}/landRegister`,
  landResult:`${baseUrl}/landResult`,
  land:`${baseUrl}/landPage`,
}

window.router=__DEV__?devRouter:prodRouter

{
  let _mtac = {"performanceMonitor":1,"senseQuery":1}
  let mta = document.createElement("script")
  mta.src = "//pingjs.qq.com/h5/stats.js?v2.0.4"
  mta.setAttribute("name", "MTAH5")
  mta.setAttribute("sid", "500656381")
  mta.setAttribute("cid", "500656382")
  document.querySelector('body').appendChild(mta)
}

{
  let nodeScript = document.createElement('script')
  nodeScript.async = true
  nodeScript.src = ((("https:") == document.location.protocol) ? "https://" : "http://") + 'bilog.niiwoo.com/js/webaccess.js'
  document.querySelector('body').appendChild(nodeScript)
}