<template>
  <div class="mask" @touchmove.prevent>
    <div class="mask-bg"></div>
    <div class="mask-con">
      <div class="rule">
        <div class="rule-tab">
          <div
            class="item"
            v-for="(item,index) in ruleTab"
            :key="index"
            :class="{'active': index === tabIndex}"
            @click="onRuleTabClick(index)"
          >
            <p>{{item}}</p>
          </div>
        </div>
        <scroll class="rule-scroll" :data="[tabIndex]">
          <div class="rule-scroll-wrapper">
            <div class="rule-content" v-if="tabIndex === 0">
              <p class="rule-p1">1、活动时间</p>
              <p class="rule-p2">2019年3月14日-2019年4月15日</p>
              <p class="rule-p1">2、邀请人奖励</p>
              <p class="rule-p2">第一重奖励：</p>
              <p
                class="rule-p2"
              >活动期间，您可分享邀请链接给好友，好友通过邀请链接完成注册即邀请成功；每邀请1位好友注册并成功获取额度，您可获得1个20元还款红包；此项奖励每位邀请人最多可获得1000元；</p>
              <p class="rule-p2">第二重奖励：</p>
              <p class="rule-p2">活动期间，每邀请1位好友注册并借款成功（已支付服务费），您可获得好友首笔借款申请金额*2%的现金红包，上不封顶。</p>
              <p class="rule-p1">3、被邀请人奖励</p>
              <p class="rule-p2">活动期间，好友通过邀请链接完成注册并首次成功获取额度，可获得1个20元还款红包。</p>
              <br>
              <p
                class="rule-p2 c-gray"
              >团贷网可能会根据实际业务安排对活动时间、活动内容等进行调整，该调整不会影响调整前已参与活动的用户的权益，团贷网将根据实际调整情况重新发布活动规则；凡以不正当手段（包括但不限于：注册虚假账号、恶意刷奖、实施网络攻击等）参与本次活动的用户，团贷网有权终止其参与，取消奖励领取资格。</p>
            </div>
            <div class="rule-content" v-else>
              <p class="rule-p1">1、还款红包</p>
              <p class="rule-p2">（1）还款红包将在好友成功获取额度后1个工作日内发放，红包详情可至“我的-优惠券”查看。</p>
              <p class="rule-p2">（2）还款红包使用有效期为6个月（从发放日开始计算），请在有效期内使用，过期不予补发；</p>
              <p class="rule-p2">（3）还款红包可在每期按时还款后1个工作日内自动返现至您的账户余额，每期还款仅限使用一个还款红包，逾期还款不可使用。</p>
              <p class="rule-p1">2、现金红包</p>
              <p class="rule-p2">（1）现金红包将在好友借款成功后1个工作日内发放；</p>
              <p class="rule-p2">（2）现金红包领取有效期为30天（从发放日开始计算），请在有效期内至“我的-优惠券”领取，过期不予补发。</p>
            </div>
          </div>
        </scroll>
        <div class="mask-rule-btn" @click="hideRule">我知道了</div>
      </div>
    </div>
  </div>
</template>

<script>
import 'assets/sass/mask.scss'
import Scroll from 'components/scroll.vue'


export default {
  data() {
    return {
      ruleTab: ['活动规则', '奖品说明'],
      tabIndex: 0
    }
  },
  methods: {
    onRuleTabClick(index) {
      this.tabIndex = index
    },
    hideRule() {
      this.$emit('hideRule')
    }
  },
  components: {
    Scroll
  }
}
</script>

