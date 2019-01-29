import axios from 'axios'
import {setAxiosDefaultConfig,apiPrefix} from './config'

setAxiosDefaultConfig(axios)

export function getInitStatus(){
  return axios.get(`${apiPrefix}init`,{
    t: new Date().getTime()
  })
}

export function share(){
  return axios.post(`${apiPrefix}share`)
}
export function gift({key,redCount}){
  return axios.post(`${apiPrefix}gift`,{
    key,
    redCount
  })
}

export function record(){
  return axios.get(`${apiPrefix}record`,{
    t: new Date().getTime()
  })
}

export function draw({key,boxName}){
  return axios.post(`${apiPrefix}draw`,{key,boxName,t: new Date().getTime()})
}

export function userCurDraw(){
  return axios.get(`${apiPrefix}userCurDraw`,{t: new Date().getTime()})
}



