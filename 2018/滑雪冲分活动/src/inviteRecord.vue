<style lang="scss">
  .content{
    position: relative;
    width: 100%;
    height: 100vh;
    @include bg('./assets/images/record-bg.jpg');
    background-size: cover;
    padding-top: rem(120);
    }
  .tab{
    width: rem(690);
    margin: 0 auto;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    font-size: rem(28);
    position: relative;
    background: #fff;
    z-index: 2;
    >.item{
      height: rem(86);
      line-height: rem(86);
      flex: 1;
      background: #007ead;
      position: relative;
      color: #ffffff;
      &.on{
        background: #fff;
        color: #0074a1;
        }
      }
    }

  .tab-item{
    width: 4rem;
    margin: 0 auto;
    height: rem(77);
    line-height: rem(77);
    position: relative;
    z-index: 1;
    }
  .swiper{
    padding: rem(15) 0 rem(50);
    @include wh(690,476);
    background: #fff;
    }
  .swiper-slide{
    height: auto;
    }
  .tab-content{
    /*padding: 0 rem(40);*/
    }
  .record-list-null{
    box-shadow: 0 rem(5) rem(5) 0 rgba(204, 253, 254, 0.75);
    @include wh(690,739);
    background: #fff;
    margin: 0 auto;
    padding: rem(60) 0 rem(50);
    .xiaopai{
      @include wh(224,177);
      @include bg('./assets/images/null.png');
      display: block;
      margin: rem(80) auto rem(30);
      }
    font-size: rem(24);
    color: #c0c1c1;
    text-align: center;
    }

  .record-top{
    @include wh(690,161);
    margin: rem(12) auto 0;
    display: -webkit-box;
    background: #fff;
    div{
      -webkit-box-flex: 1;
      text-align: center;
      padding-top: rem(43);
      span{
        display: block;
        font-size: rem(22);
        color: #333333;
        &:nth-child(1){
          font-size: rem(54);
          color: #cb2d2d;
          font-weight: bold;
          }
        }
      }
    }

  .record-list{
    @include wh(690,554);
    background: #fff;
    margin: rem(12) auto 0;
    .list-con{
      @include wh(690,68);
      line-height: rem(68);
      display: -webkit-box;
      span{
        width: 33.33%;
        display: block;
        -webkit-box-flex: 1;
        text-align: center;
        font-size: rem(22);
        color: #666666;
        }
      &.head-list{
        height: rem(79);
        line-height: rem(79);
        span{
          color: #0074a1;
          }
        }
      }
    }

  .btn-share {
    display: block;
    margin: rem(45) auto 0;
    border-radius: rem(10);
    background-image: -webkit-linear-gradient( 90deg, rgb(142,6,6) 0%, rgb(214,52,52) 100%);
    @include wh(689,94);
    line-height: rem(94);
    font-size: rem(40);
    color: #ffffff;
    text-align: center;
    }

</style>

<template>
  <section class="content">
    <div class="tab">
      <div v-for="(item,idx) in tabItems"
           :key="idx"
           :name="item.trackName"
           :class="{'on':idx+''===tabIdx}"
           @click="onTabItemClk(idx,$event)"
           class="item">
        <div class="tab-item">
          <p class="tab-text">{{item.text}}</p>
        </div>
      </div>
    </div>
    <!-- 邀请记录 -->
    <div v-show="tabIdx==='0'" class="tab-content">
      <div v-if="inviteData.length===0" class="record-list-null">
      <i class="xiaopai"></i>
      暂时没有相关数据
      </div>
      <div v-else>
        <div class="record-top">
          <div>
            <span>{{registerCount}}</span><span>总计注册好友</span>
          </div>
          <div>
            <span>{{inviteCount}}</span><span>总计出借达标</span>
          </div>
        </div>
        <div class="record-list">
          <div class="list-con head-list">
            <span>好友</span>
            <span>注册日期 </span>
            <span>累计出借金额</span>
          </div>
          <div  class="swiper swiper-container js-inviteSwiper">
            <div class="swiper-wrapper">
              <div class="swiper-slide">
                <div class="list-con" v-for="(item,idx) in inviteData" :key="idx"> 
                  <span>{{item.telNo}}</span>
                  <span>{{item.registerDate}}</span>
                  <span>{{invetSum(item.isInvest)}}</span>
                </div>
              </div>
            </div>
            <div class="rulescrollbar swiper-scrollbar"></div>
          </div>
        </div>
      </div>
    </div>
    <!-- 邀请记录 end -->
    <!-- 冲分记录 -->
    <div v-show="tabIdx==='1'" class="tab-content">
      <div v-if="pointsInfo.length===0" class="record-list-null">
        <i class="xiaopai"></i>
        暂时没有相关数据
      </div>
      <div v-else>
        <div class="record-top">
          <div>
            <span>{{pointRecordNum}}</span><span>总计积分记录</span>
          </div>
          <div>
            <span>{{totalPoints}}</span><span>总计积分数</span>
          </div>
        </div>
        <div class="record-list">
          <div class="list-con head-list">
            <span>获得时间</span>
            <span>途径 </span>
            <span>获得积分</span>
          </div>
          <div class="swiper swiper-container js-rankingSwiper">
            <div class="swiper-wrapper">
              <div class="swiper-slide">
                <div class="list-con" v-for="(item,idx) in pointsInfo" :key="idx">
                  <span>{{item.createTimeStr}}</span>
                  <span>{{item.remark}}</span>
                  <span>{{item.changeCount}}</span>
                </div>
              </div>
            </div>
            <div class="rulescrollbar swiper-scrollbar"></div>
          </div>
        </div>
      </div>
    </div>
    <!-- 冲分记录 end -->
    <p @click="shareBtnClk" name="邀请冲分页_好友助力" class="btn-share">好友助力  速达高分领现金</p>

    <!-- 登录弹窗 -->
    <ModalContainer
            v-if="modalStatus.login"
            @onCloseBtnClk="modalStatus.login=false">
      <AlertModal
              :title="['亲，请先登录后再参与活动哦~']"
              btnText="前往登录"
              :btnCallback="onLoginModalBtnClk"
      />
    </ModalContainer>
    <!-- 登录弹窗 end -->

  </section>
