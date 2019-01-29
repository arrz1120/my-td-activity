

<template>
  <section class="page-container">
      <div class="banner">
          <div class="snow-container">
            <div class="snow snow-move"></div>
            <div class="snow snow-move"></div>
          </div>
          <div class="rule-btn" @click="_showRule" name="活动规则" mtaName="rule_a1">活动规则</div>
          <p class="ad-txt">【广告】市场有风险， 出借需谨慎</p>
          <div class="logo"></div>
          <div class="banner-tit"></div>
      </div>
      <div class="sec1">
          <div class="sec-tit">圣诞猜“树”</div>
          <p class="txt">活动期间，用户可在0-9中随意选择一个数字，猜中1次即可获得1份瓜分现金，开奖数字为猜数人次的末位数字，每日23:59停止猜数，24点开奖~</p>
          <div class="info">
              <div class="info-left">
                  <p class="info-p1">{{isActivityEnd?'12.28':'今日'}}瓜分金额（元）</p>
                  <p class="info-p2">{{dicidendMoney}}</p>
              </div>
              <div class="info-right">
                  <p class="info-p1">当前猜数人次</p>
                  <p class="info-p3">{{guessCount1}}<span>{{guessCount2}}</span></p>
              </div>
          </div>
          <p class="sec-p1">每30秒刷新一次数据</p>
          <p class="sec-p2">今日剩余猜数机会为<span>{{chance}}</span>次</p>
          <p class="sec-p3" @click="onGetChanceClick" name="首页获取猜数机会" mtaName="getchance_a3">获取猜数机会<i class="arrow-move"></i></p>
          <div class="select-container">
              <div class="select-arrow select-prev" @click="prev"></div>
              <div class="select-arrow select-next" @click="next"></div>
              <p class="select-p1">请选择您的数字</p>
              <p class="select-p2">{{guessNumber}}</p>
              <p class="select-p3">竞猜次数</p>
              <div class="select-flex">
                  <div class="minus" @click="minus"></div>
                  <input :style="{ fontSize: fontSize + 'px' }" 
                         type="text" 
                         class="input" 
                         ref="guessInput"
                         v-model="guessCount"
                         @focus="inputFocus"
                         @blur="inputBlur" 
                         @input="input" />
                  <div class="add" @click="add"></div>
              </div>
          </div>
          <div class="btn-yellow breath" name="页面猜数确定" mtaName="guess_a4" @click="onGuessClick">确定</div>
          <p class="sec-p4">每日首次猜数即有机会获得1份惊喜奖品~</p>
          <div class="today-select">
              <p class="ts-p1">今日已选数字</p>
              <div class="ts-wrapper">
                <div v-if="isLogin" class="ts-flex">
                    <div class="item" v-for="(item,index) in guessData" :key="index">
                        {{item.guessNumber}}<span>x{{item.guessCount}}</span>
                    </div>
                </div>
                <div v-else class="ts-flex">
                    <p class="no-login"><span @click="_toLogin">登录</span>查看已选数字</p>
                </div>
              </div>
          </div>
      </div>
      <div class="sec2">
          <div class="icon-connect icon-connect1"></div>
          <div class="icon-connect icon-connect2"></div>
          <div class="sec-tit">礼遇加息来助力</div>
          <div class="txt">
              活动期间，用户成功出借（且匹配成功）We自动服务、We+自动服务（新手专享服务除外），即可获得相应的加息奖励，加息幅度如下：
          </div>
          <div class="table">
              <div class="th">
                  <div class="td">产品类型</div>
                  <div class="td">加息幅度</div>
                  <div class="td">加息后<br />参考年回报率</div>
              </div>
              <div class="tr">
                  <div class="td">We自动服务3</div>
                  <div class="td">0.5%</div>
                  <div class="td">9.0%</div>
              </div>
              <div class="tr">
                  <div class="td">We自动服务6</div>
                  <div class="td">1.0%</div>
                  <div class="td">10.5%</div>
              </div>
              <div class="tr">
                  <div class="td">We自动服务12</div>
                  <div class="td">1.5%</div>
                  <div class="td">12.5%</div>
              </div>
              <div class="tr">
                  <div class="td">We+自动服务6</div>
                  <div class="td">0.5%</div>
                  <div class="td">10.5%</div>
              </div>
              <div class="tr">
                  <div class="td">We+自动服务12</div>
                  <div class="td">0.5%</div>
                  <div class="td">12.0%</div>
              </div>
              <div class="tr">
                  <div class="td">We+自动服务18</div>
                  <div class="td">0.5%</div>
                  <div class="td">12.1%</div>
              </div>
              <div class="tr">
                  <div class="td">We+自动服务24</div>
                  <div class="td">1.5%</div>
                  <div class="td">13.6%</div>
              </div>
              <div class="tr">
                  <div class="td">We+自动服务36</div>
                  <div class="td">1.5%</div>
                  <div class="td">14.1%</div>
              </div>
          </div>
          <p class="p1">若该期间开放的We自动服务、We+自动服务未能在活动期内满额，则该加息可延续至其满额为止。</p>
          <div class="btn-red breath" @click="onInvestBtnClick" name="普惠加息立即出借" mtaName="lend_a6">立即出借</div>
      </div>
      <p class="ad-txt-bottom">在法律允许的范围内，活动规则解释权归团贷网所有<br />*本次活动和奖品与苹果公司无关</p>
      <div class="btn-share" @click="_toShare" name="浮标分享" mtaName="share_a2"></div>
      <div class="btn-prize shake" @click="onPrizeBtnClick" name="中奖记录" mtaName="record_a5"></div>

      <box v-if="popup.box" @boxOpen="showPrize"></box>  
      <rule v-if="popup.rule" @on-close="hidePopup"></rule>  
      <popup v-if="popup.login" 
             @onBtnClick="onPopupLoginClick" 
             @on-close="hidePopup" 
             button-text="马上登录" 
             name="马上登录"
             mtaName="login_a7"
             title="亲，请先登录~">
      </popup>
      <popup v-if="popup.verified" 
             @onBtnClick="_toVerified" 
             @on-close="hidePopup" 
             button-text="前往认证" 
             name="前往认证"
             mtaName="realname_a8"
             title="亲，您还未实名认证哦~">
      </popup>
      <popup v-if="popup.yesterdayNoGuess" @onBtnClick="hidePopup" @on-close="hidePopup" button-text="好 的" title="亲，您昨日没有参与猜数哦~"></popup>
      <popup v-if="popup.actEnd" @onBtnClick="hidePopup" @on-close="hidePopup" button-text="确 定" title="活动已结束~"></popup>
      <popup v-if="popup.noChance" 
             @onBtnClick="_showChancePopup" 
             @on-close="hidePopup" 
             name="弹窗获取猜数机会"
             mtaName="nochance_b1"
             button-text="获取更多的猜奖机会" 
             title="亲，您没有足够的猜数机会~">
      </popup>
      <popup v-if="popup.stopGuess" 
             @onBtnClick="_pageRefresh" 
             @on-close="hidePopup" 
             name="每日停止猜数"
             mtaName="stopguess_b2"
             button-text="好 的" 
             title="亲，每日23:59停止猜数哦~">
      </popup>
      <popup v-if="popup.hasChoose" 
             @onBtnClick="guessConfirm" 
             @on-close="hidePopup" 
             name="竞猜数字二次确认"
             mtaName="confirm_b3"
             class="choose-popup" 
             button-text="确 定">
          <div class="choose">
            <div>
                <p><span class="label">您选择的数字: </span>{{guessNumber}}</p>
                <p><span class="label">竞猜次数: </span>{{guessCount}}次</p>
            </div>
        </div>
    </popup>
    <popup v-if="popup.guess" 
           @onBtnClick="showGuessResult" 
           @on-close="hidePopup" 
           class="guess-popup" 
           button-text="查看中奖详情" 
           name="昨日中奖"
           mtaName="yesterdaylottery_d1"
           title="昨日猜数人次为">
      <div class="countup">
        <countupp :end-val="yesterdayInfo.endVal" class="counter"></countupp>
      </div>
    </popup>
    <popup v-if="popup.prize" 
          @onBtnClick="toWatchPrize"
          @on-close="hidePopup" 
          class="prize-popup" 
          button-text="立即查看"
          name="每日奖品立即查看"
          mtaName="check_b5"
          :title="prizeName">
      <div class="prize-wrap">
        <img v-if="prizeName" :src="prizeSrc" alt="奖品" />
      </div>
      <div v-if="yesterdayInfo.guessCorrect">
        <p class="prize-detail-p1">
            中奖明细<i></i>
        </p>
        <p class="prize-detail-p2">瓜分奖励将于开奖后次日发放至团宝箱</p>
      </div>
    </popup>
    <popup v-if="popup.yesterdayPrize" 
          @on-close="hidePopup" 
          class="prize-popup" 
          :title="'恭喜获得' + yesterdayInfo.redEnvelopeStr + '元现金红包！'">
      <div class="prize-wrap">
        <img :src="require('../assets/images/prize1.png')" alt="奖品" />
      </div>
        <p class="prize-detail-p1" 
           name="昨日中奖明细"
           mtaName="lotterydetail_d2" 
           @click="showGuessIn">
            中奖明细<i></i>
        </p>
        <p class="prize-detail-p2">瓜分奖励将于开奖后次日发放至团宝箱</p>
    </popup>
    <popup :preventDefault="false" v-if="popup.guessIn" 
           @onBtnClick="hidePopup" 
           @on-close="hidePopup" 
           class="guessIn-popup" 
           button-text="好 的" 
           :title="yesterdayInfo.guessCorrect?'恭喜您猜中了~':'很遗憾，您昨日未猜中~'">
      <div class="con-txt">
          <section class="guess-num">
            <span>您昨日竞猜的数字：</span>
            <div class="list-wrapper" ref="wrapper">
              <div class="scroll-content" ref="content">
                <span class="scroll-item" v-for="(item, idx) in yesterdayGuessData" :key="idx">
                    <span class="lable-num">{{ item.guessNumber }}</span>
                    <i class="lable-count">x{{item.guessCount}}</i>
                    <i v-if="!(yesterdayGuessData.length-1 == idx)"> 、</i>
                </span>
              </div>
            </div>
          </section>
          <p>
            <span class="guess">昨日猜数人次：{{yesterdayInfo.endVal}}</span>
            <span>中奖数字：{{yesterdayInfo.trueNumber}}</span>
          </p>
          <p>昨日瓜分金额：{{yesterdayInfo.dicidendMoney}}元</p>
          <p>昨日瓜分份数：{{yesterdayInfo.guessTrueNumberCounting}}份</p>
        </div>
    </popup>
    <popup v-if="popup.noPrize"
           @on-close="hidePopup" 
           title="很遗憾，奖品已送完~">
        <div class="no-prize"></div>
        <div class="con-btn no-prizeBtn" name="每日猜数奖品送完" mtaName="empty_b4" @click="onNoPrizeClick">确 定</div>
    </popup>
    <getGuessChance v-if="popup.getGuessChance" 
                    @on-close="hidePopup" 
                    @on-share="_toShare" 
                    @on-borrow="onInvestBtnClick" 
                    :borrowMoney="userWeAmount">
    </getGuessChance>
    <PrizeAlert v-if="popup.prizeAlert" 
                @on-close="hidePopup" 
                :winRecordList="winRecordList" 
                :lottryRecordList="lottryRecordList"
                @on-get="onGetBonus"            
    ></PrizeAlert>
  </section>
