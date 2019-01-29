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

let baseUrl = '/huodong/jiaXiTeQuan20181218/'

module.exports={
  initUserJiaXiTeQuan(){
    return axios.get(`${baseUrl}initUserJiaXiTeQuan`,
    {params: {
      deviceFrom:'WAP'
    }})
  },
  /**
   * 获取我的团币接口
   */
  getMycoin () {
    return axios.get(`${baseUrl}getMycoin`, {
      params: {
        deviceFrom:'WAP'
      }
    })
  },
  /**
   * 团币兑换加息特权接口
   */
  tuanBiExChangeJiaXi (typeId, deviceFrom="WAP") {
    const data = {
      typeId,
      deviceFrom
    }
    return axios({
      url: `${baseUrl}tuanBiExChangeJiaXi`,
      method: 'post',
      data
    })
  },


  /*获取用户中奖记录*/

  getUserDrawRecordList(){
    return axios.get(`${baseUrl}getUserDrawRecordList`,
    {params: {
      deviceFrom:'WAP'
    }})
  },


    /*获取用户加息特权列表*/

    getUserJiaXiTeQuan(){
      return axios.get(`${baseUrl}getUserJiaXiTeQuan`,
      {params: {
        deviceFrom:'WAP'
      }})
    },





  /*发送已经领取全程加息*/

  sendFuLiJiaXiTeQuan(){
    return axios.post(`${baseUrl}sendFuLiJiaXiTeQuan`,
    {params: {
      deviceFrom:'WAP'
    }})
  },


  getUserSumJiaXiTeQuan(){
    return axios.get(`${baseUrl}getUserSumJiaXiTeQuan`,
    {params: {
      deviceFrom:'WAP'
    }})
  }




}

