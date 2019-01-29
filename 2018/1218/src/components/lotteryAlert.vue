<style lang="scss">
  .lotteryAlert-container{
    position: fixed;
    z-index: 10;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    transform: translateZ(1px);
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    .lotteryAlert-shade{
      background: rgba(0,0,0,.75);
      position: absolute;
      z-index: 0;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
    }
    .lotteryAlert-main{
      width: 13.5rem;
      position: relative;
      z-index: 1;
    }
    .lotteryAlert-header{
      @include wh(495,227);
      @include bg('../assets/images/common/05-02.png');
      position: absolute;
      z-index: 0;
      top: -4.5rem;
      left: 1.35rem;
    }
    .lotteryAlert-wrapper{
      background: linear-gradient(to bottom,#ff5b9c,#ff4272);
      border-radius: .45rem;
      position: relative;
      z-index: 1;
      padding: .75rem .5rem ;
      padding-top: 1.35rem;
    }
    .lotteryAlert-1218{
      @include wh(512,158);
      @include bg('../assets/images/common/05-01.png');
      position: absolute;
      z-index: 0;
      top: -2rem;
      left: 1.25rem;
    }
    .lotteryAlert-content{
      background: #ffffff;
      position: relative;
      z-index: 1;
      min-height: 5rem;
      border-radius: .345rem;
      padding: 1.25rem;
      padding-bottom: 1rem;
    }
    .lotteryAlert-title{
      color: #ff4172;
      font-size: rem(36);
      text-align: center;
    }
    .lotteryAlert-msg{
      font-size: rem(26);
      color: #575757;
      margin-top: 1rem;
      line-height: 1.5;
    }
    .lotteryAlert-btn{
      @include wh(472,110);
      @include bg('../assets/images/common/06.png');
      margin: 0 auto;
      margin-top: 1rem;
      font-size: rem(39);
      color: #ee103a;
      text-align: center;
      padding-top: 0.5rem;
    }
    .lotteryAlert-close{
      @include wh(66,66);
      @include bg('../assets/images/common/07.png');
      position: relative;
      z-index: 1;
      margin-top: 0.5rem;
    }
  }
</style>

<template>
  <section class="lotteryAlert-container">
    <div class="lotteryAlert-shade"></div>
    <div class="lotteryAlert-main">
      <div class="lotteryAlert-header"></div>
      <div class="lotteryAlert-wrapper">
        <div class="lotteryAlert-1218"></div>
        <div class="lotteryAlert-content">
          <ul class="lotteryAlert-title" v-if="title">
            <li 
              class="item"
              v-for="(item,i) in title"
              :key="i">
              {{item}}
            </li>
          </ul>
          <p 
            class="lotteryAlert-msg" 
            :style="{textAlign:msg.length<17?'center':''}"
            v-if="msg">
            {{msg}}
          </p>
          <p 
            class="lotteryAlert-btn" 
            v-if="btnText"
            @click="onBtnClk">
            {{btnText}}
          </p>
        </div>
      </div>
    </div>
    <div class="lotteryAlert-close" :name="trackName" @click="onCloseClk"></div>
  </section>
</template>

<script>
  export default {
    
    props:['title','msg','btnText','trackName'],

    methods:{
      onBtnClk(e){
        this.btnText&&this.$emit('btnCallback',e)
      },
      onCloseClk(){
        this.$emit('closeCallback')
      }
    }
  }
</script>
