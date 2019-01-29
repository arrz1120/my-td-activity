<style lang="scss">

</style>

<template>
  <section class="app">
    
    <home @showRule="showRule" @onStartClick="toJumpStart" />
    <transition name="fade">
      <div class="mask" v-if="mask.isShow">
        <div class="mask-bg"></div>
        <div class="mask-con">
          <rule v-if="mask.rule" />
          <login v-if="mask.login" />
          <finish v-if="mask.finish" 
                  :gameState="gameState" 
                  @hideMask="onMaskCloseClick"/>
          <maskShare v-if="mask.maskShare" 
                   @hideMask="hideMask"
                  :gameState="gameState" 
                  :isAtHome="isAtHome"
                  :name="shareBtnName"
                  :mtaName="shareBtnMtaName" />
          <maskGetPrize v-if="mask.maskGetPrize" 
                  :gameState="gameState" 
                  @getPrize="getPrize"/>
          <prize v-if="mask.prize" :prizeType="prizeType" :prizeName="prizeName" />
          <div class="mask-close" @click="onMaskCloseClick"></div>
        </div>
      </div>
    </transition>
    <transition name="move-to-top" @after-enter="afterJumpEnter">
      <jump :jumpEnter="jumpEnter" 
            :gameState="gameState" 
            v-if="jumpStart" 
            @showMaskFinish="showMaskFinish" 
            :isFirstPlay="isFirstPlay"
            @hideFirstPlay="hideFirstPlay" />
    </transition>  
  </section>
</template>

<script>
import './assets/sass/mask.scss'
import Home from './components/home'
import Jump from './components/jump'
import Rule from './components/mask/rule'
import Login from './components/mask/login'
import Finish from './components/mask/finish'
import maskShare from './components/mask/share'
import maskGetPrize from './components/mask/getPrize'
import Prize from './components/mask/prize'
import {getInitStatus,start,share,drawPrize} from './api/api'
import Share from './js/lib/initShare'
import {setRefreshStorage} from './js/lib/util'

export default {
  name: 'App',
  data(){
    return {
      isLogin: false,
      isActivityStart:false,
      isActivityEnd: false,
      gameState: {},
      jumpStart: false,
      jumpEnter: false,
      shareBtnName: null,
      shareBtnMtaName: null,
      prizeType: null,
      prizeName: null,
      isAtHome:true,
      isFirstPlay: true,
      mask: {
        isShow: false,
        login: false,
        rule: false,
        finish: false,
        prize: false,
        maskShare: false,
        maskGetPrize: false
      }
    }
  },
  created(){
    setRefreshStorage()
    this._getInitStatus()
    Share.set(this)
  },
  watch: {
    jumpEnter(newVal){
      if(newVal){
        this.isAtHome = false
      }else{
        this.isAtHome = true
      }
    }
  },
  methods: {
    _getInitStatus(){
      getInitStatus().then(res => {
        this.updateStatus(res)
        if(res.gameStateDto.gameIndex === 0){
          this.isFirstPlay = true
        }else{
          this.isFirstPlay = false
        }
        if(res.activityEndFlag){
          toast.show('活动已结束')
          return
        }
      })
    },
    updateStatus(res){
      this.isLogin = res.loginFlag
      this.isActivityStart = res.activityStartFlag
      this.isActivityEnd = res.activityEndFlag
      if(res.activityStatus === 2 && res.loginFlag){
          this.gameState = res.gameStateDto 
      }
      this.gameState.journeyStartable = res.journeyStartable
      this.gameState.sharable = res.sharable
    },
    showMask(name){
      this.hideMask()
      this.mask.isShow = true
      this.mask[name] = true
    },
    hideMask(){
      for(var key in this.mask){
        if(this.mask[key]){
          this.mask[key] = false
        }
      }
    },
    showRule(e){
      this.showMask('rule')
    },
    toJumpStart(){
      // this.jumpStart = true
      let {isLogin,isActivityStart,isActivityEnd,gameState} = this
      if(!isActivityStart){
        toast.show('活动未开始，敬请期待')
        return
      }
      if(isActivityEnd){
        toast.show('活动已结束')
        return
      }
      if(!isLogin){
        this.showMask('login')
        return
      }
      if(gameState == {}){
        return 
      }
      
      //未开始
      if(gameState.gameState === 0){
        this.gameStart()
        return
      }
      if(gameState.gameState === 1){
        this.jumpStart = true
        return
      }

      if(gameState.journeyStartable){
        this.gameStart()
      }else{
        if(gameState.canDrawPrize){
          if(gameState.drawPrizeFlag){
            this.showMask('finish')
          }else{
            this.showMask('maskGetPrize')
          }
        }else{
          if(gameState.sharable){
            this.shareBtnName = "载入_分享再玩一次"
            this.shareBtnMtaName = "sharetoplay_a4"
            this.isAtHome = true
            this.showMask('maskShare')
          }else{
            this.showMask('finish')
          }
        }
      }
    },
    gameStart(){
      start().then(res => {
          this.updateStatus(res)
          this.$nextTick(()=>{
            this.jumpStart = true
          })
        })
    },
    showMaskFinish(param){
      this.gameState.correctAnswerCount = param.correctCount
      if(param.hasPrize){
        this.showMask('maskGetPrize')
      }else{
        if(param.sharable){
          this.shareBtnName = "通关_分享再玩一次"
          this.shareBtnMtaName = "sharetoplay_a5"
          this.isAtHome = false
          this.showMask('maskShare')
        }else{
          this.showMask('finish')
        }
      }
    },
    shareCallback(){
      this.hideMask()
      share().then(res => {
        location.href = location.href
      })
    },
    getPrize(){
      drawPrize().then(res => {
        this.prizeType = res.type
        this.prizeName = res.prizeName
        this.showMask('prize')
      })
    },
    afterJumpEnter(){
      this.jumpEnter = true
    },
    onMaskCloseClick(){
      if(!this.isAtHome && (this.mask.finish || this.mask.maskShare  || this.mask.maskGetPrize || this.mask.prize)){
        location.href = location.href
      }
      this.hideMask()
    },
    hideFirstPlay(){
      this.isFirstPlay = false
    }
  },
  components: {
    Home,
    Jump,
    Rule,
    Finish,
    Prize,
    Login,
    maskShare,
    maskGetPrize
  }
}
</script>

<style lang="scss">
  .app{
  }
</style>

