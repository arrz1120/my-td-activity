<template>
  <section class="page-game" @touchmove.prevent>
    <section class="countdown-container">
      <div class="countdown-icon" :class="{'animate':hasShakeClock}"></div>
      <div class="countdown-progress">
        <span :style="{'transform':`scaleX(${gameCountdown/30})`}" class="countdown-cur"></span>
      </div>
      <p class="countdown-text">{{gameCountdown}}S</p>
    </section>
    <section class="score-container">
      <div class="score-icon"></div>
      <div class="score-progress">
        <p class="score-text">{{score}}分</p>
      </div>
    </section>
    <div class="sidebar-container">
      <!-- <div class="item music" name="游戏页_音乐开关" :class="{'animate':hasMusicIconAnimated}" @click="onMusicIconClk"></div> -->
      <div class="item share" name="游戏页_分享icon" v-if="viewStatus!=='1'" @click="onShareBtnClk"></div>
      <div class="item ranking" name="游戏页_冲分榜icon" v-if="viewStatus!=='1'" @click="onRankingBtnClk"></div>
    </div>
    <p v-if="hasPlayBtn" name="游戏页_开始" @click="onPlayBtnClk(true,$event)" class="play-btn">开始</p>
    <p v-if="hasRdyTimer" class="rdy-container">{{rdyCountdown}}S</p>

    <!-- 滑雪组件 -->
    <Skiing
      ref="compSkiing"
      @postScore="getScore"
    />
    <!-- 滑雪组件 end -->

    <!-- 游戏攻略弹窗 -->
    <ModalContainer 
      topic="游戏攻略" 
      v-if="modalStatus.guide" 
      @onCloseBtnClk="onGuideModalCloseClk">
      <GuideModal/>
    </ModalContainer>
    <!-- 游戏攻略弹窗 end -->

    <!-- 游戏得分弹窗 -->
    <ModalContainer 
      :topic="scoreModal.topic"
      v-if="modalStatus.score" 
      @onCloseBtnClk="onScoreModalCloseClk">
      <ScoreModal
        :topic="scoreModal.topic"
        :msgs="scoreModal.msgs"
        :prizeVal="scoreModal.prizeVal"
        :btnText="scoreModal.btnText"
        trackName="游戏结束弹窗_分享活动"
        :btnCallback="onScoreModalBtnClk"
      />
    </ModalContainer>
    <!-- 游戏得分弹窗 end -->

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

    <!-- 玩过1/2次弹窗 -->
    <ModalContainer 
      v-if="modalStatus.gameStatus"
      @onCloseBtnClk="modalStatus.gameStatus=false">
      <AlertModal
        :title="gameStatusModal.title"
        :msg="gameStatusModal.msg"
        :btnText="gameStatusModal.btnText"
        :trackName="gameStatusModal.trackName"
        :btnCallback="onGameStatusModalBtnClk"
      />
    </ModalContainer>
    <!-- 玩过1/2次弹窗 end -->

  </section>
</template>

