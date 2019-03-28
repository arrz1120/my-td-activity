import ajax from './configAPI.js'

const baseUrl = window.webUrlPrefix + '/springOutInterestRates2019/'

export function getInitStatus(){
    return ajax.get(`${baseUrl}init`)
}

export function getLeftIntegral(){
    return ajax.get(`${baseUrl}getLeftIntegral`)
}

export function getUserDrawRecordList(){
    return ajax.get(`${baseUrl}getUserDrawRecordList`)
}

export function getUserIntegralRecordList(){
    return ajax.get(`${baseUrl}getUserIntegralRecordList`)
}

export function lottery(){
    return ajax.post(`${baseUrl}draw`)
}

export function getScrollData(){
    return ajax.get(`${baseUrl}getDrawRecordList`)
}

export function apiExchange(data){
    return ajax.post(`${baseUrl}exchange`,data)
}

export function shareDraw(){
    return ajax.post(`${baseUrl}shareDraw`)
}

export function integralDraw(){
    return ajax.post(`${baseUrl}integralDraw`)
}

export function share(){
    return ajax.post(`${baseUrl}share`)
}

export function integralExchangeDraw(){
    return ajax.post(`${baseUrl}integralExchangeDraw`)
}

export function loginDraw(){
    return ajax.post(`${baseUrl}loginDraw`)
}

