<template>
  <popup class="chance-view" title="获取猜数机会方式" @on-close="$emit('on-close')">
    <div class="robe"></div>
    <div class="way">
      <ul>
        <li>
          <section class="wrap">
            <div class="left-wrap">
              <h2 class="tit">方式一</h2>
              <p class="detail">当日登录并分享活动即可获得1次猜数机会，每位用户每日仅限1次。</p>
            </div>
            <div class="right-wrap">
              <div class="share-btn btn" @click="handleShare" name="分享获猜数机会" mtaName="sharetoget_c1"></div>
            </div>
          </section>
        </li>
        <li>
          <section class="wrap">
            <div class="left-wrap">
              <h2 class="tit">方式二</h2>
              <p class="detail">当日出借We、We+自动服务（新手专享服务除外）累计金额每满1万元即可获得1次猜数机会，获得次数无上限。</p>
            </div>
            <div class="right-wrap">
              <div class="borrow-btn btn" @click="handleBorrow" name="出借获猜数机会" mtaName="lendtoget_c2"></div>
            </div>
          </section>
        </li>
      </ul>
    </div>
    <div class="ad">
      <div class="left-wrap">
        <p class="borrow-txt">今日累计出借金额（元）</p>
        <p class="borrow-money">{{ borrowMoney }}<span class="yuan">元</span></p>
      </div>
    </div>
  </popup>
</template>

<script>
import Popup from './popup'
export default {
  components: {
    Popup
  },
  props: {
    borrowMoney: {
      type: null
    }
  },
  methods: {
    handleShare (event) {
      this.$emit('on-share', event)
    },
    handleBorrow (event) {
      this.$emit('on-borrow', event)
    }
  }
}
</script>

<style lang="scss" scoped>
.chance-view {
  /deep/ .popup-con {
    padding-top: rem(66);
    padding-bottom: rem(52);
  }
  /deep/ .con-tit {
    margin-bottom: rem(43) !important;
    &::before {
      content: "";
      display: inline-block;
      background: url('../assets/images/tit-left-icon.png') center top no-repeat;
      background-size: 100%;
      @include wh(103, 25);
      vertical-align: middle;
      margin-right: rem(25);
    }
    &::after {
      content: "";
      display: inline-block;
      background: url('../assets/images/tit-right-icon.png') center top no-repeat;
      background-size: 100%;
      @include wh(103, 25);
      vertical-align: middle;
      margin-left: rem(25);
    }
  }
  .robe {
    @include wh(65, 109);
    @include bg('../assets/images/gou.png');
    position: absolute;
    right: 0;
    top: rem(28);
  }
  .way {
    padding: 0 rem(22);
    li {
      background: linear-gradient(#bd1d21, #e33940);
      padding: rem(4);
      border-radius: rem(10);
      margin-bottom: rem(29);

      .wrap {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
        height: 100%;
        background-color: #bd1d21;
        padding: rem(25) rem(20) rem(30);
        border-radius: inherit;
      }

      .left-wrap {
        text-align: left;
        width: 65%;
      }
      .right-wrap {
        flex: 1;
      }
      .tit {
        font-size: rem(30);
        line-height: rem(42);
        color: #fff;
        font-weight: bold;
      }
      .detail {
        color: #ffe8cd;
        font-size: rem(24);
        line-height: rem(36);
        margin-top: rem(10);
      }
      .share-btn {
        @include wh(225, 81);
        @include bg('../assets/images/share-btn.png');
      }
      .borrow-btn {
        @include wh(225, 81);
        @include bg('../assets/images/borrow-btn.png');
      }
    }
  }
  .ad {
    position: relative;
    @include wh(618, 188);
    @include bg('../assets/images/info-bg2.png');
    color: #752806;
    font-size: rem(24);
    margin: 0 auto;
    .left-wrap {
      position: absolute;
      left: rem(170);
      width: rem(443);
      height: 100%;
      display: flex;
      justify-content: center;
      flex-direction: column; 

      .borrow-txt {
        line-height: rem(40)
      }
      .borrow-money {
        font-size: rem(80);
        color: #e31239;
        font-weight: bold;

        .yuan {
          font-weight: bold;
          font-size: rem(34);
        }
        
      }
    }
  }
}
</style>
