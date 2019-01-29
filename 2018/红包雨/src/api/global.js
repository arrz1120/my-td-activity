import Promise from 'promise-polyfill'
import '../assets/sass/reset.scss'
import '../js/lib/toast.js'
import '../js/lib/jsbridge3.1.6.js'

window.Promise=Promise

let baseUrl=__DEV__?
  window.location.origin:
  `//at.tuandai.com${window.webUrlPrefix}/redEnvelope`

let devRouter={
  baseUrl,
  urlPrefix:window.webUrlPrefix,
  index:`${baseUrl}/index`
}

let prodRouter={
  baseUrl,
  urlPrefix:window.webUrlPrefix,
  index:`${baseUrl}/index`
}

window.router=__DEV__?devRouter:prodRouter

// {
//   let _mtac = {"performanceMonitor":1,"senseQuery":1}
//   let mta = document.createElement("script")
//   mta.src = "//pingjs.qq.com/h5/stats.js?v2.0.4"
//   mta.setAttribute("name", "MTAH5")
//   mta.setAttribute("sid", "500657105")
//   mta.setAttribute("cid", "500657107")
//   document.querySelector('body').appendChild(mta) 
// }

// {
//   let nodeScript = document.createElement('script')
//   nodeScript.async = true
//   nodeScript.src = ((("https:") == document.location.protocol) ? "https://" : "http://") + 'bilog.niiwoo.com/js/webaccess.js'
//   document.querySelector('body').appendChild(nodeScript)
// }