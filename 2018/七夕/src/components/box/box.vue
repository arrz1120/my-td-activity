<template>
  <div class="box">
    <div class="tit"></div>
    <div class="content">
      <div class="box-row">
        <div class="item">
          <img
              v-if="state.userDrawPrizeList && state.userDrawPrizeList[0].boxStatus===3"
              name="宝箱一"
              :src="getPrizeSrc1(state && state.userDrawPrizeList[0].prizeName)"
              @click="open1"
              alt="">
          <img
            v-else
            name="宝箱一"
            :class="['animated',{swing: state.userDrawPrizeList && state.userDrawPrizeList[0].boxStatus == 2}]"
            src="../../assets/images/app/box1.png"
            @click="open1">
            <p
              v-if="state.userDrawPrizeList && state.userDrawPrizeList[0].boxStatus===3">
              恭喜你获得<br>
              <span 
                class="fb"
                v-html="state.userDrawPrizeList[0].prizeName">
              </span>
            </p>
            <p
              v-else>
              累计召唤<span>3</span>只喜鹊<br>可开宝箱
            </p>
        </div>
        <div class="item">
          <img
            v-if="state.userDrawPrizeList && state.userDrawPrizeList[1].boxStatus===3"
            name="宝箱二"
            :src="getPrizeSrc2(state.userDrawPrizeList && state.userDrawPrizeList[1].prizeName)"
            @click="open2"
            alt="">
          <img
            v-else
            name="宝箱二"
            :class="['animated',{swing: state.userDrawPrizeList && state.userDrawPrizeList[1].boxStatus == 2}]"
            src="../../assets/images/app/box2.png"
            @click="open2">
            <p
              v-if="state.userDrawPrizeList && state.userDrawPrizeList[1].boxStatus===3">
              恭喜你获得<br>
              <span
                class="fb"
                v-html="state.userDrawPrizeList[1].prizeName"
              ></span>
            </p>
            <p
              v-else>
              累计召唤<span>6</span>只喜鹊可开宝箱<br>
              <span>（有机会获得iPhone X）</span>
            </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {getLuckTreasurePrize} from '../../api/api.js'
import '../../js/toast.js'

const df1 = 'CHINAVALENTINEDAY2018_TREAS1_DRAW_FLAG'
const df2 = 'CHINAVALENTINEDAY2018_TREAS2_DRAW_FLAG'

