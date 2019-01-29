<style lang="scss">
  .ruleModal-container{
    position: fixed;
    z-index: 10;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    transform: translateZ(1px);
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    .ruleModal-shade{
      background: rgba(0,0,0,.75);
      position: absolute;
      z-index: 0;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
    }
    .ruleModal-main{
      width: 13rem;
      position: relative;
      z-index: 1;
      background: linear-gradient(to bottom,#ff5b9c,#ff4272);
      padding: 0.5rem;
      padding-bottom: 0.75rem;
      border-radius: .45rem;
    }
    .ruleModal-maintitle{
      font-size: rem(50);
      color: #ffffff;
      text-align: center;
      font-weight: bold;
    }
    .ruleModal-halo{
      @include wh(135,87);
      @include bg('../assets/images/common/08-01.png');
      position: absolute;
      z-index: 0;
      top: 0;
      right: 1.5rem;
    }
    .ruleModal-tb{
      @include wh(55,37);
      @include bg('../assets/images/common/08-02.png');
      position: absolute;
      top: 1.75rem;
      left: 2rem;
    }
    .ruleModal-content{
      position: relative;
      z-index: 1;
      margin-top: 0.25rem;
      
    }
    .ruleModal-swiper{
      border-radius: .5rem 0 .5rem .5rem;
      background: #ffffff;
      height: 15rem;
      padding: .75rem 1rem;
      padding-left: 1.25rem;
      font-size: rem(25);
      width: 11.01rem;
      margin: 0;
    }
    .ruleModal-slide{
      height: auto;
    }
    .ruleModal-swiper-dl{
      position: relative;
      line-height: 1.35;
      text-align: justify;
      &:not(:last-child){
        margin-bottom: 0.75rem;
      }
      >.dt{
        font-size: rem(28);
        color: #ff696f;
        text-align: center;
        margin-bottom: 0.25rem;
      }
      >.dd{
        position: relative;
        margin-bottom: 0.35rem;
      }
      .mark{
        color: #fd4e77;
      }
      .small{
        font-size: rem(20);
      }
    }
    .ruleModal-swiper-scrollbar{
      .swiper-scrollbar-drag{
        background: rgba(255, 88, 125, 0.75);
      }
    }
    .ruleModal-swiper-icon{
      display: inline-block;
      vertical-align: middle;
      @include wh(18,16);
      @include bg('../assets/images/common/09.png');
      transform: scale(.75);
    }
    .ruleModal-swiper-idx{
      position: absolute;
      top: -.05rem;
      left: -.75rem;
      color: #ff3b75;
      font-size: rem(28);
    }
    .ruleModal-swiper-heart{
      @include wh(18,16);
      @include bg('../assets/images/common/09.png');
      position: absolute;
      top: .15rem;
      left: -.65rem;
    }
    .ruleModal-swiper-nav{
      position: absolute;
      z-index: 0;
      top: 0;
      right: 0;
      width: 1rem;
      font-size: rem(26);
      line-height: 1;
      text-align: center;
      >.item{
        background: #fff2b1;
        color: #f34439;
        padding: 0.5rem 0;
        border-radius: 0 .25rem .25rem 0;
        &:not(:last-child){
          margin-bottom: 0.15rem;
        }
        &.on{
          background: #ffffff;
        }
      }
    }
    .ruleModal-close{
      @include wh(66,66);
      @include bg('../assets/images/common/07.png');
      position: relative;
      z-index: 1;
      margin-top: 0.5rem;
    }
  }
</style>

<template>
  <section class="ruleModal-container" @touchmove.prevent>
    <div class="ruleModal-shade"></div>
    <div class="ruleModal-main">
      <div class="ruleModal-halo"></div>
      <p class="ruleModal-tb"></p>
      <p class="ruleModal-maintitle">活动规则</p>
      <div class="ruleModal-content" ref="swiperContent">
        <div class="ruleModal-swiper swiper-container">
          <div class="swiper-wrapper">
            <div class="ruleModal-slide swiper-slide">
              <!-- 加息专区 -->
              <dl class="ruleModal-swiper-dl">
                <dt class="dt" ref="navItem0">
                  <i class="ruleModal-swiper-icon"></i>
                  加息专区
                  <i class="ruleModal-swiper-icon"></i>
                </dt>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">①</i>
                  团币兑换：12月3日-12月22日期间，用户可使用团币兑换<i class="mark">0.1%~0.6%加息特权</i>，每个用户限兑换1次；
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">②</i>
                  红包雨：12月3日-12月17日期间，每位用户首次参与游戏可获得1个彩蛋<i class="mark">（0.1%加息特权）</i>，每人限领1份；
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">③</i>
                  集爱心：12月18日-12月22日期间，个人可将邀友集爱心活动中收集的爱心用于兑换<i class="mark">0.1%~0.3%加息特权</i>，每人限兑换1次；
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">④</i>
                  爱心榜单：12月3日-12月22日期间，根据用户出借指定的We自动服务、We+自动服务（新手专享服务除外）累计出借金额进行排名，前500名用户可分别获得<i class="mark">0.1%~0.5%加息特权</i>。
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">⑤</i>
                  福利加息：12月3日-12月22日期间，用户登录活动页面，即可获得1份<i class="mark">1.0%的福利加息特权</i>，每人限领1份；
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">⑥</i>
                  签到彩蛋：12月18日-12月22日期间，用户在团贷网App首次签到即可获得0.1%加息特权，若连续签到2天及以上可再获得0.1%加息特权。
                </dd>
              </dl>
              <dl class="ruleModal-swiper-dl">
                <dt class="dt">
                  <i class="ruleModal-swiper-icon"></i>
                  加息特权发放规则说明
                  <i class="ruleModal-swiper-icon"></i>
                </dt>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">①</i>
                  12月3日-12月22日期间出借的We自动服务、We+自动服务(新手专享服务除外)均可享受1218活动期间获得的加息特权，加息特权将于12月23日起5个工作日由系统自动添加至用户符合条件的We自动服务、We+自动服务上；
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">②</i>
                  活动中获得的加息特权可累计，可与普惠加息叠加享受，加息额度均以最终叠加结果计算；
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">③</i>
                  加息特权仅限本次活动期间内使用，过期作废；
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-heart"></i>
                  We自动服务：加息匹配至所投标的，加息奖励将随标的回款计划按月发放或到期发放;
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-heart"></i>
                  We+自动服务：加息至所投服务退出服务时一次性发放持有时间产生的加息奖励。
                </dd>
              </dl>
              <!-- 加息专区 end -->
              <!-- 瓜分现金 -->
              <dl class="ruleModal-swiper-dl">
                <dt class="dt" ref="navItem1">
                  <i class="ruleModal-swiper-icon"></i>
                  瓜分现金
                  <i class="ruleModal-swiper-icon"></i>
                  </dt>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">①</i>
                  12月10日-12月17日期间，用户可通过个人或组队（2~3人）的形式进行连续登录并访问、点赞、邀请等任务来收集爱心，具体任务说明如下：
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-heart"></i>
                  连续登录并访问：每日登录并访问活动页面1次即可获得1颗爱心，连续登录并访问活动页面3天后，从第4天开始依次递增1颗<br/><i class="small">（举例：若连续登录并访问活动页面8天，则可获得1+1+1+2+3+4+5+6=23颗）</i>
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-heart"></i>
                  点赞：分享活动页，邀请好友点赞，1个赞=1颗爱心，最高可获得100颗爱心
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-heart"></i>
                  邀请新用户注册并完成首次出借：每邀请一位新用户注册并首次出借，金额≥100元，则邀请人可获得5颗爱心
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">②</i>
                  12月18日，将根据团队成员在12月10日-12月17日期间获得爱心总数进行排名，前5名可分别获得9000元/4500元/3000元/1500元/900元的现金奖励，由团队成员（2~3人）平均分配；
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">③</i>
                  12月18日-12月22日期间，个人爱心可用于兑换<i class="mark">0.1%~0.3%加息特权</i>，每人限兑换1次；
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">④</i>
                  以上任务由团队成员各自完成，集爱心数会计入团队总成绩；
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">⑤</i>
                  <i class="mark">每位用户仅限加入1个团队，一旦加入，不可退出不可更换。</i>
                </dd>
                <dd class="dd"><i class="mark">注：创建的团队名称建议积极向上，平台会对敏感词进行和谐处理</i></dd>
              </dl>
              <!-- 瓜分现金 end -->
              <!-- 幸运翻牌 -->
              <dl class="ruleModal-swiper-dl">
                <dt class="dt" ref="navItem2">
                  <i class="ruleModal-swiper-icon"></i>
                  幸运翻牌
                  <i class="ruleModal-swiper-icon"></i>
                </dt>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">①</i>
                  12月3日-12月22日期间，用户出借指定的We自动服务、We+自动服务（新手专享服务除外）累计出借金额≥2万元，即可获得1次参与普惠卡牌的机会，累计出借金额≥10万元，即可获得1次参与尊享卡牌的机会；
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">②</i>
                  翻牌活动时间：12月18日00:00-12月22日23:59；
                </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">③</i>
                  获奖后，系统会将奖品发放至团宝箱，实物礼品颜色随机，需用户在15个工作日内领取并填写收货地址，逾期未领取均视为自动放弃，不予补发；出借红包无需领取，可直接在出借时使用。
                </dd>
          
              </dl>
              <!-- 幸运翻牌 end -->
              <!-- 爱心榜单 -->
              <dl class="ruleModal-swiper-dl">
                <dt class="dt" ref="navItem3">
                  <i class="ruleModal-swiper-icon"></i>
                  爱心榜单
                  <i class="ruleModal-swiper-icon"></i>
                </dt>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">①</i>
                  12月3日-12月22日期间，将根据用户出借指定的We/We+自动服务（新手专享服务除外）累计出借金额进行排名，排名前500名均可获得奖励；
                  </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">②</i>
                  若用户加入金额相同，则根据最后一笔加入时间进行排名，较早加入的排名靠前；
                  </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">③</i>
                  榜单以截止于12月22日23:59:59的排名信息为准；
                  </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">④</i>
                  榜单名单将于次日后公布，系统会将实物礼品和现金红包发放至团宝箱，奖品发放后，用户可在15个工作日内领取，实物礼品需填写收货地址，如过期未领取，视为自动放弃，将不予补发；
                  </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">⑤</i>
                  本次活动与奖品与苹果公司无关；
                  </dd>
                <dd class="dd">
                  <i class="ruleModal-swiper-idx">⑥</i>
                  在法律许可范畴内，本次活动最终解释权归团贷网所有。
                  </dd>
              </dl>
              <!-- 爱心榜单 end -->
            </div>
          </div>
          <div class="swiper-scrollbar ruleModal-swiper-scrollbar"></div>
        </div>
        <ul class="ruleModal-swiper-nav">
          <li 
            class="item"
            :class="{'on':navIdx===i}"
            v-for="(item,i) in navItems"
            :key="i"
            @click="onNavItemClk(i)">
            {{item.text}}
          </li>
        </ul>
      </div>
    </div>
    <div class="ruleModal-close" @click="onClose"></div>
  </section>
</template>

<script>
  import Swiper from 'swiper'
  import '../assets/sass/swiper-3.4.2.scss'
  export default {

    props:['initIdx'],

    data(){
      return{
        swiper:null,
        navIdx:0,
        navItems:[
          {text:'加息专享',translate:0},
          {text:'瓜分现金',translate:0},
          {text:'幸运翻牌',translate:0},
          {text:'爱心榜单',translate:0},
        ],
      }
    },

    methods:{
      initSwiper(){
        const vm=this
        this.swiper=new Swiper('.ruleModal-swiper',{
          scrollbar: '.ruleModal-swiper-scrollbar',
          direction: 'vertical',
          slidesPerView: 'auto',
          freeMode: true,
          onInit(swiper){
            const swiperOffsetTop=vm.$refs.swiperContent.getBoundingClientRect().top
            const navMap={
              0:'navItem0',
              1:'navItem1',
              2:'navItem2',
              3:'navItem3',
            }
            vm.navItems.forEach((item,i,ctx)=>{
              const targetOffsetTop=vm.$refs[`navItem${i}`].getBoundingClientRect().top
              ctx[i].translate=targetOffsetTop-swiperOffsetTop
            })
          },
          onSetTranslate(swiper){
            const navItems=vm.navItems
            const navItem0Translate=navItems[0].translate-15
            const navItem1Translate=navItems[1].translate-15
            const navItem2Translate=navItems[2].translate-15
            const navItem3Translate=navItems[3].translate-15
            const swiperTranslate=swiper.translate

            if(swiperTranslate<-navItem3Translate){
              vm.navIdx=3
              return
            }
            if(swiperTranslate<-navItem2Translate){
              vm.navIdx=2
              return
            }
            if(swiperTranslate<-navItem1Translate){
              vm.navIdx=1
              return
            }
            if(swiperTranslate<-navItem0Translate||swiperTranslate<=0){
              vm.navIdx=0
              return
            }
          }
        })
        this.onNavItemClk(this.initIdx,0)
      },
      onClose(){
        this.$emit('closeCallback')
      },
      onNavItemClk(idx,duration=250){
        this.navIdx=idx
        const targetTranslate=this.navItems[this.navIdx].translate
        this.swiper.setWrapperTranslate(-targetTranslate+10)
        this.swiper.setWrapperTransition(duration)
      }
    },
    
    mounted(){
      this.$nextTick(()=>{
        this.initSwiper()
      })
    }

  }
</script>

