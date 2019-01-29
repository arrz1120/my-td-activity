import $ from 'jquery'

let baseUrl = '/huodong/'

if(__DEV__){
    baseUrl = '/mock/huodong/'
}

export function getData(api,param){
    return new Promise((resolve,reject) => {
        $.ajax({
            url: baseUrl + api,
            type: 'get',
            data: param || {},
            success:function(res){
                resolve(res)
            },
            error:function(err){
                reject(err)
            }
        })
    })
}

export function postData(api,param){
    return new Promise((resolve,reject) => {
        $.ajax({
            url: baseUrl + api,
            type: 'post',
            dataType: "json",
            contentType: 'application/json',
            data: param || {},
            success:function(res){
                resolve(res)
            },
            error:function(err){
                reject(err)
            }
        })
    })
}

export function getStatus(){
    let state = {
        activityTime: null,
        login: null
    }
    return new Promise((resolve,reject) => {
        getData('newYearBox2019/checkActivityTime').then(res => {
            state.activityTime = res
            getData('userInfo/checkLogin').then(res => {
                state.login = res
                resolve(state)
            }).catch(err => {
                reject(err)
            })
        })
    })
}

export function getTittleTime(){
    return getData('newYearBox2019/getTittleTime') 
}

export function getLeZhongEndTime(){
    return getData('newYearBox2019/getLeZhongEndTime') 
}

export function lottery(){
    return getData('newYearBox2019/draw') 
}

export function getPrize(){
    return getData('newYearBox2019/getPrize') 
}

export function getGtCode(){
    return postData('register/getGtCode') 
}

export function getSmsCodeV3(data){
    return postData('register/getSmsCodeV3',data) 
}
export function validateRegister(data){
    return postData('register/noLoginNoValidateExtenderKeyRegister',data) 
}
