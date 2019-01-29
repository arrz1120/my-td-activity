import $ from 'jquery'
import '../lib/toast'

let baseUrl = window.webUrlPrefix + '/thanksgivingAutumn'

if(__DEV__){
    baseUrl = '/mock' + baseUrl
}

export function showErr(){
    toast.show('网络异常, 请关闭页面后，重新打开')
}

export function getData(api){
    return new Promise((resolve,reject) => {
        $.ajax({
            url: baseUrl + api,
            type: 'get',
            success:function(res){
                resolve(res)
                
            },
            error:function(err){
                console.log(err)
                showErr()
            }
        })
    })
}

export function postData(api,param){
    return new Promise((resolve,reject) => {
        $.ajax({
            url: baseUrl + api,
            type: 'post',
            data: param,
            success:function(res){
                resolve(res)
            },
            error:function(err){
                console.log(err)
                reject(err.responseJSON.code)
            }
        })
    })
}
