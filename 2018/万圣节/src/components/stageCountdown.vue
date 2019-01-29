<style lang="scss" scoped>
  .countdown-container{
    @include wh(108,105);
    @include bg('../assets/images/stage3rd/01.png');
    position: absolute;
    top: .75rem;
    right: .5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: rem(36);
  }
</style>

<template>
  <section class="countdown-container">
      <p class="countdown">{{countdownVal}}s</p>
    </section>
</template>

<script>
import Timr from 'timrjs'
export default {
  props:['countdown','status'],
  data(){
    return{
      countdownVal:30,
      countdownTimer:null
    }
  },
  methods:{
    init(){
      this.countdownVal=this.countdown
      this.countdownTimer=Timr(this.countdownVal)
      this.countdownTimer.ticker(({currentTime})=>{
        this.countdownVal=currentTime
      })
      this.countdownTimer.finish(()=>{
        this.countdownTimer=null
        this.$emit('timeout')
      })
    },
    play(){
      this.countdownTimer.start()
    },
    pause(){
      this.countdownTimer.pause()
    },
  },
  watch:{
    status(newVal){
      if(newVal==='play'){
        if(!this.countdownTimer){
          this.init()
        }
        this.play()
        return
      }
      if(newVal==='pause'){
        this.pause()
        return
      }
    }
  },
  created(){
    
  }
}
</script>


