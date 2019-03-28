<template>
    <div class="lottery-container">
        <div class="banner">
            <div class="rule-btn" @click="onRuleBtnClick">活动规则</div>
            <div class="banner-tit zoomIn"></div>
            <div class="banner-sub fadeInFromBottom">活动时间：3月10日-3月19日</div>
        </div>
        <div class="sec sec1">
            <div class="sec-flex">
                <div class="flex-left">
                    <img :src="avatar" alt="">
                    <p class="tel" v-if="logined">{{userName}}</p>
                </div>
                <div class="flex-right">
                    <div v-if="logined">
                        <p class="fr-p1">累计出借：<span>￥{{allAmo}}</span></p>
                        <p class="fr-p1">当前积分：<span>{{score}}</span></p>
                    </div>
                    <div v-else>
                        <p class="fr-login" @click="onLoginTxtClick" mtaName="login_b1" name="请先登录入口">请先登录</p>
                    </div>
                    <div class="fr-btn" @click="toInvest" mtaName="lend_b2" name="用户信息栏出借赚积分">出借赚积分</div>
                </div>
            </div>
        </div>
        <div class="sec sec2">
            <div class="tit"></div>
            <p class="p">活动期间，用户通过分享活动和消耗30积分，可分别获得1次刮奖机会，每位用户每日限刮2次，刮奖机会当天有效，奖品有30元~150元出借红包、0.5%~2%加息券。</p>
            <div class="lottery">
                <div class="eraser-bg">
                    <div class="e-content">
                        <img :src="shareEraser.prizeImage" alt="">
                        <p>{{shareEraser.prizeName}}</p>
                    </div>
                    <div class="opacity-cover" v-if="!shareEraser.able"></div>
                    <div class="finger finger-move" v-if="shareEraser.able && !shareEraser.begin"></div>
                    <canvas class="shareEraser" v-if="!shareEraser.finish"></canvas>
                    <div class="eraser-btn breath" v-if="!logined" @click="onLoginTxtClick">登录<br />查看</div>
                    <div class="eraser-btn" 
                        v-else-if="!shareEraser.finish && logined" 
                        :class="shareEraserBreath" 
                        @click="onShareEraserClick"
                        :mtaName="shared? 'shave_b5' :'share_b3'" 
                        :name="shared?'已分享前往刮奖':'分享刮奖'"
                    >
                        分享<br />刮奖
                    </div>
                    <div class="eraser-btn" 
                        v-else-if="shareEraser.finish && logined" 
                        @click="watchPrize"
                        mtaName="check_b9" 
                        name="刮刮乐查看"
                    >
                        查看
                    </div>
                    
                </div>
                <div class="eraser-bg">
                    <div class="e-content">
                        <img :src="scoreEraser.prizeImage" alt="">
                        <p>{{scoreEraser.prizeName}}</p>
                    </div>
                    <div class="opacity-cover" v-if="!scoreEraser.able"></div>
                    <div class="finger finger-move" v-if="scoreEraser.able && !scoreEraser.begin"></div>
                    <canvas ref="scoreEraser" v-if="!scoreEraser.finish"></canvas>
                    <div class="eraser-btn breath" v-if="!logined" @click="onLoginTxtClick">登录<br />查看</div>
                    <div class="eraser-btn" 
                        v-else-if="!scoreEraser.finish && logined" 
                        :class="scoreEraserBreath" 
                        @click="onEraserBtnClick"
                        :mtaName="integralDrawExchanged?'shave_b6':'coin_b4'" 
                        :name="integralDrawExchanged?'已用积分前往刮奖':'积分刮奖'"
                    >
                        积分<br />刮奖
                    </div>
                    <div class="eraser-btn" 
                        v-else-if="scoreEraser.finish && logined" 
                        @click="watchPrize"
                        mtaName="check_b9" 
                        name="刮刮乐查看"
                    >
                        查看
                    </div>
                </div>
            </div>
            <div class="award-user">
                <div class="swiper-container" v-if="awardUser.length" id="awardSwiper">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide swiper-no-swiping" 
                             v-for="(item,index) in awardUser"
                             :key="index"
                             >
                             <p>
                                {{item.name}}获得{{item.prizeName}}
                             </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="sec sec3">
            <div class="tit"></div>
            <p class="p">活动期间，用户可使用相应的积分进行兑换礼品，礼品每日10点限量放出，当日兑完即止。</p>
            <div v-if="logined">
                <p class="p1">当前积分：<span>{{score}}</span></p>
            </div>
            <div v-else>
                <p class="login-txt" mtaName="login_b10" name="登录查看积分入口" @click="onLoginTxtClick">登录查看积分</p>
            </div>
            <p class="p2" v-if="exchangeStatus==1">积分兑换礼品开放时间：<span>10:00:00</span></p>
            <p class="p2" v-if="exchangeStatus==3">积分兑换礼品开放时间：<span>3月10日~3月19日</span></p>
            <div class="invest-btn" v-if="exchangeStatus==2&&leftTime<=0" @click="toInvest" mtaName="lend_b11" name="兑奖区出借赚积分">出借赚积分</div>
            <p class="p2" v-if="exchangeStatus==2&&leftTime>0">当日积分兑换开放时间倒计：<span>{{leftTimeShow.h}}:{{leftTimeShow.m}}:{{leftTimeShow.s}}</span></p>
            <div class="exchange-box">
                <div class="row" v-if="exchangeDtoList">
                    <div class="row-item" v-for="(v,i) in exchangeDtoList" :key="i">
                        <p class="r-p1">{{v.prizeName}}</p>
                        <div class="r-img">
                            <img :src="require(`../assets/images/lottery/gift${i+1}.png`)" alt="">
                        </div>
                        <p class="r-p2">积分：<span>{{v.exchangeCost}}</span></p>
                        <p class="r-p2">库存：<span>{{v.leftStock}}</span></p>
                        <div v-if="exchangeStatus!=3">
                            <div class="r-btn" v-if="exchangeStatus==1||(exchangeStatus==2&&leftTime>0)">敬请期待</div>
                            <div v-if="exchangeStatus==2&&leftTime<=0">
                                <div class="r-btn" v-if="v.leftStock!=0" @click="showExchangeConfirm(i,$event)" mtaName="exchange_b12" name="马上兑换">马上兑换</div>
                                <div class="r-btn disabled" v-if="v.leftStock==0">已兑完</div>
                                <div class="r-none box-center" v-if="v.leftStock==0&&!lastDay"><p>今日已兑完<br>明日再来哦~</p></div>
                            </div>
                        </div>
                        <div class="r-btn disabled" v-if="exchangeStatus==3">活动结束</div>
                    </div>
                </div>
            </div>
        </div>
        <p class="bot-txt">【广告】市场有风险，出借需谨慎<br>* 本活动及奖品与苹果公司无关</p>
        <div class="bot-btn">
            <div class="item" mtaName="invest03" name="出借赚积分" @click="onBotLeftClick"><i class="bot-icon-left2"></i>出借赚积分</div>
            <div class="item active" mtaName="point_exchange04" name="积分兑好礼" @click="onBotRightClick"><i class="bot-icon-right1"></i>积分兑好礼</div>
        </div>
        <div class="share-btn" mtaName="" name="" @click="onShareBtnClick"></div>
        <div class="prize-btn" mtaName="" name="" @click="onPrizeBtnClick"></div>

        <transition name="fade">
            <maskContainer v-if="mask.show" @maskClose="maskClose">
                <prize-list v-if="mask.prizeList" />
                <rule v-if="mask.rule" />
                <activity-not-start v-if="mask.activityNotStart" />
                <activity-end v-if="mask.activityEnd" />
                <no-login v-if="mask.noLogin" />
                <lottery-not-enough 
                    v-if="mask.lotteryNotEnough" 
                    :score="score"
                    :otherMask="otherMask"
                />
                <is-share v-if="mask.isShare" @goToScoreEraser="goToScoreEraser"></is-share>
                <exchange-to-eraser v-if="mask.exchangeToEraser" @goToScoreEraser="goToScoreEraser"></exchange-to-eraser>
                <score-not-enough v-if="mask.scoreNotEnough"></score-not-enough>
                <exchange-success v-if="mask.exchangeSuccess" :exchangePrice="exchangePrice" />
                <exchange30 v-if="mask.exchange30" @exchangeSuccess30="exchangeSuccess30"></exchange30>
                <exchangeConfirm 
                    v-if="mask.exchangeConfirm"
                    :choiceItem="choiceItem"
                    @exchangeFun="exchangeFun"
                />
            </maskContainer>
        </transition>
        <transition name="fade">
            <maskContainer v-if="otherMask!=-1" @maskClose="closeOtherMask">
                <exchangeEnd v-if="otherMask==2" />
                
                <lottery-not-enough 
                    v-if="otherMask==4" 
                    :score="score"
                    :otherMask="otherMask"
                />
            </maskContainer>
        </transition>
        <transition>
            <maskContainer v-if="showLoginEraser" :showClose="loginEraserClose" @maskClose="maskClose">
                <loginEraser @showCloseBtn="showCloseBtn"></loginEraser>
            </maskContainer>
        </transition>
    </div>
