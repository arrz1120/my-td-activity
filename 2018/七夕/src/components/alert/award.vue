<template>
    <div class="alert-tips" @touchmove.prevent>
        <div class="con-award">
            <h2 class="tit">恭喜您获得了<span>{{award.name}}</span></h2>
            <img class="img" :src="award.src" alt="">
            <div 
                class="btn" 
                :name="award.type == 'box1'? '查看奖品_宝箱一': '查看奖品_宝箱二'"
                @click="seeGift">查看奖品</div>
            <div class="close"  @click="close"></div>
        </div>
    </div>
</template>
<script>
import {ToAppTreasureChest} from '../../js/bridge.js'
export default {
  props: ['award'],
  methods: {
      close() {
          this.$emit('showAlertAward',{
              show: false
          })
      },
      seeGift(e) {
          if (this.award.type === 'box1') {
            AddMaiDian('lottery16a',e.target)
          }
          else if (this.award.type === 'box2') {
            AddMaiDian('lottery18a',e.target)
          }
          ToAppTreasureChest(this.award.giftType)
          
          if (window.sessionStorage) {
            sessionStorage.setItem("need-refresh", true);
          }
      }
  }
}
</script>

<style lang="scss">
@import "./alert.scss";
.con-award{
    @include wh(585,523);
    @include bg('../../assets/images/app/alert/con-award.png');
    padding-top: rem(56);
    position: relative;
    .tit{
        color: #7d1ca1;
        font-size: rem(32);
        text-align: center;
        font-weight: bold;
        span{
            color: #fa4b3e;
        }
    }
    .img{
        width: rem(320);
        display: block;
        margin: rem(30) auto;
    }
    .btn{
        text-align: center;
    }
    .close{
        bottom: rem(-80);
    }
}
</style>
