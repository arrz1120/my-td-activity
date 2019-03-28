<template>
  <div class="myAward bg">
    <div class="frame1">
      <div class="item">
        <p class="award-p1">{{totalRepaymentRedpacket}}</p>
        <p class="award-p2">累计还款红包（元）</p>
      </div>
      <div class="item">
        <p class="award-p1">{{totalRedpacket}}</p>
        <p class="award-p2">累计现金红包（元）</p>
      </div>
    </div>
    <div class="frame2">
      <div class="f2-tit" @click="gotoCouponPage">红包详情可至“我的-优惠券”查看 >></div>
      <div class="scroll-container">
        <div class="scroll-tab">
          <div class="item">我的奖励</div>
          <div class="item">获得时间</div>
        </div>
        <scroll class="scroll" :data="awardList" v-if="awardList.length">
          <div class="scroll-wrapper">
            <div class="scroll-item" v-for="(item,index) in awardList" :key="index">
              <div class="item">{{item.prizeName}}</div>
              <div class="item">{{item.date}}</div>
            </div>
          </div>
        </scroll>
        <div class="no-data" v-else>
          <img :src="require('../assets/images/index/no-data.png')" alt>
          <p>空空如也~
            <br>快去邀请好友 一起赚福利吧
          </p>
        </div>
      </div>
    </div>
    <div class="invite-btn" @click="goToShare" name="立即邀请b">立即邀请</div>
  </div>
</template>

<script>
import Scroll from "components/scroll.vue";
import { myAward,checkwhitelist } from "api/baseAPI";
import util from "js/utils";
import Share from "js/initShare.js";

const extenderKey = util.getQueryString("extenderKey");

export default {
  created() {
    Share.set(extenderKey);
    this.getAwardData();
  },
  data() {
    return {
      totalRedpacket: null,
      totalRepaymentRedpacket: null,
      awardList: []
    };
  },
  methods: {
    getAwardData() {
      myAward().then(res => {
        this.totalRedpacket = res.totalRedpacket;
        this.totalRepaymentRedpacket = res.totalRepaymentRedpacket;
        this.awardList = res.data;
      });
    },
    goToShare(e) {
      const tips = '抱歉，本活动仅对部分用户开放'  
      util.track(e);
      checkwhitelist()
        .then(res => {
          if (res.flag) {
            util.toShare(extenderKey);
          } else {
            toast.show(tips);
          }
        })
        .catch(err => {
          toast.show(tips);
        });
    },
    gotoCouponPage() {
      util.toCouponPage();
    }
  },
  components: {
    Scroll
  }
};
</script>