</template>

<script>
import Swiper from 'swiper'
import * as api from '../api/baseAPI'
import * as util from '../js/lib/util'
import * as share from '../js/lib/initShare'
import Eraser from '../js/lib/eraser'

import maskContainer from './mask/mask'
import prizeList from '../components/mask/prize-list'
import activityEnd from '../components/mask/activity-end'
import activityNotStart from '../components/mask/activity-not-start'
import noLogin from '../components/mask/no-login'
import Rule from '../components/mask/rule'
import lotteryNotEnough from '../components/mask/lottery-not-enough'
import exchangeSuccess from '../components/mask/exchange-success'
import exchangeEnd from '../components/mask/exchangeEnd'
import exchangeConfirm from '../components/mask/exchangeConfirm'
import isShare from '../components/mask/is-share'
import exchangeToEraser from '../components/mask/exchange-to-eraser'
import scoreNotEnough from '../components/mask/score-not-enough'
import exchange30 from '../components/mask/exchange30'
import loginEraser from '../components/mask/login-eraser'

// import vConsole from 'vconsole'
// new vConsole()

const imgHb = new Image()
const imgJxq = new Image()
const imgHbSrc = require('../assets/images/lottery/hb.png')
const imgJxqSrc = require('../assets/images/lottery/jxq.png')
const coverSrc = require('../assets/images/lottery/eraser-cover.png')
imgHb.src = imgHbSrc
imgJxq.src = imgJxqSrc

