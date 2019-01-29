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
  // 获取游戏页初始信息
  apiGetGameBaseInfo(){
    return axios('/inviteActivity/skiing201811/queryGameIndex')
  },
  // 提交游戏得分
  apiPostGameScore(data){
    return axios('/inviteActivity/skiing201811/game',{
      params:data
    })
  },
  // 游戏页分享功能
  apiShareGame(){
    return axios('/inviteActivity/skiing201811/share')
  }
}
