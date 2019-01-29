<style lang="scss">
  .scoreModal-container{
    width: 12rem;
    min-height: 10.5rem;
    position: relative;
    z-index: 0;
    .scoreModal-msg{
      text-align: center;
      font-size: rem(30);
      color: #333333;
      span{
        font-size: rem(40);
        display: block;
        }
    }
    .scoreModal-prize{
      @include wh(188,177);
      @include bg('../assets/images/modal/05-01.png');
      margin: 0 auto;
      margin-top: .75rem;
      text-align: center;
      color: #ffffff;
      font-size: rem(22);
      padding-top: 1rem;
    }
    .scoreModal-prize-val{
      font-size: rem(58);
      line-height: 1;
      font-weight: bold;
    }
    .scoreModal-btn{
      @include wh(450,85);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: rem(34);
      color: #ffffff;
      margin: 0 auto;
      margin-top: 1rem;
      background: linear-gradient(to bottom,#ffb83d,#ff8f1e);
      border-radius: .25rem;
    }
    .ck-btn{
      text-align: center;
      .ck{
        display: inline-block;
        font-size: rem(28);
        color: #cb2d2d;
        text-decoration: underline;
        margin: rem(30) auto;
        }
      }

  }
</style>

<template>
  <section class="scoreModal-container">
    <div class="scoreModal-msg">
      <p class="item">恭喜本次获得<span>{{point}}积分</span></p>
    </div>
    <div class="scoreModal-prize">
      <p class="scoreModal-prize-val">{{prizeVal}}</p>
      <p class="scoreModal-prize-type">团币</p>
    </div>
    <p class="scoreModal-btn" @click="toHomeBtnClk">{{btnText}}</p>
    <div class="ck-btn">
      <span class="ck" name="助力弹窗_滑雪大作战" @click="toTBXModalBtnClk">查看奖品</span>
    </div>
  </section>
</template>

<script>
  export default {
    props:['topic','point','btnText','toHomeBtnClk','toTBXModalBtnClk','prizeVal'],
  }
</script>




