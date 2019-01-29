<template>
  <div class="wrap">
    <span class="ad-tips">【广告】市场有风险，出借需谨慎</span>
    <i class="icon-text"></i>
    <span class="time">12月10日—12月22日</span>
    <span class="btn-rule" @click="onRuleBtnClk">活动规则</span>
    <i class="icon-pf"></i>
    <i class="icon-rp"></i>
    <i class="icon-jb"></i>
    <span class="ren"></span>
    <div class="b-con">
      <span class="btn-carve breath" @click="goCarveBtnClk">组团瓜分9000元</span>
    </div>

    <!-- 底部导航 -->
    <Footerbar :idx="1"/>
    <!-- 底部导航 end -->
    <!-- 规则弹窗 -->
    <RuleModal v-if="alertStatus.rule" 
        :initIdx="1" 
        @closeCallback="alertStatus.rule=false"
    />
    <!-- 规则弹窗 end -->
    <!-- 加息遮罩层 -->
    <JxtqAlert
      v-if="alertStatus.newClientJiaXi"
      number="1.0"
      @onCloseBtnClk="alertStatus.newClientJiaXi=false"
    />
    <!-- 加息遮罩层  end-->
    <!-- 登录弹窗 -->
    <LotteryAlert
            v-if="modalStatus.login"
            :title="['请先登录']"
            msg="亲，请先登录后再参与活动哦~"
            btnText="登录"
            @btnCallback="onLoginModalBtnClk"
            @closeCallback="modalStatus.login=false"
    />
    <!-- 登录弹窗 end -->
    <!-- 未开始弹窗 -->
    <LotteryAlert
            v-if="modalStatus.activityUnstart"
            :title="['组团集爱心瓜分现金','活动未开始！']"
            msg="1218组团集爱心瓜分现金活动时间为2018年12月10日~12月22日。活动尚未开始，敬请期待！"
            @closeCallback="modalStatus.activityUnstart=false"
    />
    <!-- 未开始弹窗 end -->
    <!-- 已结束弹窗 -->
    <LotteryAlert
            v-if="modalStatus.activityEnd"
            :title="['组团集爱心瓜分现金','活动已结束！']"
            msg="1218组团集爱心瓜分现金活动时间为2018年12月10日~12月22日。活动已结束，非常感谢您的关注！"
            @closeCallback="modalStatus.activityEnd=false"
    />
    <!-- 已结束弹窗 end -->
  </div>
</template>
<script>
import './assets/sass/carveRedpacket.scss'
import {toLogin} from './js/lib/utils.js'
import Footerbar from './components/footerbar.vue'
import RuleModal from './components/ruleModal.vue'
import JxtqAlert from './components/jxtqAlert.vue'
import LotteryAlert from './components/lotteryAlert.vue'
import {initStatus,carveRpAPI} from './api/rank.js'
import {checkNewClientJiaXi,} from './api/commonAPI.js'
export default {
  name: 'App',
  components:{
    Footerbar,
    RuleModal,
    JxtqAlert,
    LotteryAlert,
  },
  data(){
    return{
        alertStatus:{
            rule:false,
            newClientJiaXi:false,
        },
        modalStatus:{
            activityUnstart:false,
            activityEnd:false,
            login:false,
        },
    }
  },

  methods:{
    onRuleBtnClk(){
      this.alertStatus.rule=true
    },
    goCarveBtnClk(){
          carveRpAPI().then(res=>{
              if (res){
                  window.location.href='//at.tuandai.com/huodong/collectLove/index.html'
              }
          }).catch(err=>{

              if(err.response.status >=500 && err.response.status <= 599){
                  toast.show('服务器繁忙，请重试')
                  return
              }
              // 为开始
              if(err.response.data.status===601){
                  this.modalStatus.activityUnstart=true
                  return
              }
              // 活动已结束
              if(err.response.data.status===602){
                  this.modalStatus.activityEnd=true
                  return
              }
              // 未登录
              if(err.response.data.status === 611){
                  this.modalStatus.login=true
                  return
              }
          })
      },
      // 登录弹窗按钮 click 事件
      onLoginModalBtnClk(){
          toLogin()
      },
  },

  created(){
    // 判断登录状态
    initStatus()
      .then(res=>{
        if(res.loginFlag){
          // 判断是否领取1.2%加息特权
          return checkNewClientJiaXi()
        }
        return 'break'
      })
      .then(res2=>{
        if(res2==='break') return
        if(res2.code==='SUCCESS'){
          this.alertStatus.newClientJiaXi=true
        }
      })
      .catch(err=>{
        const errData=err.response.data
        if(errData.code==null){
          toast.show(err.message)
          return
        }
        toast.show(errData.message)
      })
      .catch(err2=>{
        toast.show('未知错误，请刷新重试')
        console.log(err2)
      })
  }
}
</script>
