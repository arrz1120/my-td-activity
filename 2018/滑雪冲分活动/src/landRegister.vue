<template>
  <div class="content">
    <i class="logo"></i>
    <span class="ad-tips">【广告】市场有风险，出借需谨慎</span>
    <p class="txt0">恭喜您将获得<br><span>{{point}} <em v-if="isShowCodeInput">X4倍</em>积分！</span></p>
    <div class="rp ani-redpacket">
      <p><span>10</span>元现金</p>
      <i class="rp-add">（新手专享）</i>
    </div>
    <p class="txt1">好友{{telNo}}也可至少将获得{{point}} <em v-if="isShowCodeInput">X4倍</em>积分</p>
    <p class="txt2">（新手好友注册开通存管后即可领取所有奖励）</p>
    <div class="form-con">
      <div class="input-con">
        <i class="icon-phone"></i>
        <input
                v-model="inputVal.tel"
                @blur="onTelInputBlur"
                class="input-text"
                type="tel"
                maxlength="11"
                placeholder="请输入手机号码">
      </div>
      <div class="input-con" v-if="isShowCodeInput">
        <i class="icon-code"></i>
        <input
                v-model="inputVal.msg"
                @blur="onMsgInputBlur"
                class="input-text code"
                type="text"
                maxlength="6"
                placeholder="请输入验证码">
        <span @click="onMsgSendBtnClk" name="分享注册页_获取验证码" class="btn-send input-btn">{{msgBtnText}}</span>
      </div>
      <span @click="cktelBtnClk" name="分享注册页_立即领取_校验新老" class="btn-submit breath"  v-if="!isShowCodeInput">立即领取</span>
      <span @click="onRegiBtnClk" name="分享注册页_立即领取_提交注册" class="btn-submit"  v-if="isShowCodeInput">立即领取</span>
      <p class="tips">提交即表示您已同意<a href="https://contract.tuandai.com/P2P/web/contractTypeService.aspx">《团贷网服务协议》</a></p>
    </div>

    <!-- 老用户助力 -->
    <ModalContainer
            :topic="oldModal.topic"
            v-if="modalStatus.old"
            @onCloseBtnClk="modalStatus.old=false">
      <OldModal
              :topic="oldModal.topic"
              :point="point"
              :prizeVal="oldModal.prizeVal"
              :btnText="oldModal.btnText"
              :toHomeBtnClk="toHomeBtnClk"
              :toTBXModalBtnClk="toTBXModalBtnClk"
      />
    </ModalContainer>
    <!-- 老用户助力 end -->

    <!-- 已助力弹窗 -->
    <ModalContainer
            :topic="assitModal.topic"
            v-if="modalStatus.assit"
            @onCloseBtnClk="modalStatus.assit=false">
      <AssitModal
              :topic="assitModal.topic"
              :msgs="assitModal.msgs"
              :btnText="assitModal.btnText"
              :btnCallback="toHomeBtnClk"
      />
    </ModalContainer>
    <!-- 已助力弹窗 end -->
  </div>
</template>

