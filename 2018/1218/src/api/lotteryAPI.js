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

const prefix='/huodong'

module.exports={
  checkLoginStatusAPI(){
    return axios.get(`${prefix}/mainHall20181218/card/checkIsLogin`)
  },
  getInitDataAPI(){
    return axios.get(`${prefix}/mainHall20181218/card/getUserMessage`)
  },
  lotteryCardAPI(data){
    return axios.post(`${prefix}/mainHall20181218/card/draw`,qs.stringify(data),{
      headers:{
        'Content-Type':'application/x-www-form-urlencoded'
      }
    })
  },
  getBingoRecordsAPI(){
    return axios(`${prefix}/mainHall20181218/card/getAllDrawRecord`)
  }
}