</template>

<script>
import '../assets/sass/home.scss'
import {getInitInfo,getUserInfo,guess,getTanchuangInfo,getLotteryRecordList, getDrawRecordList,share} from '../api/home.js'
import {toLogin,toVerified,toP2P,toTBX,toTB} from '../js/lib/utils.js'
import popup from './popup'
import countupp from './countup'
import rule from './rule'
import box from './box'
import getGuessChance from './getGuessChance'
import PrizeAlert from './prizeAlert'
import Share from '../js/lib/initShare.js'
import '../js/lib/toast.js'

// import vconsole from 'vconsole'
// new vconsole()

export default {
    created(){
        Share.set(this)
        this._initStatus()
    },
    mounted(){
        setInterval(() => {
            getInitInfo().then(res => {
                this.nowGuessCounting = res.guessCounting
            }).catch(err => {
                this.toastErr()
            })
        },30000)
    },
    data(){
        return {
            isGuessCommit: false,
            noEnoughPrizeFlag: false,
            isLogin: false,
            isActivityEnd: false,
            firstTanChuangFlag: true,
            dicidendMoney: 0, //今日瓜分金额
            nowGuessCounting: 0, //当前猜数人次
            userRealNameVerified: false, //是否实名,
            firstGuessFlag: false, //是否第一次猜 
            chance: 0, //猜题机会
            guessData: [], //已猜数据
            yesterdayGuessData: [], //用户昨天猜的数字 
            guessNumber: 0, //猜的数字
            guessCount: 1, //猜的次数
            prizeName: '', 
            userWeAmount: 0,
            winRecordList: [],              //中奖纪录,
            lottryRecordList: [],              //开奖纪录
            popup: {
                box: false, //开宝箱
                rule: false,
                login: false, //登录弹窗
                verified: false,//实名认证弹窗
                actEnd: false,//活动已结束
                noChance: false,//咩有足够的猜奖机会
                stopGuess: false,//停止猜奖
                hasChoose: false,//已经选择
                prize: false,//获得18元现金红包
                guess: false,// 猜奖人数
                guessIn: false,//中奖弹窗
                yesterdayNoGuess: false, //昨日未抽奖
                getGuessChance: false,//获取猜数机会
                yesterdayPrize: false, //所日瓜分所得奖励
                noPrize: false, //奖品已送完
                prizeAlert: false //中奖&开奖
            },
            yesterdayInfo: {
                isGuess: false, //昨日是否猜题
                guessCorrect: false, //昨日猜题是否正确
                endVal: 0, //昨天所有人的猜数总次数
                dicidendMoney: 0, //昨天瓜分金额
                trueNumber: null, //昨天的正确答案
                guessTrueNumberCounting: null,  //昨天所有人猜中正确答案的总次数
                redEnvelopeStr: 0 //昨天应发的红包金额
            }
        }
    },
    computed:{
        fontSize(){
            let count = this.guessCount.toString().length
            if(count===1){
                return 28
            }
            if(count===2){
                return 24
            }
            if(count===3){
                return 18
            }
            if(count===4){
                return 14
            }
            if(count>4){
                return 10
            }
        },
        prizeSrc(){
            if(!this.prizeName){
                return ''
            }
            if(this.prizeName.indexOf('红包') === -1){
                return require('../assets/images/prize2.png')
            }else{
                return require('../assets/images/prize1.png')
            }
        },
        guessCount1(){
            if(this.nowGuessCounting<10){
                return ''
            }else{
                let str = this.nowGuessCounting.toString()
                return parseInt(str.substring(0,str.length - 1))
            }
        },
        guessCount2(){
            if(this.nowGuessCounting<10){
                return this.nowGuessCounting
            }else{
                let str = this.nowGuessCounting.toString()
                return parseInt(str.charAt(str.length - 1))
            }
        }
    },
    methods:{
        showPopup(name){
            this.hidePopup()
            this.popup[name] = true
        },
        hidePopup(){
            for(var key in this.popup){
                if(this.popup[key]){
                    this.popup[key] = false
                }
            }
        },
        _initStatus(){
            getInitInfo().then(res => {
                this.isLogin = res.loginFlag
                this.isActivityEnd = res.activityEndFlag
                this.nowGuessCounting = res.guessCounting
                this.dicidendMoney = res.dicidendMoney
                this.firstTanChuangFlag = res.firstTanChuangFlag
            }).then(res => {
                this._getYesterdayInfo()
                this._getUserInfo()
            }).catch(err=> {
                this.toastErr()
            })
        },
        _getYesterdayInfo(){
            if(this.isActivityEnd){
                toast.show('活动已结束')
                return
            }
            if(this.firstTanChuangFlag){
                return
            }
            getTanchuangInfo().then(res => {
                this.showPopup('guess')
                this.yesterdayInfo.endVal = res.yesterdayGuessCounting 
                this.yesterdayInfo.dicidendMoney = res.yesterdayDicidendMoney 
                this.yesterdayInfo.trueNumber = res.yesterdayTrueNumber 
                this.yesterdayInfo.guessTrueNumberCounting = res.yesterdayGuessTrueNumberCounting
                if(res.yesterdayUserGuessNumberInfo && res.yesterdayUserGuessNumberInfo.length>0){
                    this.yesterdayGuessData = res.yesterdayUserGuessNumberInfo
                    this.yesterdayInfo.isGuess = true
                    let isCorrect = res.yesterdayUserGuessNumberInfo.some(item => item.guessNumber == res.yesterdayTrueNumber) 
                    if(isCorrect){
                        this.yesterdayInfo.redEnvelopeStr = res.yesterdayRedEnvelopeStr 
                        this.yesterdayInfo.guessCorrect = true
                    }else{
                        this.yesterdayInfo.guessCorrect = false
                    }
                }else{
                    this.yesterdayInfo.isGuess = false
                    this.yesterdayInfo.guessCorrect = false
                }
            }).catch(err => {
                this.toastErr()
            })
        },
        _getUserInfo(){
            if(this.isLogin){
                getUserInfo().then(res => {
                    this.chance = parseInt(res.userRemainGuessCounting)
                    this.guessData = res.userGuessNumberInfo.reverse()
                    // this.guessData = [
                    //     {guessNumber: 5, guessCount: 1},
                    //     {guessNumber: 2, guessCount: 1},
                    //     {guessNumber: 1, guessCount: 2},
                    //     {guessNumber: 0, guessCount: 1},
                    //     {guessNumber: 9, guessCount: 1}
                    // ]
                    this.userRealNameVerified = res.userRealNameVerifiedFlag
                    this.userWeAmount = res.userWeAmount
                }).catch(err => {
                    this.toastErr()
                })
            }
        },
        _toLogin(){
            toLogin()
        },
        onPopupLoginClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            toLogin()
        },
        _toVerified(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            toVerified()
        },
        _showChancePopup(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.showPopup('getGuessChance')
        },
        _pageRefresh(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            location.href = location.href
        },
        _showRule(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.showPopup('rule')
        },
        toWatchPrize(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            toTBX()
        },
        showGuessIn(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.hidePopup()
            this.showPopup('guessIn')
        },
        onInvestBtnClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            let {isActivityEnd} = this
            if(isActivityEnd){
                this.showPopup('actEnd')
                return
            }
            toP2P()
        },
        onGetBonus (e) {
            toTBX()
        },
        onPrizeBtnClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            if(!this.isLogin){
                this.showPopup('login')
                return
            }
            this._getLotteryRecordList()
            this._getDrawRecordList()
        },
        _toShare(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            let {isLogin,isActivityEnd} = this
            if(isActivityEnd){
                this.showPopup('actEnd')
                return
            }
            if(!isLogin){
                this.showPopup('login')
                return
            }    
            Share.show()
        },
        shareCallback(){
            share().then(res => {
                if(res){
                    this.chance += 1
                }
            }).catch(err => {
                this.toastErr()
            })
        },
        prev(){
            if(this.guessNumber === 0){
                return
            }
            this.guessCount = 1
            this.guessNumber--
        },
        next(){
            if(this.guessNumber === 9){
                return
            }
            this.guessCount = 1
            this.guessNumber++
        },
        add(){
            // if(this.guessCount === this.chance){
            //     return
            // }
            this.guessCount++
        },
        minus(){
            if(this.guessCount === 1){
                return
            }
            this.guessCount--
        },
        format(value){
            let val = value
            if(val === ''){
                val = this.guessCount
            }else{
                if(val.substring(0,1)==='0' && val.length>1){
                    val = parseInt(val.substring(1))
                }else{
                    val = parseInt(val)
                    if(val<1){
                        val = 1
                    }
                }
            }
            return val
        },
        input(e){
            e.target.value = e.target.value.replace(/\D/gi,"")
            this.guessCount = this.format(e.target.value)
        },
        inputBlur(e){
            if(e.target.value === '' || e.target.value == 0){
                e.target.value = 1
            }
            this.guessCount = this.format(e.target.value)
        },
        inputFocus(e){
            e.target.value = ''
        },
        onGuessClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            let {isLogin,isActivityEnd,userRealNameVerified,guessCount,chance} = this
            if(isActivityEnd){
                this.showPopup('actEnd')
                return
            }
            if(!isLogin){
                this.showPopup('login')
                return
            }
            if(!userRealNameVerified){
                this.showPopup('verified')
                return
            }
            if(guessCount>chance){
                this.showPopup('noChance')
                return
            }
            this.showPopup('hasChoose')
        },
        guessConfirm(e){
            if(this.isGuessCommit){
                return
            }
            this.isGuessCommit = true
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            let {guessNumber,guessCount} = this
             guess(guessNumber,guessCount).then(res => {
                this.isGuessCommit = false
                this.chance = res.userRemainGuessCounting
                let tempData = res.userGuessNumberInfo.reverse()
                this.guessData = this.sortData(tempData) 
                this.hidePopup()
                if(res.firstGuessFlag){
                    this.firstGuessFlag = true
                    if(res.noEnoughPrizeFlag){
                        this.noEnoughPrizeFlag = true
                    }else{
                        this.prizeName = `恭喜获得${res.prizeName}`
                    }
                    this.showPopup('box')
                }
            }).catch(err => {
                this.isGuessCommit = false
                this.hidePopup()
                if(err.response.data.status){
                    let status = err.response.data.status
                    if((status.toString().substring(0,1) == '5')){
                        this.toastErr()
                        return
                    }
                    if(status === 694){
                        this.showPopup('stopGuess')
                        return
                    }
                    if(status === 693){
                        this.showPopup('noChance')
                        return
                    }
                    if(status === 882){
                        this.showPopup('noPrize')
                        return
                    }
                    if(status === 611){
                        this.showPopup('noPrize')
                        return
                    }
                    if(status === 804){
                        toast.show('请输入数字')
                        return
                    }
                    toast.show(err.response.data.message)
                }else{
                    this.toastErr()
                }
            })
        },
        toastErr(){
            toast.show('网络异常，请稍后重试')
        },
        onGetChanceClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            if(!this.isLogin){
                this.showPopup('login')
                return
            }
            this.showPopup('getGuessChance')
        },
        showGuessResult(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            let {isLogin,yesterdayInfo} = this
            this.hidePopup()
            if(!isLogin){
                this.showPopup('login')
                return
            }
            if(yesterdayInfo.isGuess){
                if(yesterdayInfo.guessCorrect){
                    this.showPopup('yesterdayPrize')
                }else{
                    this.showPopup('guessIn')
                }
            }else{
                this.showPopup('yesterdayNoGuess')
            }
        },
        _getLotteryRecordList() {
          if (this.isLogin) {
            getLotteryRecordList().then(res => {
              this.winRecordList = res
              this.showPopup('prizeAlert')
            }).catch(err => {
              const errData = err
              if(errData.code === 'FORBIDDEN') {
                this.showPopup('login')
              } else if (errData.code === 'ACTIVITY_NOT_EXIST') {
                toast.show(errData.message || '活动不存在')
              } else {
                this.toastErr()
              }
            })
          }
        },
        _getDrawRecordList() {
          if (this.isLogin) {
            getDrawRecordList().then(res => {
              this.lottryRecordList = res
            }).catch(err => {
              const errData = err
              if(errData.code === 'FORBIDDEN') {
                this.showPopup('login')
              } else if (errData.code === 'ACTIVITY_NOT_EXIST') {
                toast.show(errData.message || '活动不存在')
              } else {
                this.toastErr()
              }
            })
          }
        },
        onNoPrizeClick(e){
            AddMaiDian(e.target.getAttribute('mtaName'),e.target)
            this.hidePopup()
        },
        showPrize(){
            if(this.noEnoughPrizeFlag){
                this.showPopup('noPrize')
            }else{
                this.showPopup('prize')
            }
        },
        sortData(data){
            if(data.length === 0){
                return []
            }else{
                let dataGuess = data.filter(item => item.guessNumber === this.guessNumber)
                let noGuess = data.filter(item => item.guessNumber !== this.guessNumber)
                noGuess.unshift(dataGuess[0])
                return noGuess
            }
        }      
    },
    components:{
      popup,
      countupp,
      rule,
      box,
      PrizeAlert,
      getGuessChance
    }
}
</script>

