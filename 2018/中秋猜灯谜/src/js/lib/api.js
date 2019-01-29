import './toast'

let baseUrl = '/activity/riddleGame'

if(__DEV__){
    baseUrl = '/mock' + baseUrl
}

export function getCookie(name){
    var strcookie = document.cookie;//获取cookie字符串
    var arrcookie = strcookie.split("; ");//分割
    //遍历匹配
    for ( var i = 0; i < arrcookie.length; i++) {
        var arr = arrcookie[i].split("=");
        if (arr[0] == name){
            return arr[1];
        }
    }
    return "";
}

export function showErr(){
    toast.show('网络异常, 请关闭页面后，重新打开')
}

export function getData(api,param){
    // console.log(api)
    return new Promise((resolve,reject) => {
        $.ajax({
            url: baseUrl + api,
            type: 'get',
            data: param || {},
            success:function(res){
                resolve(res)
            },
            error:function(err){
                console.log(err)
                showErr()
                reject(err.responseJSON.code)
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
                showErr()
                reject(err.responseJSON.code)
            }
        })
    })
}
