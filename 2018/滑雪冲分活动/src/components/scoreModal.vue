<style lang="scss">
  .scoreModal-container{
    width: 12rem;
    min-height: 10rem;
    position: relative;
    z-index: 0;
    .scoreModal-msg{
      text-align: center;
      font-size: rem(30);
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
  }
</style>

<template>
  <section class="scoreModal-container">
    <ul class="scoreModal-msg">
      <li class="item" v-for="(item,idx) in msgs" :key="idx">{{item}}</li>
    </ul>
    <div class="scoreModal-prize">
      <p class="scoreModal-prize-val">{{prizeVal}}</p>
      <p class="scoreModal-prize-type">团币</p>
    </div>
    <p class="scoreModal-btn" :name="trackName" @click=onBtnClk>{{btnText}}</p>
  </section>
</template>

<script>
  export default {
    
    props:['topic','msgs','btnText','btnCallback','prizeVal','trackName'],

    methods:{
      onBtnClk(e){
        this.btnCallback&&this.btnCallback(e)
      }
    }

  }
</script>


