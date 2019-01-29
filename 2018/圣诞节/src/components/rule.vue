<template>
  <section class="popup-wrapper" @touchmove.prevent>
    <div class="mask"></div>
    <div class="popup-rule">
        <p class="rule-tit">活动规则</p>
        <ul>
            <li>1.每位用户每日首次猜数即有机会获得1份惊喜奖品，数量有限，送完即止；</li>
            <li>2.猜数机会当日有效，当日不使用视为放弃；</li>
            <li>3.猜中1次即可获得1份瓜分现金，猜中2次即可获得2份瓜分现金，如此类推；</li>
            <li>4.每日23:59停止当日猜数，开奖数字为每日猜数人次末位数字，于每日24点开奖；</li>
            <li>5.瓜分奖励保留2位小数发放，于开奖后次日发放至团宝箱，逾期不领取视为放弃；</li>
            <li>6.本活动仅限已实名认证用户参与，禁止一切刷奖行为，一经发现，所有奖品不予兑换。</li>
        </ul>
        <div class="close" @click="handleClose"></div>
    </div>
  </section>
</template>

<script>
import '../../src/assets/sass/popup.scss'


export default {
  methods: {
    handleClose (e) {
      this.$emit('on-close', e)
    },
    onBtnClick() {
      this.$emit('onBtnClick')
    }
  }
}
</script>

<style lang="scss" scoped>
    .popup-rule{
        position: relative;
        @include wh(744,1015);
        @include bg('../assets/images/rule-bg.png');
        margin-top: rem(-100);
    }
    .close{
          @include bg('../assets/images/popup-close.png');
          @include wh(70, 70);
          position: absolute;
          left: 50%;
          bottom: rem(-100);
          transform: translateX(-50%);
    }
    .popup-rule{
        padding-top: rem(222);
        .rule-tit{
            color: #a10309;
            font-size: rem(40);
            font-weight: bold;
            text-align: center;
        }
        ul{
            padding: rem(102) rem(102) 0 rem(80);
            li{
                line-height: rem(34);
                color: #9b5b1d;
                font-size: rem(26);
                margin-bottom: rem(32);
                text-align: justify;
            }
        }
    }
</style>
