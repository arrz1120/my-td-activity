import Promise from 'promise-polyfill'
import '../assets/sass/reset.scss'
import '../js/lib/toast.js'
import '../js/lib/jsbridge3.1.5.js'

window.Promise=Promise

let baseUrl=__DEV__?
  window.location.origin:
  'https://at.tuandai.com/huodong/hallowmas'

let devRouter={
  baseUrl,
  urlPrefix:window.webUrlPrefix,
  index:`${baseUrl}/index.html`,
  land:`${baseUrl}/register.html`
}

let prodRouter={
  baseUrl,
  urlPrefix:window.webUrlPrefix,
  index:`${baseUrl}/index`,
  land:`${baseUrl}/register`,
}

window.router=__DEV__?devRouter:prodRouter

{
  let _mtac = {"performanceMonitor":1,"senseQuery":1}
  let mta = document.createElement("script")
  mta.src = "//pingjs.qq.com/h5/stats.js?v2.0.4"
  mta.setAttribute("name", "MTAH5")
  mta.setAttribute("sid", "500652524")
  mta.setAttribute("cid", "500652525")
  document.querySelector('body').appendChild(mta) 
}

{
  let nodeScript = document.createElement('script')
  nodeScript.async = true
  nodeScript.src = ((("https:") == document.location.protocol) ? "https://" : "http://") + 'bilog.niiwoo.com/js/webaccess.js'
  document.querySelector('body').appendChild(nodeScript)
}