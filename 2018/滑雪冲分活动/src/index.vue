<template>
  <section class="page-index">
    <div class="snowflake"></div>
    <div class="logo"></div>
    <p class="warning-tips">【广告】市场有风险，出借需谨慎</p>
    <div class="rule-btn" name="首页_活动规则" @click="onRuleBtnClk"></div>
    <div class="banner-title"></div>
    <p class="banner-date">活动时间：2018.11.26-12.10</p>
    <section class="btn-group">
      <p class="game-btn" name="首页_进入游戏" @click="onPlayBtnClk">进入游戏</p>
      <div class="btn-row">
        <p class="item" name="首页_冲分榜" @click="onRankingBtnClk">冲分榜</p>
        <p class="item" name="首页_我的奖励" @click="onMyPrizeBtnClk">我的奖励</p>
      </div>
    </section>
    <section class="bingo-container">
      <div class="bingo-records"></div>
    </section>
    <p class="ios-copyright">本活动及奖品与苹果公司无关</p>

    <!-- 规则弹窗 -->
    <ModalContainer 
      topic="活动规则"
      v-if="modalStatus.rule"
      @onCloseBtnClk="modalStatus.rule=false">
      <RuleModal/>
    </ModalContainer>
    <!-- 规则弹窗 end -->

    <!-- 我的奖品弹窗 -->
    <ModalContainer 
      topic="我的奖品"
      v-if="modalStatus.userPrize"
      @onCloseBtnClk="modalStatus.userPrize=false">
      <MyPrizeModal
        :prizeItems="myPrizeList"
      />
    </ModalContainer>
    <!-- 我的奖品弹窗 end -->

    <!-- 登录弹窗 -->
    <ModalContainer 
      v-if="modalStatus.login"
      @onCloseBtnClk="modalStatus.login=false">
      <AlertModal
        :title="['亲，请先登录后再参与活动哦~']"
        btnText="前往登录"
        trackName="登录引导弹窗_前往登录"
        :btnCallback="onLoginModalBtnClk"
      />
    </ModalContainer>
    <!-- 登录弹窗 end -->

    <!-- 活动结束弹窗 -->
    <ModalContainer
      v-if="modalStatus.activityEnd"
      @onCloseBtnClk="modalStatus.activityEnd=false">
      <AlertModal
        :title="['亲，您来晚了，活动已结束！','下次记得早点来哦~']"
        btnText="我知道了"
        iconType="activityEnd"
        :btnCallback="()=>{modalStatus.activityEnd=false}"
      />
    </ModalContainer>
    <!-- 活动结束弹窗 end -->

  </section>
</template>

<script>
  import './assets/sass/index.scss'
  import './assets/sass/animation.scss'
  import Marquee from './js/lib/marquee.js'
  import initShare from './js/lib/initShare.js'
  import ModalContainer from './components/modalContainer.vue'
  import RuleModal from './components/ruleModal.vue'
  import MyPrizeModal from './components/myPrizeModal.vue'
  import AlertModal from './components/alertModal.vue'
  import {
    apiGetIndexBaseInfo,
    apiGetMyPrize,
  } from './api/indexApi.js'
  import {
    toLogin,
  } from './js/lib/utils.js'
  export default {

    components:{
      ModalContainer,
      RuleModal,
      MyPrizeModal,
      AlertModal,
    },

    data(){
      return{
        isLogined:false,
        activityStatus:null,
        myPrizeList:[
          // {date:'2018-12-11',prizeName:'1888元现金红包',status:0},
        ],
        modalStatus:{
          rule:false,
          userPrize:false,
          login:false,
          activityEnd:false,
        }
      }
    },
    
    methods:{
      initBingoRecords(items){
        new Marquee('.bingo-records',{
          items
        })
      },
      // 活动规则 click 事件
      onRuleBtnClk({target}){
        this.modalStatus.rule=true
        sa.quick('trackHeatMap',target)
      },
      // 我的奖励 click 事件
      onMyPrizeBtnClk(){
        try {
          sa.quick('trackHeatMap',target)
        } catch (error) {}
        if(!this.isLogined){
          this.modalStatus.login=true
          return
        }
        // 获取我的奖励数据
        apiGetMyPrize()
          .then(res=>{
            if(res.code!=='SUCCESS'){
              toast.show(res.message)
              return
            }
            this.myPrizeList=res.data.prize.map(item=>{
              return{
                date:item.drawDate,
                prizeName:item.prizeName,
                prizeType:item.typeId,
                status:item.prizeStatus,
              }
            })
            this.modalStatus.userPrize=true
          })
          .catch(err=>{
            toast.show('服务器繁忙，请重试')
          })
      },
      // 登录弹窗-前往登录 click 事件
      onLoginModalBtnClk(){
        try {
          sa.quick('trackHeatMap',target)
        } catch (error) {}
        toLogin()
      },
      // 开始游戏 click 事件
      onPlayBtnClk({target}){
        try {
          sa.quick('trackHeatMap',target)
        } catch (error) {}
        if(this.activityStatus===-2){
          toast.show('暂无活动')
          return
        }
        if(this.activityStatus===-1){
          toast.show('活动尚未开始')
          return
        }
        if(this.activityStatus===1){
          this.modalStatus.activityEnd=true
          return
        }
        if(this.activityStatus===0){
          window.location.href=router.game
          return
        }
      },
      // 冲分榜 click 事件
      onRankingBtnClk({target}){
        try {
          sa.quick('trackHeatMap',target)
        } catch (error) {}
        window.location.href=router.ranking
      }
    },

    mounted(){
      initShare.set()
      // 获取首页基本信息
      apiGetIndexBaseInfo()
        .then(res=>{
          if(res.code!=='SUCCESS'){
            toast.show(res.message)
            return
          }
          const resData=res.data
          if(resData.carousel){
            const bingoRecords=resData.carousel.map(item=>{
              return{
                val:`恭喜 ${item.telNo} 获得 ${item.prizeName}`
              }
            })
            this.initBingoRecords(bingoRecords)
          }
          this.isLogined=resData.status.loginStatus
          this.activityStatus=resData.status.activityStatus
        })
        .catch(err=>{
          toast.show('服务器繁忙，请刷新页面')
        })

    }

  }
</script>
