import axios from 'axios'

axios.defaults.baseURL=__DEV__?'/mock':''
axios.defaults.timeout=20000
axios.interceptors.response.use(function (res) {
  if(res.status===200){
    return res.data
  }
  return res
}, function (error) {
  return Promise.reject(error)
})

export function getIndexData(){
  return axios.get('/loan/loan201903/index')
}

export function getNcCode(data){
  return axios.get('/register/sendSmsCode/v3',{
    params: data
  })
}

export function checkPhone(data){
  return axios.get('/register/checkphone/v3',{
    params: data
  })
}

export function landInfo(data){
  return axios.get('/loan201903/landInfo',{
    params: data
  })
}

