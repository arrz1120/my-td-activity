<template>
  <section class="page-lottery">
    <p class="rule-btn" name="活动规则_幸运翻牌23a" @click="onRuleBtnClk">活动规则</p>
    <section class="topic-container">
      <div class="topic-title"></div>
      <p class="topic-date">12月3日—12月22日</p>
      <ul class="topic-tips">
        <li class="item">用户出借指定的We自动服务、We+自动服务（新手专</li>
        <li class="item">享服务除外），即有机会获得翻牌机会。</li>
      </ul>
      <div class="topic-decoration"></div>
    </section>
    <section class="lottery-container">

      <ul class="lottery-tab">
        <li 
          class="item" 
          :class="{'on':tabIdx===i}"
          v-for="(item,i) in tabItems" 
          :key="i"
          @click="onTabItemClk(i)">
          {{item.text}}
        </li>
      </ul>
      <div class="lottery-tab-placeholder" v-if="isInitDataLoading"></div>
      <!-- 普惠卡牌 -->
      <div class="lottery-tab-container" v-show="tabIdx===0&&!isInitDataLoading">
        <p class="lottery-rule">累计出借金额≥2万元可翻 普惠卡牌</p>
        <LotteryCard 
          v-if="!userLotteryPrize.junior"
          cardType="junior"
          :prizeList="juniorPrize"
          :bingoPrize="juniorBingoPrize"
          @onCardClk="onLotteryCardClk"
          ref="juniorLottery"
        />
        <div class="lotteryCard-container" v-else>
          <div class="lotteryCard-bingo-container n1 show">
            <img :src="userLotteryPrize.junior.src" class="lotteryCard-bingo-img">
            <p class="lotteryCard-bingo-name text-nowrap">{{userLotteryPrize.junior.text}}</p>
          </div>
        </div>
        <!-- 未开始 end -->
        <div class="lottery-status-container" v-if="activityStatus==='undo'">
          <div class="lottery-invest-contaner" name="前往登录_普惠卡牌24a" v-if="!isLogined" @click="onLotteryLoginBtnClk">
            <p class="lottery-invest-text">请先登录</p>
          </div>
          <p class="lottery-myinvest" v-else>我累计出借：{{userInvestNum}}元</p>
          <p class="lottery-btn n2" name="授权出借26a" @click="onInvestBtnClk">立即出借</p>
          <p class="lottery-status">翻牌未开始，敬请期待！</p>
          <p class="lottery-date">翻牌时间：2018年12月18日-12月22日</p>
        </div>
        <!-- 未开始 -->
        <!-- 已开始 -->
        <div class="lottery-status-container" v-if="activityStatus==='doing'">
          <p class="lottery-myinvest" v-if="isLogined">我累计出借：{{userInvestNum}}元</p>
          <p class="lottery-btn n1" name="查看奖品_普惠卡牌34a" v-if="isJuniorLotteryDrew" @click="onCheckPrizeBtnClk">查看奖品</p>
          <p class="lottery-btn n1" name="开始翻牌_普惠卡牌28a" v-else @click="onLotteryStartClk">开始翻牌</p>
          <div class="lottery-invest-contaner" name="授权出借_普惠卡牌30a" v-if="!isJuniorLotteryDrew" @click="onInvestBtnClk">
            <p class="lottery-invest-text">立即出借</p>
          </div>
        </div>
        <!-- 已开始 end -->
        <!-- 已结束 -->
        <div class="lottery-status-container" v-if="activityStatus==='done'">
          <div class="lottery-invest-contaner" v-if="!isLogined" @click="onLotteryLoginBtnClk">
            <p class="lottery-invest-text">请先登录</p>
          </div>
          <p class="lottery-btn n1" name="查看奖品_普惠卡牌34a" v-if="isLogined&&isJuniorLotteryDrew" @click="onCheckPrizeBtnClk">查看奖品</p>
          <p class="lottery-myinvest" v-if="isLogined&&!isJuniorLotteryDrew">我累计出借：{{userInvestNum}}元</p>
          <p class="lottery-status">活动已结束，谢谢关注！</p>
          <p class="lottery-date">翻牌时间：2018年12月18日-12月22日</p>
        </div>
        <!-- 已结束 end -->
      </div>
      <!-- 普惠卡牌 end -->
      <!-- 尊享卡牌 -->
      <div class="lottery-tab-container" v-show="tabIdx===1&&!isInitDataLoading">
        <p class="lottery-rule">累计出借金额≥10万元可翻 尊享卡牌</p>
        <LotteryCard 
          v-if="!userLotteryPrize.senior"
          cardType="senior"
          :prizeList="seniorPrize"
          :bingoPrize="seniorBingoPrize"
          @onCardClk="onLotteryCardClk"
          ref="seniorLottery"
        />
        <div class="lotteryCard-container" v-else>
          <div class="lotteryCard-bingo-container n2 show">
            <img :src="userLotteryPrize.senior.src" class="lotteryCard-bingo-img">
            <p class="lotteryCard-bingo-name text-nowrap">{{userLotteryPrize.senior.text}}</p>
          </div>
        </div>
        <!-- 未开始 end -->
        <div class="lottery-status-container" v-if="activityStatus==='undo'">
          <div class="lottery-invest-contaner" name="前往登录_尊享卡牌25a" v-if="!isLogined" @click="onLotteryLoginBtnClk">
            <p class="lottery-invest-text">请先登录</p>
          </div>
          <p class="lottery-myinvest" v-else>我累计出借：{{userInvestNum}}元</p>
          <p class="lottery-btn n2" name="授权出借27a" @click="onInvestBtnClk">立即出借</p>
          <p class="lottery-status">翻牌未开始，敬请期待！</p>
          <p class="lottery-date">翻牌时间：2018年12月18日-12月22日</p>
        </div>
        <!-- 未开始 -->
        <!-- 已开始 -->
        <div class="lottery-status-container" v-if="activityStatus==='doing'">
          <p class="lottery-myinvest" v-if="isLogined">我累计出借：{{userInvestNum}}元</p>
          <p class="lottery-btn n1" name="查看奖品_尊享卡牌35a" v-if="isSeniorLotteryDrew" @click="onCheckPrizeBtnClk">查看奖品</p>
          <p class="lottery-btn n1" name="开始翻牌_尊享卡牌29a" v-else @click="onLotteryStartClk">开始翻牌</p>
          <div class="lottery-invest-contaner" name="授权出借_尊享卡牌31a" v-if="!isSeniorLotteryDrew" @click="onInvestBtnClk">
            <p class="lottery-invest-text">立即出借</p>
          </div>
        </div>
        <!-- 已开始 end -->
        <!-- 已结束 -->
        <div class="lottery-status-container" v-if="activityStatus==='done'">
          <div class="lottery-invest-contaner" v-if="!isLogined" @click="onLotteryLoginBtnClk">
            <p class="lottery-invest-text">请先登录</p>
          </div>
          <p class="lottery-btn n1" name="查看奖品_尊享卡牌35a" v-if="isLogined&&isSeniorLotteryDrew" @click="onCheckPrizeBtnClk">查看奖品</p>
          <p class="lottery-myinvest" v-if="isLogined&&!isSeniorLotteryDrew">我累计出借：{{userInvestNum}}元</p>
          <p class="lottery-status">活动已结束，谢谢关注！</p>
          <p class="lottery-date">翻牌时间：2018年12月18日-12月22日</p>
        </div>
        <!-- 已结束 end -->
      </div>
      <!-- 尊享卡牌 end -->
    </section>
    <LotteryRecords
      v-if="isRecordShow&&activityStatus!=='undo'"
      :tabIdx="tabIdx"
      :juniorList="juniorRecords"
      :seniorList="seniorRecords"
    />
    <Footerbar :idx="2"/>
    <!--登录弹窗-->
    <JxAlertLogin v-if="modalStatus.login" @onCloseBtnClk="modalStatus.login=false"/>
    <!--登录弹窗 end-->
    <!-- 未开始弹窗 -->
    <LotteryAlert
      v-if="modalStatus.activityUnstart"
      :title="['1218幸运翻牌活动未开始！']"
      msg="1218幸运翻牌活动时间为2018年12月18日~12月22日。活动尚未开始，敬请期待！"
      @closeCallback="modalStatus.activityUnstart=false"
    />
    <!-- 未开始弹窗 end -->
    <!-- 已结束弹窗 -->
    <LotteryAlert
      v-if="modalStatus.activityEnd"
      :title="['1218幸运翻牌活动已结束！']"
      msg="1218幸运翻牌活动时间为2018年12月18日~12月22日。活动已结束，非常感谢您的关注！"
      @closeCallback="modalStatus.activityEnd=false"
    />
    <!-- 已结束弹窗 end -->
    <!-- 未达普惠弹窗 -->
    <LotteryAlert
      v-if="modalStatus.junior"
      :title="['您还未达到翻开','普惠卡牌的要求哦~']"
      msg="12月3日-12月22日期间，出借指定的We/We+自动服务（新手专享服务除外）累计出借金额≥2万元，可获得翻普惠卡牌的机会。"
      btnText="立即出借"
      trackName="授权出借_普惠卡牌弹窗33a"
      @btnCallback="onInvestBtnClk($event)"
      @closeCallback="modalStatus.junior=false"
    />
    <!-- 未达普惠弹窗 end -->
    <!-- 未达尊享弹窗 -->
    <LotteryAlert
      v-if="modalStatus.senior"
      :title="['您还未达到翻开','尊享卡牌的要求哦~']"
      msg="12月3日-12月22日期间，出借指定的We/We+自动服务（新手专享服务除外）累计出借金额≥10万元，可获得翻尊享卡牌的机会。"
      btnText="立即出借"
      trackName="授权出借_尊享卡牌弹窗34a"
      @btnCallback="onInvestBtnClk($event)"
      @closeCallback="modalStatus.senior=false"
    />
    <!-- 未达尊享弹窗 end -->
    <!-- 规则弹窗 -->
    <RuleModal 
      v-if="modalStatus.rule"
      :initIdx="2"
      @closeCallback="modalStatus.rule=false"
    />
    <!-- 规则弹窗 end -->
    <!-- 我的奖品弹窗 -->
    <MyPrize
      v-if="modalStatus.myPrize"
      :initIdx="0"
      :jxVal="userJiaXiVal | filterSumJX"
      :jxList="userJiaXiList"
      :prizeList="userPrizeList"
      @closeCallback="modalStatus.myPrize=false"
    />
    <!-- 我的奖品弹窗 end -->
    <!-- 侧边导航 -->
    <Sidebar
      :isLogined="isLogined"
      :jxVal="userJiaXiVal | filterSumJX"
      @prizeCallback="onMyPrizeBtnClk"
    />
    <!-- 侧边导航 end -->
    <!-- 加息遮罩层 -->
    <JxtqAlert
      v-if="modalStatus.newClientJiaXi"
      number="1.0"
      @onCloseBtnClk="modalStatus.newClientJiaXi=false"
    />
    <!-- 加息遮罩层  end-->
  </section>
