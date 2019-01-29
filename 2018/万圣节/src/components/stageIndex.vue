
<template>
  <section class="stage-index">
    <div class="logo"></div>
    <p class="warning">【广告】市场有风险，投资需谨慎</p>
    <div class="toptic"></div>
    <p class="act-date">活动时间：10月29日-11月1日</p>
    <div @click="onRuleBtnClk" class="rule-btn" name="活动规则"></div>
    <div class="castle"></div>
    <div class="bat"></div>
    <p @click="onPlayBtnClk" class="game-btn" :name="playBtnTrackText">{{playBtnText}}</p>
    <section :class="{'d-hide':!hasBingoRecords}" class="bingo-records">
      <div class="records-container"></div>
    </section>

    <!-- 规则弹窗 -->
    <div v-if="ruleModalStatus" class="mask">
      <div class="mask-bg"></div>
      <div class="mask-con">
        <Rule ></Rule>
        <div @click="onRuleCloseBtnClk" class="mask-close"></div>
      </div>
    </div>
    <!-- 规则弹窗 -->

    <!-- 锁屏弹窗 -->
    <div v-if="lockModalStatus" class="mask">
      <div class="mask-bg"></div>
      <div class="mask-con">
        <LockScreen @onBtnClk="onLockModalBtnClk"></LockScreen>
      </div>
    </div>
    <!-- 锁屏弹窗end -->

  </section>
</template>

<script>
import cookies from 'browser-cookies'
import '../assets/sass/stageIndex.scss'
import Marquee from '../js/lib/marquee.js'
import Rule from './mask/rule.vue'
import LockScreen from './mask/lockScreen.vue'
import {
  apiGetBingoRecords,
  apiGetUserStageKey
} from '../api/baseApi.js'
import {
  toLogin,
  toTBX,
} from '../js/lib/utils.js'
export default {

  components:{
    Rule,
    LockScreen
  },

  data(){
    return{
      isLogined:false,
      isDrawed:false,
      ruleModalStatus:false,
      lockModalStatus:false,
      hasBingoRecords:false,
      stageInfo:{
        key:null,
        num:1
      },
      playBtnText:'开始逃生'
    }
  },

  computed:{
    playBtnTrackText(){
      if(this.playBtnText==='开始逃生'){
        return '开始闯关'
      }
      return '首页查看奖品'
    }
  },

  methods:{
    initBingoRecords(items){
      new Marquee('.records-container',{
        items
      })
    },
    onLockModalBtnClk(){
      let data={
        stageKey:this.stageInfo.key,
        stageNum:this.stageInfo.num
      }
      if(this.stageInfo.key==='ALL_PASS'){
        data.stageNum=4
      }
      this.$emit('onLockModalBtnClk',data)
    },
    onPlayBtnClk({target}){
      if(this.playBtnText==='开始逃生'){
        MtaH5.clickStat('start_a2')
        sa.quick('trackHeatMap',target)
      }else{
        MtaH5.clickStat('check_a3')
        sa.quick('trackHeatMap',target)
      }
      if(!this.isLogined){
        toLogin(window.location.href)
        return
      }
      if(this.isDrawed){
        toTBX()
        return
      }
      let hasLockModal=cookies.get('hasLockModal')
      if(!hasLockModal){
        this.lockModalStatus=true
        cookies.set('hasLockModal','true',{
          expires:30
        })
        return
      }
      this.onLockModalBtnClk()
    },
    onRuleBtnClk({target}){
      this.ruleModalStatus=true
      MtaH5.clickStat('rule_a1')
      sa.quick('trackHeatMap',target)
    },
    onRuleCloseBtnClk(){
      this.ruleModalStatus=false
    }
  },

  created(){
    // 获取用户答题 key
    apiGetUserStageKey()
      .then(res=>{
        if(!res.logined){
          this.isLogined=false
          return
        }
        this.isLogined=true
        this.isDrawed=res.userAnswerKey.drawed
        this.stageInfo.key=res.userAnswerKey.key
        this.stageInfo.num=res.userAnswerKey.num
        if(this.isDrawed){
          this.playBtnText='查看奖品'
        }
      })
      .catch(err=>{
        toast.show(err.message)
      })

      // 获取中奖记录
      apiGetBingoRecords()
        .then(res=>{
          this.hasBingoRecords=true
          this.$nextTick(()=>{
            let bingoRecords=res.map(item=>{
              return{
                val:item
              }
            })
            this.initBingoRecords(bingoRecords)
          })
        })
        .catch(err=>{
          this.hasBingoRecords=false
        })
  },
}
</script>


