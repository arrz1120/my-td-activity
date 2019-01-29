
<template>
  <section class="jiaxi-wraper">
      <header>
          <h2 class="tit"></h2>
          <p class="date">12月3日-12月22日</p>
      </header>
      <section class="jiaxi-container">
            <div class="jiaxi-inner">
              <h3 class="tit" v-if="!isLogin">我的加息</h3>
              <h3 class="tit" v-else>加息{{jiaXiValFinal}}%</h3>
              <div class="jxq">
                    <div class="rate">
                          <p class="rate-num">2.5<span>%</span>
                          </p>
                          <p class="rate-tit">普惠加息</p>
                    </div>
                    <div class="rate">
                          <p class="rate-num">{{isLogin?sumJiaXiTeQuan:'?'}}<span>%</span></p>
                          <p class="rate-tit">
                          加息特权
                          </p>
                    </div>
              </div>
              <div class="btn-loan" @click="loan" mtaName="invest9a" name="立即出借9a">立即出借</div>
            </div>
      </section>

      <section class="list-container">
            <ul class="list">
                <li :class="{'finish':completTask.tb==1}"  style="padding-top:0.56rem;">
                    <h3 class="tit">团币加息
                      <p>
                        <span class="num">0.1</span>%
                        <span class="line">~</span>
                        <span class="num">0.6</span>%
                      </p>
                      </h3>
                    <div class="icon icon-tb"></div>
                    <div class="btn btn-finish" v-if="completTask.tb==1">{{tbJiaXiTeQuan}}%加息特权</div>
                    <div class="btn"  v-else  @click="dhtb"  mtaName="exchange10a" name="马上兑换10a">马上兑换</div>
                </li>
                <li  :class="{'finish':completTask.hb==1}">
                    <h3 class="tit">红包雨加息<span class="num">0.1</span>%</h3>
                    <div class="icon icon-hb"></div>
                    <div class="btn btn-finish" @click="toHby"  mtaName="attend11a" name="马上参加11a">活动已结束</div>
                </li>
                <li  :class="{'finish':completTask.jx==1}" style="padding-top:0.56rem;">
                    <h3 class="tit">
                      集爱心加息
                      <p>
                        <span class="num">0.1</span>%
                        <span class="line">~</span>
                        <span class="num">0.3</span>%
                      </p>
                    </h3>
                    <div class="icon icon-jx"></div>
                    <div class="btn" @click="toGfhb"   mtaName="attend12a" name="马上参加12a">马上参加</div>
                </li>
                <li  :class="{'finish':completTask.ranking==1}" style="padding-top:0.56rem;">
                    <h3 class="tit">
                      上榜加息
                      <p>
                        <span class="num">0.1</span>%
                        <span class="line">~</span>
                        <span class="num">0.5</span>%
                      </p>
                      </h3>
                    <div class="icon icon-jb"></div>
                    <div class="btn"  @click="toRanking"  mtaName="attend13a" name="马上参加13a">马上参加</div>
                </li>

                <li  :class="{'finish':isGetFullJiaxi}" style="padding-top:0.56rem;">
                    <h3 class="tit">
                      福利加息1.0%
                    </h3>
                    <div class="icon icon-gift"></div>
                    <div class="btn" @click="getJx"   mtaName="gain39a"
                    name="马上领取39a"
                    v-if="!isGetFullJiaxi"
                    >马上领取</div>

                    <div class="btn btn-finish" v-else >已经领取</div>


                </li>
                <li  :class="{'finish-1':signJiaXiStatus==2}" style="padding-top:0.56rem;">
                    <h3 class="tit-1">签到彩蛋</h3>
                    <h3 class="tit tit-2">

                      <p>
                        <span class="num">0.1</span>%
                        <span class="line">~</span>
                        <span class="num">0.2</span>%
                      </p>
                      </h3>
                    <div class="icon icon-cd">
                        <p class="day-num" v-if="atcivitySt.sign!==2">+{{isSignNum<=3?isSignNum:3}}<span class="small">天</span> </p>
                    </div>
                    <div class="btn btn-1"  @click="toSignIn"  mtaName="signup40a" name="签到40a"
                    v-if="signJiaXiStatus==0"
                    >马上签到</div>

                    <div class="btn btn-1 btn-small"   v-else
                     @click="toSignIn"
                    mtaName="signup40a" name="签到40a">
                    {{signRate}}%<span   v-if="signJiaXiStatus==2">+{{signRate3Day}}%</span>加息特权</div>
                </li>

            </ul>
      </section>


      <section class="rule-container">
            <h3 class="tit">规则说明</h3>
            <ul class="list">
                <li>
                    <span>1</span>
                    用户可以通过团币兑换、红包雨游戏、集爱心兑换及累计出借上榜来获得加息特权；
                </li>
                <li>
                    <span>2</span>加息特权可与普惠加息叠加使用，加息额度均以最终叠加结果计算；
                </li>
                <li>
                    <span>3</span>加息范围：12月3日-22日期间的We自动服务、We+自动服务（新手专享服务除外）。
                </li>
            </ul>
    </section>

      <div class="btn-rule" @click="showRule" name="活动规则_加息专享8a" mtaName="rule8a">活动规则</div>




      <!--登录弹窗-->
      <JxAlertLogin v-if="alertStatus.login" @onCloseBtnClk="alertStatus.login=false"/>
      <!--登录弹窗 end-->


      <!--活动结束or活动未开始-->
      <JxAlertoverOrDNS
      v-if="alertStatus.gameoverOrDNS"
      @onCloseBtnClk="alertStatus.gameoverOrDNS=false"
      :topic="alertTxt.topic"
      :txt="alertTxt.txt"
      />
      <!--活动结束or活动未开始 end-->


    <!-- 团币立即兑换弹窗 start -->
    <jx-alert-tbdh
    v-if="alertStatus.tbDh"
    :popup-style="{zIndex: 11}"
    :mycoin="myCoin"
    :item="jiaxiLists[jiaxiListsIdx]"
    :btn-disabled="tbDhBtnDisabled"
    @on-cancel="alertStatus.tbDh = false"
    @on-covert="onDHCovert"
    >
    </jx-alert-tbdh>
    <!-- 团币立即兑换弹窗 end -->

    <!-- 团币不足弹窗 start -->
    <jx-alert-tbbz
    v-if="alertStatus.tbBz"
    :popup-style="{zIndex: 11}"
    :mycoin="myCoin"
    @on-cancel="alertStatus.tbBz = false"
    ></jx-alert-tbbz>
    <!-- 团币不足弹窗 end -->

    <!-- 团币兑换加息列表弹窗 start -->
    <jx-alert-tbjx
    v-if="alertStatus.tbJx"
    :list="jiaxiLists"
    :mycoin="myCoin"
    :popup-style="{zIndex: 10}"
    @on-cancel="onCancel"
    @on-covert="onJXCovert"
    ></jx-alert-tbjx>
    <!-- 团币兑换加息列表弹窗 end -->

    <!-- 底部导航 -->
    <Footerbar :idx="0"/>
    <!-- 底部导航 end -->

    <!-- 规则弹窗 -->
    <RuleModal
      v-if="alertStatus.rule"
      :initIdx="0"
      @closeCallback="alertStatus.rule=false"
    />
    <!-- 规则弹窗 end -->

    <!-- 我的奖品弹窗 -->
    <MyPrize
      v-if="alertStatus.myPrize"
      :initIdx="0"
      :jxVal="sumJiaXiTeQuan | filterSumJX"
      :jxList="this.alertList.jxList"
      :prizeList="this.alertList.prizeList"
      @closeCallback="alertStatus.myPrize=false"
    />
    <!-- 我的奖品弹窗 end -->

    <!-- 侧边导航 -->
    <Sidebar
      :jxVal="sumJiaXiTeQuan | filterSumJX"
      @prizeCallback="onMyPrizeBtnClk"
      :isLogined="isLogin"
    />
    <!-- 侧边导航 end -->

    <!-- 加息遮罩层 -->
    <JxtqAlert
        v-if="alertStatus.jxAlerlt"
        number="1.0"
        @onCloseBtnClk="alertStatus.jxAlerlt=false"
    />
    <!-- 加息遮罩层  end-->


