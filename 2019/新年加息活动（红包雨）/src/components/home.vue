<template>
    <div class="home" @touchmove.prevent>
        <div class="rule-btn" name="红包雨活动玩法" mtaName="rule2a" @click="onRuleBtnClick"></div>
        <p class="ad-txt">【广告】市场有风险 出借需谨慎</p>
        <div class="banner-tit zoomIn"></div>
        <div class="banner-sub fadeInFromBottom">活动时间：1月29日-2月13日</div>
        <div class="home-cover">
            <div class="home-btn breath" name="立即开始" mtaName="begin2b" @click="onBtnClick"></div>
            <p v-if="initStatus.logined" class="cover-p1">当日剩余<span>{{userInitStatusDto.leftDrawCount}}次</span>游戏机会</p>
            <p v-if="initStatus.logined && !userInitStatusDto.shared" class="cover-p2"><span name="分享活动" mtaName="share2d" @click="linkShare">分享活动</span>获取游戏机会</p>
            <p v-if="!initStatus.logined" class="cover-p2"><span name="前往登录" mtaName="login2c" @click="linkLogin">前往登录</span>查看游戏机会</p>
        </div>
        <transition name="fade">
            <div v-if="gameStart" class="game-container" @touchmove.prevent>
                <div v-if="!gameReady" class="ready-time">
                    <p class="timeout">{{readyTimeout}}</p>
                    <div class="ready-img"></div>
                </div>
                <game v-else ref="game" @onCount="onCount" @gameOver="gameOver"></game>
                <div class="counter">
                    <p v-if="gameReady">已击中<span>{{counter}}</span>个红包</p>
                </div>
            </div>
        </transition>
        <transition name="fade">
            <maskContainer v-if="mask.show" @hideMask="hideMask">
                <no-chance-today v-if="mask.noChanceToday"></no-chance-today>
                <no-chance v-if="mask.noChance" @noChanceShare="noChanceShare"></no-chance>
                <activity-end v-if="mask.activityEnd"></activity-end>
                <activity-not-start v-if="mask.activityNotStart"></activity-not-start>
                <no-login v-if="mask.noLogin" @goToLogin="goToLogin"></no-login>
                <prize-list v-if="mask.prizeList"></prize-list>
                <rule v-if="mask.rule"></rule>
                <open-box v-if="mask.openBox" />
            </maskContainer>
        </transition>
        <transition name="fade">
            <open-box v-if="openBoxShowFlag" 
                      :userId="userId" 
                      :redCount="redCount" 
                      :boxCount="boxCount" 
                      @updateCountData="updateOpenBoxData"
                      @lotteryCompleted="lotteryCompleted" />
        </transition>
        <transition name="fade">
            <award v-if="awardShowFlag" 
                   :awardData="awardData"
                   :shared="userInitStatusDto.shared"
                   @hideAward="hideAward"
                   @awardWatchPrize="awardWatchPrize"
                   @awardShare="awardShare" />
        </transition>
        <div class="share-btn" mtaName="share03" name="分享" @click="onShareBtnClick"></div>
        <div class="prize-btn" mtaName="redenvelopes04" name="红包" @click="onPrizeBtnClick"></div>
        <div class="toIndex-btn" @click="onToIndexBtnClick"></div>
    </div>
</template>

<script>
import '../assets/sass/home.scss'

import maskContainer from './mask/mask'
import noChanceToday from './mask/no-chance-today'
import noChance from './mask/no-chance'
import activityEnd from './mask/activity-end'
import activityNotStart from './mask/activity-not-start'
import noLogin from './mask/no-login'
import prizeList from './mask/prize-list'
import rule from './mask/home-rule'
import openBox from './mask/open-box'
import award from './mask/award'

import Timr from 'timrjs'
import Game from './game'
import * as util from '../js/lib/util.js'
import * as api from '../api/api.js'
import * as share from '../js/lib/initShare'
import {hex_md5} from '../js/lib/md5'

