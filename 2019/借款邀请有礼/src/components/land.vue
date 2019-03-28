<template>
    <div>
        <div class="land" v-if="!finishFlag">
            <p class="land-p1">
                您的好友
                <span>{{userName}}</span>
                <br>邀您一起领福利啦
            </p>
            <div class="land-hb"></div>
            <div class="input-container">
                <div class="input-box">
                    <div class="phone-input">
                        <i class="icon-phone"></i>
                        <input type="tel" placeholder="请输入手机号码" maxlength="11" v-model="input.tel">
                        <i class="icon-close" @click="clearTelInput"></i>
                    </div>
                    <p class="err-tips">{{errTips.tel}}</p>
                </div>
                <!-- <div v-show="validate.tel"> -->
                <!-- <div class="nc-wrapper">
                    <div id="nc"></div> 
                    <p class="err-tips">{{errTips.nc}}</p>
                </div>-->
                <div class="input-box">
                    <div class="code-input">
                        <div class="icon-code"></div>
                        <input type="text" placeholder="请输入验证码" maxlength="6" v-model="input.code">
                    </div>
                    <div class="code-btn" @click="getCode" name="获取验证码">{{sendMsg.text}}</div>
                    <p class="err-tips">{{errTips.code}}</p>
                </div>
                <p class="input-agree" @click="onCheckboxChange">
                    <span class="checkbox">
                        <i v-show="validate.checkbox"></i>
                    </span>注册即同意
                    <a @click.stop href="https://loan.tuandai.com/h5/am01.html">《团贷网借款注册服务协议》</a>
                </p>
                <!-- </div> -->
                <div class="register-btn" @click="onRegisterBtnClick" name="立即领福利">立即领福利</div>
            </div>
            <div class="logo-box"></div>
            <div class="frame">
                <div class="frame-flex">
                    <div class="item">
                        <div class="f-icon f-icon1"></div>
                        <div class="f-txt">
                            <p class="f-txt-p1">额度高</p>
                            <p class="f-txt-p2">最高额度可达5万元</p>
                        </div>
                    </div>
                    <div class="item">
                        <div class="f-icon f-icon2"></div>
                        <div class="f-txt">
                            <p class="f-txt-p1">放款快</p>
                            <p class="f-txt-p2">最快1小时放款</p>
                        </div>
                    </div>
                </div>
                <div class="frame-flex">
                    <div class="item">
                        <div class="f-icon f-icon3"></div>
                        <div class="f-txt">
                            <p class="f-txt-p1">利率低</p>
                            <p class="f-txt-p2">年化利率低至6%</p>
                        </div>
                    </div>
                    <div class="item">
                        <div class="f-icon f-icon4"></div>
                        <div class="f-txt">
                            <p class="f-txt-p1">周期灵活</p>
                            <p class="f-txt-p2">1~24个月灵活周转</p>
                        </div>
                    </div>
                </div>
            </div>
            <footer>
                <p>2010-2019 版权所有 © 团贷网</p>
                <p>粤ICP备12043601号-1 粤公安网备44190002000538号</p>
                <p>东莞团贷网互联网科技服务有限公司</p>
            </footer>
        </div>
        <finish v-else></finish>
    </div>
</template>

<script>
import Finish from "./register-finish"
import "../js/lib/geetest"

import "../js/lib/toast"
import * as api from "../api/baseAPI"
import util from "../js/lib/utils"
import Share from 'js/initShare.js'

const [tips1, tips2, tips3, tips4] = [
    "手机号码不能为空",
    "请输入正确的手机号码",
    "请拉动滑块验证",
    "验证码不能为空"
]
const extenderKey = util.getQueryString("extenderKey")
const activityCode = 'loan201903'
let geetest = {
    captchaObj: null,
    challenge: '',
    gt: ''
}

