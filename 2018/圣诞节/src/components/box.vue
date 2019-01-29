<template>
  <section class="popup-wrapper" @touchmove.prevent>
    <div class="mask"></div>
    <div class="popup-box">
        <div class="pop-snow-container">
            <div class="pop-snow snow-move"></div>
            <div class="pop-snow snow-move"></div>
        </div>
        <div class="box-wrapper">
            <div class="platform platform-move"></div>
            <div class="light light-move"></div>
            <div v-if="!boxOpen" class="box light-move" @click="openBox"></div>
            <div v-else class="box-open fadeIn"></div>
        </div>
    </div>
  </section>
</template>

<script>
import '../../src/assets/sass/popup.scss'


export default {
  data(){
      return {
          boxOpen: false
      }
  },
  methods: {
      openBox(e){
          e.target.className = 'box animated tada'
          setTimeout(()=>{
            this.boxOpen = true
            setTimeout(()=>{
                this.$emit('boxOpen')
            },1000)
          },1000)
      }
  }
}
</script>

<style lang="scss" scoped>
    .popup-box{
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0;
        left: 0;
        @include flexCenter;
        padding-top: rem(200);
    }
    .pop-snow-container{
        width: 100%;
        height: 100%;
        position: absolute;
        top: 0;
        left: 0;
        overflow: hidden;
        .pop-snow{
            @include wh(750,1192);
            @include bg('../assets/images/snow.png');
        }
    }
    .box-wrapper{
        @include wh(666,163);
            position: relative;
        .platform{
            @include wh(666,163);
            @include bg('../assets/images/box-platform.png');
            position: absolute;
            top: 0;
            left: 0;
        }
        .light{
            @include wh(719,247);
            @include bg('../assets/images/box-light.png');
            position: absolute;
            left: rem(-30);
            top: rem(-116);
        }  
        .box{
            @include wh(486,468);
            @include bg('../assets/images/box.png');
            position: absolute;
            left: rem(90);
            top: rem(-314);
        } 
        .box-open{
            @include wh(549,562);
            @include bg('../assets/images/box-open.png');
            position: absolute;
            left: rem(80);
            top: rem(-410);
        } 
    }
</style>