export default {
    created() {
        share.initShare()
        this.getInitStatus()
        // api.share().then(res => {
            // location.href = location.href
        // })
    },  
    data() {
        return {
            readyTimeout: 3,
            counter: 0,
            gameStart: false,
            gameReady: false,
            openBoxShowFlag: false,
            awardShowFlag: false,
            redCount: 0,
            boxCount: 0,
            userId: '',
            awardData: [],
            mask: {
                show: false,
                noChanceToday: false,
                noChance: false,
                activityEnd: false,
                activityNotStart: false,
                noLogin: false,
                prizeList: false,
                rule: false
            },
            initStatus: {
                activityStatus: null,
                logined: false,
            },
            userInitStatusDto: {
                leftDrawCount: 0,
                shared: false,
                totalRaise: '',
                playGames: true
            }
            
        }
    },
    methods: {
        async getInitStatus(){
            const res = await api.getInitStatus()
            this.initStatus.activityStatus = res.activityStatus
            this.initStatus.logined = res.logined
            if(res.userInitStatusDto){
                this.userId = res.userInitStatusDto.userId
                this.userInitStatusDto.leftDrawCount = res.userInitStatusDto.leftDrawCount
                this.userInitStatusDto.shared = res.userInitStatusDto.shared
                this.userInitStatusDto.totalRaise = res.userInitStatusDto.totalRaise
                this.userInitStatusDto.playGames = res.userInitStatusDto.playGames
            }
            if(!this.userInitStatusDto.playGames){
                this.openBoxShowFlag = true
            }
        },
        checkStatus(){
            const {activityStatus,logined} = this.initStatus
            const {leftDrawCount} = this.userInitStatusDto
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
        onBtnClick(e) {
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            const {leftDrawCount,shared} = this.userInitStatusDto
            if(!this.checkStatus()){
                return
            }
            if(leftDrawCount <= 0){
                if(shared){
                    this.showMask('noChanceToday')
                }else{
                    this.showMask('noChance')
                }
                return
            }
            this.userInitStatusDto.leftDrawCount -= 1
            this.readyToStart()
        },
        readyToStart() {
            const timr = Timr(3)
            timr.ticker(({currentTime})=>{
                this.readyTimeout = currentTime===0? 'Go~': currentTime
            })
            timr.onStart(() => {
                this.gameStart = true
            })
            timr.finish(() => {
                setTimeout(() => {
                    this.gameReady = true
                },500)
            })
            timr.start()
        },
        gameOver() {
            api.gift({
                key: hex_md5(this.userId + '@' + this.counter),
                redCount: this.counter
            }).then(res => {
                this.gameStart = false
                this.updateOpenBoxData(res.redCount,res.boxCount)
                this.openBoxShowFlag = true
            }).catch(err => {
                if(err.response){
                    toast.show(err.response.data.message,2000,() => {
                        location.href = location.href
                    })
                }
            })
        },
        updateOpenBoxData(redCount,boxCount){
            this.redCount = redCount
            this.boxCount = boxCount
        },
        lotteryCompleted(shared,drawPrizeList){
            this.userInitStatusDto.shared = shared
            this.awardData = drawPrizeList
            this.openBoxShowFlag = false
            this.awardShowFlag = true
        },
        noChanceShare() {
            this.hideMask()
            share.shareShow()
        },
        goToLogin() {
            util.toLogin()
        },
        linkShare(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.noChanceShare()
        },
        hideAward(){
            this.awardShowFlag = false
        },
        awardShare(){
            this.awardShowFlag = false
            this.noChanceShare()
        },
        awardWatchPrize(){
            if (window.sessionStorage) {
                sessionStorage.setItem("need-refresh", true);
            }
            util.toTBX()
        },
        linkLogin(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            util.toLogin()
        },
        onCount(val) {
            this.counter = val
        },
        showMask(name) {
            this.mask.show = true
            this.mask[name] = true
        },
        hideMask() {
            for(let key in this.mask){
                if(this.mask[key]){
                   this.mask[key] = false
                }
            }
        },
        onRuleBtnClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.showMask('rule')
        },
        onPrizeBtnClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            const {activityStatus,logined} = this.initStatus
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
        onToIndexBtnClick(e){
            location.href = 'https://at.tuandai.com/huodong/newYearsRaiseInterest2019/index.html'
        }
    },
    components: {
        Game,
        maskContainer,
        noChanceToday,
        noChance,
        activityEnd,
        activityNotStart,
        noLogin,
        prizeList,
        rule,
        openBox,
        award
    }
}
</script>


