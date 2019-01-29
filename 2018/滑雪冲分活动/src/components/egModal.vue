<style lang="scss">
  .ruleModal-container{
    font-size: rem(22);
    padding: 0 1rem;
    padding-bottom: 1rem;
    .ruleModal-swiper{
      height: 8.6rem;
    }
    .ruleModal-swiper-slide{
      height: auto;
    }
    .ruleModal-text{
      margin-bottom: .5rem;
      line-height: rem(32);
      text-align: justify;
      &.n1{
        margin-bottom: 0;
      }
    }
    .ruleModal-title{
      font-size: rem(26);
      text-align: center;
      padding: 0 0 rem(20);
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
          <p class="ruleModal-title">举个栗子：</p>
          <p class="ruleModal-text">小派邀好友助力玩滑雪游戏，好友A玩游戏得了1000分，并注册出借了20000元；好友B玩游戏得了900分，并先注册出借了10000元，后出借了20000元，则小派获得多少积分？</p>
          <p class="ruleModal-text">好友A=1000*4+5000=9000；</p>
          <p class="ruleModal-text">好友B=900*4+5000+30000=38600;</p>
          <p class="ruleModal-text">小派好友助力获得积分=47600</p>
          <p class="ruleModal-text">注：每位好友出借达标3万，就能获得3.5万积分</p>
        </div>
      </div>
      <div class="ruleModal-swiper-scrollbar swiper-scrollbar"></div>
    </section>
    <ul class="ruleModal-tips">
      <li class="item">本活动与苹果公司无关，在法律许可</li>
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

