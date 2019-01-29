<style lang="scss">
    .pass-container{
        position: relative;
        width: 100vw;
        height: 100vh;
        overflow: hidden;
    }
    .pass1{
        @include bg('../assets/images/pass1.jpg');
        padding-top: rem(157);
        .p1{
            color: #fff;
            font-size: rem(26);
            line-height: rem(48);
            text-align: center;
            .space{
                width: rem(160);
                height: rem(48);
                position: relative;
                display: inline-block;
            }
            .sugar{
                @include wh(131,102);
                @include bg('../assets/images/sugar.png');
                position: absolute;
                top: rem(-34);
                left: rem(10);
                z-index: 8;
            }
        }
        .ghost{
            position: relative;
            margin-top: rem(60);
            margin-left: rem(28);
            @include wh(695,539);
            @include bg('../assets/images/ghost.png');
            .ghost-hand{
                @include wh(134,175);
                @include bg('../assets/images/ghost-hand.png');
                position: absolute;
                left: rem(425);
                top: rem(271);
                padding-top: rem(40);
                .hand{
                    width: rem(112);
                    height: rem(75);
                }
            }
        }
        .desk{
            position: absolute;
            bottom: 0;
            left: rem(122);
            @include wh(540,256);
            @include bg('../assets/images/desk.png');
            .desk-txt{
                color: #fff;
                font-size: rem(22);
                text-align: center;
                margin-top: rem(-60);
                opacity: 0;
                &.animte{
                    opacity: 1;
                    animation: shake 1s;
                }
            }
            .desk-sugar{
                @include wh(131,102);
                @include bg('../assets/images/sugar.png');
                position: absolute;
                top: rem(-20);
                left: rem(192);
            }
        }
    }

    @media screen and (max-height:570px) {
       .desk-txt-media{
           margin-top: rem(80) !important;
       }
    }

    @keyframes shake {
        from,
        to {
            -webkit-transform: translate3d(0, 0, 0);
            transform: translate3d(0, 0, 0);
        }

        10%,
        30%,
        50%,
        70%,
        90% {
            -webkit-transform: translate3d(5%, 0, 0);
            transform: translate3d(-5%, 0, 0);
        }

        20%,
        40%,
        60%,
        80% {
            -webkit-transform: translate3d(5%, 0, 0);
            transform: translate3d(5%, 0, 0);
        }
    }
</style>


<template>
    <div class="pass-container pass1">
        <audio ref="audio" :src="require('../assets/images/music.mp3')"></audio>
         <Countdown 
            :status="countdownStatus" 
            :countdown="countdown"
            @timeout="countdownTimeout"
        />
        <div class="p1">
            您的朋友正被小鬼怪捉弄，把
            <div class="space">
                <span class="sugar" 
                      ref="sugar"
                      @touchstart.prevent="sugarTouchstart" 
                      @touchmove.prevent="sugarTouchmove" 
                      @touchend.prevent="sugarTouchend">
                </span>
            </div>
            交到
        </div>
        <p class="p1">小鬼怪手中才能解救朋友。</p>
        <div class="ghost" @click="musicPlay">
            <div class="ghost-hand">
                <div class="hand" ref="hand"></div>
            </div>
        </div>
        <div class="desk" @click="musicPlay">
            <div :class="{'animte':sugarTips}" class="desk-txt desk-txt-media">哎呀，糖果粘在桌子上了~</div>
            <div class="desk-sugar"
                ref="deskSugar"
                @touchstart.prevent="deskTouchstart" 
                @touchmove.prevent="deskTouchmove" 
                @touchend.prevent="deskTouchend"></div>
        </div>
    </div>
</template>

<script>
import Countdown from './stageCountdown.vue'

export default {
    data() {
        return {
            countdown:30,
            countdownTimer:null,
            countdownStatus:null,
            isSuccess: false,
            sugarTips: false
        }
    },
    created() {
        this.touch = {}
        this.deskTouch = {}
    },
    mounted() {
        this.play()
    },
    methods: {
        play() {
            this.countdown=30
            this.countdownStatus='play'
        },
        sugarTouchstart(e) {
            this.touch.initiated = true
            // 用来判断是否是一次移动
            this.touch.moved = false
            const touch = e.touches[0]
            this.touch.startX = touch.pageX
            this.touch.startY = touch.pageY
        },
        sugarTouchmove(e) {
            if (!this.touch.initiated) {
                return
            }
            const touch = e.touches[0]
            const deltaX = touch.pageX - this.touch.startX
            const deltaY = touch.pageY - this.touch.startY
            if (!this.touch.moved) {
                this.touch.moved = true
            }
            this.$refs.sugar.style.webkitTransform = `translate3d(${deltaX}px,${deltaY}px,0)`
            this.$refs.sugar.style.transform = `translate3d(${deltaX}px,${deltaY}px,0)`
        },
        sugarTouchend(e) {
            const sugarRect = this.$refs.sugar.getBoundingClientRect()
            const handRect = this.$refs.hand.getBoundingClientRect()
            const sugarW = sugarRect.width
            const sugarH = sugarRect.height
            const handW = handRect.width
            const handH = handRect.height
            const deltaX = handRect.left - sugarRect.left
            const deltaY = handRect.top - sugarRect.top
            if(deltaY < sugarH && deltaY > -handH && deltaX < sugarW && deltaX > -handW){
                this.sugarTips = false
                this.isSuccess = true
                this.countdownStatus='pause'
                this.$emit('passSuccess')
            }else{
                this.isSuccess = false
                this.$refs.sugar.style.webkitTransform = `translate3d(0,0,0)`
                this.$refs.sugar.style.transform = `translate3d(0,0,0)`
            }
        },
        deskTouchstart(e){
            this.deskTouch.initiated = true
            // 用来判断是否是一次移动
            this.deskTouch.moved = false
            const touch = e.touches[0]
            this.deskTouch.startX = touch.pageX
            this.deskTouch.startY = touch.pageY
        },
        deskTouchmove(e) {
            if (!this.deskTouch.initiated) {
                return
            }
            const touch = e.touches[0]
            let deltaX = touch.pageX - this.deskTouch.startX
            let deltaY = touch.pageY - this.deskTouch.startY
            if (!this.deskTouch.moved) {
                this.deskTouch.moved = true
            }
            if(deltaX>80){
                deltaX = 80
            }
            if(deltaX<-80){
                deltaX = -80
            }
            if(deltaY>30){
                deltaY = 30
            }
            if(deltaY<-30){
                deltaY = -30
            }
            this.$refs.deskSugar.style.webkitTransform = `translate3d(${deltaX}px,${deltaY}px,0)`
            this.$refs.deskSugar.style.transform = `translate3d(${deltaX}px,${deltaY}px,0)`
        },
        deskTouchend(e) {
            this.sugarTips = true
            this.musicPlay()
            this.timer3 = setTimeout(() => {
                this.sugarTips = false
                clearTimeout(this.timer3)
            },3000)
            this.$refs.deskSugar.style.webkitTransform = `translate3d(0,0,0)`
            this.$refs.deskSugar.style.transform = `translate3d(0,0,0)`
        },
        countdownTimeout(){
            this.countdownStatus=null
            this.$emit('passFail')
        },
        musicPlay(){
            this.$refs.audio.play()
        }
    },
    components: {
        Countdown
    }
}
</script>