</template>

<script>
  import './assets/sass/lottery.scss'
  import {rem,toLogin,toP2P,toTBX} from './js/lib/utils.js'
  import LotteryCard from './components/lotteryCard.vue'
  import LotteryAlert from './components/lotteryAlert.vue'
  import Footerbar from './components/footerbar.vue'
  import RuleModal from './components/ruleModal.vue'
  import MyPrize from './components/myPrize.vue'
  import Sidebar from './components/sidebar.vue'
  import JxtqAlert from './components/jxtqAlert.vue'
  import JxAlertLogin from './components/jxAlertLogin.vue'
  import LotteryRecords from './components/lotteryRecords.vue'
  import {
    checkLoginStatusAPI,
    getInitDataAPI,
    lotteryCardAPI,
    getBingoRecordsAPI,
  } from './api/lotteryAPI.js'
  import {
    getUserTotalJiaXi,
    getUserJiaXiList,
    checkNewClientJiaXi,
  } from './api/commonAPI.js'
  export default {

    components:{
      LotteryCard,
      Footerbar,
      LotteryAlert,
      RuleModal,
      MyPrize,
      Sidebar,
      JxtqAlert,
      JxAlertLogin,
      LotteryRecords,
    },

    data(){
      return{
        
        isInitDataLoading:true,
        isLogined:false,
        activityStatus:'undo',
        userInvestNum:0,
        userJiaXiVal:0,
        userJiaXiList:[],
        userPrizeList:[],

        userLotteryPrize:{
          junior:'',
          senior:''
        },

        modalStatus:{
          junior:false,
          senior:false,
          activityUnstart:false,
          activityEnd:false,
          login:false,
          rule:false,
          myPrize:false,
          newClientJiaXi:false,
        },

        tabIdx:0,
        tabItems:[
          {text:'普惠卡牌'},
          {text:'尊享卡牌'},
        ],

        lotteryCardPos:[],
        isLotteryAPILoading:false,

        juniorPrize:[
          {
            src:require('./assets/images/lottery/award/01-01.png'),
            text:'iPhone XR',
            x:rem(235*0),
            y:rem(280*0),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/01-02.png'),
            text:'科沃斯扫地机器人',
            x:rem(235*1),
            y:rem(280*0),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/01-03.png'),
            text:'九阳破壁机',
            x:rem(235*2),
            y:rem(280*0),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/01-04.png'),
            text:'美的挂烫机',
            x:rem(235*0),
            y:rem(280*1),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/07-01-01.png'),
            text:'',
            x:rem(235*1),
            y:rem(280*1),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/01-05.png'),
            text:'飞利浦男士电动剃须刀 ',
            x:rem(235*2),
            y:rem(280*1),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/01-06.png'),
            text:'苏泊尔玻璃电热水壶 ',
            x:rem(235*0),
            y:rem(280*2),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/01-08.png'),
            text:'5~1218元现金红包',
            x:rem(235*1),
            y:rem(280*2),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/01-07.png'),
            text:'10~50元出借红包',
            x:rem(235*2),
            y:rem(280*2),
            delay:0,
            opacity:1,
          },
        ],
        juniorBingoPrize:'',
        isJuniorLotteryDrew:false,
        isJuniorLotteryClked:false,

        seniorPrize:[
          {
            src:require('./assets/images/lottery/award/02-01.png'),
            text:'iPhone XS Max',
            x:rem(235*0),
            y:rem(280*0),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/02-02.png'),
            text:'年会邀请卡',
            x:rem(235*1),
            y:rem(280*0),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/02-03.png'),
            text:'史密斯 空气净化器',
            x:rem(235*2),
            y:rem(280*0),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/02-04.png'),
            text:'飞利浦 意式咖啡机',
            x:rem(235*0),
            y:rem(280*1),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/02-05.png'),
            text:'戴森吹风机  ',
            x:rem(235*1),
            y:rem(280*1),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/02-06.png'),
            text:'Beats 头戴式耳机  ',
            x:rem(235*2),
            y:rem(280*1),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/02-07.png'),
            text:'松下电饭煲 ',
            x:rem(235*0),
            y:rem(280*2),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/02-08.png'),
            text:'美的家用迷你烤箱 ',
            x:rem(235*1),
            y:rem(280*2),
            delay:0,
            opacity:1,
          },
          {
            src:require('./assets/images/lottery/award/02-09.png'),
            text:'10~100元红包',
            x:rem(235*2),
            y:rem(280*2),
            delay:0,
            opacity:1,
          },
        ],
        seniorBingoPrize:'',
        isSeniorLotteryDrew:false,
        isSeniorLotteryClked:false,

        juniorRecords:[],
        seniorRecords:[],
        isRecordShow:false
      }
    },
    computed:{
      canJuniorLottery(){
        if(this.userInvestNum>=20000&&!this.userLotteryPrize.junior){
          return true
        }
        return false
      },
      canSeniorLottery(){
        if(this.userInvestNum>=100000&&!this.userLotteryPrize.senior){
          return true
        }
        return false
      }
    },
    filters: {
      filterSumJX (val) {
        let sum = "" + val
        if (sum.indexOf('.') !== -1) {
          return sum.replace(/(\d+)0$(?!\.)/, '$1')
        } else {
          return sum + '.0'
        }
      }
    },

    methods:{
      getLotteryCardPos(){
        return this.juniorPrize.map(({x,y},i)=>{
          return{
            x,
            y,
          }
        })
      },
      getBingoPrizeUrl(code){
        const codeMap={
          // 普惠
          'pu-01':'01.png',
          'pu-02':'02.png',
          'pu-03':'03.png',
          'pu-04':'04.png',
          'pu-05':'05.png',
          'pu-06':'06.png',
          'pu-07':'08.png',
          'pu-08':'07.png',
          'pu-09':'07.png',
          'pu-10':'07.png',
          'pu-11':'08.png',
          // 尊享
          'zun-01':'09.png',
          'zun-02':'10.png',
          'zun-03':'11.png',
          'zun-04':'12.png',
          'zun-05':'13.png',
          'zun-06':'14.png',
          'zun-07':'15.png',
          'zun-08':'16.png',
          'zun-09':'08.png',
          'zun-10':'07.png',
          'zun-11':'07.png',
          'zun-12':'08.png',
        }
        return `${router.baseUrl}/images/lottery/prize/${codeMap[code]}`
      },
      // 登录弹窗按钮 click 事件
      onLoginModalBtnClk(){
        toLogin()
      },
      // 活动规则 click 事件
      onRuleBtnClk({target}){
        AddMaiDian('rule23a',target)
        this.modalStatus.rule=true
      },
      // 侧边导航-我的奖品 click 事件
      onMyPrizeBtnClk(){
        if(!this.isLogined){
          this.modalStatus.login=true
          return
        }
        getUserJiaXiList()
          .then(res=>{
            const resJiaXiList=res.jiaXiTeQuanList
            const resPrizeList=res.userDrawRecordList
            this.userJiaXiList=resJiaXiList.map((item,i)=>{
              return{
                title:item.jiaXiName,
                date:item.jiaXiDate,
                val:`${item.jiaXiValue}%`,
              }
            })
            this.userPrizeList=resPrizeList.map(item=>{
              return{
                title:item.prizeName,
                date:item.drawDate,
                desc:item.prizeSource,
              }
            })
            this.userJiaXiVal=res.sumJiaXiTeQuan
            this.modalStatus.myPrize=true
          })
          .catch(err=>{
            const errData=err.response.data
            if(errData.code==null){
              toast.show(err.message)
              return
            }
            if(errData.code==='FORBIDDEN'){
              this.modalStatus.login=true
              return
            }
            toast.show(errData.message)
          })
      },
      // 查看奖品 click 事件
      onCheckPrizeBtnClk({target}){
        if(this.tabIdx===0){
          AddMaiDian('prize34a',target)
        }
        if(this.tabIdx===1){
          AddMaiDian('prize35a',target)
        }
        toTBX()
      },
      // 卡牌 tab click 事件
      onTabItemClk(idx){
        this.tabIdx=idx
      },
      // 开始翻牌 click 事件
      onLotteryStartClk({target}){
        if(this.tabIdx===0){
          AddMaiDian('turnover28a',target)
        }
        if(this.tabIdx===1){
          AddMaiDian('turnover29a',target)
        }
        if(!this.isLogined){
          this.modalStatus.login=true
          return
        }
        if(this.activityStatus==='done'){
          this.modalStatus.activityEnd=true
          return
        }
        if(this.tabIdx===0){
          if(!this.canJuniorLottery){
            this.modalStatus.junior=true
            return
          }
          if(this.isJuniorLotteryClked) return
          this.isJuniorLotteryClked=true
          this.$refs['juniorLottery'].onPlay()
          return
        }
        if(this.tabIdx===1){
          if(!this.canSeniorLottery){
            this.modalStatus.senior=true
            return
          }
          if(this.isSeniorLotteryClked) return
          this.isSeniorLotteryClked=true
          this.$refs['seniorLottery'].onPlay()
          return
        }
      },
      // 卡牌 click 事件
      onLotteryCardClk({cardIdx}){
        const typeId=(()=>{
          if(this.tabIdx===0) return 2
          if(this.tabIdx===1) return 10
        })()
        if(typeId===2&&this.isJuniorLotteryDrew) return
        if(typeId===10&&this.isSeniorLotteryDrew) return
        if(this.isLotteryAPILoading) return
        this.isLotteryAPILoading=true
        toast.show('请稍候...',8000)
        lotteryCardAPI({typeId})
          .then(({resultCode,drawResult})=>{
            toast.hide()
            this.isLotteryAPILoading=false
            if(resultCode===-2){
              this.modalStatus.login=true
              throw new Error('break')
            }
            if(resultCode===602){
              this.modalStatus.activityEnd=true
              throw new Error('break')
            }
            if(resultCode===-4){
              this.modalStatus.junior=true
              throw new Error('break')
            }
            if(resultCode===-5){
              this.modalStatus.senior=true
              throw new Error('break')
            }
            if(resultCode===-6||resultCode===-7){
              toast.show('已经抽过奖',2500,()=>{
                window.location.href=window.location.href
              })
              throw new Error('break')
            }
            if(resultCode===500){
              toast.show('网络繁忙，请重试')
              throw new Error('break')
            }
            // 抽奖成功
            if(typeId===2){
              this.isJuniorLotteryDrew=true
              this.juniorBingoPrize={
                src:this.getBingoPrizeUrl(drawResult.prizeUrl),
                text:drawResult.prizeName
              }
              this.$refs['juniorLottery'].showBingoAnimate(cardIdx)
              return getBingoRecordsAPI()
            }
            if(typeId===10){
              this.isSeniorLotteryDrew=true
              this.seniorBingoPrize={
                src:this.getBingoPrizeUrl(drawResult.prizeUrl),
                text:drawResult.prizeName
              }
              this.$refs['seniorLottery'].showBingoAnimate(cardIdx)
              return getBingoRecordsAPI()
            }
          })
          .then(res2=>{
            if(res2.message==='break') return
            this.juniorRecords=res2.twoPoolList.map(item=>{
              return{
                headImg:item.userImg,
                tel:item.userPhone,
                prize:`抽中${item.prizeName}`,
                date:item.drawTime
              }
            })
            this.seniorRecords=res2.tenPoolList.map(item=>{
              return{
                headImg:item.userImg,
                tel:item.userPhone,
                prize:`抽中${item.prizeName}`,
                date:item.drawTime
              }
            })
            this.isRecordShow=false
            this.$nextTick(()=>{
              this.isRecordShow=true
            })
          })
          .catch(err=>{
            if(err.message==='break') return
            this.isLotteryAPILoading=false
            const errRes=err.response
            if(errRes==null||typeof errRes.data==='string'){
              toast.show(err.message)
              return
            }
            toast.show('服务器繁忙，请重试')
          })
      },
      // 授权出借 click 事件
      onInvestBtnClk({target}){
        if(this.activityStatus==='undo'){
          if(this.tabIdx===0){
            AddMaiDian('invest26a',target)
          }
          if(this.tabIdx===1){
            AddMaiDian('invest27a',target)
          }
        }
        if(this.activityStatus==='doing'){
          if(this.tabIdx===0){
            this.modalStatus.junior?
            AddMaiDian('invest32a',target):
            AddMaiDian('invest30a',target)
          }
          if(this.tabIdx===1){
            this.modalStatus.senior?
            AddMaiDian('invest33a',target):
            AddMaiDian('invest31a',target)
          }
        }
        toP2P()
      },
      // 翻牌-请先登录 click 事件
      onLotteryLoginBtnClk({target}){
        if(this.tabIdx===0){
          AddMaiDian('login24a',target)
        }
        if(this.tabIdx===1){
          AddMaiDian('login25a',target)
        }
        toLogin()
      },
    },

    created(){
      this.lotteryCardPos=this.getLotteryCardPos()
      // 获取初始信息
      getInitDataAPI()
        .then(res=>{
          this.isInitDataLoading=false
          this.isLogined=res.isLogin
          if(this.isLogined){
            this.userInvestNum=res.userInvestData
          }
          // 活动未开始
          if(res.resultCode===603){
            this.activityStatus='undo'
            if(this.isLogined){
              // 判断是否领取1.2%加息特权
              return checkNewClientJiaXi()
            }
            throw new Error('break')
          }
          // 活动已开始/已结束
          if(res.resultCode===602){
            this.activityStatus='done'
          }
          if(res.resultCode===604){
            this.activityStatus='doing'
          }
          if(res.userDrawList.length>0){
            const userJuniorPrize=res.userDrawList.filter(item=>item.type===2)[0]
            const userSeniorPrize=res.userDrawList.filter(item=>item.type===10)[0]
            if(userJuniorPrize){
              this.isJuniorLotteryDrew=true
              this.userLotteryPrize.junior={
                src:this.getBingoPrizeUrl(userJuniorPrize.prizeUrl),
                text:userJuniorPrize.prizeName
              }
            }
            if(userSeniorPrize){
              this.isSeniorLotteryDrew=true
              this.userLotteryPrize.senior={
                src:this.getBingoPrizeUrl(userSeniorPrize.prizeUrl),
                text:userSeniorPrize.prizeName
              }
            }
          }
          if(this.isLogined){
            // 获取中奖列表/判断是否领取1.2%加息特权
            return Promise.all([getBingoRecordsAPI(),checkNewClientJiaXi()])
          }
          return getBingoRecordsAPI()
        })
        .then(res2=>{
          // 未开始分支
          if(this.activityStatus==='undo'){
              if(res2.code==='SUCCESS'){
                this.modalStatus.newClientJiaXi=true
              }
              // 获取用户加息值
              return getUserTotalJiaXi()
          }
          // 已开始/已结束分支
          let resRecords
          if(this.isLogined){
            const resCheck=res2[1]
            if(resCheck.code==='SUCCESS'){
              this.modalStatus.newClientJiaXi=true
            }
            resRecords=res2[0]
          }else{
           resRecords=res2
          }
          this.juniorRecords=resRecords.twoPoolList.map(item=>{
            return{
              headImg:item.userImg,
              tel:item.userPhone,
              prize:`抽中${item.prizeName}`,
              date:item.drawTime
            }
          })
          this.seniorRecords=resRecords.tenPoolList.map(item=>{
            return{
              headImg:item.userImg,
              tel:item.userPhone,
              prize:`抽中${item.prizeName}`,
              date:item.drawTime
            }
          })
          this.isRecordShow=true
          if(this.isLogined){
            // 获取用户加息值
            return getUserTotalJiaXi()
          }
          throw new Error('break')
        })
        .then(res3=>{
          if(res3.isLoginStatus){
            this.userJiaXiVal=res3.sumJiaXiTeQuan
          }
        })
        .catch(err=>{
          if(err.message==='break') return
          this.isInitDataLoading=false
          const errRes=err.response
          if(errRes==null||typeof errRes.data==='string'){
            toast.show(err.message)
            return
          }
          toast.show(errRes.data.message)
        })
    },

  }
</script>
