<template>
  <popup class="prize-view"  @on-close="$emit('on-close')" :preventDefault="false" >
    <div class="prize-wrapper">
      <section class="nav">
        <span class="nav-item" :class="{'active': winTab}" @click="winTab = true; lotteryTab = false" >中奖记录</span>
        <span class="nav-item" :class="{'active': lotteryTab}" @click="winTab = false; lotteryTab = true">开奖记录</span>
      </section>
      <section class="content">
        <div class="record">
            <template v-if="winTab">
              <template v-if="winRecordList && winRecordList.length">
                <div class="record-wrap">
                  <div class="record-title">
                    <span>日期</span>
                    <span>中奖数字</span>
                    <span>竞猜数字</span>
                    <span>获得奖励</span>
                  </div>
                  <div class="record-list">
                    <ul>
                      <li class="record-item" v-for="(item, idx) in winRecordList" :class="{'even': idx%2 !== 0}" :key="idx" >
                        <span>{{ item.createDate }}</span>
                        <span>{{ item.trueNumber }}</span>
                        <span>{{ item.prizeStatus === 0 ? '无' : item.guessNumber + '(x'+item.guessCount+')'}}</span>
                        <template v-if="item.prizeStatus === 3">
                          <span class="pending" @click="$emit('on-get', $event)">{{ item.prizeStatus | filterStatus }}</span>
                        </template>
                        <template v-else>
                          <span>{{ item.prizeStatus | filterStatus }}</span>
                        </template>
                      </li>
                    </ul>
                  </div>
                </div>
              </template>
              <template v-else>
                <div class="no-win">暂无中奖记录</div>
              </template>
            </template>
            <template v-if="lotteryTab">
              <template v-if="lottryRecordList && lottryRecordList.length">
                <div class="record-wrap">
                  <div class="record-title">
                    <span>日期</span>
                    <span>猜数人次</span>
                    <span class="money" style="">瓜分金额<i class="yuan">(元)</i></span>
                    <span>瓜分份数</span>
                  </div>
                  <div class="record-list">
                    <ul>
                      <li class="record-item" v-for="(item, idx) in lottryRecordList" :class="{'even': idx%2 !== 0}" :key="idx" >
                        <span>{{ item.createDate }}</span>
                        <span>{{ item.guessTotal }}</span>
                        <span>{{ item.guaFenMoney }}</span>
                        <span>{{ item.guessRightTotal }}</span>
                      </li>
                    </ul>
                  </div>
                </div>
              </template>
              <template v-else>
                <div class="no-lottery">暂无开奖记录</div>
              </template>
            </template>  
        </div>
      </section>
    </div>
  </popup>
</template>

<script>
import Popup from './popup'
const prizeStaMap = {
  0: '无',
  1: '待发放',
  2: '未猜中',
  3: '待领取',
  4: '已领取'
}
export default {
  name: 'PrizeAlert',
  components: {
    Popup
  },
  filters: {
    filterStatus(status) {
      return prizeStaMap[status]
    }
  }, 
  props: {
    winRecordList: {
      type: Array,
      default () {
        return []
      }
    },
    lottryRecordList: {
      type: Array,
      default () {
        return []
      }
    }
  },
  data() {
    return {
      winTab: true,
      lotteryTab: false
    }
  }
}
</script>

<style lang="scss" scoped>
  .prize-view {
    /deep/ .popup-con {
      padding-top: rem(60);
    }
    .prize-wrapper {
      margin-bottom: rem(30);
      width: rem(649);
      overflow: hidden;
      transform: translateZ(1px);
      
      .nav {
        display: flex;
        .nav-item {
          flex: 1;
          font-size: rem(40);
          font-weight: bold;
          color: #a10309;
          padding: rem(20) 0;
          border-top-left-radius: rem(10);
          border-top-right-radius: rem(10);
          &.active {
            color: #af6842;
            background-color: #fff0d3;
            margin-bottom: rem(-10);
          }
        }
      }
      .content {
        width: rem(649);
        height: rem(685);
        background-color: #fff0d3;
        border-radius: rem(10);
        padding: rem(10) rem(8);
        .record {
          width: 100%;
          height: 100%;
          border:1px #d3ad80 solid;
          display: flex;
          align-items: center;
          justify-content: center;
          border-radius: rem(10);
          padding: rem(17) rem(11);
          
          .record-wrap {
            width: 100%;
            height: 100%;
            background-color: #d3ad80;
            border-radius: rem(10);
            border:1px #d3ad80 solid;
            overflow: hidden;
            .record-title {
              display: flex;
              height: rem(79);
              align-items: center;
              color: #fff;
              font-size: rem(30);
              font-weight: bold;
              
              span {
                flex: 1;
                &.money {
                  flex: none;
                  .yuan {
                    font-size: rem(18);
                  }
                }

              }
            }
            .record-list {
              height: rem(545);
              overflow: hidden;
              overflow-y: scroll;
              li.record-item {
                background-color: #fff7e8; 
                display: flex;
                height: rem(68);
                align-items: center;
                color: #88511a;
                font-size: rem(26);
                &.even {
                  background-color: #f3dbb8;
                }
                span {
                  flex: 1;

                  &.pending {
                    font-size: rem(24);
                    line-height: rem(47);
                    font-weight: bold;
                    text-align: center;
                    color: #852c06;
                    @include wh(168, 56);
                    @include bg('../assets/images/btn.png');
                    margin-top: rem(9);
                  }
              
                }
              }
            }
          }
          
        }
        .no-lottery {
          @include bg('../assets/images/xiaopai.png');
          @include wh(300, 379);
          font-size: rem(36);
          color: #9b9b90;
          padding-top: rem(345);
        }
        .no-win {
          @include bg('../assets/images/xiaopai.png');
          @include wh(300, 379);
          font-size: rem(36);
          color: #9b9b90;
          padding-top: rem(345);
        }
      }
    }
  }

</style>
