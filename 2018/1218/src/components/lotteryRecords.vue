<template>
  <section class="record-container">
    <!-- 普惠中奖名单 -->
    <div class="record-junior-contianer" v-show="tabIdx===0">
      <div class="record-title-container">
        <p class="record-title">普惠卡牌 幸运中奖名单</p> 
      </div>
      <div class="record-junior-list record-wrapper" v-if="juniorList.length>0">
        <div 
          class="record-item"
          v-for="(item,i) in juniorList"
          :key="i">
          <img class="record-item-img" :src="item.headImg">
          <dl class="record-item-dl">
            <dt class="dt">{{item.tel}}</dt>
            <dd class="dd">{{item.prize}}</dd>
          </dl>
          <p class="record-item-date">{{item.date}}</p>
        </div>
      </div>
      <div class="record-nodata" v-if="juniorList.length===0">
        <div class="record-nodata-img"></div>
        <p class="record-nodata-text">暂时没有相关中奖数据</p>
      </div>
    </div>
    <!-- 普惠中奖名单 end -->
    <!-- 尊享中奖名单 -->
    <div class="record-senior-contianer" v-show="tabIdx===1">
      <div class="record-title-container">
        <p class="record-title">尊享卡牌 幸运中奖名单</p> 
      </div>
      <div class="record-senior-list record-wrapper" v-if="seniorList.length>0">
        <div 
          class="record-item"
          v-for="(item,i) in seniorList"
          :key="i">
          <img class="record-item-img" :src="item.headImg">
          <dl class="record-item-dl">
            <dt class="dt">{{item.tel}}</dt>
            <dd class="dd">{{item.prize}}</dd>
          </dl>
          <p class="record-item-date">{{item.date}}</p>
        </div>
      </div>
      <div class="record-nodata" v-if="seniorList.length===0">
        <div class="record-nodata-img"></div>
        <p class="record-nodata-text">暂时没有相关中奖数据</p>
      </div>
    </div>
    <!-- 尊享中奖名单 end -->
  </section>
</template>

<script>
  import Slider from '../js/lib/marquee.js'
  export default {
    
    props:['juniorList','seniorList','tabIdx'],

    data(){
      return{
        juniorRecordsSlider:null,
        seniorRecordsSlider:null,
      }
    },
    
    methods:{
      initJuniorRecords(){
        this.juniorRecordsSlider=new Slider('.record-junior-list',{
          showSlides:5
        })
        const imgEls=Array.apply(null,document.querySelectorAll('.record-item-img'))
        imgEls.forEach((item,i)=>{
          item.onerror=()=>{
            item.src=require('../assets/images/lottery/avatar.png')
          }
        })
      },
      initSeniorRecords(){
        this.seniorRecordsSlider=new Slider('.record-senior-list',{
          showSlides:5
        })
        const imgEls=Array.apply(null,document.querySelectorAll('.record-item-img'))
        imgEls.forEach((item,i)=>{
          item.onerror=()=>{
            item.src=require('../assets/images/lottery/avatar.png')
          }
        })
      },
      initRecords(){
        if(this.tabIdx===0){
          if(this.juniorList.length===0) return
          if(this.juniorRecordsSlider) return
          this.initJuniorRecords()
          return
        }
        if(this.tabIdx===1){
          if(this.seniorList.length===0) return
          if(this.seniorRecordsSlider) return
          this.initSeniorRecords()
          return
        }
      },
    },

    watch:{
      tabIdx(){
        this.$nextTick(()=>{
          this.initRecords()
        })
      }
    },

    mounted(){
      this.$nextTick(()=>{
        this.initRecords()
      })
    }

  }
</script>

