import ajax from './configAPI.js'

export function getIndexData(){
    return ajax.get('/loan/loan201903/index')
  }
  
  export function checkPhone(data){
    return ajax.get('/loan/register/checkphone/v3',data)
  }
  
  export function landInfo(data){
    return ajax.get('/loan/loan201903/landInfo',data)
  }
  
  export function register(data){
    return ajax.post('/loan/register/smsregister/v3',data)
  }
  
  export function myInvite(){
    return ajax.get('/loan/loan201903/invite')
  }
  
  export function myAward(){
    return ajax.get('/loan/loan201903/prize')
  }
  
  export function getGtInfo(){
    return ajax.get('/loan/register/initcaptcha/v1')
  }
  
  export function getMsgCode(data){
    return ajax.get('/loan/register/sendSmsCode/v4',data)
  }
  
  export function checkwhitelist(){
    return ajax.get('/loan/loan201903/checkwhitelist')
  }

