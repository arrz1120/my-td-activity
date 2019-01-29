<style lang="scss">

  .jxalert-login{
    .alert-con{
      .con-inner{
        .btn-login{
             @include bg('../assets/images/jiaxi/btn-login.png');
             @include wh(472, 124);
             color: #ee103a;
             font-size: rem(38);
             text-align: center;
             line-height: rem(100);
             margin: rem(30) auto 0;
        }
        .con-txt{
          text-align: center;
          font-size: rem(30);
          margin: rem(30) 0;
        }
      }
    }
  }

</style>

<template>
  <section class="jxalert-container jxalert-login"   @touchmove.prevent>
        <div class="alert-bg"></div>
        <div class="alert-con">
            <div class="con-inner">
                  <h3 class="con-tit">请先登录</h3>
                  <p class="con-txt">亲，请先登录后再参与活动哦~</p>
                  <div class="btn-login" @click="goToLogin">前往登录</div>
            </div>
            <div class="con-close" @click="closeAlert"></div>
        </div>
  </section>
</template>

<script>

  import '../assets/sass/jx-alert.scss'
  import {toLogin} from '../js/lib/utils.js'

  export default {

    methods:{
      closeAlert(e){
          this.$emit('onCloseBtnClk',e)
      },
      goToLogin(){
          toLogin()
      }

    }

  }
</script>


