<template slot-scope="slotProps">
  <div class="strategy" id="strategy" ref="strategy">
    <div class="tit"></div>
    <div class="content">

      <div class="item">
        <p>分享活动到微信/朋友圈，可召唤1只喜鹊<span>（1只/天，最多召唤2只）</span>。</p>
        <div class="btn" @click="toShare" name="立即分享">立即分享</div>
        <div
          v-if="state.userItemStatusList!==undefined &&state.userItemStatusList.item_1"
          class="icon-finish">
        </div>
      </div>

      <div class="item">
        <p>单笔投资≥5000元（1个月及以上项目，债权转让和智享转让除外），可召唤1只喜鹊<span>（1只/天，最多召唤3只）</span>。</p>
        <div class="btn" @click="toJoin" name="马上加入">马上加入</div>
        <div
          v-if="state.userItemStatusList!==undefined &&  state.userItemStatusList.item_2"
          class="icon-finish">
        </div>
      </div>

      <div class="item item-flex">
        <p>消耗200团币可召唤1只喜鹊<span>（最多召唤1只）</span>。</p>
        <div
          v-if="state.userItemStatusList!==undefined && state.userItemStatusList.item_3"
          class="btn btn-gray">
          已召唤
        </div>
        <div
          v-else class="btn"
          name="立即召唤"
          @click="toCall">立即召唤
        </div>
        <div
          v-if="state.userItemStatusList!==undefined && state.userItemStatusList.item_3"
          class="icon-finish"></div>
      </div>

      <div class="item">
        <p>邀请1位好友注册团贷网，可召唤1只喜鹊<span>（最多召唤1只）</span>。</p>
        <div class="btn" @click="toInvite" name="马上邀请">马上邀请</div>
        <div
          v-if="state.userItemStatusList!==undefined && state.userItemStatusList.item_4"
          class="icon-finish">
        </div>
      </div>

      <div class="item">
        <p>所邀请的好友投资团贷网（投资金额、项目不限），可召唤1只喜鹊<span>（最多召唤1只）</span>。</p>
        <div
          name="提醒好友投资"
          class="btn"
          @click="toFriendInvest">
          提醒好友投资
        </div>
        <div
          v-if="state.userItemStatusList!==undefined && state.userItemStatusList.item_5"
          class="icon-finish">
        </div>
      </div>

    </div>
  </div>
</template>

<script>
import {isApp, Login, Invest} from '../../js/bridge.js'
import {getInviteList, getVaildCoin} from '../../api/api.js'
import {ShareShow, ShareCallBack} from '../../js/share.js'

export default {
  props:['state'],
  methods: {
    beforeToDo() {
      let {activityTimeStauts, logined} = this.state
      if (!logined) {
        this.$emit('showAlertTips',{
          type: 'con-2'
        })
        return false
      }
      if (activityTimeStauts === 0 || activityTimeStauts === 2) {
        this.$emit('showAlertTips',{
          type: 'con-1'
        })
        return false
      }
      return true
    },
    shareFn() {
      if (!this.state.logined) {
        this.$emit('showAlertTips',{
          type: 'con-2'
        })
        return
      }
      ShareShow()
      if (isApp) {
        ShareCallBack()
      }
    },
    toShare(e){
      AddMaiDian('share5a',e.target)
      if(!this.beforeToDo()){
        return
      }
      this.shareFn()
    },
    toJoin(e){
      AddMaiDian('invest6a',e.target)
      if(!this.beforeToDo()){
        return
      }
      Invest()
    },
    toCall(e){
      AddMaiDian('call7a',e.target)
      if(!this.beforeToDo()){
        return
      }
      getVaildCoin().then(res => {
        if (res.code === "SUCCESS") {
          if (res.data >= 200) {
            this.$emit('showAlertTips',{
              type: 'con-3',
              vaildCoin: res.data
            })
          } else {
            this.$emit('showAlertTips',{
              type: 'con-4',
              vaildCoin: res.data
            })
          }
        }
      })
    },
    toInvite(e) {
      AddMaiDian('invite8a',e.target)
      if(!this.beforeToDo()){
        return
      }
      this.shareFn()
    },
    toFriendInvest(e) {
      AddMaiDian('remind9a',e.target)
      if(!this.beforeToDo()){
        return
      }
      if (!this.state.logined) {
        this.$emit('showAlertTips',{
          type: 'con-2'
        })
        return
      }
      getInviteList().then(res => {
        let recordFriListData = []
        if (res.data && res.data!=="NO-DATA") {
          recordFriListData = res.data
        }
        this.$emit('showAlertRecord',{
          type: 'con-fri-record',
          recordFriList: recordFriListData
        })
      }).catch(err => {
      })

    }
  }

}
</script>

<style lang="scss" scoped>
  @import '../../assets/sass/_util.scss';

  .strategy{
    @include wh(645,1450);
    @include bg('../../assets/images/app/bg-strategy.png');
    background-position: left bottom;
    margin: rem(80) auto 0;
    // padding-top: rem(47);
    position: relative;
    .tit{
      @include wh(334,133);
      @include bg('../../assets/images/app/tit2.png');
      position: absolute;
      left: 50%;
      transform: translate(-50%,0);
    }
    .content{
      padding-top: rem(130);
      .item{
        width: rem(539);
        background: #fff;
        border-radius: rem(8);
        margin: 0 auto rem(72);
        position: relative;
        padding: rem(25) rem(10) rem(62) rem(20);
        p{
          color: #9b50b7;
          font-size: rem(24);
          line-height: rem(45);
        }
        span{
          color: #fa4b3e;
        }
      }
      .item-flex{
        padding: 0 0 rem(34) 0;
        display: flex;
        align-items: center;
        justify-content: center;
        height: rem(200);
      }
      .btn{
        width: rem(291);
        position: absolute;
        left: 50%;
        transform: translateX(-50%);
        bottom: rem(-35);
        text-align: center;
        color: #7d1ca1;
        font-size: rem(28);
        font-weight: bold;
        padding: rem(20) 0;
        background-image: -webkit-linear-gradient(top,#ffea4a,#f9b625);
        border-radius: rem(40); 
      }
      .btn-gray{
        background-image: -webkit-linear-gradient(top,#c8c3ca,#6e6773);
        color: #fffeff;
        font-weight: normal;
      }
      .icon-finish{
        @include wh(79,78);
        @include bg('../../assets/images/app/icon-finish.png');
        position: absolute;
        right: 0;
        bottom: 0;
      }
    }
  }
</style>


