import axios from 'axios'
import Promise from 'promise-polyfill'
window.Promise=Promise
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

module.exports={

    //冲分榜接口
    rankAPI() {
        return axios('/inviteActivity/skiing201811/rank')
    },
    //我知道了事件接口
    iKnowAPI() {
        return axios('/inviteActivity/skiing201811/iKnow')
    },
    //积分抽奖
    pointsdrawAPI() {
        return axios('/inviteActivity/skiing201811/pointsdraw')
    },
    // 邀请冲分记录查询
    inviteRecordAPI() {
        return axios('/inviteActivity/skiing201811/inviteRecord')
    },
}

