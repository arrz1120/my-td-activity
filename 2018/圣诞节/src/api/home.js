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

let baseUrl = '/huodong/christmas/'

module.exports={
    getInitInfo(){
      return axios.get(`${baseUrl}getInitInfo`)
    },
    getUserInfo(){
      return axios.get(`${baseUrl}getUserInfo`)
    },
    guess(number,count){
      return axios.get(`${baseUrl}guessV3`,{
        params: {
          guessCount: count,
          guessNumber: number
        }
      })
    },
    getTanchuangInfo(){
      return axios.get(`${baseUrl}getTanchuangInfo`)
    },
    getLotteryRecordList() {
      return axios.get(`/huodong/christmas20181223/getUserLotteryRecordList`)
    },
    getDrawRecordList() {
      return axios.get(`/huodong/christmas20181223/getDrawRecordList`)
    },
    share(){
      return axios.get(`${baseUrl}share`)
    }
}

