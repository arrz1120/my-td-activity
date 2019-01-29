import axios from 'axios'
import {setAxiosDefaultConfig,apiPrefix} from './config'

setAxiosDefaultConfig(axios)

// export function getData(){
//   return axios.get(`${apiPrefix}getData`,{t: new Date().getTime()})
// }

// export function getInterest(){
//   return axios.get(`${apiPrefix}getInterest`,{t: new Date().getTime()})
// }

export function getPeriod(){
  return axios.get(`${apiPrefix}getPeriod`,{t: new Date().getTime()})
}


