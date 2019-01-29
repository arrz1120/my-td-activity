<style lang="scss" scoped>
 * { touch-action: pan-y; } 
    .hb-container{
        position: absolute;
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        overflow: hidden;
        .hb{
            width: rem(150);
            height: rem(184);
            @include bg('../assets/images/hb.png');
            background-position: center center;
            background-size: rem(114) rem(156);
            position: absolute;
            top: rem(-200);
            left: 0;
            transform: rotate(20deg);
            // transition: all 2s linear;
        }
        .hb-open{
            width: 100%;
            height: 100%;
            @include bg('../assets/images/hb-open.png');
            // background-image: url('../assets/images/hb-open.png');
            background-size: rem(114) rem(156);
        }
        // .fadeOut{
        //     transition: all 0.2s linear !important;
        //     opacity: 0;
        // }
    }
</style>

<template>
    <div class="game-wapper">
        <div class="game-timeout">
            <p class="gt-p1">倒计时</p>
            <p class="gt-p2">{{currentTime}}s</p>
        </div>
        <div class="hb-container" ref="hbContainer" v-if="hbConfig && hbConfig.length">
            <div class="hb" 
                ref="hb" 
                name="红包7c"
                mtaName="redpacket7c"
                v-for="(item,index) in hbConfig" 
                :style="{left: item.x0 + 'px'}" 
                :key="index"
                @transitionend="hbTransitionEnd"
                @click="onHbClick(index,$event)"
                @touchstart="onHbClick(index,$event)"
            >
                <div class="hb-open" v-show="item.isClick"></div>
            </div>
        </div>
    </div>
</template>

<script>
import Timr from 'timrjs'
import {rem} from '../js/lib/util.js'

const WINDOW_WIDTH = document.documentElement.clientWidth
const WINDOW_HEIGHT = document.documentElement.clientHeight
const HB_WIDTH = rem(162)
const HB_HEIGHT = rem(162)
const ANGLE = 25
const GAME_TIME = 10

export default {
    created(){
        
    },
    mounted() {
        this.initHb()
        this.$nextTick(()=>{
            this.init()
        })
    },
    data() {
        return {
            currentTime: GAME_TIME,
            counter: 0,
            xIndex: 0,
            hbConfig: []
        }
    },
    methods: {
        init() {
            const timr = Timr(GAME_TIME)
            timr.ticker(({currentTime})=>{
                this.currentTime = currentTime
            })
            timr.onStart(() => {
                setTimeout(()=>{
                    this.play()
                },20)
            })
            timr.finish(() => {
                this.hbConfig = null
                this.$emit('gameOver')
            })
            timr.start()
        },
        initHb() {
            let hbData = []
            for(let i=0;i<30;i++){
                let x0 = this.getX(),
                    y0 = -HB_HEIGHT-20,
                    y1 = WINDOW_HEIGHT + HB_HEIGHT,
                    x1 =  - y1 * Math.tan(ANGLE * Math.PI / 180),
                    delay = i*400 + 100*Math.random(),
                    isClick = false,
                    duration = 1.5 + Math.random()*0.5
                hbData.push({
                    x0,y0,x1,y1,delay,duration,isClick
                })
            }
            this.hbConfig = hbData
        },
        getX() {
            const minX = WINDOW_WIDTH/2 - HB_WIDTH/2
            const maxX = WINDOW_WIDTH + HB_WIDTH/2
            return minX + Math.random()*(maxX - minX)
        },
        play(){
            const hb = this.$refs.hbContainer.children
            const hbConfig = this.hbConfig
            const len = hbConfig.length
            for(var i=0;i<len;i++){
                hb[i].style.transition  = `all ${hbConfig[i].duration}s linear`
                hb[i].style.webkitTransition  = `all ${hbConfig[i].duration}s linear`
                hb[i].style.transitionDelay  = hbConfig[i].delay + 'ms'
                hb[i].style.webkitTransitionDelay  = hbConfig[i].delay + 'ms'
                hb[i].style.webkitTransform = `translate3d(${hbConfig[i].x1}px,${hbConfig[i].y1}px,0) rotate(20deg)`
                hb[i].style.transform = `translate3d(${hbConfig[i].x1}px,${hbConfig[i].y1}px,0) rotate(20deg)`
            }
        },
        onHbClick(index,e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            if(this.hbConfig[index].isClick) return
            this.hbConfig[index].isClick = true
            this.counter += 1
            this.$emit('onCount',this.counter)
        },
        hbTransitionEnd(e){
            this.$refs.hbContainer.removeChild(e.target)
        }
    }
}
</script>

<style>
    .game-wapper{
        width: 100vw;
        height: 100vh;
        position: absolute;
        top: 0;
        left: 0;
    }
    .canvas{
        width: 100vw;
        height: 100vh;
        position: absolute;
        top: 0;
        left: 0;
    }
    .game-timeout{
        padding-top: rem(50);
    }
    .gt-p1{
        font-size: rem(30);
        color: #fff;
        margin-left: rem(32);
    }
    .gt-p2{
        font-size: rem(70);
        color: #ffdf04;
        margin-left: rem(44);
    }
    
</style>


