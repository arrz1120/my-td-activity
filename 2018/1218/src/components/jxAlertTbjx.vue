<style lang="scss" scoped>
    .con-inner {
      padding-top: rem(20) !important;
      .con-tit {
        font-size: rem(40);
        font-weight: bold;
      }
      .con-txt {
        text-align: center;
        font-size: rem(30);
        margin: rem(10) 0 rem(30);

        .list-box {
          width: rem(482);
          height: rem(112);
          background: linear-gradient(#fd8169, #fa5e6d, #f73370);
          margin: 0 auto;
          display: flex;
          padding: rem(5) 0 rem(5) rem(10);
          margin-bottom: rem(10);

          .left {
            flex: 1;
            overflow: hidden;
            border: 1px dashed #fff;
            border-radius: rem(5);
            .desc {
              height: 100%;
              width: rem(48);
              border-right: 1px dashed #fff;
              text-align: center;
              float: left;
              display: flex;
              align-items: center;
              justify-content: center;
              span {
                display: inline-block;
                width: rem(26);
                font-size: rem(20);
                line-height: rem(24);
                color: #ffffff;
              }
            }

            .detail {
              height: 100%;
              color: #fff;
              text-align: center;
              overflow: hidden;
              .rate {
                font-size: rem(50);
                font-weight: bold;
                .precent {
                  margin-left: rem(8);
                  font-size: rem(30);
                  font-weight: normal;
                }
              }
              .coin {
                font-size: rem(22);
                letter-spacing: rem(2)
              }

            }

          }
          .right {
            flex: 1;
            overflow: hidden;
            .btn-convert {
              width: rem(186);
              height: rem(70);
              font-size: rem(26);
              line-height: rem(54);
              color: #ee103a;
              background: url(../assets/images/jiaxi/btn-login.png) center top no-repeat;
              background-size: 100% 100%;
              text-align: center;
              margin: rem(25) auto 0;
            }
          }
        }
      }
      .hint {
        color: #6d6d6d;
        text-align: center;
        font-size: rem(22);
        padding-bottom: rem(20);

        .my-coin {
          color: #fd664d;
        }
      }
    }
</style>

<template>
  <section class="jxalert-container" :style="popupStyle">
        <div class="alert-bg"></div>
        <div class="alert-con">
            <div class="con-inner">
                  <h3 class="con-tit">团币兑换加息特权</h3>
                  <div class="con-txt">
                    <template v-if="list.length > 0">
                      <div class="list-box" v-for="(item, index) in list" :key="item.typeId">
                        <div class="left">
                          <div class="desc">
                            <span>加息特权</span>
                          </div>
                          <div class="detail">
                            <p class="rate">{{ item.rate }}<span class="precent">%</span></p>
                            <p class="coin">{{item.coin}}团币</p>
                          </div>
                        </div>
                        <div class="right">
                          <div class="btn-convert" @click="handleCovert(item, index,$event)"  :mtaName="item.mtaName"  :name="item.name">马上兑换</div>
                        </div>
                      </div>
                    </template>
                  </div>
                  <p class="hint">我的团币：<span class="my-coin">{{mycoin}}</span> （每人限兑一次）</p>
            </div>
            <div class="con-close" @click="closeAlert"></div>
        </div>
  </section>
</template>

<script>

  export default {
    name: 'jxAlertTbjx',
    props: {
      list: {
        type: Array,
        required: true
      },
      mycoin: {
        type: [String, Number],
        required: true
      },
      popupStyle: {
        type: Object
      }
    },
    data () {
      return {
      }
    },
    methods: {
      closeAlert () {
        this.$emit('on-cancel')
      },
      handleCovert (item, idx,e) {
        AddMaiDian(e.target.getAttribute('mtaName'),e.target);
        this.$emit('on-covert', item, idx)
      }
    }
  }
</script>


