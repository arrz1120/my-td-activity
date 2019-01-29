<style lang="scss">
    .jxalert-over{
      .alert-con{
        .con-inner{
          padding-bottom: rem(20);
          .con-txt{
            font-size: rem(26);
            margin: rem(30) rem(50);
            line-height: rem(36);
          }
        }
      }
    }



</style>

<template>
  <section class="jxalert-container jxalert-over"   @touchmove.prevent>
        <div class="alert-bg"></div>
        <div class="alert-con">
            <div class="con-inner">
                  <h3 class="con-tit" v-html="topic"></h3>
                  <p class="con-txt" v-html="txt"></p>
            </div>
            <div class="con-close" @click="closeAlert"></div>
        </div>
  </section>
</template>

<script>

  import '../assets/sass/jx-alert.scss'

  export default {
    props:['topic','txt'],
    methods:{
      closeAlert(e){
          this.$emit('onCloseBtnClk',e)
      }
    }

  }
</script>


