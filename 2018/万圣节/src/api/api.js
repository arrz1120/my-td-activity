import axios from 'axios'
import qs from 'querystringify'

axios.defaults.baseURL=__DEV__?'/mock':''
axios.defaults.timeout=8000
axios.interceptors.response.use(function (res) {
  if(res.status===200){
    return res.data
  }
  return res
}, function (error) {
  return Promise.reject(error)
})

let urlPrefix=window.router.urlPrefix

module.exports={
  isRead(pass){
    return axios.get(`${urlPrefix}/hallowmas/isRead`, {
      params: {
        gNum: pass
      }
    })
  },
  getUsesrTbExchangeCount(){
    return axios.get(`${urlPrefix}/hallowmas/getUsesrTbExchangeCount`)
  },
  getUserCoin(){
    return axios.get(`${urlPrefix}/hallowmas/getUserCoin`)
  },
  exchange(pass){
    return axios.post(`${urlPrefix}/hallowmas/exchange`,qs.stringify({
      gNum:pass
    }))
  },
  draw() {
    return axios.post(`${urlPrefix}/hallowmas/draw`)
  },
  shareAdd(pass,way) {
    return axios.get(`${urlPrefix}/hallowmas/shareAdd`, {
      params: {
        gNum: pass,
        way: way
      }
    })
  }
}

