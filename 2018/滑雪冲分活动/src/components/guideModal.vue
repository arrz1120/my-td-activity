<style lang="scss">
  .guideModal-container{
    @include wh(570,708);
    @include bg('../assets/images/modal/05.jpg');
    overflow: hidden;
    margin-top: -1.75rem;
    padding-top: 1.25rem;
    position: relative;
    z-index: 0;
    .guideModal-tips{
      font-size: rem(20);
      text-align: center;
      color: #d63434;
    }
    .guideModal-pai-container{
      position: absolute;
      z-index: 1;
      top: 2rem;
      left: 4.5rem;
      animation: guideModalPai 2s linear infinite;
    }
    .guideModal-pai{
      @include wh(132,182);
      @include bg('../assets/images/game/06.png');
      position: relative;
      z-index: 1;
    }
    .guideModal-pai-path{
      @include wh(132,230);
      @include bg('../assets/images/game/10.png');
      position: absolute;
      z-index: 0;
      top: -.75rem;
      left: 0;
    }
    .guideModal-star{
      @include wh(61,79);
      @include bg('../assets/images/game/09-01.png');
      position: absolute;
      top: 7rem;
      left: 2.5rem;
      animation: guideModalStar 2s linear infinite;
    }
    .guideModal-box{
      @include wh(70,82);
      @include bg('../assets/images/game/09-02.png');
      position: absolute;
      top: 12rem;
      right: 2.5rem;
      animation: guideModalBox 2s linear infinite;
    }
    .guideModal-bomb{
      @include wh(68,79);
      @include bg('../assets/images/game/09-04.png');
      position: absolute;
      left: 4.5rem;
      top: 10rem;
    }
    .guideModal-finger{
      @include wh(163,185);
      @include bg('../assets/images/modal/03.png');
      position: absolute;
      z-index: 3;
      top: 4rem;
      right: 1rem;
      opacity: 0;
      animation: guideModalFinger 2s linear infinite;
    }
    .guideModal-arrow{
      position: absolute;
      z-index: 2;
      right: 2.5rem;
      top: 4rem;
      @include wh(155,43);
      opacity: 0;
      &.left{
        @include bg('../assets/images/modal/04-01.png');
        animation: guideModalArrowLeft 2s linear infinite;
      }
      &.right{
        @include bg('../assets/images/modal/04-02.png');
        animation: guideModalArrowRight 2s linear infinite;
      }
    }
        .guideModal-score-container{
      text-align: center;
      color: #ffe201;
      font-size: 0;
      margin-bottom: 0.25rem;
    }
    .guideModal-score{
      display: inline-block;
      vertical-align: middle;
      &:not(:last-child){
        margin-right: 0.5rem;
      }
    }
    .guideModal-score-icon{
      @include wh(80*.5,60*.5);
      display: inline-block;
      vertical-align: middle;
      &.n1{
        @include bg('../assets/images/game/11-01.png');
      }
      &.n2{
        @include bg('../assets/images/game/11-02.png');
      }
      &.n3{
        @include bg('../assets/images/game/11-04.png');
      }
      &.n4{
        @include bg('../assets/images/game/11-03.png');
      }
    }
    .guideModal-score-text{
      display: inline-block;
      vertical-align: middle;
      font-size: rem(26);
      margin-left: 0.15rem;
      &.bomb{
        color: #e62626;
      }
    }
  }
</style>

<template>
  <section class="guideModal-container">
    <div class="guideModal-score-container">
      <div class="guideModal-score">
        <div class="guideModal-score-icon n1"></div>
        <p class="guideModal-score-text">10</p>
      </div>
      <div class="guideModal-score">
        <div class="guideModal-score-icon n2"></div>
        <p class="guideModal-score-text">20</p>
      </div>
      <div class="guideModal-score">
        <div class="guideModal-score-icon n3"></div>
        <p class="guideModal-score-text">50</p>
      </div>
      <div class="guideModal-score">
        <div class="guideModal-score-icon n4"></div>
        <p class="guideModal-score-text bomb">-50</p>
      </div>
    </div>
    <p class="guideModal-tips">（每局30秒，结束后可抽团币）</p>
    <div class="guideModal-pai-container">
      <div class="guideModal-pai"></div>
      <div class="guideModal-pai-path"></div>
    </div>
    <div class="guideModal-finger"></div>
    <i class="guideModal-arrow left"></i>
    <i class="guideModal-arrow right"></i>
    <i class="guideModal-star"></i>
    <i class="guideModal-box"></i>
    <i class="guideModal-bomb"></i>
  </section>
</template>

<script>
  import '../assets/sass/animation.scss'
  export default {
    
  }
</script>


