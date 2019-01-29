<style lang="scss">
  .myPrizeModal-container{
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
    .myPrizeModal-shade{
      background: rgba(0,0,0,.75);
      position: absolute;
      z-index: 0;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
    }
    .myPrizeModal-main{
      width: 13.5rem;
      position: relative;
      z-index: 1;
    }
    .myPrizeModal-header{
      @include wh(495,227);
      @include bg('../assets/images/common/05-02.png');
      position: absolute;
      z-index: 0;
      top: -4.5rem;
      left: 1.35rem;
    }
    .myPrizeModal-wrapper{
      background: linear-gradient(to bottom,#ff5b9c,#ff4272);
      border-radius: .45rem;
      position: relative;
      z-index: 1;
      padding: .75rem .5rem ;
      padding-top: 1.35rem;
    }
    .myPrizeModal-1218{
      @include wh(512,158);
      @include bg('../assets/images/common/05-01.png');
      position: absolute;
      z-index: 0;
      top: -2rem;
      left: 1.25rem;
    }
    .myPrizeModal-content{
      background: #ffffff;
      position: relative;
      z-index: 1;
      border-radius: .345rem;
      padding: .5rem;
      padding-bottom: .75rem;
    }
    .myPrizeModal-content-wrapper{
      border: 1px solid #ff5b9c;
      min-height: 5rem;
      border-radius: .15rem;
      overflow: hidden;
    }
    .myPrizeModal-tab{
      display: flex;
      text-align: center;
      font-size: rem(34);
      color: #ffffff;
      background: linear-gradient(to bottom,#ff718d,#ff356b);
      >.item{
        flex: 1;
        padding: 0.35rem 0;
        &.on{
          background: #ffffff;
          color: #ff3767;
          font-weight: bold;

        }
      }
    }
    .myPrizeModal-tab-container{
      font-size: rem(26);
    }
    .myPrizeModal-jx-val{
      font-size: rem(28);
      color: #fe1738;
      text-align: center;
      height: 1.75rem;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .myPrizeModal-jx-records{
      margin: 0 auto;
      height: 9rem;
    }
    .myPrizeModal-record-slide{
      height: auto;
    }
    .myPrizeModal-record-cell{
      width: 10rem;
      margin: 0 auto;
      display: flex;
      align-items: center;
      // justify-content: space-between;
      border-bottom: 1px dashed #bfbfbf;
      padding: 0.375rem 0;
      >.item{
        flex: 1;
        &.n1{
          flex: 3;
        }
        &.n2{
          text-align: center;
          flex: 2;
        }
        &.n3{
          text-align: right;
        }
      }
    }
    .myPrizeModal-prize-records{
      margin: 0 auto;
      height: 10.75rem;
    }
    .myPrizeModal-nodata{
      height: 10.75rem;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
    }
    .myPrizeModal-nodata-img{
      @include wh(244,223);
      @include bg('../assets/images/common/10.png');
    }
    .myPrizeModal-nodata-text{
      font-size: rem(30);
      color: #ff3565;
      margin-top: .75rem;
    }
    .myPrizeModal-nodata-btn{
      @include wh(472,110);
      @include bg('../assets/images/common/06.png');
      font-size: rem(39);
      color: #ee103a;
      text-align: center;
      padding-top: 0.35rem;
      margin-top: 0.75rem;
    }
    .myPrizeModal-jx-scrollbar,.myPrizeModal-prize-scrollbar{
      .swiper-scrollbar-drag{
        background: rgba(255, 88, 125, 0.75);
      }
    }
    .myPrizeModal-close{
      @include wh(66,66);
      @include bg('../assets/images/common/07.png');
      position: relative;
      z-index: 1;
      margin-top: 0.5rem;
    }
  }
</style>

<template>
  <section class="myPrizeModal-container" @touchmove.prevent>
    <div class="myPrizeModal-shade"></div>
    <div class="myPrizeModal-main">
      <div class="myPrizeModal-header"></div>
      <div class="myPrizeModal-wrapper">
        <div class="myPrizeModal-1218"></div>
        <div class="myPrizeModal-content">
          <div class="myPrizeModal-content-wrapper">
            <ul class="myPrizeModal-tab">
              <li 
                class="item"
                :class="{'on':i===tabIdx}"
                @click="onNavItemClk(i)"
                v-for="(item,i) in tabItems"
                :key="i">
                {{item.text}}
              </li>
            </ul>
            <!-- 加息特权 -->
            <div class="myPrizeModal-tab-container" v-show="tabIdx===0">
              <div class="myPrizeModal-jx-container" v-if="jxList.length>0">
                <p class="myPrizeModal-jx-val">我的加息特权：<b>{{jxVal}}%</b></p>
                <div class="myPrizeModal-jx-records swiper-container">
                  <div class="swiper-wrapper">
                    <div class="myPrizeModal-record-slide swiper-slide">
                      <ul 
                        class="myPrizeModal-record-cell"
                        v-for="(item,i) in jxList"
                        :key="i">
                        <li class="item n1">{{item.title}}</li>
                        <li class="item n2">{{item.date}}</li>
                        <li class="item n3">{{item.val}}</li>
                      </ul>
                    </div>
                  </div>
                  <div class="myPrizeModal-jx-scrollbar swiper-scrollbar"></div>
                </div>
              </div>
              <div class="myPrizeModal-nodata" v-if="jxList.length===0">
                <div class="myPrizeModal-nodata-img"></div>
                <p class="myPrizeModal-nodata-text">暂时没有相关数据</p>
                <p class="myPrizeModal-nodata-btn">获取更多加息特权</p>
              </div>
            </div>
            <!-- 加息特权 end -->
            <!-- 我的奖品 -->
            <div class="myPrizeModal-tab-container" v-show="tabIdx===1">
              <div class="myPrizeModal-prize-records swiper-container" v-if="prizeList.length>0">
                <div class="swiper-wrapper">
                  <div class="myPrizeModal-record-slide swiper-slide">
                    <ul 
                      class="myPrizeModal-record-cell"
                      v-for="(item,i) in prizeList"
                      :key="i">
                      <li class="item n1">{{item.title}}</li>
                      <li class="item n2">{{item.desc}}</li>
                      <li class="item n3">{{item.date}}</li>
                    </ul>
                  </div>
                </div>
                <div class="myPrizeModal-prize-scrollbar swiper-scrollbar"></div>
              </div>
              <div class="myPrizeModal-nodata" v-if="prizeList.length===0">
                <div class="myPrizeModal-nodata-img"></div>
                <p class="myPrizeModal-nodata-text">暂时没有相关数据</p>
              </div>
            </div>
            <!-- 我的奖品 end -->
          </div>
        </div>
      </div>
    </div>
    <div class="myPrizeModal-close" @click="onClose"></div>
  </section>
</template>

<script>
  import Swiper from 'swiper'
  import '../assets/sass/swiper-3.4.2.scss'
  export default {
    
    props:['initIdx','jxList','prizeList','jxVal'],

    data(){
      return{
        tabIdx:0,
        tabItems:[
          {text:'加息特权'},
          {text:'我的奖品'}
        ],
        jxSwiper:null,
        prizeSwiper:null,
      }
    },

    methods:{
      initJxSwiper(){
        this.jxSwiper=new Swiper('.myPrizeModal-jx-records',{
          scrollbar: '.myPrizeModal-jx-scrollbar',
          direction: 'vertical',
          slidesPerView: 'auto',
          freeMode: true,
        })
      },
      initPrizeSwiper(){
        this.prizeSwiper=new Swiper('.myPrizeModal-prize-records',{
          scrollbar: '.myPrizeModal-prize-scrollbar',
          direction: 'vertical',
          slidesPerView: 'auto',
          freeMode: true,
        })
      },
      onNavItemClk(idx){
        this.tabIdx=idx
        this.$nextTick(()=>{
          if(this.tabIdx===0){
            if(this.jxSwiper) return
            this.initJxSwiper()
            return
          }
          if(this.tabIdx===1){
            if(this.prizeSwiper) return
            this.initPrizeSwiper()
            return
          }
        })
      },
      onClose(){
        this.$emit('closeCallback')
      }
    },

    mounted(){
      this.tabIdx=this.initIdx
      this.onNavItemClk(this.tabIdx)
    }

  }
</script>