<script>
import Timr from 'timrjs'
import cookies from 'browser-cookies'
import qs from 'querystringify'
import './assets/sass/game.scss'
import initShare from './js/lib/initShare.js'
// import LoadAudio from './js/lib/loadAudio.js'
import Skiing from './components/skiing.vue'
import ModalContainer from './components/modalContainer.vue'
import GuideModal from './components/guideModal.vue'
import ScoreModal from './components/scoreModal.vue'
import AlertModal from './components/alertModal.vue'
import {
  apiGetGameBaseInfo,
  apiPostGameScore,
  apiShareGame,
} from './api/gameApi.js'
import {
  toLogin
} from './js/lib/utils.js'
export default {

  components:{
    Skiing,
    ModalContainer,
    GuideModal,
    ScoreModal,
    AlertModal,
  },

  data(){
    return{
      viewStatus:null,
      gameTimer:null,
      rdyTimer:null,
      score:0,
      gameCountdown:30,
      rdyCountdown:3,
      hasPlayBtn:false,
      hasRdyTimer:false,
      // hasMusicIconAnimated:false,
      isLogined:false,
      activityStatus:null,
      gameStatus:null,
      extenderKey:'',
      bgmAudio:null,
      bgmSrc:`${router.baseUrl}/images/bgm.mp3`,
      modalStatus:{
        guide:false,
        score:false,
        login:false,
        gameStatus:false,
      },
      gameStatusModal:{
        title:['亲，您今天已经玩过一局啦，','分享活动还能再玩一局哦~'],
        msg:'',
        btnText:'立即分享',
        trackName:'已玩过一次弹窗_立即分享'
      },
      scoreModal:{
        topic:'',
        msgs:[''],
        prizeVal:'',
        btnText:'分享活动 再玩一局',
        btnCallback:null
      },
      isShareLand:false,
    }
  },

  computed:{
    hasShakeClock(){
      if(this.gameCountdown===0){
        return false
      }
      if(this.gameCountdown<=10){
        return true
      }
      return false
    }
  },

  methods:{
    // 获取 Skiing 组件 score
    getScore(val){
      this.score+=val
    },
    initRdyTimer(){
      this.hasRdyTimer=true
      let timer=Timr(this.rdyCountdown)
      timer.ticker(e=>{
        this.rdyCountdown=e.currentTime
      })
      timer.finish(()=>{
        this.hasRdyTimer=false
        this.initGamerTimer()
        this.$refs.compSkiing.startGame()
      })
      timer.start()
      this.rdyTimer=timer
    },
    initGamerTimer(){
      let timer=Timr(this.gameCountdown)
      timer.ticker(e=>{
        this.gameCountdown=e.currentTime
      })
      timer.finish(()=>{
        if(this.viewStatus==='1'){
          const score=this.score<=0?0:this.score
          // this.hasMusicIconAnimated=false
          // if(Jsbridge.isApp()){
          //   LoadAudio.appPause()
          // }
          window.location.href=`${router.landRegister}?point=${score}&extenderKey=${this.extenderKey}`
          return
        }
        this.$refs.compSkiing.stopGame(()=>{
          const {scoreModal,score,modalStatus,computedScore}=this
          // this.hasMusicIconAnimated=false
          // if(Jsbridge.isApp()){
          //   LoadAudio.appPause()
          // }
          // 提交游戏分数
          apiPostGameScore({
            point:score<=0?0:score
          }).then(res=>{
            if(res.code===601){
              toast.show('提交分数格式错误，请刷新重玩')
              return
            }
            if(res.code===602){
              toast.show('已经没有游玩次数')
              return
            }
            if(res.code===200){
              scoreModal.prizeVal=res.prizeName.replace(/团币/,'')
              this.gameStatus=res.gameStatus
              computedScore(score)
              modalStatus.score=true
              return
            }
            toast.show('提交游戏分数失败，请刷新重玩')
          }).catch(err=>{
            toast.show('提交游戏分数失败，请刷新重玩')
          })
          
        })
      })
      timer.start()
      this.gameTimer=timer
    },
    checkHasGuideModal(){
      if(cookies.get('hasGuide')) return
      cookies.set('hasGuide','true')
      this.modalStatus.guide=true
    },
    setShare(){
      const vm=this
      if(this.isShareLand){
        initShare.set({
          shareUrl:`${router.land}?extenderKey=${this.extenderKey}`,
          callback(state){
            if(vm.viewStatus==='1') return
            if(state!=='onComplete') return
             apiShareGame()
              .then(res=>{
                if(res.code!=='SUCCESS'){
                  toast.show(res.message)
                  return
                }
                window.location.href=window.location.href
              })
              .catch(err=>{
                toast.show('分享游戏失败，请重试')
              })
          }
        })
        return
      }
      initShare.set({
        shareUrl:`${router.index}`,
        callback(){
          
        }
      })
    },
    computedScore(val){
      const {scoreModal,gameStatus}=this

      switch (gameStatus) {
        case 2:
          scoreModal.btnText='好友助力 赢666现金'
          break;
        case 3:
          scoreModal.btnText='再玩一局'
          break;
        default:
          scoreModal.btnText='分享活动 再玩一局'
          break;
      }
      if(val<=0){
        scoreModal.topic='失败是成功之母！'
        scoreModal.msgs=['很遗憾，本次未获得积分','依然可以抽团币获得']
        return
      }
      scoreModal.msgs=['恭喜本次获得',`${val}积分`]
      if(val<=499){
        scoreModal.topic='咳咳，一定是手滑了！'
        return
      }
      if(val<=999){
        scoreModal.topic='哎哟~表现不错哦'
        return
      }
      scoreModal.topic='大神！请收下我的膝盖'
    },
    // 开始按钮 click 事件
    onPlayBtnClk(needChecked=true,e){
      try {
        e.target&&sa.quick('trackHeatMap',e.target)
      } catch (error) {}
      if(needChecked){
        // 活动状态判断
        const {isLogined,gameStatus,activityStatus,modalStatus}=this
        if(activityStatus===-1){
          toast.show('活动尚未开始')
          return
        }
        if(activityStatus===1){
          toast.show('活动已结束')
          return
        }
        // 登录状态判断
        if(!isLogined){
          modalStatus.login=true
          return
        }
        // 游戏状态判断
        if(this.gameStatus===1){
          this.gameStatusModal.title=['亲，您今天已经玩过一局啦，','分享活动还能再玩一局哦~']
          this.gameStatusModal.msg=''
          this.gameStatusModal.btnText='立即分享'
          this.gameStatusModal.trackName='已玩过一次弹窗_立即分享'
          this.modalStatus.gameStatus=true
          return
        }
        if(this.gameStatus===2){
          this.gameStatusModal.title=['您今天的机会已经用完','明天再来哦~']
          this.gameStatusModal.msg=['积分达30000，还能赢666现金！']
          this.gameStatusModal.btnText='好友助力 赢666现金'
          this.gameStatusModal.trackName='已玩过两次弹窗_好友助力'
          this.modalStatus.gameStatus=true
          return
        }
      }
      
      this.hasPlayBtn=false
      this.initRdyTimer()
    },
    // 游戏攻略弹窗关闭 click 事件
    onGuideModalCloseClk(){
      this.modalStatus.guide=false
      if(this.viewStatus==='1'){
        this.onPlayBtnClk(false)
      }
    },
    // 得分弹窗按钮 click 事件
    onScoreModalBtnClk({target}){
      try {
        sa.quick('trackHeatMap',target)
      } catch (error) {}
      if(this.gameStatus===3){
        window.location.href=window.location.href
        return
      }
      this.modalStatus.score=false
      this.isShareLand=true
      this.setShare()
      initShare.show()
      this.isShareLand=false
    },
    // 登录弹窗按钮 click 事件
    onLoginModalBtnClk(){
      toLogin()
    },
    // 分享 icon click 事件
    onShareBtnClk({target}){
      try {
        sa.quick('trackHeatMap',target)
      } catch (error) {}
      if(!this.isLogined){
        this.modalStatus.login=true
        return
      }
      this.isShareLand=true
      this.setShare()
      initShare.show()
      this.isShareLand=false
    },
    // 冲分榜 click 事件
    onRankingBtnClk({target}){
      try {
        sa.quick('trackHeatMap',target)
      } catch (error) {}
      window.location.href=router.ranking
    },
    // 玩过弹窗 click 事件
    onGameStatusModalBtnClk({target}){
      try {
        sa.quick('trackHeatMap',target)
      } catch (error) {}
      this.modalStatus.gameStatus=false
      this.isShareLand=true
      this.setShare()
      initShare.show()
      this.isShareLand=false
    },
    // 音乐 icon click 事件
    onMusicIconClk({target}){
      try {
        sa.quick('trackHeatMap',target)
      } catch (error) {}
      if(this.hasMusicIconAnimated){
        this.hasMusicIconAnimated=false
        if(Jsbridge.isApp()){
          LoadAudio.appPause()
        }else{
          this.bgmAudio.pause()
        }
        return
      }
      this.hasMusicIconAnimated=true
      if(Jsbridge.isApp()){
        LoadAudio.appPlay(this.bgmSrc)
      }else{
        this.bgmAudio.play()
      }
    },
    // 得分弹窗关闭 click 事件
    onScoreModalCloseClk(){
      window.location.href=window.location.href
    }
  },

  created(){
    this.checkHasGuideModal()
    const urlQuery=qs.parse(window.location.search)
    this.viewStatus=urlQuery.viewStatus
    if(this.viewStatus==='1'){
      this.extenderKey=urlQuery.extenderKey||''
      if(this.modalStatus.guide) return
      this.$nextTick(()=>{
        this.onPlayBtnClk(false)
      })
      return
    }
    this.hasPlayBtn=true
    // 获取游戏页初始信息
    apiGetGameBaseInfo()
      .then(res=>{
        if(res.code!=='SUCCESS'){
          toast.show(res.message)
          return
        }
        const resData=res.data
        const vm=this
        this.isLogined=resData.status.loginStatus
        this.activityStatus=resData.status.activityStatus
        this.gameStatus=resData.gameStatus
        this.extenderKey=resData.status.extenderKey||''
        this.setShare()
      })
      .catch(err=>{
        toast.show('服务器繁忙，请刷新重试')
      })
  },

  mounted(){
     // bgm
    //  this.hasMusicIconAnimated=true
    // if(Jsbridge.isApp()){
    //   Jsbridge.appLifeHook(null,()=>{
    //     LoadAudio.appPlay(this.bgmSrc)
    //   },()=>{
    //     LoadAudio.appPause()
    //   })
    // }else{
    //   this.$nextTick(()=>{
    //     this.bgmAudio=new LoadAudio(this.bgmSrc,{
    //       autoplay:true
    //     })
    //   })
    // }
  }

}
</script>
