<template>
    <div class="home">
        <div class="home-lable"></div>
        <div class="rule-btn maidian" name="活动规则1c" mtaName="rule1c" @click="showMask('rule')">活动规则</div>
        <p class="ad-txt">【广告】市场有风险，出借需谨慎</p>
        <div class="home-tit"></div>
        <div class="home-sub">活动时间：12月3日—12月17日</div>
        <div class="home-hb"></div>
        <div class="home-cover">
            <div class="home-btn breath maidian" name="立即开始2c" mtaName="begin2c" @click="onBtnClick">立即开始</div>
            <p v-if="logined" class="cover-p1">当日剩余<span>{{chance}}次</span>游戏机会</p>
            <p v-if="logined && !isShare" class="cover-p2"><span name="分享活动4c" mtaName="share4c" @click="linkShare">分享活动</span>获取游戏机会</p>
            <p v-if="!logined" class="cover-p2"><span name="前往登录3c" mtaName="login3c" @click="linkLogin">前往登录</span>查看游戏机会</p>
            <p class="cover-p3">在法律许可范畴内，本次活动最终解释权归团贷网所有<br />*本次活动和奖品与苹果公司无关</p>
        </div>
        <transition name="fade">    
            <div v-if="gameStart" class="game-container">
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
            <div v-if="isShowPrize" class="prize-container">
                <div class="close" @click="onPrizeContainerClose"></div>
                <p class="prize-p">
                    恭喜您击中了<span>{{counter}}</span>个红包<br>
                    获得<span>{{counter>=15? 2: 1}}</span>个礼物
                </p>
                <div class="prize-hb-wrapper">
                    <div class="prize-hb">
                        <p>￥<span>{{redPackDrawPrizes.length && redPackDrawPrizes[0].prizeValue}}</span></p>
                    </div>
                    <div v-if="counter>=15" class="prize-add"></div>
                    <div v-if="counter>=15" class="prize-hb">
                        <p>￥<span>{{redPackDrawPrizes.length>1 && redPackDrawPrizes[1].prizeValue}}</span></p>
                    </div>
                </div>   
                <div v-if="isFirstPlay" class="first-prize">
                    <p class="prize-p">赠送惊喜彩蛋<br /><span>0.1%加息特权</span></p>
                    <div class="jxq"></div>
                </div>
                <div v-if="isShare" class="prize-btn-wrapper">
                    <div class="lookPrize-btn2" @click="lookPrize">查看奖品</div>    
                </div> 
                <div v-else class="prize-btn-wrapper">
                    <div class="share-btn" mtaName="share8c" name="分享再玩一次8c" @click="shareToPlayAgain">分享再玩一次</div>   
                    <div class="lookPrize-btn1" mtaName="prize9c" name="查看奖品9c" @click="lookPrize">查看奖品</div>    
                </div>
            </div>
        </transition>
        <transition name="fade">
            <div v-if="mask.show" class="mask">
                <div class="mask-bg"></div>
                <div class="mask-con">
                    <no-chance-today v-if="mask.noChanceToday"></no-chance-today>
                    <no-chance v-if="mask.noChance" @goToShare="goToShare"></no-chance>
                    <activity-end v-if="mask.activityEnd"></activity-end>
                    <activity-not-start v-if="mask.activityNotStart"></activity-not-start>
                    <no-login v-if="mask.noLogin" @goToLogin="goToLogin"></no-login>
                    <prize-list v-if="mask.prizeList" :listData="prizeListData"></prize-list>
                    <rule v-if="mask.rule"></rule>
                </div>
                <div class="mask-close" @click="hideMask"></div>
            </div>
        </transition>   
        <div class="home-link">
            <div class="link-share maidian" name="分享0a" mtaName="share0a" @click="goToShare"></div>    
            <div class="link-prize-list maidian" name="我的红包雨奖品0b" mtaName="prize0b" @click="getPrizesList"></div>
            <div class="link-1218 maidian" name="1218封面0c" mtaName="1218cover0c" @click="to1218"></div>
        </div> 
    </div>
</template>

<script>
import Timr from 'timrjs'
import Game from './game'
import {toLogin,toTBX} from '../js/lib/util.js'
import Share from '../js/lib/initShare.js'
import noChanceToday from './mask/no-chance-today'
import noChance from './mask/no-chance'
import activityEnd from './mask/activity-end'
import activityNotStart from './mask/activity-not-start'
import noLogin from './mask/no-login'
import prizeList from './mask/prize-list'
import rule from './mask/rule'

import {userInit,userRecList,toDraw} from '../api/api.js'

