<template>
    <div class="jump-container" @click="toJump(jumpIndex+1)">
        <!-- <div class="jump-count">{{jumpIndex}}/12</div> -->
            <div class="jump-wrapper">
            <transition name="fade">   
                <div v-show="jumpEnter" :class="paiClassName" ref="pai"></div>
            </transition>
            <div class="city-wrapper" ref="cityWrapper">
                <div class="city" 
                    v-for="(item,index) in city" 
                    :style="{top: distance*index + 'px'}"
                    :key="index"
                    v-show="index<=jumpIndex+1"
                    :class="{'city-show': addCityShowClassName === true && index===jumpIndex+1}"
                    >
                    <img :src="require(`../assets/images/city${item.index}.png`)" :class="item.name" alt="">
                </div>
            </div>
        </div>
        <question v-if="isShowQuestion" 
                  :jumpIndex="jumpIndex"
                  @selectAnswer="selectAnswer" />
        <transition name="fade">          
            <div v-if="isFirstPlay" class="firstPlayTips">
                <div class="img finger-move"></div>
                <p>点击屏幕跳动</p>
            </div>    
        </transition>      
        <audio :src="require('../assets/images/music.mp3')" ref="audio"></audio>
    </div>
</template>

<script>
import '../assets/sass/jump.scss'
import config from '../js/lib/config.js'
import {rem} from '../js/lib/util.js'
import Question from './question'
import {jump,answer} from '../api/api'

let startAngle = null,
    endAngle = 0,
    rotate = 0,
    r = 0,
    x0 = 0,
    y0 = 0