export default {
    created() {
        Share.set(extenderKey)
        this.getUserName()
    },
    data() {
        return {
            userName: "",
            isChecking: false,
            input: {
                tel: "",
                code: ""
            },
            errTips: {
                tel: "",
                code: ""
            },
            validate: {
                tel: false,
                code: false,
                checkbox: true
            },
            sendMsg: {
                text: "获取验证码",
                duration: 60,
                sent: false
            },
            finishFlag: false
        }
    },
    methods: {
        getUserName() {
            api
                .landInfo({ extenderKey })
                .then(res => {
                    this.userName = res.value
                })
                .catch(err => {
                    if (err.response) {
                        toast.show(err.response.data.message + "，请重试")
                    }
                })
        },
        setSendMsgCodeTimer() {
            const { sendMsg } = this
            if (sendMsg.duration > 0) {
                setTimeout(() => {
                    sendMsg.duration--
                    sendMsg.text = `${sendMsg.duration} s`
                    this.setSendMsgCodeTimer()
                }, 1000)
                return
            }
            sendMsg.sent = false
            sendMsg.duration = 60
            sendMsg.text = "获取验证码"
        },
        getCode(e) {
            util.track(e)
            const { validate, sendMsg, input, isChecking } = this
            if (input.tel === "") {
                this.showTelErrorTips(tips1)
                return
            }
            if(!(/^(13|14|15|16|17|18|19)[0-9]{9}$/.test(input.tel))){
                this.showTelErrorTips(tips2)
                return
            }
            if(isChecking) return
            if (sendMsg.sent) return
            sendMsg.sent = true
            this.checkPhone().then(res => {
                api
                    .getGtInfo()
                    .then(res => {
                        this.initGt(JSON.parse(res.data))
                    })
                    .catch(err => {
                        this.sendMsg.sent = false
                        console.log(err)
                        if (err.response) {
                            toast.show(err.response.data.message)
                        }
                    })
            }).catch(err => {
                this.sendMsg.sent = false
                if (err.response) {
                    toast.show(err.response.data.message)
                }
            })
        },
        initGt(resData) {
            const { validate, sendMsg, input } = this
            initGeetest(
                {
                    gt: resData.gt,
                    challenge: resData.challenge,
                    offline: !resData.success,
                    new_captcha: true,
                    product: "bind"
                },
                captchaObj => {
                    captchaObj.onReady(() => {
                        geetest.challenge = resData.challenge
                        geetest.gt = resData.gt
                        geetest.captchaObj = captchaObj
                        geetest.captchaObj.verify()
                    })
                    captchaObj.onError(() => {
                        captchaObj.reset()
                        sendMsg.sent = false
                        toast.show("Geetest 未能初始化，请刷新页面重试")
                    })
                    captchaObj.onClose(() => {
                        sendMsg.sent = false
                    })
                    captchaObj.onSuccess(() => {
                        const getValidate = captchaObj.getValidate()
                        if (!getValidate) {
                            toast.show("请先完成滑块认证")
                            sendMsg.sent = false
                            return
                        }
                        toast.show("请稍候...", 8000)
                        api.getMsgCode({
                            telNo: input.tel,
                            activityCode,
                            extenderKey,
                            challenge: getValidate.geetest_challenge,
                            validate: getValidate.geetest_validate,
                            seccode: getValidate.geetest_seccode
                        }).then(res => {
                            toast.show('验证码发送成功')
                            this.setSendMsgCodeTimer()
                        })
                            .catch(err => {
                                toast.show(err.response.data.message)
                                sendMsg.sent = false
                            })
                    })
                }
            )
        },
        onCheckboxChange() {
            this.validate.checkbox = !this.validate.checkbox
        },
        showTelErrorTips(str) {
            this.errTips.tel = str
            setTimeout(() => {
                this.errTips.tel = ""
            }, 1500)
        },
        showNcErrorTips(str) {
            this.errTips.nc = str
            setTimeout(() => {
                this.errTips.nc = ""
            }, 1500)
        },
        showCodeErrorTips(str) {
            this.errTips.code = str
            setTimeout(() => {
                this.errTips.nc = ""
            }, 1500)
        },
        checkPhone() {
            const { input } = this
            this.isChecking = true
            return new Promise((resolve, reject) => {
                api
                    .checkPhone({
                        telNo: input.tel,
                        extenderKey
                    })
                    .then(res => {
                        if (res.code === "SUCCESS") {
                            this.isChecking = false
                            resolve()
                        }
                    })
                    .catch(err => {
                        reject(err)
                        this.isChecking = false
                    })
            })
        },
        onTelInputBlur() {
            setTimeout(() => {
                const { input, validate } = this
                if (input.tel == "") {
                    validate.tel = false
                    this.showTelErrorTips(tips1)
                    return
                }
                if (!/^(13|14|15|16|17|18|19)[0-9]{9}$/.test(input.tel)) {
                    validate.tel = false
                    this.showTelErrorTips(tips2)
                    return
                }
                api
                    .checkPhone({
                        telNo: input.tel,
                        extenderKey
                    })
                    .then(res => {
                        if (res.code === "SUCCESS") {
                            validate.tel = true
                        }
                    })
                    .catch(err => {
                        this.showTelErrorTips(tips2)
                        validate.tel = false
                        console.log(err)
                        if (err.response) {
                            toast.show(err.response.data.message)
                        }
                    })
            }, 20)
        },
        onRegisterBtnClick(e) {
            util.track(e)
            const { validate, sendMsg, input } = this
            if (input.tel === "") {
                this.showTelErrorTips(tips1)
                return
            }
            if (this.input.code === "") {
                this.showCodeErrorTips(tips4)
                this.sendMsg.sent = false
                return
            }
            if (!validate.checkbox) {
                toast.show("请勾选同意《团贷网借款注册服务协议》")
                return
            }
            api
                .register({
                    telNo: input.tel,
                    code: input.code,
                    extenderKey,
                    activityCode
                })
                .then(res => {
                    if (res.code === "SUCCESS") {
                        sa.login(res.data.userId) 
                        this.finishFlag = true
                    }
                })
                .catch(err => {
                    if (err.response) {
                        toast.show(err.response.data.message)
                    }
                })
        },
        clearTelInput() {
            this.input.tel = ""
        }
    },
    components: {
        Finish
    }
}
</script>
