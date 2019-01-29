import axios from 'axios'

axios.defaults.baseURL=__DEV__?'/mock':''
axios.defaults.timeout=8000
axios.defaults.headers={'X-Requested-With': 'XMLHttpRequest'}
axios.interceptors.response.use(function (res) {
  if(res.status===200){
    return res.data
  }
  return res
}, function (error) {
  return Promise.reject(error)
})

// const urlPrefix=''
const urlPrefix='/huodong'

module.exports={
  // 用户加息明细列表
  getUserJiaXiList(){
    return axios(`${urlPrefix}/jiaXiTeQuan20181218/getUserJiaXiTeQuan`,{
      params:{
        deviceFrom:'WAP'
      }
    })
  },
  // 用户总加息值
  getUserTotalJiaXi(){
    return axios(`${urlPrefix}/jiaXiTeQuan20181218/getUserSumJiaXiTeQuan`,{
      params:{
        deviceFrom:'WAP'
      }
    })
  },
  // 判断是否领取1.2%加息特权
  checkNewClientJiaXi(){
    return axios.post(`${urlPrefix}/jiaXiTeQuan20181218/sendFuLiJiaXiTeQuan`,{
      deviceFrom:'WAP'
    })
  }
}

