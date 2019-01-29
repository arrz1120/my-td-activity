<template>
  <div id="app">
    <Container
        :state="state"
        @showPrize="_showPrize"
        @toggleRule="_toggleRule"
        @showAlertTips="_showAlertTips"
        @showAlertAward="_showAlertAward"
        @showAlertRecord="_showAlertRecord">
    </Container>
    <Record
        :state="state"
        @showAlertTips="_showAlertTips"
        @showAlertRecord="_showAlertRecord">
    </Record>
     <AlertTips
        v-show="showAlertTips"
        @toggleAlertTips="_toggleAlertTips"
        @changeRecFriList ="_changeRecFriList"
        :showType="alertTipsType"
        :state="state"
        :boxType="boxType"
        :tbNum="vaildCoin"
        :sendMsg="sendMsg"
        >
    </AlertTips>
    <AlertRecord
        :showType="alertRecordType"
        v-show="showAlertRecord"
        @toggleAlertRecord="_toggleAlertRecord"
        @showAlertTips="_showAlertTips"
        @sendMsgFun="_sendMsgFun"
        :recordList="recordList"
        :recordFriList="recordFriList"
        >
    </AlertRecord>
    <Rule
        v-if="showRule"
        @toggleRule="_toggleRule">
    </Rule>
    <Award
        v-if="award.show"
        @showAlertAward="_showAlertAward"
        :award="award">
    </Award>
  </div>
</template>

<script>

import AlertRecord from './components/alert/alertRecord'
import AlertTips from './components/alert/alertTips'
import Award from './components/alert/award'
import Rule from './components/alert/rule'
import Container from './components/container/container'
import Record from './components/record/record'
import {setShare} from './js/share.js'
import {getIndexInfo} from './api/api'

if(process.env.NODE_ENV==='development'){
    window.isLogined = true
}

export default {
  name: 'App',
  data(){
      return {
          state: {},
          activityState:'',
          alertTipsType: '',
          alertRecordType: '',
          showRule: false,
          showAlertTips: false,
          showAlertRecord: false,
          sendMsg:{},
          recordList:[],
          recordFriList:[],
          vaildCoin: 0,
          award: {
              show: false,
              name: '',
              src: '',
              type: '',
              giftType: ''
          },
          boxType: ''
      }
  },
  created() {
    this._getIndexInfo()
  },
  methods: {
      _getIndexInfo(){
          getIndexInfo().then((res) => {
              if (res.code === 'SUCCESS') {
                  this.state = res.data
                  this.state.logined = isLogined
                  this.state.activityTimeStauts = 1
              }
              else if (res.code === "ACTIVITY_NOT_START"){
                  this.state = {
                      activityTimeStauts: 0,
                      logined: isLogined
                  }
              }
              else if (res.code === "ACTIVITY_FINISHED"){
                  this.state = {
                      activityTimeStauts: 2,
                      logined: isLogined
                  }
              }
              if (this.state.logined) {
                setShare(this.state.logined)
              } 
          }).catch((err) => {
          })
      },
     _toggleRule(show){
        this.showRule = show
      },
      _showAlertTips(param){
          this.alertTipsType = param.type
          this.vaildCoin = param.vaildCoin
          this.boxType = param.boxType
          this.showAlertTips = true
      },
      _showAlertRecord(param){
          this.alertRecordType = param.type
          this.recordList = param.recordList
          this.recordFriList = param.recordFriList
          this.showAlertRecord = true
      },
      _toggleAlertTips(show){
          this.showAlertTips = show
      },
      _toggleAlertRecord(show){
          this.showAlertRecord = show
      },
      _sendMsgFun(datas){
          this.sendMsg.msgUser = datas.msgUser;
          this.sendMsg.msgFlag = datas.msgFlag;
          this.sendMsg.itemIndex = datas.itemIndex;

      },
      _changeRecFriList(index){
        if(this.recordFriList[index]!=undefined){
            this.recordFriList[index].send=true;
        }
      },
      _showAlertAward(param){
        //   this.award.show = param.show
        //   if(param.name) this.award.name = param.name
        //   if(param.src) this.award.src = param.src
        //   if(param.type) this.award.type = param.type
        //   if(param.giftType) this.award.giftType = param.giftType
          this.award = {
              show: param.show,
              name: param.name,
              src: param.src,
              type: param.type,
              giftType: param.giftType
          }
      },
      _showPrize(param) {
          if (this.state.userDrawPrizeList && param.prizeName) {
              this.state.userDrawPrizeList[param.boxType].boxStatus = 3
              this.state.userDrawPrizeList[param.boxType].prizeName = param.prizeName
          }
          if(param.giftType){
              this.award.giftType = param.giftType
          }
      }
  },
  components: {
    Container,
    Record,
    AlertTips,
    AlertRecord,
    Rule,
    Award
  }
}
</script>

<style lang="scss">
    @import './assets/sass/_reset.scss';
</style>