export default {
    props:['jumpEnter','gameState','isFirstPlay'],
    data(){
        return {
            city: config,
            arriveIndex: 0,
            jumpIndex: 0,
            startAngle1: 0,
            startAngle2: 0,
            isShowQuestion: false,
            addCityShowClassName: false,
            isSelectAnswer: false
        }
    },
    created(){ 
        this.timer = null
        this.raf = null
        this.distance = 100
        this.isJumping = true
        this.baseLinePos = null
    },
    mounted(){
        let city = this.$refs.cityWrapper.children
        let distance = this.distance
        let dis = (window.innerHeight - city[0].clientHeight + distance*2)/2 
        if(dis>distance){
            this.baseLinePos = dis - distance
            this.$refs.cityWrapper.style.top = dis - distance + 'px'
        }
    },
    watch: {
        jumpEnter(newVal){
            if(newVal){
                let pos = this.gameState.position
                if(pos){
                    let city = this.city.filter(item => item.name === pos)
                    this.arriveIndex = city[0].index
                }else{
                    this.isJumping = false
                }
                this.$nextTick(()=>{
                    this.setStartPosition()
                })
            }
        }
    },
    computed: {
        paiClassName() {
            return this.jumpIndex%2 === 0? 'pai pai-left': 'pai pai-right'
        }
    },
    methods: {
        setStartPosition(){
            this.jumpIndex = this.arriveIndex
            let paiHehgit = rem(225)
            let x,y
            if(this.arriveIndex%2 === 0){
                //小pai落在右边
                x = rem(500)
                y = this.baseLinePos - paiHehgit/2 + 10
            }else{
                //小pai落在左边
                x = rem(180)
                y = this.baseLinePos - paiHehgit/2
            }
            this.$refs.pai.style.transform = this.$refs.pai.style.webkitTransform = `translate3d(${x}px,${y}px,0)`
            this.$refs.cityWrapper.style.transform = this.$refs.cityWrapper.style.webkitTransform = `translate3d(0,${-this.distance*this.arriveIndex}px,0)`
            if(this.arriveIndex>0){
                setTimeout(()=>{
                    if(!this.gameState.answerFlag){
                        this.isJumping = true
                        this.isShowQuestion = true
                    }else{
                        this.isJumping = false
                    }
                },400)
            }else{
                this.isJumping = false
            }
        },
        toJump(idx){
            if(this.isFirstPlay){
                this.$emit('hideFirstPlay')
            }
            if(this.isJumping) return
            if(idx<=this.jumpIndex) return
            this.isJumping = true
            this.setJumpData()  
        },
        selectAnswer(result){
            let position = this.city[this.jumpIndex].name
            answer(position,result).then(res => {
                setTimeout(() => {
                    this.isShowQuestion = false
                    this.isJumping = false
                    if(res.finishJourney){
                        this.$emit('showMaskFinish',{
                            shared: res.shared,
                            correctCount: res.correctCount,
                            sharable: res.sharable,
                            hasPrize: res.hasPrize
                        })
                    }
                },1000)
            })
        },
        setJumpData(){
            this.$refs.audio.play()
            let pai = this.$refs.pai
            let city = this.$refs.cityWrapper.children
            let dis = (city[0].clientWidth - pai.clientWidth)/2
            let x1 = pai.getBoundingClientRect().left
            let y1 = pai.getBoundingClientRect().top
            if(this.jumpIndex%2 === 0){
                let x2 = city[this.jumpIndex + 1].getBoundingClientRect().left + dis*2 - 20
                let y2 = y1 + this.distance
                x0 = (x1 - x2) / 2 + x2
                y0 = (y2 - y1) / 2 + y1
                startAngle = Math.atan2(y0-y1, x1-x0)
                endAngle = startAngle + Math.PI
                r = Math.sqrt( Math.pow(x1-x0, 2) + Math.pow(y0-y1, 2) ) 
                this.jumpMove()
            }else{
                let x2 = city[this.jumpIndex + 1].getBoundingClientRect().left + dis
                let y2 = y1 + this.distance + 10
                x0 = (x2 - x1) / 2 + x1
                y0 = (y2 - y1) / 2 + y1
                startAngle = Math.PI - Math.atan2(y0-y1, x0-x1)
                endAngle = -Math.atan2(y0-y1, x0-x1)
                r = Math.sqrt( Math.pow(x0-x1, 2) + Math.pow(y0-y1, 2) ) 
                this.jumpMove()
            }
            
        },
        jumpMove(){
            if(this.jumpIndex%2 === 0){
                if(startAngle >= endAngle){
                    this.arrive()
                    return
                }
                if(rotate < -360){
                    rotate = -360
                }
                let x = x0 + r*Math.cos(startAngle)
                let y = y0 - r*Math.sin(startAngle)
                this.$refs.pai.style.transform = this.$refs.pai.style.webkitTransform = `translate3d(${x}px,${y}px,0) rotateZ(${rotate}deg)`
                startAngle += 0.1
                rotate -= 12
            }else{
                if(startAngle <= endAngle){
                    this.arrive()
                    return
                }
                if(rotate > 360){
                    rotate = 360
                }
                let x = x0 + r*Math.cos(startAngle)
                let y = y0 - r*Math.sin(startAngle)
                this.$refs.pai.style.transform = this.$refs.pai.style.webkitTransform = `translate3d(${x}px,${y}px,0) rotateZ(${rotate}deg)`
                startAngle -= 0.1
                rotate += 12
            }
            this.raf = window.requestAnimationFrame(this.jumpMove)
        },
        arrive(){
            cancelAnimationFrame(this.raf)
            this.raf = null
            startAngle = null
            endAngle = 0
            rotate = 0
            r = 0
            x0 = 0
            y0 = 0
            this.jumpIndex += 1
            this.addCityShowClassName = true
            this.$nextTick(()=>{
                this.screenMove()
            })
        },
        screenMove(){
            let transform = this.$refs.pai.style.transform.split(',')
            transform[1] = parseFloat(transform[1].replace('px','')) -this.distance + 'px'
            this.$refs.cityWrapper.style.transform = this.$refs.cityWrapper.style.webkitTransform = `translate3d(0,${-this.distance*this.jumpIndex}px,0)`
            this.$refs.pai.classList.add('pai-transtion')
            this.$refs.pai.style.transform = this.$refs.pai.style.webkitTransform = transform.join(',')
            setTimeout(()=>{
                this.$refs.pai.classList.remove('pai-transtion')
                this.showQuestion()
            },400)
        },
        showQuestion(){
            setTimeout(()=>{
                let jumpFrom = this.city[this.jumpIndex-1].name
                let jumpTo = this.city[this.jumpIndex].name
                jump(jumpFrom,jumpTo).then(res => {
                    this.isShowQuestion = true
                })
            },400)
        }
    },
    components: {
        Question
    }
}
</script>


