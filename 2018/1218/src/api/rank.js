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

let baseUrl = '/huodong/loveRank/'

module.exports={
    initStatus(){
        return axios.get(`${baseUrl}initStatus`)
    },
    getList() {
        return axios.get(`${baseUrl}list`)
    },
    // 瓜分活动封面接口
    carveRpAPI(){
        return axios.get('/huodong/collectLove/cover')
    },
}

