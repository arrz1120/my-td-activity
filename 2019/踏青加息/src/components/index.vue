<template>
  <div class="index">
    <div class="banner">
      <div class="logo"></div>
      <div class="rule-btn" @click="onRuleBtnClick" name="活动规则">活动规则</div>
      <div class="banner-tit zoomIn"></div>
      <div class="banner-sub fadeInFromBottom">活动时间：3月10日-3月19日</div>
    </div>
    <!-- <p class="bot-txt">【广告】市场有风险，出借需谨慎</p> -->
    <div class="sec sec1">
      <div class="tit"></div>
      <p class="p">活动期间，用户成功出借（且匹配成功）以下的We自动服务、We+自动服务（新手专享服务除外），即可获得相应的加息奖励，加息幅度如下：</p>
      <div class="table">
        <div class="th">
          <div class="td">产品类型</div>
          <div class="td">加息幅度</div>
          <div class="td">加息后
            <br>参考年回报率
          </div>
        </div>
        <div class="tbody">
          <div class="tr">
            <div class="td">We自动服务3</div>
            <div class="td">0.5%</div>
            <div class="td">8.0%</div>
          </div>
          <div class="tr">
            <div class="td">We自动服务6</div>
            <div class="td">0.5%</div>
            <div class="td">9.0%</div>
          </div>
          <div class="tr">
            <div class="td">We+自动服务6</div>
            <div class="td">0.5%</div>
            <div class="td">9.5%</div>
          </div>
          <div class="tr">
            <div class="td">We+自动服务12</div>
            <div class="td">1.0%</div>
            <div class="td">11.4%</div>
          </div>
          <div class="tr">
            <div class="td">We+自动服务18</div>
            <div class="td">0.5%</div>
            <div class="td">11.1%</div>
          </div>
        </div>
      </div>
    </div>
    <div class="sec sec2">
      <div class="tit"></div>
      <p class="p">活动期间，每日限量开放专享服务，用户成功出借（且匹配成功）We自动服务12、We+自动服务24和We+自动服务36，即可获得相应的加息奖励。</p>
      <div class="table">
        <div class="th">
          <div class="td">产品类型</div>
          <div class="td">加息幅度</div>
          <div class="td">加息后
            <br>参考年回报率
          </div>
        </div>
        <div class="tbody">
          <div class="tr">
            <div class="td">We自动服务12</div>
            <div class="td">3.0%</div>
            <div class="td">13.0%</div>
          </div>
          <div class="tr">
            <div class="td">We+自动服务24</div>
            <div class="td">3.5%</div>
            <div class="td">14.5%</div>
          </div>
          <div class="tr">
            <div class="td">We+自动服务36</div>
            <div class="td">3.5%</div>
            <div class="td">15.0%</div>
          </div>
        </div>
      </div>
      <div class="invest-btn" @click="goToInvest" name="立即出借享加息" mtaName="lend_a5">立即出借享加息</div>
    </div>
    <p class="adv-tips">【广告】市场有风险，出借需谨慎
      <br>* 本活动及奖品与苹果公司无关
    </p>
    <div class="bot-btn">
      <div class="item active" mtaName="lendtoearn_a3" name="出借赚积分" @click="onBotLeftClick">
        <i class="bot-icon-left1"></i>出借赚积分
      </div>
      <div class="item" mtaName="exchange_a4" name="积分兑好礼" @click="onBotRightClick">
        <i class="bot-icon-right2"></i>积分兑好礼
      </div>
    </div>

    <div class="share-btn" mtaName="share_a1" name="分享" @click="onShareBtnClick"></div>
    <div class="prize-btn" mtaName="record_a2" name="团字礼包" @click="onPrizeBtnClick"></div>

    <transition name="fade">
      <maskContainer v-if="mask.show" @maskClose="maskClose">
        <prize-list v-if="mask.prizeList"/>
        <rule v-if="mask.rule"/>
        <activity-not-start v-if="mask.activityNotStart"/>
        <activity-end v-if="mask.activityEnd"/>
        <no-login v-if="mask.noLogin"/>
      </maskContainer>
    </transition>
    <transition>
      <maskContainer v-if="showLoginEraser" :showClose="loginEraserClose" @maskClose="maskClose">
        <loginEraser @showCloseBtn="showCloseBtn"></loginEraser>
      </maskContainer>
    </transition>
  </div>
</template>

<script>
import '../assets/sass/index.scss'
import * as api from '../api/baseAPI'
import * as util from '../js/lib/util'
import * as share from '../js/lib/initShare'

import maskContainer from './mask/mask'
import prizeList from '../components/mask/prize-list'
import activityEnd from '../components/mask/activity-end'
import activityNotStart from '../components/mask/activity-not-start'
import noLogin from '../components/mask/no-login'
import Rule from '../components/mask/rule'
import loginEraser from '../components/mask/login-eraser'

export default {
  created() {
    share.initShare()
    this.getInitStatus()
  },
  data() {
    return {
      activityStatus: null,
      logined: false,
      shared: false,
      isDrawing: false,
      prizeValue: '',
      showLoginEraser: false,
      loginEraserClose: false,
      mask: {
        show: false,
        getPrize: false,
        prizeList: false,
        rule: false,
        noLogin: false,
        activityEnd: false,
        activityNotStart: false
      }
    }
  },
  methods: {
    async getInitStatus() {
      const res = await api.getInitStatus()
      this.activityStatus = res.activityStatus
      this.logined = res.logined
      if (res.logined) {
        const { userStatus } = res
        if (userStatus.openLoginDraw && !userStatus.loginDrawed) {
          this.showLoginEraser = true
        }
      }
    },
    showMask(name) {
      this.hideMask()
      this.mask.show = true
      this.mask[name] = true
    },
    hideMask() {
      for (let key in this.mask) {
        if (this.mask[key]) {
          this.mask[key] = false
        }
      }
    },
    maskClose() {
      if (this.showLoginEraser) {
        this.showLoginEraser = false
      }
      else {
        this.hideMask()
      }
    },
    onRuleBtnClick(e) {
      util.track(e)
      this.showMask('rule')
    },
    goToInvest(e) {
      util.track(e)
      const { activityStatus } = this
      if (activityStatus === null) {
        return
      }
      if (activityStatus === 1) {
        this.showMask('activityNotStart')
        return
      }
      if (activityStatus === 3) {
        this.showMask('activityEnd')
        return
      }
      util.toAppP2p()
    },
    onPrizeBtnClick(e) {
      util.track(e)
      const { logined } = this
      if (!logined) {
        this.showMask('noLogin')
        return
      }
      this.showMask('prizeList')
    },
    onShareTxtClick(e) {
      util.track(e)
      const { logined, activityStatus } = this
      if (!logined) {
        this.showMask('noLogin')
        return false
      }
      if (activityStatus === null) {
        return false
      }
      if (activityStatus === 1) {
        this.showMask('activityNotStart')
        return false
      }
      if (activityStatus === 3) {
        this.showMask('activityEnd')
        return false
      }
      share.shareShow()
    },
    onShareBtnClick(e) {
      util.track(e)
      if (!this.logined) {
        this.showMask('noLogin')
        return
      }
      share.shareShow()
    },
    onBotLeftClick(e) {
      util.track(e)
    },
    onBotRightClick(e) {
      util.track(e)
      location.href = 'http://at.tuandai.com/huodong/springOutInterestRates2019/lottery.html'
    },
    showCloseBtn() {
      this.loginEraserClose = true
    }
  },
  components: {
    prizeList,
    Rule,
    noLogin,
    maskContainer,
    activityNotStart,
    activityEnd,
    loginEraser
  }
}
</script>