export default {
 props: ['state'],
 data() {
   return {
     giftType1: '',
     giftType2: 'hb',
   }
 },
 methods: {
   beforeOpen() {
      let {activityTimeStauts, logined} = this.state
      if (activityTimeStauts === 0 || activityTimeStauts === 2) {
        this.$emit('showAlertTips',{
          type: 'con-1'
        })
        return false
      }
      if (!logined) {
        this.$emit('showAlertTips',{
          type: 'con-2'
        })
        return false
      }
      return true
   },
   open1(e){
      AddMaiDian('box3a',e.target)
      if (!this.beforeOpen()) {
        return
      }
      if(this.state.xiQueTotalCount < 3) {
          this.$emit('showAlertTips',{
            type: 'con-6',
            boxType: 3
          })
          return
        }
      if (this.state.userDrawPrizeList[0].boxStatus === 3) {
        let prizeSrc = this.getPrizeSrc1(this.state.userDrawPrizeList[0].prizeName)
        this.$emit('showAlertAward',{
            show: true,
            name: this.state.userDrawPrizeList[0].prizeName,
            src: prizeSrc,
            type: 'box1',
            giftType: this.giftType1
        })
      } else {
        if(this.state.userDrawPrizeList[0].boxStatus!==2){
          return
        }
        getLuckTreasurePrize(df1)
        .then((res) => {
            if (res.code === 'SUCCESS') {
              let prizeSrc = this.getPrizeSrc1(res.data.prizeName)
              this.$emit('showAlertAward',{
                show: true,
                name: res.data.prizeName,
                src: prizeSrc,
                giftType: this.giftType1,
                type: 'box1'
              })
              this.$emit('showPrize',{
                boxType: 0,
                prizeName: res.data.prizeName,
                giftType: this.giftType1
              })
            }
            else if(res.code === 'WINED_PRIZE'){
              toast.show(res.message,2000,function(){
                window.location.reload()
              })
            }
            else if(res.code === 'TICKET_NOT_ENOUGH'){
              toast.show(res.message)
            }
            else if(res.code === 'FAIL'){
              toast.show(res.message)
            }
          })
        .catch((err) => {
          console.log(err)
        })
      }

   },
   open2(e){
      AddMaiDian('box4a',e.target)

      if (!this.beforeOpen()) {
        return
      }
      if(this.state.xiQueTotalCount < 6) {
          this.$emit('showAlertTips',{
            type: 'con-6',
            boxType: 6
            })
          return
        }
      if (this.state.userDrawPrizeList[1].boxStatus === 3) {
        let prizeSrc = this.getPrizeSrc2(this.state.userDrawPrizeList[1].prizeName)
        this.$emit('showAlertAward',{
            show: true,
            name: this.state.userDrawPrizeList[1].prizeName,
            src: prizeSrc,
            type: 'box2',
            giftType: this.giftType2
        })
      } else{
        if(this.state.userDrawPrizeList[1].boxStatus!==2){
          return
        }
        getLuckTreasurePrize(df2)
          .then((res) => {
            if (res.code === 'SUCCESS') { 
              let prizeSrc = this.getPrizeSrc2(res.data.prizeName)
              this.$emit('showAlertAward',{
                show: true,
                name: res.data.prizeName,
                src: prizeSrc,
                giftType: this.giftType2,
                type: 'box2'
              })
              this.$emit('showPrize',{
                boxType: 1,
                prizeName: res.data.prizeName,
                giftType: this.giftType2
              })
            } 
            else if(res.code === 'WINED_PRIZE'){
              toast.show(res.message,2000,function(){
                window.location.reload()
              })
            }
            else if(res.code === 'TICKET_NOT_ENOUGH'){
              toast.show(res.message)
            }
            else if(res.code === 'FAIL'){
              toast.show(res.message)
            }
          })
          .catch((err) => {
            console.log(err)
        })
      }

   },
   getPrizeSrc1(name) {
     let src = ''
     switch (name) {
       case '10元投资红包':
         src = require('../../assets/images/app/gift1/hb10.png')
         break;
       case '5元投资红包':
         src = require('../../assets/images/app/gift1/hb5.png')
         break;
       case '58团币':
         src = require('../../assets/images/app/gift1/tb58.png')
         this.giftType1 = 'tb'
         break;
       case '28团币':
         src = require('../../assets/images/app/gift1/tb28.png')
         this.giftType1 = 'tb'
         break;
       case '18团币':
         src = require('../../assets/images/app/gift1/tb18.png')
         this.giftType1 = 'tb'
         break;

       default:
         break;
     }
     return src
   },
   getPrizeSrc2(name) {
     let src = ''
     switch (name) {
       case 'iPhone X':
         src = require('../../assets/images/app/gift2/iphone.png')
         break;
       case '88元现金红包':
         src = require('../../assets/images/app/gift2/hb88.png')
         break;
       case '20元投资红包':
         src = require('../../assets/images/app/gift2/hb20.png')
         break;
       case '10元投资红包':
         src = require('../../assets/images/app/gift2/hb10.png')
         break;
       case '5元投资红包':
         src = require('../../assets/images/app/gift2/hb5.png')
         break;
       case '0.8元现金红包':
         src = require('../../assets/images/app/gift2/hb08.png')
         break;
       case '0.5元现金红包':
         src = require('../../assets/images/app/gift2/hb05.png')
         break;
       case '0.3元现金红包':
         src = require('../../assets/images/app/gift2/hb03.png')
         break;
       default:
         break;
     }
     return src
   }
 }
}
</script>

<style lang="scss" scoped>
  @import '../../assets/sass/_util.scss';

  .box{
    @include wh(645,489);
    @include bg('../../assets/images/app/bg-box.png');
    margin: rem(30) auto 0;
    position: relative;
    .tit{
      @include wh(334,133);
      @include bg('../../assets/images/app/tit1.png');
      position: absolute;
      left: 50%;
      transform: translate(-50%,rem(-46));
    }
  }

  .content{
    padding: rem(117) rem(16) 0 rem(16);
    .box-row{
      display: flex;
      .item:nth-child(1){
        width: rem(280);
      }
      .item:nth-child(2){
        flex: 1;
      }
      .item{
        // flex: 1;
        img{
          width: rem(257);
          height: rem(195);
          display: block;
          margin: 0 auto;
        }
        p{
          text-align: center;
          margin-top: rem(21);
          line-height: rem(36);
          font-size: rem(24);
          color: #7d1ca1;
          span{
            color: #fa4b3e;
            margin: 0 rem(5);
          }
          .fb{
            font-weight: bold;
          }
        }
      }
    }
  }

  .animated {
    animation-duration: 1s;
    animation-fill-mode: both
  }
  .swing {
    transform-origin: center center;
    animation-name: swing;
    animation-iteration-count: infinite;
}

  @keyframes swing {
    10% {
        transform: rotate(5deg)
    }
    20% {
        transform: rotate(-10deg)
    }
    30% {
        transform: rotate(5deg)
    }
    40% {
        transform: rotate(-5deg)
    }
    50% {
        transform: rotate(0deg)
    }
}
</style>
