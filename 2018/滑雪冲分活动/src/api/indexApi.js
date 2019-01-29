import axios from 'axios'

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

module.exports={
  // 获取首页基本信息
  apiGetIndexBaseInfo(){
    return axios('/inviteActivity/skiing201811/indexMessage')
  },
  // 获取我的奖励数据
  apiGetMyPrize(){
    return axios('/inviteActivity/skiing201811/prize')
  }
}
