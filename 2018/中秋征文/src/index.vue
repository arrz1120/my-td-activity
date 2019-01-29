<style lang="scss">
  .content{
    position: relative;
    z-index: 2;
  }
  .banner{
    padding-top: rem(123);
    position: relative;
    .logo{
      @include wh(160,54);
      @include bg('./assets/images/logo.png');
      position: absolute;
      left: rem(46);
      top: rem(29);
    }
    .rule-btn{
      @include bg('./assets/images/rule-btn.png');
      background-size: 100% 100%;
      width: rem(120);
      position: absolute;
      right: 0;
      top: rem(25);
      color: #fff9ec;
      padding: rem(20) 0 rem(20) rem(18);
    }
    .b-tit1{
      @include wh(672,151);
      @include bg('./assets/images/b-tit1.png');
      margin: 0 auto;
    }
    .b-tit2{
      color: #ffe9c8;
      font-size: rem(42);
      text-align: center;
      margin-top: rem(10);
    }
    .b-tit2::before{
      content: "";
      display: inline-block;
      @include wh(27,2);
      margin-right: rem(16);
      background: #8b8f8e;
      vertical-align: middle;
    }
    .b-tit2::after{
      content: "";
      display: inline-block;
      @include wh(27,2);
      margin-left: rem(16);
      background: #8b8f8e;
      vertical-align: middle;
    }
    .b-tit3{
      @include wh(406,55);
      @include bg('./assets/images/b-tit3.png');
      margin: rem(25) auto 0;
      line-height: rem(55);
      text-align: center;
      color: #ffefd7;
    }
  }
  .sec{
    background-color: #fff;
    width: rem(688);
    border-radius: 4px;
    margin: 0 auto rem(55);
    background-position: center rem(69);
    background-repeat: no-repeat;
    position: relative;
    .tit{
      color: #a77d41;
      font-size: rem(40);
      font-weight: bold;
      text-align: center;
      padding-top: rem(56);
    }
    .btn{
      width: rem(578);
      position: absolute;
      left: 50%;
      bottom: rem(-50);
      margin-left: rem(-289);
      padding: rem(30) 0;
      color: #5c2907;
      text-align: center;
      border-radius: rem(50);
      font-size: rem(40);
      background: linear-gradient(to bottom,#ffe240,#f4a901);
    }
    .txt{
      p{
        color: #3c3c3c;
        line-height: rem(44);
        text-indent: rem(48);
        text-align: justify;
      }
      span{
        color: #a77d41;
      }
    }
  }
  .sec1{
    height: rem(572);
    background-image: url('./assets/images/bg-frame1.png');
    background-size: rem(639) rem(464);
    padding-left: rem(62);
    padding-right: rem(62);
    margin-top: rem(133);
    .txt{
      margin-top: rem(46);
    }
  }
  // .sec2{
  //   height: rem(637);
  //   background-image: url('./assets/images/bg-frame1.png');
  //   background-size: rem(639) rem(464);
  //   padding-left: rem(75);
  //   padding-right: rem(75);
  //   position: relative;
  //   margin-bottom: rem(83);
  //   .icon-prev{
  //     @include wh(19,32);
  //     @include bg('./assets/images/icon-prev.png');
  //     position: absolute;
  //     top: rem(336);
  //     left: rem(56);
  //   }
  //   .icon-next{
  //     @include wh(19,32);
  //     @include bg('./assets/images/icon-next.png');
  //     position: absolute;
  //     top: rem(336);
  //     right: rem(56);
  //   }
  //   .gift-box{
  //     width: 100%;
  //     text-align: center;
  //     padding-top: rem(34);
  //     .gift-tit{
  //       width: rem(260);
  //       padding: rem(10) 0;
  //       background: #c4a579;
  //       color: #ffffff;
  //       font-size: rem(30);
  //       border-radius: rem(22);
  //       margin: 0 auto;
  //     }
  //     .gift-flex{
  //       display: flex;
  //       justify-content:center;
  //       align-items: center;
  //     }
  //     .icon-add{
  //       @include wh(26,26);
  //       @include bg('./assets/images/icon-add.png');
  //       margin: 0 rem(19)
  //     }
  //     .gift{
  //       margin-top: rem(49);
  //       .img{
  //         @include wh(185,185);
  //         border-radius: 50%;
  //         background: #f1f1f1;
  //         overflow: hidden;
  //         display: flex;
  //         align-items: center;
  //         justify-content: center;
  //       }
  //       img{
  //         width: 100%;
  //         height: 100%;
  //       }
  //       p{
  //         color: #a77d41;
  //         padding-top: rem(31);
  //       }
  //     }
  //   }
  // }
  .sec2{
    height: rem(637);
    background-image: url('./assets/images/bg-frame1.png');
    background-size: rem(639) rem(464);
    padding-left: rem(60);
    padding-right: rem(60);
    position: relative;
    margin-bottom: rem(83);
    .txt{
      margin-top: rem(33);
    }
    .table{
      width: rem(547);
      margin: rem(31) auto 0;
      border: 1px solid #ece1d3;
      ul{
        .table-flex{
          display: flex;
          .item{
            padding: rem(12) 0;
            flex: 1;
            text-align: center;
            color: #3c3c3c;
            font-size: rem(28);
            &:first-child{
              flex: 0 0 rem(98);
            }
          } 
          .item-a{
            background: url('./assets/images/A.png') center no-repeat;
            background-size: rem(30) rem(40);
          }
          .item-b{
            background: url('./assets/images/B.png') center no-repeat;
            background-size: rem(30) rem(40);
          }
          .item-c{
            background: url('./assets/images/C.png') center no-repeat;
            background-size: rem(30) rem(40);
          }
          &:nth-child(even){
            background: #f9f6f1;
          }
        }
      }
    }
  }
  .sec3{
    height: rem(756);
    background-image: url('./assets/images/bg-frame3.png');
    background-size: rem(639) rem(643);
    position: relative;
    padding: 0 rem(28);
    .a-prev{
      @include wh(71,71);
      @include bg('./assets/images/icon-prev2.png');
      background-size: rem(19) rem(32);
      background-position: center;
      position: absolute;
      top: rem(410);
      left: rem(18);
      z-index: 2;
    }
    .a-next{
      @include wh(71,71);
      @include bg('./assets/images/icon-next2.png');
      background-size: rem(19) rem(32);
      background-position: center;
      position: absolute;
      top: rem(410);
      right: rem(18);
      z-index: 2;
    }
    .user{
      display: flex;
      margin: rem(30) auto 0;
      justify-content: space-between;
      width: rem(518);
      .info{
        display: flex;
        align-items: center;
        height: rem(54);
        img{
          display: inline-block;
          @include wh(54,54);
          border-radius: 50%;
          margin-right: rem(12);
        }
        span{
          color: #a77d41;
          font-size: rem(26);
        }
      }
      .praise{
        display: flex;
        align-items: center;
        height: rem(54);
        .p-icon{
          display: inline-block;
          margin-right: rem(14);
        }
        .p-icon1{
          @include wh(28,29);
          @include bg('./assets/images/p-icon1.png');
        }
        .p-icon2{
          @include wh(26,27);
          @include bg('./assets/images/p-icon2.png');
        }
        span{
          display: block;
          color: #a77d41;
          font-size: rem(26);
          line-height: rem(54);
        }
      }
    }
    .article-slider{
      // @include wh(548,421);
     width: 100%; 
      position: relative;
    }
    .article-box{
      .article-con{
        height: rem(480);
        width: rem(518);
        border: 1px solid #e1d2bc;
        margin: rem(15) auto 0;
        padding-left: rem(40);
        padding-right: rem(27);
      }
      .no-data-con{
        margin-top: rem(90);
      }
      .no-data{
        width: 100%;
        height: 100%;
        background: url('./assets/images/no-data.png') center no-repeat;
        background-size: rem(249) rem(255);
      }
      .scroll{
        height: rem(360);
        overflow: hidden;
        position: relative;
        padding-right: rem(40);
        .bscroll-vertical-scrollbar{
          background: #f5f5f5;
          border-radius: 3px;
        }
        .bscroll-indicator{
          background: #d4be9e !important;
        }
      }
      .a-tit{
        color: #9a6f32;
        font-size: rem(30);
        padding-top: rem(29);
        text-align: center;
        margin-bottom: rem(22);
      }
      .a-txt{
        font-size: rem(22);
        color: #666;
        line-height: rem(38);
        text-indent: rem(44);
        text-align: justify;
      }
    }
  }
  .sec4{
    height: rem(584);
    background-image: url('./assets/images/bg-frame4.png');
    background-size: rem(639) rem(407);
    padding: 0 rem(77);
    margin-bottom: rem(83);
    .txt{
      margin-top: rem(36);
      p{
        span{
          font-weight: bold;
        }
      }
    }
  }
  .sec5{
    height: rem(355);
    background-image: url('./assets/images/bg-frame5.png');
    background-size: rem(639) rem(304);
    background-position: center center;
    padding-top: rem(64);
    padding-left: rem(78);
    padding-right: rem(73);
    position: relative;
    .no-data{
      width: 100%;
      height: 100%;
      background: url('./assets/images/no-data.png') center no-repeat;
      background-size: auto 65%;
      position: absolute;
      top: 0;
      left: 0;
    }
    .award-scroll-box{
      height: rem(230);
      overflow: hidden;
      background: url('./assets/images/bg-line5.png') center no-repeat;
      background-size: rem(531) rem(116);
    }  
    .award-slider{
      height: rem(57);
      .award-flex{
        height: rem(57);
        display: flex;
        align-items: center;
        color: #a77d41;
        .award-left{
          flex: 1
        }
        .award-right{
          flex: 0 0 rem(200);
          text-align: right;
        }
      }
    }
  }
  .footer{
    text-align: center;
    color: #48b7d0;
    font-size: rem(20);
    margin-top: rem(80);
  }
  .share-btn{
    @include wh(127,129);
    @include bg('./assets/images/share-btn.png');
    position: fixed;
    left: rem(5);
    bottom: rem(110);
    z-index: 3;
  }
  .breath{
    animation: breath 0.8s ease-out alternate infinite;
  }
  @keyframes breath{
    0%{
      transform: scale(1,1);
    }
    100%{
      transform: scale(0.95,0.95);
    }
  }
</style>

<template>
  <section class="app">
    <bg></bg>
    <div class="content">
      <div class="banner">
        <div class="logo"></div>
        <div class="rule-btn" @click="showRule" name="活动规则">活动规则</div>
        <div class="b-tit1"></div>
        <div class="b-tit2">记录你最难忘的中秋故事</div>
        <div class="b-tit3">活动时间：9月7日-9月25日</div>
      </div>
      <div class="sec sec1">
        <h3 class="tit">征文活动</h3>
        <div class="txt">
          <p>思念像中秋的满月，牵挂似满天的繁星，中秋节对于每个人来说都有着不同的意义。提起中秋节，有的人想起的是一家欢聚团圆的欢乐时刻，有的人想起的是热闹喧嚣的中秋集市，还有的人想起的是家乡独特的习俗……</p>
          <p>在过去的多个中秋节里，你最难忘的是哪一个呢？在这里，<span>我们带着丰厚的奖金期待着你的故事。</span></p>
        </div>
      </div>
      <!-- <div class="sec sec2">
        <h3 class="tit">征文奖品</h3>
        <div class="icon-prev" @click="slidePrev"></div>
        <div class="icon-next" @click="slideNext"></div>
        <Slider 
          ref="slider">
          <div 
            v-for="(item,index) in prizeData"
            :key="index"
            class="gift-box">
            <div class="gift-tit">{{item.title}}</div>
            <div class="gift-flex">
              <div class="gift">
                <div class="img">
                  <img :src="require('./assets/images/prize'+item.content[0].prizeSrc+'.png')" alt="">
                </div>
                <p>{{item.content[0].prizeName}}</p>
              </div>
              <div v-if="item.content.length>1" class="icon-add"></div>
              <div v-if="item.content.length>1" class="gift">
                <div class="img">
                  <img :src="require('./assets/images/prize'+item.content[1].prizeSrc+'.png')" alt="">
                </div>
                <p>{{item.content[1].prizeName}}</p>
              </div>
            </div>
          </div>
        </Slider>
        <div class="btn breath" @click="toWrite" name="马上投稿_3a">马上投稿</div>
      </div> -->
      
      <div class="sec sec2">
        <h3 class="tit">征文规则</h3>
        <div class="txt">
          <p>以“难忘的中秋节”为主题书写<span>800字</span>以上，与中秋节有关的故事或经历，成功入选的原创文章将于活动结束后，按照注册时间、累计签到天数和当月会员等级等维度分为<span>A、B、C</span>三档从高往低计算稿费。</p>
        </div>
        <div class="table">
          <ul>
            <li class="table-flex">
              <div class="item item-a"></div>
              <div class="item">A档稿费</div>
              <div class="item">1字/1.5元</div>
            </li>
            <li class="table-flex">
              <div class="item item-b"></div>
              <div class="item">B档稿费</div>
              <div class="item">1字/1元</div>
            </li>
            <li class="table-flex">
              <div class="item item-c"></div>
              <div class="item">C档稿费</div>
              <div class="item">1字/0.5元</div>
            </li>
          </ul>
        </div>
        <div class="btn breath" @click="toWrite" name="马上投稿_3a">马上投稿</div>
      </div>
      <div class="sec sec3">
        <h3 class="tit">征文展示</h3>
        <div class="a-prev" v-if="article.length" @touchstart="articlePrev"></div>
        <div class="a-next" v-if="article.length" @touchstart="articleNext"></div>
        
        <Slider @scrollEnd="articleScrollEnd" ref="articleSlider" class="article-slider" v-if="article.length" :autoPlay='false'>
          <div 
            class="article-box"
            v-for="(item,index) in article"
            :key="index">
            <div class="user">
              <div class="info">
                <img v-if="item.headImage" :src="item.headImage" alt="">
                <img v-else :src="require('./assets/images/avatar.png')" alt="">
                <span>{{item.nickName? item.nickName: '团贷小星'}}</span>
              </div>
              <div class="praise" v-if="isLogin" @click="_praise">
                <i class="p-icon" :class=" item.praiseFlag ? 'p-icon2' : 'p-icon1' "></i>
                <span>点赞({{item.praise}})</span>
              </div>
            </div>
            <div class="article-con">
              <h5 class="a-tit">{{item.title}}</h5>
              <Scroll class="scroll" :data="articlePage" :scrollbar="true">
                <div>
                  <p class="a-txt">{{item.content}}</p>  
                </div>
              </Scroll>
            </div>
          </div>
        </Slider>
        <div class="article-box" v-else>
          <div class="article-con no-data-con">
            <div class="no-data"></div>
          </div>
        </div>
      </div>
      <div class="sec sec4">
        <h3 class="tit">有奖灯谜征集</h3>
        <div class="txt">
          <p><span>中秋节</span>作为我国重大的传统节日，伴随着许多传统习俗，比如吃月饼、点灯笼、猜灯谜等。其中猜灯谜是非常考验人智慧的，那出迷题的人是否更上一层楼呢？</p>
          <p>欢迎在这里留下您的谜语，写完后每人都会有一份小礼物哦！我们将筛选部分优秀的谜语用在下一个活动中，请务必认真填写~</p>
        </div>
        <div class="btn breath" @click="setLantern" name="灯谜征集">有奖灯谜征集</div>
      </div>
      <div class="sec sec5">
        <div class="award-scroll-box" v-if="awardList.length">
          <marquee class="award-slider" :slides="4">
            <div class="award-flex" v-for="item in awardList">
              <div class="award-left">用户{{item.name}}领取了灯谜奖品</div>  
              <div class="award-right">{{item.prizeName}}</div>  
            </div>  
          </marquee>
        </div>
        <div class="no-data" v-else></div>
      </div>
      <footer class="footer">【广告】市场有风险，投资需谨慎</footer>
    </div>
    <div class="share-btn" @click="toShare" name="分享"></div>
    <rule-alert
      :showRule="showRuleAlert"
      @toggleRuleAlert="toggleRuleAlert"
    ></rule-alert>
    <lanternRiddle
      @hideAlert="hideLanternAlert"
      @showHasPrize="showHasPrize"
      @showAward="showAward"
      :show="showLanternAlert"></lanternRiddle>
    <tipsAlert
      @hideAlert="hideTipsAlert"
      :show="showTipsAlert.show"
      :showType="showTipsAlert.showType"
      :isToWrite="loginToRight"
    ></tipsAlert>
    <awardAlert
      :show="showAwardAlert.show"
      :showType="showAwardAlert.showType"
      :prizeName="showAwardAlert.prizeName"
      @hideAlert="hideAwardAlert"
    ></awardAlert>
  </section>
</template>

<script>
import BScroll from 'better-scroll'
import Slider from './components/base/slider'
import Scroll from './components/base/scroll'
import Marquee from './components/base/marquee'
import Bg from './components/bg'
import ruleAlert from './components/alert/rule'
import lanternRiddle from './components/alert/lanternRiddle'
import awardAlert from './components/alert/award'
import tipsAlert from './components/alert/tips'
import {getArticleData,awardListData, getInitStatus,praise} from './api/api.js'
import {ShareShow} from './js/lib/common/share.js'

let gift = [
  {
    title:'团粉之星（1位）',
    content:[
      {
        prizeSrc: '1',
        prizeName: '海尔空气净化器'
      },
      {
        prizeSrc: '2',
        prizeName: '100元投资红包'
      },
    ]
  },
  {
    title:'优秀奖（4位）',
    content:[
      {
        prizeSrc: '3',
        prizeName: '24寸行李箱'
      },
      {
        prizeSrc: '4',
        prizeName: '50元投资红包'
      },
    ]
  },
  {
    title:'幸运奖（150位）',
    content:[
      {
        prizeSrc: '5',
        prizeName: '5元投资红包'
      }
    ]
  }

]

export default {
  name:'index',
  data(vm) {
    console.log(vm)
    return {
      prizeData: gift,
      article: [],
      awardList: [],
      showRuleAlert: false,
      showLanternAlert: false,
      showTipsAlert: {
        show: false,
        showType: ''
      },
      showAwardAlert: {
        show: false,
        showType: '',
        prizeName: ''
      },
      activityEnd: false,
      isLogin: false,
      articlePage: 0,
      loginToRight: false
    }
  },
  created() {
    this._getInitStatus()
    this._getArticleData()
    this._awardListData()
  },
  computed: {
    articleId() {
      return this.article.length && this.article[this.articlePage].id 
    }
  },
  methods: {
    articleScrollEnd(index) {
      this.articlePage = index
    },
    slidePrev() {
      this.$refs.slider.prev()
    },
    slideNext() {
      this.$refs.slider.next()
    },
    articlePrev(){
      this.article.length && this.$refs.articleSlider.prev()
    },
    articleNext(){
      this.article.length && this.$refs.articleSlider.next()
    },
    _getInitStatus() {
      getInitStatus().then(res => {
        this.activityEnd = res.activityEndFlag
        this.isLogin = res.loginFlag
      }).catch(err => {
        if(err) {
          this.showErr()
        }
      })
    },
    _praise() {
      if(this.article[this.articlePage].praiseFlag){
        return
      }
      praise(this.articleId).then(res => {
        this.article[this.articlePage].praiseFlag = true
        this.article[this.articlePage].praise += 1
      }).catch(err => {
        if(err) {
          this.showErr()
        }
      })
    },
    _getArticleData() {
      getArticleData(this.articlePage).then((res) => {
        this.article = res
      }).catch(err => {
        if(err) {
          this.showErr()
        }
      })
    },
    _awardListData() {
      awardListData().then((res) => {
        this.awardList = res
      }).catch(err => {
        if(err) {
          this.showErr()
        }
      })
    },
    showRule(e) {
      AddMaiDian('rule1a', e.target)
      this.showRuleAlert = true
    },
    toggleRuleAlert(show){
      this.showRuleAlert = show
    },
    hideTipsAlert() {
      this.showTipsAlert.show = false
    },
    showNoLogin() {
      this.showTipsAlert = {
        show: true,
        showType: 'login'
      }
    },
    showHasPrize() {
      this.showTipsAlert = {
        show: true,
        showType: 'hasPrize'
      }
    },
    toWrite(e) {
      AddMaiDian('write3a', e.target)
      if(!this.isLogin) {
        this.loginToRight = true
        this.showNoLogin()
        return
      }
      location.href = "write.html"
    },
    setLantern(e) {
      AddMaiDian('collect4a', e.target)
      if(!this.isLogin) {
        this.loginToRight = false
        this.showNoLogin()
        return
      }
      this.showLanternAlert = true
    },
    hideLanternAlert() {
      this.showLanternAlert = false
    },
    showAward(param) {
      this.showAwardAlert = {
        show: true,
        showType: param.type,
        prizeName: param.prizeName
      }
    },
    hideAwardAlert() {
      this.showAwardAlert.show = false
    },
    toShare(e){
      AddMaiDian('share2a', e.target)
      ShareShow()
    },
    showErr() {
      this.showTipsAlert = {
        show: true,
        showType: 'error'
      }
    }
  },
  components: {
    Bg,
    Slider,
    Scroll,
    Marquee,
    ruleAlert,
    lanternRiddle,
    tipsAlert,
    awardAlert
  }
}
</script>
