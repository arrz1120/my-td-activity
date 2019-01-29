
<template>
  <section class="jiaxi-wraper">
      <header>
          <h2 class="tit"></h2>
          <p class="date">12月3日-12月22日</p>
      </header>

      <section class="rank-container">

          <div class="user-info">
              <div class="info-left" v-if="userInfo.headImg">
                  <div class="avatar">
                      <img :src="userInfo.headImg" alt="">
                  </div>
                  <p v-if="isLogin">{{userInfo.phone}}</p>
              </div>
              <!-- <div class="info-left" v-else>
                  <div class="avatar">
                      <img src="./assets/images/rank/avatar.png" alt="">
                  </div>
              </div> -->
              <div class="info-right" v-if="isLogin && activityStart">
                <p>我累计出借<span>{{userInfo.amount}}</span>元</p>
                <p v-if="userInfo.onTheList">当前排名第<span>{{userInfo.ranking}}</span></p>
                <p v-else>暂未上榜</p>
                <div class="info-btn" @click="onInfoBtnClick" mtaName="invest38a" name="立即出借冲榜38a">立即出借冲榜</div>
              </div>
              <div class="info-right" v-if="isLogin && !activityStart">
                <p class="f34">活动未开始</p>
                <p class="f34">敬请期待！</p>
              </div>
              <div class="info-right" v-if="!isLogin">
                <p class="f40" @click="goToLogin" mtaName="login37a" name="请先登录37a">请先登录</p>
              </div>
          </div>

          <div class="rank">
              <div class="rank-tit">
                  <p>名次</p>
                  <p>用户</p>
                  <p>累计出借金额</p>
              </div>
              <div class="rank-list" v-if="rankingList && rankingList.length">
                  <div class="swiper-container list-swiper" id="listSwiper">
                      <div class="swiper-wrapper">
                          <div class="swiper-slide">
                            <ul>
                                <li v-for="(item,index) in rankingList" :key="index">
                                    <div class="number"><i>{{item.ranking}}</i></div>
                                    <div class="phone">{{item.shownName}}</div>
                                    <div class="amo">￥{{item.amountStr}}</div>
                                </li>
                            </ul>
                          </div>
                      </div>
                      <div class="swiper-scrollbar"></div>
                  </div>
              </div>
              <div class="rank-list" v-else>
                  <div class="no-data"></div>
              </div>
          </div>
          <p class="end-time">统计截止至2018-12-22 23:59:59</p>
      </section>

      <section class="prize-container">
          <div class="swiper-container" id="prizeSwiper">
              <div class="swiper-wrapper">
                  <div class="swiper-slide">
                      <div class="prize-box">
                          <div class="prize-flex">
                              <div class="jxq jxq05"></div>
                              <div class="add"></div>
                              <div class="gold"></div>
                          </div>
                          <div class="prize-txt">
                              <p>0.5%加息特权</p>
                              <p>中国黄金50g金元宝</p>
                          </div>
                          <div class="prize-rank">第 1 名</div>
                      </div>
                  </div>
                  <div class="swiper-slide">
                      <div class="prize-box">
                          <div class="prize-flex">
                              <div class="jxq jxq04"></div>
                              <div class="add"></div>
                              <div class="gold"></div>
                          </div>
                          <div class="prize-txt">
                              <p>0.4%加息特权</p>
                              <p>中国黄金50g金元宝</p>
                          </div>
                          <div class="prize-rank">第 2 名</div>
                      </div>
                  </div>
                  <div class="swiper-slide">
                      <div class="prize-box">
                          <div class="prize-flex">
                              <div class="jxq jxq03"></div>
                              <div class="add"></div>
                              <div class="gold"></div>
                          </div>
                          <div class="prize-txt">
                              <p>0.3%加息特权</p>
                              <p>中国黄金50g金元宝</p>
                          </div>
                          <div class="prize-rank">第3-10名</div>
                      </div>
                  </div>
                  <div class="swiper-slide">
                      <div class="prize-box">
                          <div class="prize-flex">
                              <div class="jxq jxq03"></div>
                              <div class="add"></div>
                              <div class="goldBar"></div>
                          </div>
                          <div class="prize-txt">
                              <p>0.3%加息特权</p>
                              <p>中国黄金20g金条</p>
                          </div>
                          <div class="prize-rank">第11-20名</div>
                      </div>
                  </div>
                  <div class="swiper-slide">
                      <div class="prize-box">
                          <div class="prize-flex">
                              <div class="hb5000"></div>
                          </div>
                          <div class="prize-txt">
                              <p>0.3%加息特权</p>
                          </div>
                          <div class="prize-rank">第21-100名</div>
                      </div>
                  </div>
                  <div class="swiper-slide">
                      <div class="prize-box">
                          <div class="prize-flex">
                              <div class="hb3000"></div>
                          </div>
                          <div class="prize-txt">
                              <p>0.2%加息特权</p>
                          </div>
                          <div class="prize-rank">第101-300名</div>
                      </div>
                  </div>
                  <div class="swiper-slide">
                      <div class="prize-box">
                          <div class="prize-flex">
                              <div class="hb1500"></div>
                          </div>
                          <div class="prize-txt">
                              <p>0.1%加息特权</p>
                          </div>
                          <div class="prize-rank">第301-500名</div>
                      </div>
                  </div>
              </div>
              <div class="swiper-paging"></div>
          </div>
        <div class="swiper-prev"></div>
        <div class="swiper-next"></div>
      </section>

      <section class="rule-container">
            <h3 class="tit">爱心榜单规则</h3>
            <ul class="list">
                <li>
                    <span>1</span>12月3日-12月22日期间，将根据用户出借指定的We自动服务、We+自动服务（新手专享服务除外）累计出借金额进行排名，排名前500名均可获得奖励；
                </li>
                <li>
                    <span>2</span>若用户加入金额相同，则根据最后一笔加入时间进行排名，较早加入的排名靠前；
                </li>
                <li>
                    <span>3</span>榜单以截止于12月22日23:59:59的排名信息为准；
                </li>
                <li>
                    <span>4</span>榜单名单公布后次日，系统会将实物礼品发放至团宝箱，请获奖用户于奖品发放后15天内领取并填写收货地址，逾期不领取均视为自动放弃，逾期不予补发。
                </li>
            </ul>
    </section>

    <div class="btn-rule" @click="onRuleBtnClick" mtaName="rule36a" name="活动规则_爱心榜单36a">活动规则</div>

    <!--登录弹窗-->
    <JxAlertLogin v-if="alertStatus.login" @onCloseBtnClk="alertStatus.login=false"/>
    <!--登录弹窗 end-->

    <!-- 底部导航 -->
    <Footerbar :idx="3"/>
    <!-- 底部导航 end -->

    <!-- 规则弹窗 -->
    <RuleModal 
      v-if="alertStatus.rule"
      :initIdx="3"
      @closeCallback="alertStatus.rule=false"
    />
    <!-- 规则弹窗 end -->

    <!-- 我的奖品弹窗 -->
    <MyPrize
      v-if="alertStatus.myPrize"
      :initIdx="0"
      :jxVal="userJiaXiVal | filterSumJX"
      :jxList="userJiaXiList"
      :prizeList="userPrizeList"
      @closeCallback="alertStatus.myPrize=false"
    />
    <!-- 我的奖品弹窗 end -->

    <!-- 侧边导航 -->
    <Sidebar
      :isLogined="isLogin"
      :jxVal="userJiaXiVal | filterSumJX"
      @prizeCallback="onMyPrizeBtnClk"
    />
    <!-- 侧边导航 end -->
    <!-- 加息遮罩层 -->
    <JxtqAlert
      v-if="alertStatus.newClientJiaXi"
      number="1.0"
      @onCloseBtnClk="alertStatus.newClientJiaXi=false"
    />
    <!-- 加息遮罩层  end-->

