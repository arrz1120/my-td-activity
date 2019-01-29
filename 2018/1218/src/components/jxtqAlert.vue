<style lang="scss">

  .jxtq-container{
      .jxtq{
          z-index: 2;
      }
      .jxtq-p{
          font-size: 1rem;
          color: #fff;
          text-align: center;
          line-height: rem(90);
          span{
              color: #ffd341;
          }
      }
      .jxtq-img{
          @include bg('../assets/images/common/jxtq.png');
          @include wh(663,605);
          font-size: rem(168);
          text-align: right;
          padding-right: rem(300);
          padding-top: rem(210);
          color: #fff;
          margin-top: rem(-120);
      }
      .close{
          @include bg('../assets/images/rank/alert-close.png');
          @include wh(70, 70);
          margin: rem(-130) auto 0;
      }
  }

</style>

<template>
  <section class="jxalert-container jxtq-container">
        <div class="alert-bg"></div>
        <div class="jxtq">
            <p class="jxtq-p">恭喜您获得<br /><span>{{number}}%</span>的福利加息特权</p>
            <div class="jxtq-img">{{number}}</div>
            <div class="close" @click="closeAlert"></div>
        </div>
  </section>
</template>

<script>

  import '../assets/sass/jx-alert.scss'

  export default {
    props:['number'],
    methods:{
      closeAlert(e){
          this.$emit('onCloseBtnClk',e)
      }
    }

  }
</script>


