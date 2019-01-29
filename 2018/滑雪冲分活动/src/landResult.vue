<style lang="scss">
  .content{
    position: relative;
    @include wh(750,2586);
    @include bg('./assets/images/land/result-bg.jpg');
    padding-top: rem(120);
    }
  .logo{
    @include wh(132,48);
    @include bg('./assets/images/logo.png');
    position: absolute;
    left: rem(30);
    top: rem(20);
    }
  .ad-tips{
    position: absolute;
    right: rem(30);
    top:rem(37);
    font-size: rem(16);
    color: #4b92ff;
    }
  .txt{
    font-size:rem(46);
    color: #002786;
    text-align: center;
    }
  .rp{
    @include wh(436,478);
    @include bg('./assets/images/land/rp.png');
    margin: rem(50) auto 0 rem(160);
    p{
      font-size: rem(38);
      color: #fff;
      padding: rem(170) 0 0 rem(100);
      span{
        font-weight: bold;
        font-size: rem(80);
        display: inline-block;
        vertical-align: rem(-10);
        margin-right: rem(10);
        }
      }
    }
  .btn-get{
    display: block;
    @include bg('./assets/images/land/btn-bg.png');
    @include wh(641,144);
    margin: rem(-45) auto 0;
    font-size: rem(36);
    color: #ffffff;
    text-align: center;
    line-height: rem(125);
    }
  .tips{
    font-size: rem(24);
    color: #cb2d2d;
    text-align: center;
    margin-top: rem(26);
    }
  .title{
    display: block;
    font-size: rem(40);
    color: #002786;
    font-weight: bold;
    text-align: center;
    width: rem(724);
    padding-top: rem(30);
    position: absolute;
    left: 50%;
    margin-left: rem(-362);
    top: rem(40);
    }

  .dif-title{
    display: block;
    font-size: rem(40);
    color: #002786;
    font-weight: bold;
    text-align: center;
    padding-top: rem(20);
    padding-bottom: rem(20);
    position: relative;
    &:after{
      content: '';
      display: block;
      position: absolute;
      left: 50%;
      margin-left: rem(-271);
      top: rem(30);
      @include wh(542,16);
      @include bg('./assets/images/land/title-bg.png');
      }
    }

  .con{
    position: relative;
    @include wh(724,499);
    @include bg('./assets/images/land/con-bg.png');
    margin: rem(73) auto 0;
    padding-top: rem(180);
    .con-box{
      display: -webkit-box;
      width: rem(660);
      margin: 0 auto;
      div{
        -webkit-box-flex: 1;
        font-weight: rem(30);
        color: #333333;
        text-align: center;
        .red{
          color: #d63434;
          }
        i{
          @include wh(140,140);
          display: block;
          margin: 0 auto rem(20);
          &.icon1{
            @include bg('./assets/images/land/icon1.png');
            }
          &.icon2{
            @include bg('./assets/images/land/icon2.png');
            }
          &.icon3{
            @include bg('./assets/images/land/icon3.png');
            }
          &.icon4{
            @include bg('./assets/images/land/icon4.png');
            }
          &.icon5{
            @include bg('./assets/images/land/icon5.png');
            }
          &.icon6{
            @include bg('./assets/images/land/icon6.png');
            }
          }

        }
      }
    }

  .con-new{
    position: relative;
    @include wh(690,375);
    background: #fff;
    border-radius: rem(10);
    margin: rem(73) auto 0;
    padding-top: rem(40);
    .con-box{
      display: -webkit-box;
      width: rem(660);
      margin: 0 auto;
      div{
        -webkit-box-flex: 1;
        width: 33.33%;
        p{
          font-weight: rem(30);
          color: #333333;
          text-align: center;
          span{
            display:inline-block;
            border-radius: 50%;
            background-color: rgb(197, 214, 244);
            @include wh(28,28);
            line-height:rem(28);
            text-align: center;
            font-size: rem(25);
            color: #ffffff;
            vertical-align: rem(3);
            margin-right: rem(5);
            }
          }
        .red{
          color: #d63434;
          }
        i{
          @include wh(112,112);
          display: block;
          margin: 0 auto rem(20);
          &.icon7{
            @include bg('./assets/images/land/icon7.png');
            }
          &.icon8{
            @include bg('./assets/images/land/icon8.png');
            }
          &.icon9{
            @include bg('./assets/images/land/icon9.png');
            }
          }

        }
      }
    }



  .tips-bq{
    padding-top: rem(40);
    text-align: center;
    font-size: rem(16);
    color: #8daee6;
    }
</style>

<template>
  <section class="content">
    <i class="logo"></i>
    <i class="icon-txt"></i>
    <span class="ad-tips">【广告】市场有风险，出借需谨慎</span>
    <p class="txt">恭喜您，<br>10元现金等你领！</p>
    <div class="rp">
      <p><span>10</span>元现金</p>
    </div>
    <span class="btn-get" name="分享结果页_前往APP领取" @click="goDLAppBtnClk">前往团贷网APP领取</span>

    <div class="con-new">
      <span class="dif-title">轻松领福利</span>
      <div class="con-box">
        <div>
          <i class="icon7"></i>
          <p><span>1</span>注册</p>

        </div>
        <div>
          <i class="icon8"></i>
          <p><span>2</span>下载APP</p>
        </div>
        <div>
          <i class="icon9"></i>
          <p><span>3</span>开通银行存管</p>
        </div>
      </div>
      <p class="tips">使用红包出借可获得更多积分（1元=1积分）</p>
    </div>
    <div class="con">
      <span class="title">我的新手福利</span>
      <div class="con-box">
        <div>
          <i class="icon1"></i>
          518红包
        </div>
        <div>
          <i class="icon2"></i>
          2888体验金
        </div>
        <div>
          <i class="icon3"></i>
          新手专享标
        </div>
      </div>
    </div>
    <div class="con">
      <span class="title">团贷网的优势</span>
      <div class="con-box">
        <div>
          <i class="icon4"></i>
          <p><span class="red">六年合规</span><br>稳健运营</p>
        </div>
        <div>
          <i class="icon5"></i>
          <p>注册用户<br><span class="red">805万人</span></p>
        </div>
        <div>
          <i class="icon6"></i>
          <p><span class="red">银行存管</span><br>资金分账</p>
        </div>
      </div>
    </div>
    <p class="tips-bq">本活动及奖品与苹果公司无关</p>
  </section>
</template>

<script>
export default {
  name: 'App',
  methods:{
      //
      // isWx() {
      //   let ua = navigator.userAgent.toLowerCase();
      //   if (ua.match(/MicroMessenger/i) == 'micromessenger') {
      //       return true;
      //   } else {
      //       return false;
      //   }
      // },

      goDLAppBtnClk({target}){
          try {
              sa.quick('trackHeatMap',target)
          } catch (error) {}
          window.location.href= '//sj.qq.com/myapp/detail.htm?apkName=com.junte'
          // if(this.isWx()){
          //     window.location.href= '//app.qq.com/#id=detail&appid=1101216628'
          // }else {
          //     window.location.href= '//www.tuandai.com/app/install.aspx'
          // }
      },
    },
}
</script>
