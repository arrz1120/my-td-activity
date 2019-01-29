import axios from 'axios'
import qs from 'querystringify'
import '../js/lib/toast'
import {hex_md5} from '../js/lib/md5'
import {toLogin} from '../js/lib/util'

axios.defaults.baseURL=__DEV__?'/mock':''
axios.defaults.timeout=8000
axios.defaults.headers = {'X-Requested-With': 'XMLHttpRequest'}

axios.interceptors.response.use(function (res) {
  if(res.status===200){
    return res.data
  }
  return res
}, function (error) {
  return Promise.reject(error)
})

let baseUrl = `${window.router.urlPrefix}/redEnvelope/`

function toastErr(err) {
  if(err.response){
      let {message,code} = err.response.data
      if(code === 'FORBIDDEN'){
        toLogin()
      }else{
        toast.show(message)
      }
  }else{
      toast.show('网络异常，请稍后重试')
  } 
}

module.exports={
  userInit(){
    return new Promise((resolve,reject) => {
      axios.get(`${baseUrl}userInit`).then(res => {
        resolve(res)
      }).catch(err => {
        toastErr(err)
      })
    })
  },
  userRecList(){
    return new Promise((resolve,reject) => {
      axios.get(`${baseUrl}userRecList`).then(res => {
        resolve(res)
      }).catch(err => {
        toastErr(err)
      })
    })
  },
  shareAddCount() {
    return new Promise((resolve,reject) => {
      axios.post(`${baseUrl}shareAddCount`).then(res => {
        resolve(res)
      }).catch(err => {
        reject(err)
        toastErr(err)
      })
    })
  },
  toDraw(key,count) {
    return new Promise((resolve,reject) => {
      axios.post(`${baseUrl}toDraw`,{
        userKey: hex_md5(key).toUpperCase(),
        redCount: count
      }).then(res => {
        resolve(res)
      }).catch(err => {
        toastErr(err)
      })
    })
  }
}

