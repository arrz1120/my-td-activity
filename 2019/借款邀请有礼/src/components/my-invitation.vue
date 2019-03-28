<template>
  <div class="my-invitation bg">
    <div class="frame1">
      <div class="item">
        <p class="award-p1">{{totalInviteCnt}}</p>
        <p class="award-p2">累计邀请好友（人）</p>
      </div>
    </div>
    <div class="frame2">
      <div class="scroll-container">
        <div class="scroll-tab">
          <div class="item">我的好友</div>
          <div class="item">注册时间</div>
        </div>
        <scroll class="scroll" :data="awardList" v-if="awardList.length">
          <div class="scroll-wrapper">
            <div class="scroll-item" v-for="(item,index) in awardList" :key="index">
              <div class="item">
                {{item.telNo}}
                <span v-if="item.status == 2">未借款</span>
                <span v-if="item.status == 1">未获额</span>
              </div>
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
    <div class="invite-btn" @click="goToShare" name="立即邀请c">立即邀请</div>
  </div>
</template>

<script>
import Scroll from "components/scroll.vue";
import { myInvite, checkwhitelist } from "../api/baseAPI";
import util from "js/utils";
import Share from "js/initShare.js";

const extenderKey = util.getQueryString("extenderKey");

export default {
  created() {
    Share.set(extenderKey);
    this.getMyInviteData();
  },
  data() {
    return {
      totalInviteCnt: null,
      awardList: []
    };
  },
  methods: {
    getMyInviteData() {
      myInvite().then(res => {
        this.totalInviteCnt = res.totalInviteCnt;
        this.awardList = res.data;
      });
    },
    goToShare(e) {
      const tips = "抱歉，本活动仅对部分用户开放";
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
    }
  },
  components: {
    Scroll
  }
};
</script>

