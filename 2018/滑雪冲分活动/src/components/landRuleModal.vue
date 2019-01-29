<style lang="scss">
  .ruleModal-container{
    font-size: rem(22);
    padding: 0 1rem;
    padding-bottom: 1rem;
    .ruleModal-swiper{
      height: 11rem;
      }
    .ruleModal-swiper-slide{
      height: auto;
      }
    .ruleModal-text{
      margin-bottom: .5rem;
      &.n1{
        margin-bottom: 0;
        }
      }
    .ruleModal-tips{
      font-size: rem(18);
      color: #8daee6;
      text-align: center;
      margin-top: 1rem;
      }
    .ruleModal-table{
      border: 1px solid #ddd;
      margin-right: 0.25rem;
      margin-bottom: 0.5rem;
      margin-top: 0.25rem;
      }
    .ruleModal-table-row{
      display: flex;
      align-items: center;
      justify-content: center;
      &:not(:last-child){
        border-bottom: 1px solid #ddd;
        }
      >.item{
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        height: 1rem;
        &.n1{
          flex: 2;
          }
        &:not(:last-child){
          border-right: 1px solid #ddd;
          }
        }
      }
    }
</style>

<template>
  <section class="ruleModal-container">
    <section class="ruleModal-swiper swiper-container">
      <div class="swiper-wrapper">
        <div class="ruleModal-swiper-slide swiper-slide">
          <p class="ruleModal-text">① 通过点击分享链接，可参与游戏助力。未注册团贷网的好友参与助力需注册开通银行存管，方可获得4倍积分；已注册团贷网的好友参与助力可获得1倍积分。好友的该局游戏得分将同时累计到本人和邀请人总积分中，每位用户仅可助力一次；</p>
          <p class="ruleModal-text">② 通过本活动注册的新用户每出借1元便可获得1积分（1个月及以上项目，债权转让除外）；</p>
          <p class="ruleModal-text">③ 积分达30000分后用户即可开启达标抽奖，奖励为现金红包，最高666元；</p>
          <p class="ruleModal-text">④ 积分达100000及以上可额外获冲分大奖，冲分大奖不叠加，按最高级别发放；</p>
          <p class="ruleModal-text n1">⑤ 奖励及对应积分如下：</p>
          <div class="ruleModal-table">
            <div class="ruleModal-table-row">
              <p class="item">奖励</p>
              <p class="item">活动积分</p>
              <p class="item n1">奖品</p>
            </div>
            <div class="ruleModal-table-row">
              <p class="item">冲分奖</p>
              <p class="item">1000000</p>
              <p class="item n1">3888元现金红包</p>
            </div>
            <div class="ruleModal-table-row">
              <p class="item"></p>
              <p class="item">500000</p>
              <p class="item n1">1888元现金红包</p>
            </div>
            <div class="ruleModal-table-row">
              <p class="item"></p>
              <p class="item">300000</p>
              <p class="item n1">888元现金红包</p>
            </div>
            <div class="ruleModal-table-row">
              <p class="item"></p>
              <p class="item">200000</p>
              <p class="item n1">288元现金红包</p>
            </div>
            <div class="ruleModal-table-row">
              <p class="item">冲分奖</p>
              <p class="item">100000</p>
              <p class="item n1">108元现金红包</p>
            </div>
            <div class="ruleModal-table-row">
              <p class="item">达标奖</p>
              <p class="item">30000</p>
              <p class="item n1">最高666元现金红包</p>
            </div>
          </div>
          <p class="ruleModal-text">⑥凡以不正当手段（包括不限于作弊、扰乱系统、实时网络攻击等）参与本次活动的用户，团贷网有权终止其参与资格；</p>
          <p class="ruleModal-text">⑦本活动与邀请有礼第1、2、3、4重礼同享。</p>
        </div>
      </div>
      <div class="ruleModal-swiper-scrollbar swiper-scrollbar"></div>
    </section>
    <ul class="ruleModal-tips">
      <li class="item">本活动及奖品与苹果公司无关，在法律许可</li>
      <li class="item">范畴内，本活动最终解释权归团贷网所有。</li>
    </ul>
  </section>
</template>

<script>
    import Swiper from 'swiper'
    import '../assets/sass/swiper-3.4.2.scss'
    export default {

        mounted(){
            new Swiper('.ruleModal-swiper',{
                scrollbar: '.ruleModal-swiper-scrollbar',
                direction: 'vertical',
                slidesPerView: 'auto',
                freeMode: true,
            })
        }

    }
</script>

