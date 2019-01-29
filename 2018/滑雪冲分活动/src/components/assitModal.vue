<style lang="scss">
  .assitModal-container{
    width: 12rem;
    min-height:rem(360);
    position: relative;
    z-index: 0;
    .assitModal-msg{
      text-align: center;
      font-size: rem(30);
      padding-top: rem(70);
    }
    .assitModal-btn{
      @include wh(450,85);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: rem(34);
      color: #ffffff;
      margin: rem(60) auto 0;
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
  <section class="assitModal-container">
    <ul class="assitModal-msg">
      <li class="item" v-for="(item,idx) in msgs" :key="idx">{{item}}</li>
    </ul>
    <p class="assitModal-btn" name="已助过力_滑雪大作战" @click="onBtnClk">{{btnText}}</p>
  </section>
</template>
<script>
  export default {
    props:['topic','msgs','btnText','btnCallback'],
    methods:{
      onBtnClk(e){
        this.btnCallback&&this.btnCallback(e)
      }
    }
  }
</script>


