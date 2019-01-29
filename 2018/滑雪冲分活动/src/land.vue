<style lang="scss">
  .page-index{
    width: 16rem;
    min-height: 100vh;
    @include bg('./assets/images/index/bg.jpg');
    background-size: cover;
    position: relative;
    padding-top: 3rem;
    overflow: hidden;
    .logo{
      @include wh(132,48);
      @include bg('./assets/images/index/01.png');
      position: absolute;
      top: .5rem;
      left: .5rem;
      }
    .warning-tips{
      color: #4b92ff;
      font-size: rem(16);
      position: absolute;
      right: 0.5rem;
      top: .75rem;
      }
    .rule-btn{
      text-align: center;
      font-size: rem(28);
      color: #d63434;
      display: inline-block;
      margin:rem(20) auto 0;
      text-decoration: underline;
      }
    .land-txt{
      font-size: rem(42);
      padding-bottom: rem(26);
      color: #03348d;
      text-align: center;
      }
    .land-title{
      @include wh(655,65);
      @include bg('./assets/images/land-title.png');
      margin: 0 auto;
      }
    .banner-date{
      @include wh(570,50);
      @include bg('./assets/images/index/02.png');
      margin: 0 auto;
      margin-top: 0.25rem;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: rem(25);
      color: #012a88;
      }
    .btn-group{
      position: absolute;
      bottom: 3.5rem;
      left: 1rem;
      right: 1rem;
      color: #ffffff;
      text-align: center;
      /*z-index: 5;*/
      }
    .game-btn{
      font-size: rem(40);
      background: linear-gradient(to bottom,#d63434,#8e0606);
      padding: 0.5rem 0;
      border-radius: .25rem;
      }

    .bingo-container{
      font-size: 12px;
      color: #62728e;
      position: absolute;
      bottom: 1.5rem;
      left: 1rem;
      right: 1rem;
      width: 14rem;
      overflow: hidden;
      background: rgba(255,255,255,.55);
      border-radius: 1rem;
      padding: 0.15rem 0;
      }
    .ios-copyright{
      font-size: rem(16);
      color: #8daee6;
      text-align: center;
      position: absolute;
      left: 0;
      right: 0;
      bottom: 0.5rem;
      }
    }
  .snowflake{
    @include bg('./assets/images/index/04.png');
    position: absolute;
    z-index: 1;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    pointer-events: none;
    animation: snowflake 20s linear infinite;
    }
  @keyframes snowflake{
    0%{
      opacity: .2;
      transform: translateY(-100%);
      }
    100%{
      opacity: 1;
      transform: translateY(100%);
      }
    }

</style>
<template>
  <section class="page-index land-index">
    <div class="snowflake"></div>
    <div class="logo"></div>
    <p class="warning-tips">【广告】市场有风险，出借需谨慎</p>
    <p class="land-txt">好友{{telNo}}邀你</p>
    <div class="land-title"></div>
    <p class="banner-date">活动时间：2018.11.26-12.10</p>
    <section class="btn-group">
      <p class="game-btn" name="分享落地页_开始游戏" @click="onPlayBtnClk">进入游戏</p>
      <div class="rule-btn" name="分享落地页_积分规则戏" @click="onRuleBtnClk">积分规则&gt;</div>
    </section>

    <section class="bingo-container">
      <div class="bingo-records"></div>
    </section>
    <p class="ios-copyright">本活动及奖品与苹果公司无关</p>

    <!-- 规则弹窗 -->
    <ModalContainer 
      topic="积分规则"
      v-if="modalStatus.rule"
      @onCloseBtnClk="modalStatus.rule=false">
      <LandRuleModal/>
    </ModalContainer>
    <!-- 规则弹窗 end -->

    <!-- 登录弹窗 -->
    <ModalContainer 
      v-if="modalStatus.login"
      @onCloseBtnClk="modalStatus.login=false">
      <AlertModal
        :title="['亲，请先登录后再参与活动哦~']"
        btnText="前往登录"
        :btnCallback="onLoginModalBtnClk"
      />
    </ModalContainer>
    <!-- 登录弹窗 end -->

    <!-- 已助力弹窗 -->
    <MaskContainer
            :topic="assitModal.topic"
            v-if="modalStatus.assit">
      <AssitModal
              :topic="assitModal.topic"
              :msgs="assitModal.msgs"
              :btnText="assitModal.btnText"
              :btnCallback="toGameBtnClk"
      />
    </MaskContainer>
    <!-- 已助力弹窗 end -->
  </section>
</template>
<script>
  import qs from 'querystringify'
  import Marquee from './js/lib/marquee.js'
  import ModalContainer from './components/modalContainer.vue'
  import MaskContainer from './components/maskContainer.vue'
  import LandRuleModal from './components/landRuleModal.vue'
  import AlertModal from './components/alertModal.vue'
  import AssitModal from './components/assitModal.vue'
  import {apiGetIndexBaseInfo} from './api/indexApi.js'
  import {landAPI} from './api/landApi.js'
  import {toLogin,} from './js/lib/utils.js'
  export default {
    components:{
      ModalContainer,
      MaskContainer,
      LandRuleModal,
      AlertModal,
      AssitModal,
    },
    data(){
      return{
        extenderKey:'',
        isLogined:false,
        activityStatus:null,
        selfLink:null,
        assitStatus:null,
        telNo:'',
        modalStatus:{
          rule:false,
          login:false,
          assit:false,
        },
        assitModal:{
              topic:'你已为好友助力过啦！',
              msgs:['每人限为一位好友助力哦~'],
              btnText:'前往滑雪大作战',
              btnCallback:null
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
        sa.quick('trackHeatMap',target)
        this.modalStatus.rule=true
      },
      // 登录弹窗-前往登录 click 事件
      onLoginModalBtnClk(){
        toLogin()
      },
      // 开始游戏 click 事件
      onPlayBtnClk({target}){
        try {
             a.quick('trackHeatMap',target)
        } catch (error) {}

        if(this.activityStatus===-2){
          toast.show('暂无活动')
        }
        if(this.activityStatus===-1){
          toast.show('活动尚未开始')
        }
        if(this.activityStatus==="1"){
          this.modalStatus.activityEnd=true
          return
        }
        window.location.href=`${router.game}?extenderKey=${this.extenderKey}&viewStatus=1`
        // if(this.assitStatus==="0" || this.isLogined === "0"){
        //     window.location.href=`${router.game}?extenderKey=${this.extenderKey}&viewStatus=1`
        //   return
        // }
      },
      // 前往滑雪大作战
      toGameBtnClk({target}){
         sa.quick('trackHeatMap',target)
         this.modalStatus.assit=false
         window.location.href=router.index
      }
    },

    mounted(){
        // 落地页初始化接口
        landAPI(this.extenderKey)
            .then(res=>{
                console.log(res)
                if(res.code === "SUCCESS"){
                    this.telNo = res.data.telNo
                    this.isLogined = res.data.loginStatus
                    this.activityStatus = res.data.activityStatus
                    this.assitStatus = res.data.assitStatus
                    this.selfLink = res.data.selfLink
                }
                if(this.selfLink === "1"){
                    window.location.href=router.index
                }
                if(this.assitStatus==="1" && this.isLogined==="1"){
                    this.modalStatus.assit=true
                }
            })
            .catch(err=>{
                // console.log(err)
                toast.show('服务器繁忙，请刷新重试')
            })

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

    },
      created(){
          let qsUrl=qs.parse(window.location.search)
          this.extenderKey=qsUrl.extenderKey
      }

  }
</script>
