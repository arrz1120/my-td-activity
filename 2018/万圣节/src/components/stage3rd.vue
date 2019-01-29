<template>
  <section :class="{'animate':hasPageShaked}" class="stage-3rd">
    <audio ref="audio" :src="require('../assets/images/music.mp3')"></audio>
    <Countdown 
      :status="countdownStatus" 
      :countdown="countdown"
      @timeout="countdownTimeout"
    />
    <ul class="trouble-ul">
      <li class="item">为了躲避骷髅鬼的追击，你们躲到三楼房间里，</li>
      <li class="item">此时骷髅怪正试图从窗户中爬进来，怎么办？</li>
    </ul>
    <section class="window-container">
      <div class="window-border"></div>
      <transition name="skeleton">
        <div v-if="hasSkeleton" class="window-skeleton"></div>
      </transition>
      <div class="window-bg"></div>
    </section>
    <section class="scene-container">
      <div @click="onDoorClk" class="scene-door"></div>
    </section>
    <p :class="{'animte':hasDoorTips}" class="scene-text">真不巧，门锁被卡住了</p>
  </section>
</template>

<script>
import Shake from 'shake.js'
import '../assets/sass/stage3rd.scss'
import Countdown from './stageCountdown.vue'

export default {
  components:{
    Countdown,
  },
  data(){
    return{
      countdown:30,
      countdownStatus:null,
      shake:null,
      hasSkeleton:false,
      hasDoorTips:false,
      doorTipsTimer:null,
      hasPageShaked:false,
    }
  },
  methods:{
    play(){
      this.countdown=30
      this.countdownStatus='play'
      this.shake.start()
    },
    addShakeEvent(){
      this.shake=new Shake({
        threshold:15,
        timeout:1000
      })
      window.addEventListener('shake',()=>{
        this.hasPageShaked=true
        this.countdownStatus='pause'
        this.shake.stop()
        setTimeout(()=>{
          this.hasSkeleton=false
        },1000)
        setTimeout(()=>{
          this.$emit('passSuccess')
        },1500)
      })
    },
    showSkeleton(){
      setTimeout(()=>{
        this.hasSkeleton=true
      },1000)
    },
    countdownTimeout(){
      this.countdownStatus=null
      this.shake.stop()
      this.$emit('passFail')
    },
    onDoorClk(){
      this.hasDoorTips=true
      this.$refs.audio.play()
      clearTimeout(this.doorTipsTimer)
      this.doorTipsTimer=setTimeout(()=>{
        this.hasDoorTips=false
      },3000)
    },
  },
  created(){
    this.addShakeEvent()
    this.showSkeleton()
    this.$nextTick(()=>{
      this.play()
    })
  }
}
</script>

