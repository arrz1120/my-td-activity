<style lang="scss">
  .rankingModal-container{
    width: 12rem;
    min-height: rem(580);
    position: relative;
    z-index: 0;
    .rankingModal-msg{
      text-align: center;
      font-size: rem(30);
    }
    .rankingModal-prize{
      @include wh(191,236);
      @include bg('../assets/images/ranking/rp.png');
      margin: 0 auto;
      margin-top: .75rem;
      text-align: center;
      color: #ffffff;
      font-size: rem(22);
      padding-top: 2.5rem;
    }
    .rankingModal-prize-val{
      font-size: rem(58);
      line-height: 1;
      font-weight: bold;
      span{
        font-size: rem(24);
        }
    }
    .rankingModal-prize-type{
      font-size: rem(24);
      }
    .rankingModal-btn{
      @include wh(450,85);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: rem(34);
      color: #ffffff;
      margin: rem(34) auto 0;
      background: linear-gradient(to bottom,#ffb83d,#ff8f1e);
      border-radius: .25rem;
    }
  }
  .txt{
    font-size: rem(20);
    color: #cb2d2d;
    text-align: center;
    padding: rem(54) 0 0;
    }
</style>

<template>
  <section class="rankingModal-container">
    <ul class="rankingModal-msg">
      <li class="item" v-for="(item,idx) in msgs" :key="idx">{{item}}</li>
    </ul>
    <div class="rankingModal-prize">
      <p class="rankingModal-prize-val">{{prizeVal}}<span>元</span></p>
      <p class="rankingModal-prize-type">现金红包</p>
    </div>
    <p class="txt" v-if="punchStatus===1">奖品于活动结束后5个工作日内发放到团宝箱</p>
    <p class="txt" v-else>现金红包有效期7天，请及时领取！</p>
    <p class="rankingModal-btn" name="获奖弹窗_领取奖品/我知道了" @click=ikwonModalBtnClk v-if="punchStatus===1" >{{btnTextA}}</p>
    <p class="rankingModal-btn" name="获奖弹窗_领取奖品/我知道了" @click=toGetModalBtnClk v-else>{{btnTextB}}</p>
  </section>
</template>
<script>
  export default {
    props:['topic','msgs','btnTextA','btnTextB','ikwonModalBtnClk','toGetModalBtnClk','prizeVal','punchStatus'],
  }
</script>


