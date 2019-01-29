import axios from 'axios'

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

// let urlPrefix = '/huodong'
let baseURL = '/huodong/aroundChina/'

module.exports={
  getInitStatus(){
    return axios.get(`${baseURL}initStatus`)
  },
  start(){
    return axios.post(`${baseURL}start`)
  },
  jump(jumpFrom,jumpTo){
    const data = {
      jumpFrom,
      jumpTo
    }
    return axios({
      url: `${baseURL}jump`,
      method: 'post',
      data
    })
  },
  answer(position,result){
    const data = {
      position,
      result
    }
    return axios({
      url: `${baseURL}answer`,
      method: 'post',
      data
    })
  },
  share(){
    return axios.post(`${baseURL}share`)
  },
  drawPrize(){
    return axios.post(`${baseURL}drawPrize`)
  }
}

