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
  // 获取中奖记录数据
  apiGetBingoRecords(){
    return axios(`${urlPrefix}/hallowmas/getHallowmasPrizeInfoList`)
  },
  // 获取用户关卡 key
  apiGetUserStageKey(){
    return axios(`${urlPrefix}/hallowmas/getKey`)
  },
  // 提交用户通过数据
  apiPostUserPassStage(data){
    return axios.post(`${urlPrefix}/hallowmas/postAnswer`,qs.stringify(data))
  },
  //  获取用户分享信息
  apiGetUserShareInfo(){
    return axios(`${urlPrefix}/hallowmas/getUserShareInfo`)
  }
}

