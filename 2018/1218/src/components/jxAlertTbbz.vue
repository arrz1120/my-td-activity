<style lang="scss" scoped>
    .con-inner {
      .con-tit {
        font-size: rem(44);
      }
      .con-txt {
        text-align: center;
        font-size: rem(32);
        line-height: rem(46);
        margin: rem(30) 0;

        .coin {
          color: #f83770;
        }
      }

      .hint {
        color: #f83770;
        text-align: center;
        font-size: rem(30);
        line-height: rem(33);
        padding-bottom: rem(52);
      }
    }
</style>

<template>
  <section class="jxalert-container" :style="popupStyle">
        <div class="alert-bg"></div>
        <div class="alert-con">
            <div class="con-inner">
                  <h3 class="con-tit">您的团币不足！</h3>
                  <div class="con-txt">
                    您的当前的团币为<span class="coin">{{ mycoin }}</span>，<br/>
                      暂时不足以兑换该加息特权！
                  </div>
                  <p class="hint">*每人限兑一次</p>
            </div>
            <div class="con-close" @click="closeAlert"></div>
        </div>
  </section>
</template>

<script>

  export default {
    name: 'jxAlertTbbz',
    props: {
      popupStyle: {
        type: Object
      },
      mycoin: {
        type: [String, Number],
        required: true
      }
    },
    methods: {
      closeAlert () {
        this.$emit('on-cancel')
      }
    }
  }
</script>


