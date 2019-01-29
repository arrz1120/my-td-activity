<style lang="scss">
    .pass-container{
        position: relative;
        width: 100vw;
        height: 100vh;
        overflow: hidden;
    }
    .pass2{
        @include bg('../assets/images/pass2.jpg');
        padding-top: rem(170);
        .p1{
            color: #fff;
            font-size: rem(26);
            text-align: center;
            position: relative;
            z-index: 2;
        }
        .friend-wrap{
            @include wh(169,812);
            position: absolute;
            top: rem(30);
            left: rem(283);
            z-index: 1;
            transform-origin: center top;
        }
        .img-friend{
            @include wh(169,812);
            @include bg('../assets/images/img-friend.png');
            // transition: all 1s linear;
            transform-origin: center top;
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
            .desk-cutter{
                @include wh(191,91);
                @include bg('../assets/images/cutter.png');
                position: absolute;
                top: 0;
                left: rem(165);
            }
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
    <div class="pass-container pass2">
        <audio ref="audio" :src="require('../assets/images/music.mp3')"></audio>
        <Countdown 
            :status="countdownStatus" 
            :countdown="countdown"
            @timeout="countdownTimeout"
        />
        <div class="p1">
            您的朋友被抓住了，快趁着恶鬼不在，救出他！
        </div>
        <div class="friend-wrap" ref="friend">
            <div class="img-friend" ref="friendImg"></div>
        </div>
        <div class="desk">
            <div :class="{'animte':cutterTips}" class="desk-txt">祸不单行，剪刀坏了~</div>
            <div class="desk-cutter" @click="showCutterTips"></div>
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
            cutterTips: false,
            isPass: false
        }
    },
    mounted() {
        this.play()
    },
    methods: {
        play(){
            this.isPass = false
            this.countdown=30
            this.countdownStatus='play'

            if(window.DeviceOrientationEvent) {

                window.addEventListener('deviceorientation', (event) => {
                    if(this.isPass) return
                    var alpha = event.alpha,
                        beta = event.beta,
                        gamma = event.gamma;
                        // document.title = `alpha=${Math.floor(alpha)},beta=${Math.floor(beta)},gamma=${gamma}`;
                    if(beta>=-5 && beta<=80){
                        this.scale(alpha)
                        this.$refs.friend.style.webkitTransform = 'rotate('+ alpha + 'deg)';
                        this.$refs.friend.style.transform = 'rotate(' + alpha + 'deg)';
                        if((alpha >= 70 && alpha<=90) || (alpha>=270 && alpha<=290)){
                            this.success()
                        }
                    }
                }, false);
            }
        },
        scale(angle){
            let winWidth = window.innerWidth/2
            let imgHeight = this.$refs.friend.clientHeight
            let startAngle = Math.asin(winWidth/imgHeight)*180 / Math.PI
            let sinH = winWidth/Math.sin(angle * Math.PI / 180)
            let targetH
            if(angle > startAngle && angle <= 90){
                targetH = sinH
            }
            if(angle>=270 && angle<(360-startAngle)){
                targetH = -sinH
            }
            let scale = targetH/imgHeight
            this.$refs.friendImg.style.webkitTransform = `scale(${scale},${scale})`;
            this.$refs.friendImg.style.transform = `scale(${scale},${scale})`;
        },
        showCutterTips() {
            this.$refs.audio.play()
            this.cutterTips = true
            this.$refs.audio.play()
            this.timer3 = setTimeout(() => {
                this.cutterTips = false
                clearTimeout(this.timer3)
            },3000)
        },
        countdownTimeout(){
            this.isPass = true
            this.countdownStatus=null
            this.$emit('passFail')
        },
        success() {
            this.isPass = true
            this.countdownStatus='pause'
            this.successTimeout = setTimeout(() => {
                this.$emit('passSuccess')
                clearTimeout(this.successTimeout)
            },1000)
        }
    },
    components: {
        Countdown
    }
}
</script>

