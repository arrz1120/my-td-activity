<template>
  <section class="content">
    <i class="logo"></i>
    <span class="ad-tips">【广告】市场有风险，出借需谨慎</span>
    <i class="icon-txt"></i>
    <span class="ad-tips">【广告】市场有风险，出借需谨慎</span>
    <span class="time">活动时间：2018.11.26-12.10</span>
    <div class="sidebar-container">
      <div class="item icon-home" name="冲分榜页_返回首页icon" @click="toHomeBtnClk"></div>
      <div class="item icon-yq" name="冲分榜页_邀请记录icon" @click="toRecordBtnClk"></div>
      <div class="item icon-jl" name="冲分榜页_我的奖励icon" @click="onMyPrizeBtnClk"></div>
    </div>

    <div class="avatar-con" v-if="isLogined">
      <div class="avatar">
        <img v-if="headImage===''" :src="require('./assets/images/ranking/avatar.png')">
        <img v-else :src="headImage" alt="">
      </div>
      <div class="sj-con">
        <div>
          <span @click="toCFRecordBtnClk">{{points}} <i name="冲分榜页_冲分记录icon"></i></span>
          <span>我的积分</span>
        </div>
        <div>
          <span>{{gapReward}}</span>
          <span>离下波奖励还差</span>
        </div>
      </div>
    </div>
    <div class="avatar-con" v-if="!isLogined" @click="onLoginModalBtnClk">
      <div class="avatar">
        <img :src="require('./assets/images/ranking/avatar.png')">
      </div>
      <div class="sj-con">
        <div>
          <p>去登录查看积分&gt;</p>
        </div>
      </div>
    </div>
    <div class="con1">
      <span class="title">达标奖  抽666现金</span>
      <i class="icon-bx"></i>
      <p>积分达标30000分即可抽取<span>（每人有一次抽取机会）</span></p>
      <span class="btn-draw btn-draw-gray" v-if="points<30000&&prizeStatus===0" name="冲分榜页_开始抽奖" @click="btnDrawClk">开始抽奖</span>
      <span class="btn-draw" v-if="points>=30000&&prizeStatus===0 || !isLogined" name="冲分榜页_开始抽奖" @click="btnDrawClk">开始抽奖</span>
      <span class="btn-draw btn-draw-gray" v-if="prizeStatus===1"  @click="btnDrawEdClk">查看奖品</span>
    </div>
    <div class="con2">
      <span class="title">冲分奖  领3888现金</span>
      <p>最终累计积分以最后一天23:59:59为准<br>冲分奖不叠加，按最高级别发放</p>
    </div>
    <div class="con3">
      <span class="title">高分秘籍 轻松领现金</span>
      <i class="icon-rule" @click="onEgBtnClk"></i>
      <div class="item-con">
        <div class="item" name="冲分榜页_滑雪大作战" @click="toGameBtnClk">
          <i class="xiaopai"></i>
          <span class="red">滑雪抽团币</span>
          <span>每人每天可玩两次</span>
        </div>
        <div class="item">
          <i class="icon1"></i>
          <span>团贷网好友助力</span>
          <span>自己和好友都得积分</span>
        </div>
        <div class="item">
          <i class="icon2"></i>
          <span>好友注册成功</span>
          <span>游戏积分X4倍</span>
        </div>
        <div class="item">
          <i class="icon3"></i>
          <span>好友出借≥1000</span>
          <span>直接获5000积分</span>
        </div>
        <div class="item">
          <i class="icon4"></i>
          <span>好友出借≥30000</span>
          <span>直接获30000积分</span>
        </div>
      </div>
    </div>
    <div class="footer-btn">
      <span class="btn-share" name="冲分榜页_好友助力" @click="shareBtnClk">好友助力  速达高分领现金</span>
    </div>
    <p class="tips-bq">本活动及奖品与苹果公司无关</p>

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

    <!-- 我的奖品弹窗 -->
    <ModalContainer
            topic="我的奖品"
            v-if="modalStatus.userPrize"
            @onCloseBtnClk="modalStatus.userPrize=false">
      <MyPrizeModal
              :prizeItems="myPrizeList"
              @btnCallback="modalStatus.userPrize=false"
      />
    </ModalContainer>
    <!-- 我的奖品弹窗 end -->


    <!-- 冲分抽奖弹窗 -->
    <ModalContainer
            :topic="rankingModal.topic"
            v-if="modalStatus.ranking"
            @onCloseBtnClk="modalStatus.ranking=false">
      <RankingModal
              :punchStatus="punchStatus"
              :topic="rankingModal.topic"
              :msgs="rankingModal.msgs"
              :prizeVal="rankingModal.prizeVal"
              :btnTextA="rankingModal.btnTextA"
              :btnTextB="rankingModal.btnTextB"
              :ikwonModalBtnClk="ikwonModalBtnClk"
              :toGetModalBtnClk="toGetModalBtnClk"
      />
    </ModalContainer>
    <!-- 冲分抽奖弹窗 end -->

    <!-- 规则弹窗 -->
    <ModalContainer
            topic="积分规则"
            v-if="modalStatus.eg"
            @onCloseBtnClk="modalStatus.eg=false">
      <EgModal/>
    </ModalContainer>
    <!-- 规则弹窗 end -->

  </section>
</template>