<script>
    import qs from 'querystringify'
    import {landAPI,checkPhoneAPI,assistAPI,initGeetestCaptchaAPI,sendRegsterCodeV2API,toRegisterAPI} from './api/landApi.js'
    import './js/lib/geetest.js'
    import ModalContainer from './components/modalContainer.vue'
    import OldModal from './components/oldModal.vue'
    import AssitModal from './components/assitModal.vue'
    import {toTB} from './js/lib/utils.js'
    export default {
        components:{
            ModalContainer,
            OldModal,
            AssitModal,
        },
        data(){
            return{
                inputVal:{
                    tel:'',
                    msg:''
                },
                validate:{
                    tel:false,
                    msg:false,
                },
                isShowCodeInput:false,
                isLogined: false,
                activityStatus:null,
                assitStatus:null,
                selfFlag:null,
                isSendSmsCode: false,
                telNo:'',
                msgBtnText:'获取验证码',
                isMsgSend:false,
                msgSendDur:60,
                extenderKey:'',
                point:'',
                captchaObj:null,
                isRegiBtnDisabled:false,
                newUser:false,
                modalStatus:{
                    old:false,
                    assit:false,
                },
                assitModal:{
                    topic:'你已为好友助力过啦！',
                    msgs:['每人限为一位好友助力哦~'],
                    btnText:'前往滑雪大作战',
                    btnCallback:null
                },
                oldModal:{
                    topic:'你已是团贷网老司机！',
                    prizeVal:'',
                    btnText:'我也要玩滑雪大作战',
                }
            }
        },
        methods:{
            // 前往滑雪大作战
            toHomeBtnClk({target}){
                try {
                    sa.quick('trackHeatMap',target)
                } catch (error) {}
                this.modalStatus.assit=false
                window.location.href=router.index
            },
            toTBXModalBtnClk(){
                toTB()
                this.modalStatus.old=false
            },
            setMsgTimer(){
                let {isMsgSend,msgSendDur,msgBtnText}=this
                if(msgSendDur>0){
                    setTimeout(()=>{
                        this.msgSendDur--
                        this.msgBtnText=`( ${this.msgSendDur}s )`
                        this.isMsgSend=true
                        this.setMsgTimer()
                    },1000)
                    return
                }
                this.isMsgSend=false
                this.msgSendDur=60
                this.msgBtnText='获取验证码'
            },
            onTelInputBlur(){
                let inputVal=this.inputVal.tel
                let regx=/^(13|14|15|16|17|18|19)[0-9]{9}$/
                if(!regx.test(inputVal)){
                    this.validate.tel=false
                    toast.show('请输入正确的手机号码')
                    return
                }
                this.validate.tel=true
            },
            onMsgInputBlur(){
                let inputVal=this.inputVal.msg
                if(inputVal.length!==6){
                    this.validate.msg=false
                    toast.show('请输入6位手机验证码')
                    return
                }
                this.validate.msg=true
            },
            onMsgSendBtnClk({target}){
                sa.quick('trackHeatMap',target)
                let {validate,isMsgSend,inputVal}=this
                if(!validate.tel){
                    toast.show('请输入正确的手机号码')
                    return
                }
                if(isMsgSend) return
                this.isMsgSend=true
                sa.quick('trackHeatMap',target)

                // 发送验证码接口
                sendRegsterCodeV2API({
                    telNo:inputVal.tel
                }).then(res=>{
                    if(res.code!=='SUCCESS'){
                        this.isMsgSend=false
                        toast.show(res.message)
                        return
                    }
                    toast.show('手机验证码已经发送成功')
                    this.setMsgTimer()
                })
                    .catch(err=>{
                        this.isMsgSend=false
                        toast.show('服务器繁忙，请重试')
                    })

            },
            cktelBtnClk({target}){
                sa.quick('trackHeatMap',target)
                let telVal=this.inputVal.tel
                if(!(/^(13|14|15|16|17|18|19)[0-9]{9}$/.test(telVal))){
                    this.validate.tel=false
                    toast.show('请输入正确的手机号码')
                    return
                }
                this.validate.tel=true
                if(this.isRegiBtnDisabled) return
                this.isRegiBtnDisabled=true
                if(this.captchaObj){
                    this.captchaObj.verify()
                    return
                }
                initGeetestCaptchaAPI()
                    .then(res=>{
                        if(res.code!=='SUCCESS'){
                            toast.show(res.message)
                            return
                        }
                        let resData=JSON.parse(res.data)
                        initGeetest({
                            gt: resData.gt,
                            challenge: resData.challenge,
                            offline: !resData.success,
                            new_captcha: true,
                            product:'bind',
                        },captchaObj=>{
                            this.captchaObj=captchaObj
                            captchaObj.onReady(()=>{
                                this.isRegiBtnDisabled=false
                                captchaObj.verify()
                            })
                            captchaObj.onError(()=>{
                                captchaObj.reset()
                                this.isRegiBtnDisabled=false
                                toast.show('Geetest 未能初始化，请刷新页面重试')
                            })
                            captchaObj.onClose(()=>{
                                this.isRegiBtnDisabled=false
                            })
                            captchaObj.onSuccess(()=>{
                                // 极验成功 请求发送短信验证吗
                                let validate=captchaObj.getValidate()
                                let inputVal=this.inputVal.tel
                                if(!validate){
                                    this.isRegiBtnDisabled=false
                                    toast.show('请先完成滑块认证')
                                    return
                                }
                                // toast.show('请稍候...',10000)
                                // 校验用户手机号
                                checkPhoneAPI({
                                    telNo:inputVal,
                                    challenge:validate.geetest_challenge,
                                    validate:validate.geetest_validate,
                                    seccode:validate.geetest_seccode,
                                    gt_server_status:'1',
                                    extenderKey:this.extenderKey||'',
                                    activityCode:'Invite_Skiing_201811',

                                }).then(res2=>{
                                    toast.hide()
                                    this.isRegiBtnDisabled=false
                                    // 已注册
                                    if(res2.code==='MOBILE_EXIST'){
                                        if (window.sessionStorage) {
                                            sessionStorage.setItem("toLogin", true);
                                        }
                                        if(Jsbridge.isApp()){
                                            Jsbridge.toAppLogin()
                                        }else{
                                            window.location.href=`//passport.tuandai.com/2login?ret=${encodeURIComponent(window.location.href)}&mobile=${inputVal}`
                                        }
                                        return
                                    }
                                    // 未注册
                                    if(res2.code==='SUCCESS'){
                                        // 显示验证码输入框
                                        this.isShowCodeInput = true
                                        return
                                    }
                                    toast.show(res2.message)
                                }).catch(err=>{
                                    toast.hide()
                                    toast.show('服务器繁忙，请稍后重试')
                                })

                            })
                        })
                    })
                    .catch(()=>{})
            },
            onRegiBtnClk({target}){
                try {
                    sa.quick('trackHeatMap',target)
                } catch (error) {}
                let {validate,isRegiBtnDisabled,inputVal}=this
                if(!validate.tel){
                    this.onTelInputBlur()
                    return
                }

                if(!validate.msg){
                    this.onMsgInputBlur()
                    return
                }
                if(isRegiBtnDisabled) return
                this.isRegiBtnDisabled=true

                toRegisterAPI({
                    telNo:inputVal.tel,
                    activityCode:'Invite_Skiing_201811',
                    code:inputVal.msg,
                    extenderKey:this.extenderKey,
                    param: JSON.stringify({point:this.point})
                }).then(res=>{
                    toast.hide()
                    this.isRegiBtnDisabled=false
                    if(res.code!=='SUCCESS'){
                        toast.show(res.message)
                        return
                    }
                    window.location.href=router.landResult
                }).catch(err=>{
                    this.isRegiBtnDisabled=false
                    toast.hide()
                    toast.show('服务器繁忙，请稍后重试')
                })
            },
            // 去助力
            goAssist(){
                assistAPI({
                    extenderKey:this.extenderKey,
                    point:this.point,
                }).then(res=>{
                    // console.log(res)
                    this.oldModal.prizeVal=res.data.replace(/团币/,'')
                    this.modalStatus.old=true
                }).catch(err=>{
                    toast.show('服务器繁忙，请稍后重试')
                })
            }
        },
        created(){
            let qsUrl=qs.parse(window.location.search)
            this.extenderKey=qsUrl.extenderKey
            this.point=qsUrl.point

            // 落地页初始化接口
            landAPI(this.extenderKey)
                .then(res=>{
                    // console.log(res)
                    if(res.code === "SUCCESS"){
                        this.activityType = res.activityType
                        this.telNo = res.data.telNo
                        this.isLogined = res.data.loginStatus
                        this.activityStatus = res.data.activityStatus
                        this.assitStatus = res.data.assitStatus
                        this.selfFlag = res.data.selfFlag
                    }
                    if(this.isLogined&&this.assitStatus==="1"){
                        this.modalStatus.assit=true
                    }
                    if(this.isLogined&&this.assitStatus==="0"){
                        if(Jsbridge.isApp()){
                            Jsbridge.appLifeHook(null,null,null,null,function(){
                                if(window.sessionStorage){
                                    if(sessionStorage.getItem("toLogin")){
                                        sessionStorage.removeItem("toLogin");
                                        this.goAssist()
                                    }
                                }
                            });
                        }else {
                            if(window.sessionStorage){
                                if(sessionStorage.getItem("toLogin")){
                                    sessionStorage.removeItem("toLogin");
                                    this.goAssist()
                                }
                            }
                        }
                    }
                })
                .catch(err=>{
                    // console.log(err)
                    toast.show('服务器繁忙，请刷新重试')
                })
        }
    }
</script>