</template>
<script>
    import Swiper from 'swiper'
    import qs from 'querystringify'
    import {inviteRecordAPI} from './api/baseApi.js'
    import {apiShareGame,} from './api/gameApi.js'
    import ModalContainer from './components/modalContainer.vue'
    import AlertModal from './components/alertModal.vue'
    import {toLogin,} from './js/lib/utils.js'
    import initShare from './js/lib/initShare.js'
    export default {
        components:{
            ModalContainer,
            AlertModal,
        },
        data(){
            return{

                inviteSwiper:null,
                rankingSwiper:null,

                extenderKey:'',
                registerCount: null,
                inviteCount: null,
                pointRecordNum: null,
                totalPoints: null,
                inviteData:[],
                pointsInfo:[],
                modalSwiper:null,
                modalStatus:{
                    login:false,
                },
                tabItems:[
                    {text:'邀请记录',trackName:'邀请冲分页_邀请记录tab'},
                    {text:'冲分记录',trackName:'邀请冲分页_冲分记录tab'},
                ],
                tabIdx:'0',
            }
        },
        methods:{
            onTabItemClk(idx,{target}){
              sa.quick('trackHeatMap',target)
              this.tabIdx=idx+''
              this.$nextTick(()=>{
                if(this.tabIdx==='0'){
                  if(this.inviteSwiper) return
                  this.inviteSwiper= new Swiper('.js-inviteSwiper',{
                      scrollbar: '.rulescrollbar',
                      direction: 'vertical',
                      slidesPerView: 'auto',
                      scrollbarHide:false,
                      freeMode: true,
                  })
                }
                if(this.tabIdx==='1'){
                  if(this.rankingSwiper) return
                  this.rankingSwiper= new Swiper('.js-rankingSwiper',{
                      scrollbar: '.rulescrollbar',
                      direction: 'vertical',
                      slidesPerView: 'auto',
                      scrollbarHide:false,
                      freeMode: true,
                  })
                }
              })
            },
            // 登录弹窗-前往登录 click 事件
            onLoginModalBtnClk(){
                toLogin()
            },
            shareBtnClk({target}){
                try {
                    sa.quick('trackHeatMap',target)
                } catch (error) {}
                initShare.set({
                    shareUrl:`${router.land}?extenderKey=${this.extenderKey}`,
                    callback(state){
                        if(state!=='onComplete') return
                        apiShareGame()
                            .then(res=>{
                                if(res.code!=='SUCCESS'){
                                    toast.show(res.message)
                                    return
                                }
                                window.location.href=window.location.href
                            })
                            .catch(err=>{
                                toast.show('好友助力失败，请重试')
                            })
                    }
                })
                initShare.show()
            },
            invetSum(type){
                switch (type) {
                    case -1:
                        return '--'
                    case 0:
                        return '<1000'
                    case 1:
                        return '≥1000'
                    case 2:
                        return '≥30000'
                }
            }
        },
        mounted(){
            initShare.set()
        },
        created(){
            let qsUrl=qs.parse(window.location.search)
            inviteRecordAPI().then(res=>{
                if (res.code === "601"){
                    this.modalStatus.login=true
                    return
                }
                let resData=res.data
                this.extenderKey= resData.extenderKey
                this.inviteCount= resData.inviteRecord.inviteCount
                this.registerCount= resData.inviteRecord.registerCount
                this.pointRecordNum= resData.pointRecordNum
                this.totalPoints= resData.totalPoints
                this.inviteData=resData.inviteRecord.inviteData.map((item,i)=>{
                    return{
                        key:i,
                        telNo:item.telNo,
                        registerDate:item.registerDate,
                        isInvest:item.isInvest
                    }
                })
                this.pointsInfo=resData.pointsInfo.map((item,i)=>{
                    return{
                        key:i,
                        createTimeStr:item.createTimeStr,
                        remark:item.remark,
                        changeCount:item.changeCount
                    }
                })
                this.onTabItemClk(qsUrl.tabIdx||'0','')
            }).catch(err=>{
                // toast.show('服务器繁忙，请刷新')
            })
        },
    }
</script>





