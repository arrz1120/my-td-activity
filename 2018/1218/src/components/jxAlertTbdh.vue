<style lang="scss" scoped>
    .con-inner {
      .con-tit {
        font-size: rem(44);
      }
      .con-txt {
        text-align: center;
        font-size: rem(30);
        margin: rem(30) 0;
        color: #f83770;
        display: flex;
        align-items: center;
        justify-content: center;
        .info {
          display: inline-block;
          p {
            text-align: left;
            font-size: rem(40);
            line-height: rem(64);
            .label {
              color: #5d5d5d
            }
          }
        }
      }
      .btn-login {
        @include bg('../assets/images/jiaxi/btn-login.png');
        @include wh(472, 124);
        color: #ee103a;
        font-size: rem(40);
        text-align: center;
        line-height: rem(100);
        margin: rem(30) auto 0;

        &.disabled {
          pointer-events: none;
        }
      }

      .hint {
        color: #f83770;
        text-align: center;
        font-size: rem(30);
        line-height: rem(33);
        padding-bottom: rem(23)
      }
    }
</style>

<template>
  <section class="jxalert-container jxAlertTbdh" :style="popupStyle">
        <div class="alert-bg"></div>
        <div class="alert-con">
            <div class="con-inner">
                  <h3 class="con-tit">我的团币：{{ mycoin }}</h3>
                  <div class="con-txt">
                    <div class="info">
                      <p><span class="label">兑换：</span>{{ item.rate }}%加息特权</p>
                      <p><span class="label">消耗：</span>{{ item.coin }}团币</p>
                    </div>
                  </div>
                  <div class="btn-login" :class="{ disabled: btnDisabled }" @click="handleClick" :disabled="btnDisabled">确认兑换</div>
                  <p class="hint">*每人限兑一次</p>
            </div>
            <div class="con-close" @click="closeAlert"></div>
        </div>
  </section>
</template>

<script>

  export default {
    name: 'jxAlertTbdh',
    props: {
      popupStyle: {
        type: Object
      },
      mycoin: {
        type: [String, Number],
        required: true
      },
      item: {
        type: Object,
        required: true
      },
      btnDisabled: {
        type: Boolean,
        default: false
      }
    },
    methods: {
      closeAlert () {
        this.$emit('on-cancel')
      },
      handleClick () {
        this.$emit('on-covert', this.item)
      }
    }
  }
</script>


