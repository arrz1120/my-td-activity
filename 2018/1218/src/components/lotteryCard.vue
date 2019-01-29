<template>
  <section class="lotteryCard-container">
    <div class="lotteryCard-finger" v-if="showFinger"></div>
    <div class="lotteryCard-grid" v-if="showGridPrize">
      <div 
        class="lotteryCard-item" 
        v-for="(item,i) in transferPrizeList"
        :style="{
          left:`${item.x}px`,
          top:`${item.y}px`,
          animation:transferPrizeList[i].animation
          }"
        @webkitAnimationEnd="onCardShuffled(i)"
        @click="onCardClk(i)"
        :key="i">

        <div 
          class="lotteryCard-item-front" 
          :class="{
            'scale-hide':cardStatus==='behind',
            'scale-show':cardStatus==='front',
          }"
          :style="{backgroundImage:`url(${item.src})`}"
          v-if=!item.text>
        </div>

        <div 
          class="lotteryCard-item-front" 
          :class="{
            'n1':cardType==='junior',
            'n2':cardType==='senior',
            'scale-hide':cardStatus==='behind',
            'scale-show':cardStatus==='front',
          }"
          v-if="item.text">
          <img :src="item.src" class="lotteryCard-item-img">
          <p class="lotteryCard-item-name text-nowrap">{{item.text}}</p>
        </div>

        <div 
          class="lotteryCard-item-behind" 
          :class="{
            'n1':cardType==='junior',
            'n2':cardType==='senior',
            'scale-hide':cardStatus==='front',
            'scale-show':cardStatus==='behind',
          }">
        </div>

      </div>
    </div>
    <div 
      class="lotteryCard-bingo-container"
      :class="{'n1':cardType==='junior','n2':cardType==='senior','show':showBingoPrize}">
      <img :src="bingoPrize.src" class="lotteryCard-bingo-img">
      <p class="lotteryCard-bingo-name text-nowrap">{{bingoPrize.text}}</p>
    </div>
  </section>
</template>

<script>
  import '../assets/sass/lotteryCard.scss'
  import {rem} from '../js/lib/utils.js'
  export default {

    props:['prizeList','cardType',"bingoPrize"],

    data(){
      return{
        cardStatus:'front',
        lotteryStatus:'init',
        selectIdx:null,
        transferPrizeList:[],
        showBingoPrize:false,
        showGridPrize:true,
        showFinger:false,
      }
    },

    methods:{
      onCardClk(idx){
        if(this.lotteryStatus==='init') return
        if(this.lotteryStatus==='shuffling') return
        this.$emit('onCardClk',{
          cardIdx:idx
        })
      },
      showBingoAnimate(idx){
        this.showFinger=false
        this.transferPrizeList.forEach((item,i,ctx)=>{
          if(i!==idx){
            ctx[i].animation='lotteryCardScaleHide .35s 0s ease-out forwards'
            return
          }
          if(i===4) return
           ctx[i].animation=`lotteryCardSelected${i+1} .5s 0s linear forwards`
        })
        this.lotteryStatus='shuffled'
        setTimeout(()=>{
          this.cardStatus='front'
          setTimeout(()=>{
            this.showBingoPrize=true
            this.showGridPrize=false
          },500)
        },1000)

      },
      onCardShuffled(idx){
        if(this.lotteryStatus==='shuffled') return
        // this.showFinger=true
        this.lotteryStatus='shuffled'
      },
      onPlay(){
        this.cardStatus='behind'
        this.showFinger=true
        setTimeout(()=>{
          this.transferPrizeList.forEach((item,i,ctx)=>{
            ctx[i].src=this.bingoPrize.src
            ctx[i].text=this.bingoPrize.text
            ctx[i].animation=`shuffle${i+1} 1.5s ${i*.05}s linear forwards`
          })
          this.lotteryStatus='shuffling'
        },750)
      }
    },

    created(){
      this.transferPrizeList=this.prizeList.map((item,i)=>{
        return{
          src:item.src,
          text:item.text,
          x:item.x,
          y:item.y,
          idx:i,
          animation:`none`,
        }
      })
    },

  }
</script>

