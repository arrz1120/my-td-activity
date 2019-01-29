<template>
    <div class="index">
        <div class="bg-index-decorate"></div>
        <div class="banner">
            <div class="logo"></div>
            <!-- <div class="rule-btn" @click="onRuleBtnClick"></div> -->
            <div class="banner-tit zoomIn"></div>
            <div class="banner-sub fadeInFromBottom">活动时间：1月29日-2月13日</div>
        </div>
        <div class="sec sec1">
            <p class="p1">活动期间，用户成功出借（且匹配成功）We自动服务、We+自动服务（新手专享服务除外），即可获得相应的加息奖励，加息幅度如下：</p>
            <div class="table">
                <div class="th">
                    <div class="td">产品类型</div>
                    <div class="td">加息幅度</div>
                    <div class="td">加息后<br />参考年回报率</div>
                </div>
                <div class="tbody">
                    <div class="tr">
                        <div class="td">We自动服务3</div>
                        <div class="td">0.5%</div>
                        <div class="td">9.0%</div>
                    </div>
                    <div class="tr">
                        <div class="td">We自动服务6</div>
                        <div class="td">0.5%</div>
                        <div class="td">10.0%</div>
                    </div>
                    <div class="tr">
                        <div class="td">We+自动服务6</div>
                        <div class="td">0.5%</div>
                        <div class="td">10.5%</div>
                    </div>
                    <div class="tr">
                        <div class="td">We+自动服务12</div>
                        <div class="td">1.0%</div>
                        <div class="td">12.5%</div>
                    </div>
                    <div class="tr">
                        <div class="td">We+自动服务18</div>
                        <div class="td">0.5%</div>
                        <div class="td">12.1%</div>
                    </div>
                </div>
            </div>
            <p class="p2">*若用户加入带有“新年加息”标识的We自动服务、We+自动服务（新手专享除外），也可享受新年加息奖励。</p>
        </div>
        <p class="p-between">*We+自动服务/复投宝服务申请续期暂不享受该本次活动的所有福利，包含普惠加息、加息券及出借红包。</p>
        <!-- <div class="sec sec2">
            <div class="part part1">
                <p class="part-p1-1">已累计出借（We/We+自动服务）：</p>
                <p class="part-p1-2">￥{{totalInvest}}</p>
                <div class="dash-line"></div>
                <div class="part-flex">
                    <div class="item">
                        <p class="part-flex-p1">累计加息特权奖励</p>
                        <p class="part-flex-p2">{{totalInterest}}%</p>
                        <p class="part-flex-p3">加息特权</p>
                    </div>
                    <div class="item">
                        <p class="part-flex-p1">达标出借奖励</p>
                        <p class="part-flex-p2">{{getInterest}}%</p>
                        <p class="part-flex-p3">加息特权</p>
                    </div>
                </div>
                <div v-if="logined" class="part-login-btn part-invest-btn" @click="onInvestBtnClick"></div>
                <div v-else class="part-login-btn" @click="onLoginBtnClick"></div>
            </div>
            <div class="part part2">
                <p class="part-p2-1">登录即送0.8%加息特权</p>
                <div class="jxq"></div>
                <p class="part-p2-2">活动期间，用户<span>登录访问活动页面</span>，即可获得一份0.8%的加息特权，每位用户限获得一次。</p>
            </div>
            <div class="part part2">
                <p class="part-p2-1">出借达标享最高1%加息特权</p>
                <div class="table">
                    <div class="th">
                        <div class="td">累计出借金额</div>
                        <div class="td">加息特权奖励</div>
                    </div>
                    <div class="tbody">
                        <div class="tr">
                            <div class="td">≥0.5万元</div>
                            <div class="td">0.2%</div>
                        </div>
                        <div class="tr">
                            <div class="td">≥2万元</div>
                            <div class="td">0.5%</div>
                        </div>
                        <div class="tr">
                            <div class="td">≥10万元</div>
                            <div class="td">1.0%</div>
                        </div>
                    </div>
                </div>
                <p class="part-p2-2">活动期间，用户累计成功出借We自动服务、We+自动服务（新手专享服务除外）的金额达标，即可获得相应的加息特权。</p>
            </div>
        </div> -->
        <div class="sec sec3">
            <p class="p1">活动期间，用户每日首次登录活动页，可以获得一次参与红包雨游戏的机会，分享活动可再获得一次，游戏机会当日有效。</p>
            <div class="part part3">
                <div class="index-box" @click="toRedPacketRain">
                    <div class="finger finger-move"></div>
                </div>
                <p class="part-link" @click="toRedPacketRain">马上参与<i></i></p>
            </div>
        </div>
        <div class="sec sec4">
            <p class="p1">We+续期功能是团贷网全新推出的出借人自主选择延长We+自动服务/复投宝总服务期限的便捷服务，一键续期，优先投标不等待，避免资金站岗。</p>
            <div class="part part4">
                <p class="part4-p">1月29日-2月13日期间申请续期，即可享受续期专享加息福利</p>
                <div class="index-jxq" @click="onIndexJxqClick"></div>
                <p class="part-link" @click="onIndexJxqClick">了解更多<i></i></p>
            </div>
        </div>
        <p class="bot-txt">【广告】市场有风险 出借需谨慎</p>
        <bottom @toInvest="onInvestBtnClick" />
        <div class="share-btn" mtaName="share03" name="分享" @click="onShareBtnClick"></div>
        <div class="prize-btn" mtaName="redenvelopes04" name="红包" @click="onPrizeBtnClick"></div>
        <transition name="fade">
            <maskContainer v-if="mask.show" @hideMask="hideMask">
                <!-- <index-rule v-if="mask.rule" />
                <jx v-if="mask.jx" /> -->
                <activity-not-start v-if="mask.activityNotStart" />
                <activity-end v-if="mask.activityEnd" />
                <no-login v-if="mask.noLogin" @goToLogin="goToLogin" />
                <prize-list v-if="mask.prizeList" />
            </maskContainer>
        </transition>
    </div>