export default {
    created(){
        share.initShare()
        this.getInitStatus()
        this.initSwiper()
    },
    mounted(){
        this.$nextTick(()=>{
            this.initShareEraser()
            this.initScoreEraser()
        })
    },
    computed:{
        leftTimeShow:function(){
            return {
                h :Math.floor(this.leftTime/60/60%24)>=10?Math.floor(this.leftTime/60/60%24):'0'+Math.floor(this.leftTime/60/60%24),
                m :Math.floor(this.leftTime/60%60)>=10?Math.floor(this.leftTime/60%60):'0'+Math.floor(this.leftTime/60%60),
                s :Math.floor(this.leftTime%60)>=10?Math.floor(this.leftTime%60):'0'+Math.floor(this.leftTime%60)
            }
        },
        shareEraserBreath(){
            return !this.shared? 'breath': ''
        },
        scoreEraserBreath(){
            return !this.integralDrawExchanged? 'breath': ''
        }
    },
    data() {
        return {
            activityStatus: {},
            logined: false,
            shared: false,
            shareDrawed: false,
            integralDrawed: false,
            integralDrawExchanged: false,
            score: 0,
            haveDrawCount: 0,
            awardUser: [],
            userName: '',
            avatar: require('../assets/images/lottery/avatar.png'),
            allAmo: '',
            prizeName: '',
            typeId: null,
            abbrName: null,
            shareImgSrc: require('../assets/images/lottery/gift5.png'),
            mask: {
                show: false,
                lotteryNotEnough: false,
                exchangeSuccess: false,
                rule: false,
                prizeList: false,
                scoreNotEnough: false,
                activityNotStart: false,
                activityEnd: false,
                noLogin: false,
                isShare: false,
                exchangeToEraser: false,
                exchange30: false,
                exchangeConfirm: false
            },
            showLoginEraser: false,
            loginEraserClose: false,
            openExchange:false,
            exchangeDtoList:null,
            lastDay:false,
            otherMask:-1, //1兑换成功，2已兑完，3是否确定兑换，4积分不足
            choiceIndex: 0,
            choiceItem: null,
            exchangePrice: null,
            exchangeStatus: -1,
            leftTime:0,
            shareEraser: {
                begin: false,
                prizeName: '',
                prizeImage: '',
                finish: false,
                able: false
            },
            scoreEraser: {
                begin: false,
                prizeName: '',
                prizeImage: '',
                prizeImage: '',
                finish: false,
                able: false
            }
        }
    },
    methods: {
        showMask(name){
            this.hideMask()
            this.mask.show = true
            this.mask[name] = true
        },
        hideMask(){
            for(let key in this.mask) {
                if(this.mask[key]){
                    this.mask[key] = false
                }
            }
        },
        maskClose(){
            if(this.mask.exchangeSuccess){
                this.hideMask()
                util.pageReload()
            }
            else if(this.showLoginEraser){
                this.showLoginEraser = false
            }
            else{
                this.hideMask()
            }
        },
        closeOtherMask(){
            if(this.otherMask==1||this.otherMask==2){
                location.href = location.href.split('?')[0] + '?t=' + new Date().getTime()
            }
            this.otherMask=-1
        },
        async getInitStatus(){
            const res = await api.getInitStatus()
            this.activityStatus = res.activityStatus
            this.logined = res.logined
            this.exchangeDtoList=res.exchangeDtoList
            this.lastDay = res.lastDay
            this.openExchange = res.openExchange
            this.exchangeStatus = res.exchangeStatus
            this.leftTime = res.countZero
            if(this.leftTime>0){
                this.timerFun()
            }
            if(res.logined){
                const {userStatus} = res
                this.score = userStatus.integral
                this.allAmo = userStatus.lendSumAmt
                this.haveDrawCount = userStatus.haveDrawCount
                this.userName = userStatus.userName
                this.avatar = userStatus.headImg
                this.shared = userStatus.shared
                this.shareDrawed = userStatus.shareDrawed
                this.integralDrawed = userStatus.integralDrawed
                this.integralDrawExchanged = userStatus.integralDrawExchanged
                if(userStatus.openLoginDraw && !userStatus.loginDrawed){
                    this.showLoginEraser = true
                }
                if(userStatus.shareDrawed){
                    this.shareEraser.finish = true
                    this.shareEraser.prizeName = userStatus.shareDrawResult.prizeName
                    if(userStatus.shareDrawResult.typeId == 1){
                        this.shareEraser.prizeImage = imgHbSrc
                    }else{
                        this.shareEraser.prizeImage = imgJxqSrc
                    }
                }else{
                    if(userStatus.shared){
                        this.shareEraser.able = true
                        // this.$nextTick(() => {
                        //     this.initShareEraser()
                        // })
                    }
                }
                if(userStatus.integralDrawed){
                    this.scoreEraser.finish = true
                    this.scoreEraser.prizeName = userStatus.integralDrawResult.prizeName
                    if(userStatus.integralDrawResult.typeId == 1){
                        this.scoreEraser.prizeImage = imgHbSrc
                    }else{
                        this.scoreEraser.prizeImage = imgJxqSrc
                    }
                }else{
                    if(userStatus.integralDrawExchanged){
                        this.scoreEraser.able = true
                        // this.$nextTick(() => {
                        //     this.initScoreEraser()
                        // })
                    }
                }
            }
        },
        initSwiper(){
            api.getScrollData().then(res => {
                this.awardUser = res
                this.$nextTick(() => {
                    new Swiper('#awardSwiper',{
                        speed: 8000,
                        noSwiping : true,
                        freeMode:true,
                        autoplay: 1,
                        loop: true 
                    })
                })
            })
        },
        showLoginMask(){
            this.showMask('noLogin')
        },
        goToLogin(){
            util.toLogin()
        },
        toInvest(e){
            const {activityStatus} = this
            util.track(e)
            if(activityStatus === {}){
                return
            }
            if(activityStatus == 1){
                this.showMask('activityNotStart')
                return
            }
            if(activityStatus == 3){
                this.showMask('activityEnd')
                return
            }
            util.toAppP2p()
        },
        onRuleBtnClick(e){
            util.track(e)
            this.showMask('rule')
        },
        onPrizeBtnClick(e){
            util.track(e)
            const {logined} = this
            if(!logined){
                this.showMask('noLogin')
                return
            }
            this.showMask('prizeList')
        },
        onShareBtnClick(e){
            util.track(e)
            if(!this.logined){
                this.showMask('noLogin')
                return
            }
            share.shareShow()
        },
        onLoginTxtClick(e){
            util.track(e)
            this.goToLogin()
        },
        onBotLeftClick(e){
            util.track(e)
            location.href = 'http://at.tuandai.com/huodong/springOutInterestRates2019/index.html'
        },
        onBotRightClick(e){
            util.track(e)
        },

        showExchangeConfirm(i,e){
            util.track(e)
            if(this.activityStatus==1){
                this.showMask('activityNotStart')
                return 
            }
            if(this.activityStatus==3){
                this.showMask('activityEnd')
                return 
            }
            if(!this.logined){
                this.showMask('noLogin')
                return 
            }
            
            this.choiceIndex=i
            this.choiceItem=this.exchangeDtoList[i]
            if(this.score<this.choiceItem.exchangeCost){
                this.otherMask=4
                return
            }
            this.showMask('exchangeConfirm')
            
        },
        exchangeFun(){
            api.apiExchange({
                "exchangeStyle": this.choiceItem.abbStyle
            }).then(res => {
                this.exchangePrice=res.prizeName
                this.score = res.leftIntegral
                this.showMask('exchangeSuccess')
            }).catch(err=>{
                let res=err.response.data;
                this.otherMask=-1;
                if(res.code=="INTEGRAL_NOTENCHOUGH"){
                    this.otherMask=4
                    return
                }
                if(res.code=="NOT_ENOUGH_PRIZE_ERROR"){
                    this.otherMask=2
                    return
                }
                if(res.code=="ACTIVITY_FINISHED" || res.code=="EXCHANGE_TIME_OVER"){
                    this.otherMask=-1
                    this.activityStatus=3
                    this.exchangeStatus=3
                    this.showMask('activityEnd')
                    return
                }
                if(res.code=="NETWORK_EXCEPTION_ERROR"){
                    toast.show("网络异常，请关闭页面后，重新打开")
                    return
                }
                toast.show(res.message)
            })
        },
        timerFun(){
            let timer=setInterval(()=>{
                this.leftTime-=1
                // console.log(this.leftTime)
                if(this.leftTime<=0){
                    this.leftTime=0;
                    clearInterval(timer)
                    this.exchangeStatus=2
                }
            }, 1000)
        },
        initShareEraser(){
            const vm = this
            new Eraser('.shareEraser',{
                width: util.rem(492),
                height: util.rem(240), 
                touchSize: 20,
                cover: coverSrc,
                onErase(){
                    const {shareEraser} = vm
                    if(shareEraser.begin || shareEraser.finish){
                        return
                    }
                    shareEraser.begin = true
                    api.shareDraw().then(res => {
                        const {prizeName,typeId} = res
                        if(typeId == 1){
                            shareEraser.prizeImage = imgHbSrc
                        }
                        else if(typeId == 2){
                            shareEraser.prizeImage = imgJxqSrc
                        }
                        shareEraser.prizeName = prizeName
                    }).catch(err => {
                        toast.show(err.response.data.message)
                    })
                },
                onComplete(){
                    vm.shareEraser.able = false
                    vm.shareEraser.finish = true
                }
            })
        },
        initScoreEraser(){
            const vm = this
            new Eraser(this.$refs.scoreEraser,{
                width: util.rem(492),
                height: util.rem(240), 
                touchSize: 20,
                cover: coverSrc,
                onErase(){
                    const {scoreEraser} = vm
                    if(scoreEraser.begin || scoreEraser.finish){
                        return
                    }
                    scoreEraser.begin = true
                    api.integralDraw().then(res => {
                        const {prizeName,typeId} = res
                        if(typeId == 1){
                            scoreEraser.prizeImage = imgHbSrc
                        }
                        else if(typeId == 2){
                            scoreEraser.prizeImage = imgJxqSrc
                        }
                        scoreEraser.prizeName = prizeName
                    }).catch(err => {

                    })
                },
                onComplete(){
                    vm.scoreEraser.able = false
                    vm.scoreEraser.finish = true
                }
            })
        },
        onShareEraserClick(e){
            util.track(e)
            const {activityStatus,shared} = this
            if(activityStatus == {}){
                return
            }
            if(activityStatus == 1){
                this.showMask('activityNotStart')
                return
            }
            if(activityStatus == 3){
                this.showMask('activityEnd')
                return
            }
            if(shared){
                this.showMask('isShare')
                return
            }
            share.shareShow()
        },
        goToScoreEraser(){
            this.hideMask()
            // window.scrollTo(0,document.querySelector('.sec2').offsetTop)
        },
        onEraserBtnClick(e){
            util.track(e)
            const {activityStatus,score,integralDrawExchanged} = this
            if(activityStatus == {}){
                return
            }
            if(activityStatus == 1){
                this.showMask('activityNotStart')
                return
            }
            if(activityStatus == 3){
                this.showMask('activityEnd')
                return
            }
            if(integralDrawExchanged){
                this.showMask('exchangeToEraser')
                return
            }
            if(score<30){
                this.showMask('scoreNotEnough')
                return
            }
            this.showMask('exchange30')
        },
        exchangeSuccess30(){
            this.integralDrawExchanged = true
            this.scoreEraser.able = true
            this.score-=30
            this.goToScoreEraser()
            setTimeout(() => {
                this.initScoreEraser()
            },500)
        },
        watchPrize(e){
            util.track(e)
            util.toTBX()
        },
        showCloseBtn(){
            this.loginEraserClose = true
        }
    },
    components: {
        prizeList,
        Rule,
        noLogin,
        maskContainer,
        activityNotStart,
        activityEnd,
        lotteryNotEnough,
        exchangeSuccess,
        exchangeEnd,
        exchangeConfirm,
        isShare,
        exchangeToEraser,
        scoreNotEnough,
        exchange30,
        loginEraser
    }
}
</script>

