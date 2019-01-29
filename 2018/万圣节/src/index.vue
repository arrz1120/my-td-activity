<style lang="scss">
  body{
    background: #171727;
  }
  .mask{
    width: 100vw;
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    z-index: 9;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    transform: translateZ(1px);
    .mask-bg{
      width: 100vw;
      height: 100vh;
      position: absolute;
      top: 0;
      left: 0;
      z-index: 1;
      background: rgba(0,0,0,0.9);
    }
    .mask-close{
      @include bg('./assets/images/close.png');
      @include wh(70,70);
      position: relative;
      z-index: 2;
      position: absolute;
      left: 50%;
      bottom: 0;
      transform: translate(-50%,150%);
    }
    .mask-con{
      width: rem(560);
      position: relative;
      z-index: 2;
      background: #fff url('./assets/images/mask-bg.png') no-repeat;
      background-size: 100% auto;
      border-radius: rem(30);
      .mask-btn{
        width: rem(400);
        padding: rem(25) 0;
        text-align: center;
        font-size: rem(30);
        color: #5f2d06;
        margin: 0 auto;
        @include bg('./assets/images/mask-btn.png');
      }
    }
    .tb-con{
      padding-bottom: rem(40);
    }
    .tb-txt{
      height: rem(200);
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
      .tb-p1{
        line-height: rem(50);
        color: #333;
        font-size: rem(30);
        text-align: center;
      }
      .tb-p2{
        color: #fb5620;
        font-size: rem(22);
        margin-top: rem(30);
      }
    }
  }
</style>

<template>
  <section class="app">
    <pass0
      v-if="nowPass===0"
      @onLockModalBtnClk="onLockModalBtnClk"
      ref="pass0">
    </pass0>

    <pass1 v-if="nowPass===1"
           ref="pass1"
           @passSuccess="passSuccess"
           @passFail="passFail">
    </pass1>
    <!-- <pass2
          v-if="nowPass===2"
           ref="pass2"
          @passSuccess="passSuccess"
          @passFail="passFail">
    </pass2> -->
    <pass3
          v-if="nowPass===3"
           ref="pass3"
          @passSuccess="passSuccess"
          @passFail="passFail">
    </pass3>
    <pass4
          v-if="nowPass===4"
           ref="pass4"
          @passSuccess="passSuccess"
          @passFail="passFail"
          :stageKey="stageKey">
    </pass4>

    <div class="mask" v-show="mask.show">
      <div class="mask-bg"></div>
      <div class="mask-con">

        <!-- 团币不足 -->
        <tb-not-enough :tb='tb'
                       v-if="mask.tbNotEnough"
                       @hideMask="showMask('passFail')">
        </tb-not-enough>

        <!-- 消耗88团币查看提示 -->
        <get-tips :tb='tb'
                  :nowPass="nowPass"
                  v-if="mask.getTips"
                  @isRead="showMask('passTips')"
                  @tbNotEnough="showTbNotEnough"
                  @passFail="passFail"
                  @exchangeSuccess="showMask('passTips')">
        </get-tips>

        <!-- 获得1次查看提示机会 -->
        <watch-tips v-if="mask.watchTips" @watchTips="watchTips"></watch-tips>

        <!-- 过关提示 -->
        <passTips :nowPass="nowPass"
                  :tips="mask.passTipsTxt"
                  v-if="mask.passTips"
                  @playAgain="tryAgain">
        </passTips>

        <!-- 查看提示方式 -->
        <to-watch-tips
          v-if="mask.toWatchTips"
          :nowPass="nowPass"
          :telNo="userShareInfo.telNo"
          :extenderKey="userShareInfo.extenderKey"
          @tbNotEnough="showTbNotEnough"
          @toExchangeTb="toExchangeTb"
          @showTips="showMask('passTips')"
          @passFail="passFail"
        />

        <!-- 过关成功 -->
        <pass-success @nextPass="nextPass" v-if="mask.passSuccess"></pass-success>

        <!-- 过关失败 -->
        <pass-fail @tryAgain="tryAgain" @watchTips="watchTips" v-if="mask.passFail"></pass-fail>

      </div>
      <!-- <div class="mask-close" @click="hideMask"></div> -->
    </div>
  </section>
</template>

