<style lang="scss">
  .userPrizeModal-container{
    margin-top: -.75rem;
    padding: 0 1rem;
    .userPrizeModal-none{
      height: 12rem;
      color: #9aa4ad;
      font-size: rem(24);
      text-align: center;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
    }
    .userPrizeModal-none-img{
      @include wh(224,177);
      @include bg('../assets/images/index/06.png');
      margin-bottom: .5rem;
    }
    .userPrizeModal-swiper{
      height: 12rem;
      font-size: rem(22);
    }
    .userPrizeModal-swiper-slide{
      height: auto;
    }
    .userPrizeModal-list{
      display: flex;
      align-items: center;
      justify-content: space-between;
      border-bottom: 1px dashed #d3d3d3;
      height: 2rem;
      >.item{
        // flex: 1;
      }
    }
    .userPrizeModal-btn{
      font-size: rem(22);
      color: #ffffff;
      background: linear-gradient(to bottom,#ffb83d,#ff8f1e);
      padding: 0.35rem .75rem;
      border-radius: .25rem;
    }
  }
</style>

<template>
  <section class="userPrizeModal-container">
    <section class="userPrizeModal-none" v-if="prizeItems.length===0">
      <div class="userPrizeModal-none-img"></div>
      <p class="userPrizeModal-none-text">空空如也~</p>
    </section>
    <section class="userPrizeModal-swiper swiper-container" v-if="prizeItems.length>0">
      <div class="swiper-wrapper">
        <div class="userPrizeModal-swiper-slide swiper-slide">
          <div 
            class="userPrizeModal-list" 
            v-for="(item,idx) in prizeItems" 
            :key="idx">
            <p class="item">{{item.date}}</p>
            <p class="item">{{item.prizeName}}</p>
            <p class="item userPrizeModal-btn" name="我的奖励弹窗_去查看" @click="onBtnClk(item.prizeType,item.status,$event)">去查看</p>
          </div>
        </div>
      </div>
      <div class="userPrizeModal-swiper-scrollbar swiper-scrollbar"></div>
    </section>
  </section>
</template>

<script>
  import Swiper from 'swiper'
  import '../assets/sass/swiper-3.4.2.scss'
  import {
    toTBX,
    toTB,
  } from '../js/lib/utils.js'
  export default {
    
    props:['prizeItems'],

    methods:{
      onBtnClk(prizeType,prizeStatus,{target}){
        try {
          sa.quick('trackHeatMap',target)
        } catch (error) {}
        if(prizeType===3){
          toTB()
          return
        }
        toTBX()
      }
    },

    mounted(){
      new Swiper('.userPrizeModal-swiper',{
        scrollbar: '.userPrizeModal-swiper-scrollbar',
        direction: 'vertical',
        slidesPerView: 'auto',
        freeMode: true,
      })
    }

  }
</script>

