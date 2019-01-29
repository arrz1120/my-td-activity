<template>
  <section class="page-index">
    <div class="indexBox">
      <p class="adv">【广告】市场有风险，出借需谨慎</p>
      <div class="icon1"></div>
      <div class="a-bigger tit1"></div>
      <div class="tit2"></div>
      <div class="tai">
        <div class="zoomInDown animated num1 abs"></div>
        <div class="zoomInDown animated num2 abs"></div>
        <div class="zoomInDown animated num3 abs"></div>
        <div class="zoomInDown animated num4 abs"></div>
      </div>
      <div class="subBtn zoomInfinite" @click="onLaunchBtnClk"></div>
      <div class="ruleBtn" @click="onRuleBtnClk"></div>
      <div class="adv2">在法律许可范畴内，本次活动最终解释权归团贷网所有
        <br>*本次活动和奖品与苹果公司无关
      </div>
      <div class="flBox">
        <div class="flBoxIn shareBtn" @click="onShareBtnClk"></div>
        <a href="https://at.tuandai.com/huodong/comments1218/app/index"><div class="flBoxIn loveBtn"></div></a>
      </div>
    </div>
    <!-- 规则弹窗 -->
    <RuleModal 
      v-if=" modalStatus.rule"
      :initIdx="0"
      @closeCallback="modalStatus.rule=false"
    />
    <!-- 规则弹窗 end -->
  </section>
</template>

<script>
import "./assets/sass/index.scss"
import "./assets/sass/animate.css"
import initShare from './js/lib/initShare.js'
import RuleModal from './components/ruleModal.vue'
export default {

  components:{
    RuleModal,
  },

  data(){
    return{
      modalStatus:{
        rule:false
      }
    }
  },

  methods:{
    onLaunchBtnClk(){
      window.location.href=router.jiaxi
    },
    onRuleBtnClk(){
      this.modalStatus.rule=true
    },
    onShareBtnClk(){
      initShare.show()
    },
  },

  created(){
    initShare.set()
  }
  
}
</script>