</section>



</template>

<script>

import './assets/sass/jiaxi.scss'
import './js/lib/toast.js'
import JxAlertLogin from './components/jxAlertLogin.vue'
import JxAlertoverOrDNS from './components/jxAlertoverOrDNS.vue'
import JxAlertTbdh from './components/jxAlertTbdh'
import JxAlertTbbz from './components/jxAlertTbbz'
import JxAlertTbjx from './components/jxAlertTbjx'
import Footerbar from './components/footerbar.vue'
import Sidebar from './components/sidebar.vue'
import RuleModal from './components/ruleModal.vue'
import MyPrize from './components/myPrize.vue'
import JxtqAlert from './components/jxtqAlert.vue'
import {
    getUserJiaXiList,
  } from './api/commonAPI.js'
import {initUserJiaXiTeQuan, getMycoin, tuanBiExChangeJiaXi,getUserDrawRecordList,sendFuLiJiaXiTeQuan,getUserJiaXiTeQuan,getUserSumJiaXiTeQuan} from './api/jiaxi'

export default {
    name: 'App',
    components:{
        JxtqAlert,
        JxAlertLogin,
        JxAlertTbdh,
        JxAlertTbbz,
        JxAlertTbjx,
        JxAlertoverOrDNS,
        Footerbar,
        Sidebar,
        RuleModal,
        MyPrize,
    },
    created() {
        if(Jsbridge.isApp()){
                Jsbridge.appLifeHook(null,null,null,null,function(){
                    if(window.sessionStorage){
                        if(sessionStorage.getItem("toAppSignIn")){
                            sessionStorage.removeItem("toAppSignIn");
                            // this.goAssist()
                            location.href='';
                        }
                    }
                });
        }
        initUserJiaXiTeQuan().then(res => {
            // console.log(res);
            this.isLogin = res.isLoginStatus;
            this.completTask.tb = res.tuanBiJiaXiStatus;
            this.completTask.hb = res.hongBaoYuJiaXiStatus;
            this.completTask.jx = res.jiAiXinJiaXiStatus;
            this.completTask.ranking = res.bangDanJiaXiStatus;
            this.atcivitySt.tb = res.tuanBiDateStatus;
            this.atcivitySt.hb = res.hongBaoYuDateStatus;
            this.atcivitySt.jx = res.jiAiXinDateStatus;
            this.atcivitySt.gift = res.fuLiJiAXiDateStatus;
            this.atcivitySt.sign = res.signJiAXiDateStatus;
            this.sumJiaXiTeQuan = res.sumJiaXiTeQuan;
            this.tbJiaXiTeQuan = res.tuanBiJiaXiValue;
            this.isSignNum = res.signContinueDays;
            this.signRate = res.signFirstJiaXiValue;
            this.signRate3Day = res.signFinishJiaXiValue;
            this.signJiaXiStatus = res.signJiaXiStatus;

            if(res.isLoginStatus==1&&res.fuLiJiaXiStatus==0){
                 /*发送已经领取全程加息*/
                //  debugger;
                sendFuLiJiaXiTeQuan().then(res => {
                    if(res.code=="SUCCESS"){
                            this.alertStatus.jxAlerlt=true;
                            this.isGetFullJiaxi = true;
                            getUserSumJiaXiTeQuan().then(res => {
                              if (res.isLoginStatus === 1) {
                                this.sumJiaXiTeQuan = res.sumJiaXiTeQuan
                              }
                            }).catch(err => {
                            })
                    }
                }).catch(err => {

                })
            }else if(res.fuLiJiaXiStatus==1){
                this.isGetFullJiaxi = true;
            }
        }).catch(err => {
        })
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
    data(){
        return{
          isLogin:0,
          isSignNum : 999,
          signRate :0.1,
          signRate3Day:0.1,
          signJiaXiStatus:0,
          isGetFullJiaxi:false,
          alertList:{
              jxList:[],
              prizeList:[]
          },
          alertTxt:{
              topic:"",
              txt:""
          },
          //弹窗显示状态
          alertStatus:{
            login:false,
            gameoverOrDNS :false,
            tbJx:false,
            tbDh:false,
            tbBz:false,
            rule:false,
            myPrize:false,
            jxAlerlt:false
          },
          //任务完成情况
          completTask:{
              tb:0,
              hb:0,
              jx:0,
              ranking:0
          },
          //活动时间状态
          atcivitySt:{
              tb:0,
              hb:0,
              jx:0,
              sign:0,
              gift:0
          },
        //加息特权列表数据
        jiaxiLists: [
            {
                typeId: '1',
                rate: '0.1',
                coin: 150,
                mtaName:'exchange0_1',
                name:'马上兑换0.1加息'
            }, {
                typeId: '2',
                rate: '0.2',
                coin: 1500,
                mtaName:'exchange0_2',
                name:'马上兑换0.2加息'
            }, {
                typeId: '3',
                rate: '0.3',
                coin: 8000,
                mtaName:'exchange0_3',
                name:'马上兑换0.3加息'
            }, {
                typeId: '4',
                rate: '0.5',
                coin: 70000,
                mtaName:'exchange0_5',
                name:'马上兑换0.5加息'
            }, {
                typeId: '5',
                rate: '0.6',
                coin: 500000,
                mtaName:'exchange0_6',
                name:'马上兑换0.6加息'
            }
        ],

        jiaxiListsIdx: 0, //加息特权列表数据Idx
        myCoin: '0', //我的团币

        //加息特权0总值
        sumJiaXiTeQuan:0,

        tbJiaXiTeQuan: '0.0', //团币兑换成功后显示的加息特权值
        tbDhBtnDisabled: false //团币兑换弹窗中立即兑换按钮disabled值
      }
    },
    computed:{
        jiaXiValFinal(){
            return 2.5+this.sumJiaXiTeQuan*1
        }
    },
    methods: {
        /**
         * 获取我的团币
         */
        getMycoin () {
            getMycoin().then(res => {
                this.myCoin = res
                this.alertStatus.tbJx = true
            }).catch(err => {
              const errData=err.response.data
              if (errData.code === 'FORBIDDEN') {
                this.alertStatus.login = true
                return
              }
            })
        },
        onCancel () {
            this.alertStatus.tbJx = false
        },
        //加息弹窗->立即兑换
        onJXCovert (item, idx) {
            const mycoin = typeof this.myCoin === 'string' ? +(this.myCoin.replace(/,|，/g, "")) : this.myCoin
            this.alertStatus.tbJx = false
            if(mycoin >= item.coin) {
                this.jiaxiListsIdx = idx
                this.alertStatus.tbDh = true
            } else {
                this.alertStatus.tbBz = true
            }
        },
        //兑换弹窗->立即兑换
        onDHCovert (item) {
            this.tbDhBtnDisabled = true //防止多次点击请求
            let _this = this
            tuanBiExChangeJiaXi(item.typeId)
            .then(res => {
              if (res.code == 'SUCCESS') {
                this.alertStatus.tbDh = false
                this.myCoin = res.data.leftTuanBiCount;
                this.completTask.tb = 1
                this.tbJiaXiTeQuan = item.rate.replace(/(\d+)0$(?!\.)/, '$1')
                window.toast.show("兑换成功！", 1500, function(){
                    _this.tbDhBtnDisabled = false
                });

                getUserSumJiaXiTeQuan().then(res => {
                  if (res.isLoginStatus === 1) {
                      this.sumJiaXiTeQuan = res.sumJiaXiTeQuan;
                  }
                }).catch(err => {
                })
              } else if (res.code == 'FAIL') {
                window.toast.show(res.message || '兑换失败!', 1500, function(){
                  _this.tbDhBtnDisabled = false
                })
              } else if (res.code == 'hasChangeTuanBi') {
                window.toast.show(res.message || '已经兑换!', 1500, function(){
                  _this.tbDhBtnDisabled = false
                })
              } else if (res.code == 'noEnoughTuanBi ') {
                window.toast.show(res.message || "团币不足！", 1500, function(){
                  _this.tbDhBtnDisabled = false
                })
                this.myCoin = res.data.nowTuanBi
              }

            }).catch(err => {
                const errData=err.response.data
                let time = 1500
                switch (errData.code) {
                  case 'TOO_MANY_OPERATE_ERROR':
                    toast.show(errData.message || '操作太频繁', time, function(){
                      _this.tbDhBtnDisabled = false
                    })
                    break;
                  case 'ACTIVITY_NOT_START':
                    toast.show(errData.message || '活动未开始', time, function(){
                      _this.tbDhBtnDisabled = false
                    })
                    break;
                  case 'ACTIVITY_FINISHED':
                    toast.show(errData.message || '活动已结束', time, function(){
                      _this.tbDhBtnDisabled = false
                    })
                    break;
                  case 'FORBIDDEN':
                    _this.alertStatus.login = true
                    break;
                  default:
                    window.toast.show('系统繁忙，请稍后再试！', time, function(){
                      _this.tbDhBtnDisabled = false
                    })
                }
            })

        },
       //授权出借
       loan(e){
          AddMaiDian(e.target.getAttribute('mtaName'),e.target);
          if(Jsbridge.isApp()){
             Jsbridge.toAppP2p();
          }else{
            window.location.href = 'https://www.tuandai.com/app/install.aspx'
          }
       },
      //去签到
       toSignIn(e){
          AddMaiDian(e.target.getAttribute('mtaName'),e.target);
          if(this.atcivitySt.sign==0){
              this.showAtStAlert("签到彩蛋赠送加息特权<br>活动未开始！","1218签到彩蛋赠送加息特权活动时间为<span class='txt-red'>2018年12月18日~12月22日</span>。活动尚未开始，敬请期待！")
          }else if(this.atcivitySt.sign==2){
              this.showAtStAlert("签到彩蛋赠送加息特权<br>活动已结束！","签到彩蛋赠送加息特权<span class='txt-red'>2018年12月18日~12月22日</span>。活动已结束，非常感谢您的关注！")
              return 
          }else if(this.atcivitySt.sign==1){
              if(this.isLogin==1){
                if(Jsbridge.isApp()){
                    if (window.sessionStorage) {
                          sessionStorage.setItem("toAppSignIn", true);
                    }
                     Jsbridge.toAppSignIn();
                 }else{
                     window.location.href = 'https://www.tuandai.com/app/install.aspx'
                }
              }else{
                  this.alertStatus.login = true;
              }
          }


       },

      // 显示活动状态弹窗

      showAtStAlert(topic,txt){
              this.alertTxt.topic=topic;
              this.alertTxt.txt=txt;
              this.alertStatus.gameoverOrDNS=true;
      },

       //团币加息

       dhtb(e){
          AddMaiDian(e.target.getAttribute('mtaName'),e.target);
          if(this.atcivitySt.tb==0){
              this.showAtStAlert("团币兑换加息特权<br>活动未开始！","1218团币兑换加息特权活动时间为<span class='txt-red'>2018年12月3日~12月22日</span>。活动尚未开始，敬请期待！")
          }else if(this.atcivitySt.tb==2){
              this.showAtStAlert("团币兑换加息特权<br>活动已结束！","1218团币兑换加息特权活动时间为<span class='txt-red'>2018年12月3日~12月22日</span>。活动已结束，非常感谢您的关注！")
          }else if(this.atcivitySt.tb==1){
              if(this.isLogin==1){
                  this.getMycoin();
              }else{
                  this.alertStatus.login = true;
              }
          }

       },

      // 马上领取加息

      getJx(e){
        AddMaiDian(e.target.getAttribute('mtaName'),e.target);


          if(this.atcivitySt.gift==0){
              this.showAtStAlert("签到彩蛋赠送加息特权<br>活动未开始！","1218签到彩蛋赠送加息特权活动时间为<span class='txt-red'>2018年12月7日~12月22日</span>。活动尚未开始，敬请期待！")
          }else if(this.atcivitySt.gift==2){
              this.showAtStAlert("签到彩蛋赠送加息特权<br>活动已结束！","1218签到彩蛋赠送加息特权活动时间为<span class='txt-red'>2018年12月7日~12月22日</span>。活动已结束，非常感谢您的关注！")
          }else if(this.atcivitySt.gift==1){
              if(this.isLogin==0){
                  this.alertStatus.login = true;
              }
          }
      },


       //参加红包雨活动

       toHby(e){
           return
          AddMaiDian(e.target.getAttribute('mtaName'),e.target);
          if(this.atcivitySt.hb==0){
              this.showAtStAlert("红包雨活动未开始！","1218红包雨活动时间为<span class='txt-red'>2018年12月3日~12月17日</span>。活动尚未开始，敬请期待！")
          }else{
            //跳转 红包雨页面
            window.location.href = '//at.tuandai.com/huodong/redEnvelope/index'
          }
       },


      //参加爱心加息

       toGfhb(e){
          AddMaiDian(e.target.getAttribute('mtaName'),e.target);

          if(this.atcivitySt.hb==0){
              this.showAtStAlert("组团集爱心瓜分现金<br>活动未开始！","1218组团集爱心瓜分现金活动时间为<span class='txt-red'>2018年12月10日~12月22日</span>。活动尚未开始，敬请期待！")
          }else{
            //跳转 瓜分现金红包封面
            window.location.href = router.carveRedpacket
          }
       },

       toRanking(e){
           AddMaiDian(e.target.getAttribute('mtaName'),e.target);
            //跳转 排行版
            window.location.href = router.rank
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
                this.alertList.prizeList=resPrizeList.map((value,key) => {
                  return {
                        'title' : value.prizeName,
                        'date' : value.drawDate,
                        'desc' : value.prizeSource
                  }
                })
                this.alertList.jxList=resJiaXiList.map((value,key) => {
                  return {
                    'title' : value.jiaXiName,
                    'date' : value.jiaXiDate,
                    'val' : `${value.jiaXiValue}%`
                  }
                })
                this.sumJiaXiTeQuan = res.sumJiaXiTeQuan
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

       showRule(e){
                AddMaiDian(e.target.getAttribute('mtaName'),e.target);
                this.alertStatus.rule=true;
       }


    }
}
</script>
