import $ from 'jquery'
import './geetest'
import {getGtCode,getSmsCodeV3,validateRegister} from '../../api/index'


let doms = {
    telInput: $('#telInput'),
    codeInput: $('#codeInput'),
    registerBtn: $('.register-btn'),
    getCode: $('.get-code')
}

let geetest = {
    captchaObj: null,
    challenge:'',
    gt:''
}
let sendMsg = {
    text:'获取验证码',
    duration:120,
    sent:false,
}
let validate = {
    tel:false,
    msgCode:false,
}
let isRegiBtnDisabled = false
let duration = 60

function showCodeTimeOut(){
    if(duration>0){
        setTimeout(()=>{
            duration--
            doms.getCode.html(duration + 's可重发')
            showCodeTimeOut()
      },1000)
    }else{
        sendMsg.sent = false
        duration = 60
        doms.getCode.html('获取验证码')
    }
}

function initEvents(){
    
    doms.telInput.on('blur',function(){
        if(!(/^(13|14|15|16|17|18|19)[0-9]{9}$/.test($(this).val()))){
            validate.tel = false
            toast.show('请输入正确的手机号码')
            return
        }
        validate.tel = true
    })
    
    doms.codeInput.on('input',function(){
        // if($(this).val().length !== 6){
        //     validate.msgCode = false
        //     toast.show('请输入6位验证码')
        //     return
        //   }
          if($(this).val().length == 6){
              validate.msgCode = true
          }else{
            validate.msgCode = false
          }
    })
    
    doms.getCode.on('click',function(){ 
        if(!validate.tel){
            toast.show('请输入正确的手机号码',1500)
            return
          }
          if(sendMsg.sent) return
          sendMsg.sent = true
          geetest.captchaObj.verify()
    })
    
    doms.registerBtn.on('click',function(){
        if(!validate.tel){
            toast.show('请输入正确的手机号码',1500)
            return
         }
         if(!validate.msgCode){
           toast.show('请输入6位验证码',1500)
           return
         }
         if(isRegiBtnDisabled) return
         isRegiBtnDisabled = true
         toast.show('请稍候...',8000)
         validateRegister(JSON.stringify({
            telNo: doms.telInput.val(),
            activityCode: 'newYearBox2019',
            page: location.href,
            code: doms.codeInput.val()
         })).then(res => {
             toast.show('注册成功！',2000,function(){
                if (window.sessionStorage) {
                    sessionStorage.setItem("need-refresh", true);
                }
                location.href = res.activityUrl
             })
         }).catch(err => {
            toast.show(err.responseJSON.message,1500)
            isRegiBtnDisabled = false
         })
    })
}

initEvents()

export function initRegister(){
    getGtCode().then(res=>{
        if(res.code!=='SUCCESS'){
            throw new Error('break')
        }
        const resData=JSON.parse(res.responseStr)
        initGeetest({
            gt: resData.gt,
            challenge: resData.challenge,
            offline: !resData.success,
            new_captcha: true,
            product:'bind',
        },captchaObj=>{
            captchaObj.onReady(()=>{
                geetest.challenge=resData.challenge
                geetest.gt=resData.gt
                geetest.captchaObj=captchaObj
            })
            captchaObj.onError(()=>{
                captchaObj.reset()
                sendMsg.sent=false
                toast.show('Geetest 未能初始化，请刷新页面重试')
            })
            captchaObj.onClose(()=>{
                sendMsg.sent=false
            })
            captchaObj.onSuccess(()=>{
                const getValidate = captchaObj.getValidate()
                const telVal = doms.telInput.val()
                if(!getValidate){
                    toast.show('请先完成滑块认证')
                    sendMsg.sent = false
                    return
                }
                toast.show('请稍候...',8000)
                const formatData=JSON.stringify({
                    telNo: telVal,
                    activityCode: 'newYearBox2019',
                    challenge: getValidate.geetest_challenge,
                    validate: getValidate.geetest_validate,
                    seccode: getValidate.geetest_seccode,
                    gtFlag: '1564df43s4g67s6f1a32f4+fsd13f4s6'
                })
                getSmsCodeV3(formatData).then(res => {
                    if(res.isExists){
                        toast.show('该手机号码已注册')
                    }else{
                        if(res.isSendSmsCode){
                            toast.show('手机验证码已经发送成功')
                            showCodeTimeOut()
                        }
                    }
                    sendMsg.sent = false
                }).catch(err=>{
                    sendMsg.sent = false
                    toast.show(err.responseJSON.message)
                })
            })
        })
    })
    .catch(err=>{
        toast.show('Geetest 服务繁忙，请刷新重试')
    })
}