export default {
    created() {
        Share.set()
        if(window.isLogin){
            userInit().then(res => {
                this.chance = res.leftDrawCount
                this.userId = res.userId
                this.isShare = res.shared
            })
        }
    },
    data() {
        return {
            chance: 0,
            gameStart: false,
            gameReady: false,
            readyTimeout: 3,
            counter: 0,
            isShowPrize: false,
            isFirstPlay: true,
            isShare: false,
            prizeListData: [],
            redPackDrawPrizes: [],
            logined: window.isLogin,
            mask: {
                show: false,
                noChanceToday: false,
                noChance: false,
                activityEnd: false,
                activityNotStart: false,
                noLogin: false,
                prizeList: false,
                rule: false
            }
        }
    },
    methods: {
        onBtnClick() {
            if(!window.isActivityStart){
                this.showMask('activityNotStart')
                return
            }
            if(window.isActivityEnd){
                this.showMask('activityEnd')
                return
            }
            if(!this.logined){
                this.showMask('noLogin')
                return
            }
            if(this.chance <= 0){
                if(this.isShare){
                    this.showMask('noChanceToday')
                    return
                }else{
                    this.showMask('noChance')
                    return
                }
            }
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
            toDraw(this.userId + this.counter, this.counter).then(res => {
                let {leftCout,shared,redPackDrawPrizes,firstJiaXi} = res

                this.isFirstPlay = firstJiaXi
                this.chance = leftCout
                this.isShare = shared
                this.redPackDrawPrizes = redPackDrawPrizes

                this.gameStart = false
                this.isShowPrize = true
            })
        },
        onPrizeContainerClose() {
            this.isShowPrize = false
        },
        goToShare() {
            if(!this.logined){
                this.showMask('noLogin')
                return
            }
            if(this.isShowPrize){
                this.isShowPrize = false
            }
            this.hideMask()
            Share.show()
        },
        shareToPlayAgain(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.goToShare()
        },
        goToLogin() {
            toLogin()
        },
        linkLogin(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            toLogin()
        },
        linkShare(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.goToShare()
        },
        lookPrize() {
            toTBX()
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
        getPrizesList() {
            if(!this.logined){
                this.showMask('noLogin')
                return
            }
            userRecList().then(res => {
                this.prizeListData = res
                this.showMask('prizeList')
            })
        },
        to1218(){
            window.location.href ='/huodong/mainHall/mobile/index.html'
        }
    },
    components: {
        Game,
        noChanceToday,
        noChance,
        activityEnd,
        activityNotStart,
        noLogin,
        prizeList,
        rule
    }
}
</script>
<style lang="scss" scoped>
    .game-container{
       width: 100vw;
       height: 100vh; 
       background: rgba(0,0,0,0.85);
       position: absolute;
       top: 0;
       left: 0;
       z-index: 9;
       display: flex;
       align-items: center;
       justify-content: center;
       padding-bottom: rem(100);
       .ready-time{
           .timeout{
               color: #fa9e17;
               text-align: center;
               font-size: rem(88);
           }
           .ready-img{
               width: rem(438);
               height: rem(442);
               @include bg('../assets/images/ready-img.png');
               margin-top: rem(-20);
           }
       }
       .counter{
           width: 100vw;
           height: rem(572);
           @include bg('../assets/images/counter-bg.png');
           z-index: 2;
           position: absolute;
           bottom: 0;
           left: 0;
           text-align: center;
           font-size: rem(44);
           color: #fff;
           padding-top: rem(430);
           pointer-events: none;
           span{
               color: #fbdc05;
               font-size: rem(72);
               margin: 0 rem(40);
           }
       }
    }
    .prize-container{
        width: 100vw;
        height: 100vh; 
        background: rgba(0,0,0,0.85);
        position: absolute;
        top: 0;
        left: 0;
        z-index: 10;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
       .close{
           @include wh(80,80);
           @include bg('../assets/images/close.png');
           position: absolute;
           top: rem(44);
           right: rem(30);
       }
       .jxq{
           @include wh(299,196);
           @include bg('../assets/images/jxq.png');
           margin: rem(20) auto 0;
       }
        .prize-p{
            line-height: rem(64);
            color: #fff;
            font-size: rem(36);
            span{
                color: #fbdc05;
                font-size: rem(56);
                margin: 0 rem(16);
            }
        }
        .first-prize{
            margin-top: rem(35);
            .prize-p{
                span{
                    font-size: rem(46);
                }
            }
        }
        .prize-hb-wrapper{
            display: flex;
            justify-content: center;
            align-items: center;
            height: rem(224);
            margin-top: rem(30);
            .prize-hb{
                @include wh(182,224);
                @include bg('../assets/images/prize-hb.png');
                padding-top: rem(135);
                padding-right: rem(10);
                p{
                    font-size: rem(40);
                    color: #fff;
                    text-align: center;
                    span{
                        font-size: rem(56);
                        font-weight: bold;
                    }
                }
            }
            .prize-add{
                @include wh(66,66);
                @include bg('../assets/images/add.png');
                margin: 0 rem(38);
            }
        }
        .prize-btn-wrapper{
            margin-top: rem(85);
            display: flex;
            justify-content: center;
            .share-btn{
                @include wh(354,128);
                @include bg('../assets/images/share-btn.png');
                padding-top: rem(28);
                color: #fff;
                font-size: rem(40);
            }
            .lookPrize-btn1{
                @include wh(354,128);
                @include bg('../assets/images/lookPrize-btn1.png');
                padding-top: rem(28);
                color: #ff413d;
                font-size: rem(40);
            }
            .lookPrize-btn2{
                @include wh(542,128);
                @include bg('../assets/images/lookPrize-btn2.png');
                padding-top: rem(28);
                color: #ff413d;
                font-size: rem(40);
            }
        }
    }
    .mask{
        width: 100vw;
        height: 100vh;
        position: absolute;
        z-index: 10;
        left: 0;
        top: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        .mask-bg{
            width: 100vw;
            height: 100vh;
            position: absolute;
            z-index: 1;
            left: 0;
            top: 0;
            background: rgba(0,0,0,0.85);
        }
        .mask-con{
            position: relative;
            z-index: 2;
        }
        .mask-close{
            @include wh(80,80);
            @include bg('../assets/images/close.png');
            margin: rem(15) auto 0;
            z-index: 2;
        }
    }
    .home{
        width: 100vw;
        height: 100vh;
        background: url('../assets/images/home-bg.jpg') center bottom no-repeat;
        background-size: 100% 100%;
        position: relative;
        padding-top: rem(72);
        .home-lable{
            width: rem(171);
            height: rem(163);
            @include bg('../assets/images/home-lable.png');
            left: rem(30);
            position: absolute;
            top: 0;
        }
        .rule-btn{
            text-shadow: 1px 2px 0px rgba(211, 89, 16, 0.49);
            box-shadow: rem(2) rem(4) rem(13) 0px rgba(157, 45, 74, 0.31);
            color: #fff;
            font-size: rem(30);
            background: linear-gradient(to right,#ff9d68,#ff6f00);
            padding: rem(20) 0;
            width: rem(170);
            text-align: center;
            border-radius: rem(34) 0 0 rem(34);
            position: absolute;
            top: rem(30);
            right: 0;
        }
        .home-link{
            position: absolute;
            display: flex;
            flex-direction: column;
            right: 0;
            bottom: rem(160);
            z-index: 5;
            .link-share{
                @include wh(116,124);
                @include bg('../assets/images/link-share.png');
            }
            .link-prize-list{
                @include wh(116,124);
                @include bg('../assets/images/link-prize-list.png');
            }
            .link-1218{
                @include wh(116,124);
                @include bg('../assets/images/link-1218.png');
            }
        }
    }
    .ad-txt{
        text-align: center;
        color: #ffb3bf;
        font-size: rem(22);
        padding-left: rem(30);
    }
    .home-tit{
        width: rem(669);
        height: rem(102);
        @include bg('../assets/images/home-tit.png');
        margin: rem(93) auto 0;
    }
    .home-sub{
        width: rem(541);
        height: rem(78);
        @include bg('../assets/images/home-sub.png');
        margin: rem(33) auto 0;
        color: #fff;
        font-size: rem(30);
        text-align: center;
        padding-top: rem(20);
        position: relative;
        z-index: 5;
    }
    .home-hb{
        position: absolute;
        bottom: rem(100);
        left: 0;
        z-index: 2;
        width: rem(744);
        height: rem(711);
        @include bg('../assets/images/home-hb.png');
    }
    .home-cover{
        position: absolute;
        bottom: 0;
        left: 0;
        z-index: 3;
        width: 100vw;
        height: rem(903);
        @include bg('../assets/images/home-cover.png');
        padding-top: rem(564);
        text-align: center;
    }
    .home-btn{
        width: rem(555);
        height: rem(136);
        @include bg('../assets/images/home-btn.png');
        margin: 0 auto;
        color: #ee103a;
        font-size: rem(44);
        padding-top: rem(28);
    }
    .cover-p1{
        color: #fff;
        font-size: rem(28);
        span{
            color: #ffcb2c;
            font-size: rem(28);
            font-weight: bold;
            margin-right: rem(5);
        }
    }
    .cover-p2{
        color: #fff;
        font-size: rem(26);
        margin-top: rem(18);
        span{
            color: #ffcb2c;
            font-size: rem(26);
            text-decoration: underline;
            margin-right: rem(5);
        }
    }
    .cover-p3{
        width: 100%;
        position: absolute;
        left: 0;
        bottom: rem(33);
        font-size: rem(18);
        color: #fe9cd4;
        line-height: rem(30);

    }
    .breath{
        animation: breath 0.8s linear alternate infinite;
    }
    @keyframes breath{
        0%{
            transform: scale(1,1);
        }
        100%{
            transform: scale(0.95,0.95);
        }
    }
    .fade-enter-active, .fade-leave-active {
        transition: opacity 0.3s;
    }
    .fade-enter, .fade-leave-to {
        opacity: 0;
    }
</style>