</template>

<script>
import '../assets/sass/index.scss'
import * as api from '../api/index'
import * as util from '../js/lib/util'
import * as share from '../js/lib/initShare'
import {pageHost} from '../api/config'

import maskContainer from './mask/mask'
import activityNotStart from '../components/mask/activity-not-start'
import activityEnd from '../components/mask/activity-end'
import prizeList from '../components/mask/prize-list'
import Bottom from '../components/bottom'
import noLogin from '../components/mask/no-login'
// import indexRule from '../components/mask/index-rule'
// import jx from '../components/mask/jx08'

export default {
    created(){
        share.initShare()
        this.getPeriod()
    },
    data() {
        return {
            activityStatus: null,
            logined: false,
            totalInvest: '',
            totalInterest: '',
            getInterest: '',
            mask: {
                show: false,
                activityNotStart: false,
                activityEnd: false,
                noLogin: false,
                prizeList: false,
                // rule: false,
                // jx: false
            }
        }
    },
    methods: {
        async getPeriod(){
            const res = await api.getPeriod()
            this.activityStatus = res.period
            this.logined = res.isLogin
        },
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
        // onRuleBtnClick(e){
        //     this.showMask('rule')
        // },
        onInvestBtnClick(){
            const {activityStatus} = this
            if(activityStatus === null) return
            if(activityStatus === 0){
                this.showMask('activityNotStart')
                return
            }
            if(activityStatus === 2){
                this.showMask('activityEnd')
                return
            }
            util.toAppP2p()
        },
        goToLogin() {
            util.toLogin()
        },
        // onLoginBtnClick(){
        //     util.toLogin()
        // },
        checkStatus(){
            const {activityStatus,logined} = this
            if(activityStatus === null){
                return false
            } 
            if(activityStatus === 0){
                this.showMask('activityNotStart')
                return false
            }
            if(activityStatus === 2){
                this.showMask('activityEnd')
                return false
            }
            if(!logined){
                this.showMask('noLogin')
                return false
            }
            return true
        },
        onPrizeBtnClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            const {activityStatus,logined} = this
            if(activityStatus === null){
                return
            } 
            if(activityStatus === 0){
                this.showMask('activityNotStart')
                return
            }
            if(!logined){
                this.showMask('noLogin')
                return
            }
            this.showMask('prizeList')
        },
        onShareBtnClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            if(!this.checkStatus()){
                return
            }
            share.shareShow()
        },
        toRedPacketRain(){
            location.href = `${pageHost}/huodong/newYearsRaiseInterest2019/redPacketRain.html`
        },
        onIndexJxqClick(){
            location.href = `${pageHost}/huodong/newWeRenewalActivity/index`
        }
    },
    components: {
        // indexRule,
        // jx,
        noLogin,
        maskContainer,
        activityNotStart,
        activityEnd,
        prizeList,
        Bottom
    }
}
</script>