<script>
import {
  apiPostUserPassStage,
  apiGetUserShareInfo,
} from './api/baseApi.js'
import tbNotEnough from './components/mask/tbNotEnough'
// 兑换团币弹窗
import getTips from './components/mask/getTips'
// 兑换团币成功弹窗
import watchTips from './components/mask/watchTips'
import passTips from './components/mask/passTips'
// 分享弹窗
import toWatchTips from './components/mask/toWatchTips'

import passSuccess from './components/mask/passSuccess'
import passFail from './components/mask/passFail'

import pass0 from './components/stageIndex.vue'
import pass1 from './components/pass1'
// import pass2 from './components/pass2'
import pass3 from './components/stage3rd.vue'
import pass4 from './components/stage4th.vue'

import {isRead} from './api/api.js'
import Share from './js/lib/initShare.js'

export default {
  name: 'App',
  mounted() {
    // this.showMask('getTips')
    Share.set({
        shareUrl: window.router.index
    })
  },
  data() {
    return {
      nowPass: 4, //当前是第几关
      // 关卡 key
      stageKey:0,
      // 接口返回关卡
      targetStage:0,

      userShareInfo:{
        telNo:'',
        extenderKey:''
      },

      mask: { //弹窗状态
        show: false, //是否显示
        tbNotEnough: false, //团币不足
        getTips: false, //确定消耗88团币查看提示？
        watchTips: false, //已消耗88团币，获得1次查看提示机会！
        toWatchTips: false, //通过以下方式可查看提示
        passTips: false, //过关提示
        passSuccess: false, //过关成功
        passFail: false, //过关失败
      },
      tb: 8
    }
  },
  methods: {
    //显示弹窗
    showMask(name) {
      this.hideMask()
      this.mask[name] = true
      this.mask.show = true
    },
    //隐藏弹窗
    hideMask(){
      for(var key in this.mask){
        this.mask[key] = false
      }
      this.mask.show = false
    },
    //每一关的弹窗提示文字
    showPassTips(pass) {
      this.showMask('passTips',true)
    },
    //下一关
    nextPass() {
      this.nowPass=this.targetStage
      this.hideMask()
    },
    //闯关成功
    passSuccess() {
      let postData={
        num:this.nowPass,
        key:this.stageKey
      }
      apiPostUserPassStage(postData)
        .then(res=>{
          this.stageKey=res.key
          this.targetStage=res.num
          this.showMask('passSuccess')
        })
        .catch(err=>{
          if(err.response.status>=500||err.response.status<=599){
            toast.show('服务器繁忙，请重试')
            return
          }
          toast.show(err.response.data.message)
        })
    },
    //闯关失败
    passFail() {
      this.showMask('passFail')
    },
    //再试一次
    tryAgain() {
      this.hideMask()
      this.$refs['pass'+ this.nowPass].play()
    },
    //查看提示
    watchTips() {
      isRead(this.nowPass).then(res => {
        if(res){
          this.showMask('passTips')
        }else{
          this.showMask('toWatchTips')
        }
      }).catch(err => {
        toast.show('网络异常，请稍后重试')
        //window.location.href=`//passport.tuandai.com/2login?ret=http://dev.tuandai.com:9527/`
      })
    },
    toExchangeTb(tb) {
      this.tb = tb
      this.showMask('getTips')
    },
    showTbNotEnough(tb) {
      this.tb = tb
      this.showMask('tbNotEnough')
    },
    // 第一关开始逃生 click 事件
    onLockModalBtnClk({stageNum,stageKey}){
      this.nowPass=stageNum
      this.stageKey=stageKey
    }
  },
  created(){
    apiGetUserShareInfo()
      .then(res=>{
        this.userShareInfo.telNo=res.telNo
        this.userShareInfo.extenderKey=res.extenderKey
      })
      .catch(err=>{
        // toast.show('获取用户分享信息失败，请刷新页面重试')
      })

    window.addEventListener('pageshow',(e)=>{
      if(e.persisted){
        window.location.href=window.location.href
      }
    })
  },
  components: {
    getTips,
    tbNotEnough,
    watchTips,
    passTips,
    toWatchTips,
    passSuccess,
    passFail,
    pass0,
    pass1,
    // pass2,
    pass3,
    pass4,
  }
}
</script>