</section>

</template>

<script>

import './assets/sass/rank.scss'
import JxAlertLogin from './components/jxAlertLogin.vue'
import jxtqAlert from './components/jxtqAlert.vue'
import Swiper from 'swiper'
import RuleModal from './components/ruleModal.vue'
import MyPrize from './components/myPrize.vue'
import Sidebar from './components/sidebar.vue'
import Footerbar from './components/footerbar.vue'
import JxtqAlert from './components/jxtqAlert.vue'
import {initStatus,getList} from './api/rank.js'
import {toP2P,toLogin} from './js/lib/utils.js'
import {
    getUserTotalJiaXi,
    getUserJiaXiList,
    checkNewClientJiaXi,
} from './api/commonAPI.js'

const AVATAR = require('./assets/images/rank/avatar.png')

export default {
    name: 'App',
    data(){
        return{
        userJiaXiVal: 0,
        userJiaXiList:[],
        userPrizeList:[],
          isLogin: false,  
          activityStart: false,
          activityEnd: false,
          userInfo:{
              headImg: '',
              phone: '',
              onTheList: false,
              amount: 0,
              amountStr: '',
              shownName: '',
              ranking: 0
          },
          //弹窗显示状态
          alertStatus:{
            login:false,
            rule:false,
            myPrize:false,
            newClientJiaXi:false,
          },
          rankingList:[]
      }
    },
    components:{
        JxAlertLogin,
        RuleModal,
        MyPrize,
        Sidebar,
        Footerbar,
        JxtqAlert,
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
    created() {
        this.getRankList()
        initStatus()
            .then(res => {
                let {loginFlag,activityStartFlag,activityEndFlag} = res
                this.isLogin = loginFlag
                this.activityStart = activityStartFlag
                this.activityEnd = activityEndFlag
                if(loginFlag){
                    this.userInfo.headImg = res.userInfoDto.headImage
                    this.userInfo.phone = res.userInfoDto.shownName
                }else{
                    this.userInfo.headImg = AVATAR
                }
                if(loginFlag){
                    // 判断是否领取1.2%加息特权
                    return checkNewClientJiaXi()
                }
                return 'break'
            })
            .then(res2=>{
                if(res2==='break') return 'break'
                if(res2.code==='SUCCESS'){
                    this.alertStatus.newClientJiaXi=true
                }
                // 获取用户加息值
                return getUserTotalJiaXi()
            })
            .then(res3=>{
                if(res3==='break') return
                if(res3.isLoginStatus){
                    this.userJiaXiVal=res3.sumJiaXiTeQuan
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

    },
    mounted() {
        this.swiper = new Swiper('#prizeSwiper',{
            loop: true,
            autoplay : 3000,
            autoplayDisableOnInteraction : false,
            pagination:'.swiper-paging',
            nextButton: '.swiper-next',
            prevButton: '.swiper-prev'
        })
    },
    methods: {
        goToLogin(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            toLogin()
        },
        getInitStatus(){
            initStatus().then(res => {
                let {loginFlag,activityStartFlag,activityEndFlag} = res
                this.isLogin = loginFlag
                this.activityStart = activityStartFlag
                this.activityEnd = activityEndFlag
            })
        },
        getRankList(){
            getList().then(res => {
                if(res.myRanking){
                    let {onTheList,ranking,amount,amountStr} = res.myRanking
                    this.userInfo.onTheList = onTheList
                    this.userInfo.amount = amount
                    this.userInfo.amountStr = amountStr
                    this.userInfo.ranking = ranking
                }
                if(res.rankingListItems){
                    let list = res.rankingListItems
                    this.rankingList = list.filter(item => item.shownName!="--")
                    if(this.rankingList.length>0){
                        this.$nextTick(()=>{
                            new Swiper('#listSwiper', {
                                direction: 'vertical',
                                freeMode: true,
                                // freeModeSticky : true,
                                slidesPerView: 'auto',
                                scrollbar: '.swiper-scrollbar',
                                scrollbarHide:false,
                                resistanceRatio :0,
                                roundLengths :true
                            })
                        })
                    }
                }
            })
        },
        onMyPrizeBtnClk(){
            if(!this.isLogin){
                this.alertStatus.login=true
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
                this.alertStatus.myPrize=true
            })
            .catch(err=>{
                const errData=err.response.data
                if(errData.code==null){
                    toast.show(err.message)
                    return
                }
                if(errData.code==='FORBIDDEN'){
                    this.alertStatus.login=true
                    return
                }
                toast.show(errData.message)
            })
           
        },
        onInfoBtnClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            toP2P()
        },
        onRuleBtnClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.alertStatus.rule=true
        }

    }
}
</script>

<style lang="scss" scoped>
    .f40{
        font-size: rem(40) !important;
        text-decoration: underline;
    }
    .f34{
        font-size: rem(34) !important;
        margin-bottom: rem(7) !important;
    }
</style>