<script>
    import {rankAPI,iKnowAPI,pointsdrawAPI} from './api/baseApi.js'
    import {apiGetMyPrize,} from './api/indexApi.js'
    import {apiShareGame,} from './api/gameApi.js'
    import ModalContainer from './components/modalContainer.vue'
    import EgModal from './components/egModal.vue'
    import AlertModal from './components/alertModal.vue'
    import RankingModal from './components/rankingModal.vue'
    import MyPrizeModal from './components/myPrizeModal.vue'
    import {toLogin,toTBX} from './js/lib/utils.js'
    import initShare from './js/lib/initShare.js'
    export default {
        components:{
            ModalContainer,
            EgModal,
            AlertModal,
            RankingModal,
            MyPrizeModal,
        },
        name: 'App',
        data(){
            return{
                isLogined:false,
                activityStatus:null,
                headImage:'',
                points:null,
                prizeStatus:null,
                punchStatus:null,
                gapReward:null,
                prizeName:'',
                extenderKey:'',
                myPrizeList:[],
                modalStatus:{
                    eg:false,
                    ranking:false,
                    login:false,
                    userPrize:false,
                    activityEnd:false,
                },
                rankingModal:{
                    topic:'一分耕耘一分收获',
                    msgs:['恭喜您获得'],
                    prizeVal:'',
                    btnTextA:'我知道了',
                    btnTextB:'领取奖品',
                }
            }
        },
        methods:{
            // 未达标
            btnDrawEdClk(){
                toTBX()
            },
            // 达标抽奖
            btnDrawClk({target}){
                sa.quick('trackHeatMap',target)
                const {isLogined,points,modalStatus}=this
                // 登录状态判断
                if(isLogined===0){
                    modalStatus.login=true
                    return
                }
                if(points<30000){
                    toast.show('您积分还未达到30000分，暂无资格抽奖！')
                    return
                }
                pointsdrawAPI().then(res=>{
                    console.log(res)
                    if(res.code===601){
                        toast.show('已抽过')
                        return
                    }
                    if(res.code===602){
                        toast.show('未达标')
                        return
                    }
                    if(res.code===200){
                        this.rankingModal.prizeVal=res.prizeName.replace(/元现金红包/,'')
                        this.modalStatus.ranking=true
                        return
                    }
                }).catch(err=>{
                    toast.show('服务器繁忙，请刷新重试')
                })
            },
            // 得分弹窗按钮 click 事件
            ikwonModalBtnClk({target}){
                sa.quick('trackHeatMap',target)
                this.modalStatus.ranking=false
                iKnowAPI().then(res=>{
                    console.log(res)
                }).catch(err=>{
                    toast.show('服务器繁忙，请刷新重试')
                })
            },
            toGetModalBtnClk({target}){
                try {
                    sa.quick('trackHeatMap',target)
                } catch (error) {}
                toTBX()
            },
            toHomeBtnClk({target}){
                try {
                    sa.quick('trackHeatMap',target)
                } catch (error) {}
                window.location.href=router.index
            },
            // 我的奖励 click 事件
            onMyPrizeBtnClk({target}){
                sa.quick('trackHeatMap',target)
                if(!this.isLogined){
                    this.modalStatus.login=true
                    return
                }
                // 获取我的奖励数据
                apiGetMyPrize()
                    .then(res=>{
                        if(res.code!=='SUCCESS'){
                            toast.show(res.message)
                            return
                        }
                        this.myPrizeList=res.data.prize.map(item=>{
                            return{
                                date:item.drawDate,
                                prizeName:item.prizeName,
                                prizeType:item.typeId,
                                status:item.prizeStatus,
                            }
                        })
                        this.modalStatus.userPrize=true
                    })
                    .catch(err=>{
                        toast.show('服务器繁忙，请重试')
                    })
            },
            toRecordBtnClk({target}){
                try {
                    sa.quick('trackHeatMap',target)
                } catch (error) {}
                if(!this.isLogined){
                    this.modalStatus.login=true
                    return
                }
                window.location.href= `${router.inviteRecord}?tabIdx=0`
            },
            toCFRecordBtnClk({target}){
                try {
                    sa.quick('trackHeatMap',target)
                } catch (error) {}
                window.location.href= `${router.inviteRecord}?tabIdx=1`
            },
            // 登录弹窗-前往登录 click 事件
            onLoginModalBtnClk(){
                toLogin()
            },
            onEgBtnClk(){
                this.modalStatus.eg=true
            },
            toGameBtnClk({target}){
                try {
                    sa.quick('trackHeatMap',target)
                } catch (error) {}
                window.location.href=router.game
            },
            shareBtnClk({target}){
                try {
                    sa.quick('trackHeatMap',target)
                } catch (error) {}
                // 登录后才分享
                const {isLogined,modalStatus}=this
                if(isLogined===0){
                    modalStatus.login=true
                    return
                }
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
        },
        mounted(){
            initShare.set()
        },
        created(){
            rankAPI().then(res=>{
                this.isLogined=res.status.loginStatus
                this.activityStatus=res.status.activityStatus
                this.extenderKey=res.status.extenderKey
                this.headImage=res.headImage
                this.points=res.points
                this.prizeStatus=res.prizeStatus
                this.punchStatus=res.punchStatus
                this.gapReward=res.gapReward
                if(this.punchStatus===1){
                    this.rankingModal.prizeVal=res.prizeName.replace(/元现金红包/,'')
                    this.modalStatus.ranking=true
                }
            }).catch(err=>{
                toast.show('服务器繁忙，请刷新重试')
            })
        },
    }
</script>
