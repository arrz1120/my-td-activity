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
    //落地页初始化
    landAPI(extenderKey){
        return axios('/inviteActivity/skiing201811/land',{
            params:{
                extenderKey:extenderKey
            }
        })
    },
    // 校验手机号码
    checkPhoneAPI(data){
        return axios('/inviteActivity/common/checkPhone',{
            params:data
        })
    },
    // 老用户发起助力
    assistAPI(data){
        return axios('/inviteActivity/skiing201811/assist',{
            params:data
        })
    },
    // 发送验证码
    sendRegsterCodeV2API(data){
        return axios('/inviteActivity/common/sendRegsterCodeV2',{
            params:data
        })
    },
    // 初始化 Geetest
    initGeetestCaptchaAPI(){
        return axios.get('/inviteActivity/geetest/initGeetestCaptcha')
    },
    // 请求注册接口
    toRegisterAPI(data){
        return axios.post('/inviteActivity/common/toRegister',data,{
            headers:{
                'Content-Type':'application/json;charset=UTF-8'
            }
        })
    },
}

