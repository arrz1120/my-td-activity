<template>
  <section class="stage-4th">
    <Countdown 
      :status="countdownStatus" 
      :countdown="countdown"
      @timeout="countdownTimeout"
    />
    <ul class="trouble-ul">
      <li class="item">终于熬到天亮，无奈又来了一个女巫，施法让迷</li>
      <li class="item">雾挡住了光线，怎么办？</li>
    </ul>
    <section class="window-container">
      <div class="window-border"></div>
      <!-- 擦除 canvas -->
      <canvas :class="{'animate':hasAnimated}" class="window-smoke"></canvas>
      <!-- 擦除 canvas end -->
    </section>
    <div class="sufferer"></div>
    <section :class="{'animate':hasAnimated}" class="witch-container">
      <div class="witch-body"></div>
      <div class="witch-arm"></div>
      <div class="wtich-star"></div>
    </section>
    <p class="scene-text">恭喜你逃生成功~</p>

    <!-- 中奖弹窗 -->
    <div class="mask" v-if="prizeModalStatus">
      <div class="mask-bg"></div>
      <div class="mask-con">
        <PrizeModal/>
      </div>
    </div>
    <!-- 中奖弹窗end -->
  </section>
</template>

<script>
import '../assets/sass/stage4th.scss'
import Countdown from './stageCountdown.vue'
import Eraser from '../js/lib/eraser.js'
import PrizeModal from './mask/getPrize.vue'
import {apiPostUserPassStage} from '../api/baseApi.js'
export default {
  components:{
    Countdown,
    PrizeModal,
  },
  props:['stageKey'],
  data(){
    return{
      countdown:30,
      countdownStatus:null,
      prizeModalStatus:false,
      hasAnimated:false,
    }
  },
  methods:{
    play(){
      this.countdown=30
      this.countdownStatus='play'
    },
    countdownTimeout(){
      this.countdownStatus=null
      this.$emit('passFail')
    },
    initEraser(){
      let ctx=this
      new Eraser('.window-smoke',{
        width:10.21*mobileUtils.rem,
        height:11.66*mobileUtils.rem,
        ratio:.75,
        cover:require('../assets/images/stage4th/01.png'),
        onComplete(){
          toast.show('请稍候...',10000)
          let postData={
            num:4,
            key:ctx.stageKey
          }
          apiPostUserPassStage(postData)
            .then(res=>{
              toast.hide()
              ctx.prizeModalStatus=true
              ctx.countdownStatus='pause'
            })
            .catch(err=>{
              toast.hide()
              if(err.response.status>=500||err.response.status<=599){
                toast.show('服务器繁忙，请重试')
                return
              }
              toast.show(err.response.data.message)
            })
        }
      })
    }
  },
  created(){
    if(this.stageKey==='ALL_PASS'){
      this.prizeModalStatus=true
      return
    }
    this.$nextTick(()=>{
      this.hasAnimated=true
      this.initEraser()
      this.play()
    })
  }
}
</script>

