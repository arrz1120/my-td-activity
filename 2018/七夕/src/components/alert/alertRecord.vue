<template>
        <div class="alert-tips"  @touchmove.prevent>
            <div v-if="showType == 'con-record'">
                <div class="con-record con">
                        <h2 class="tit-1">喜鹊记录</h2>
                        <div class="close"  @click="refreshPage"></div>

                        <div class="has-data" v-if="recordList && recordList.length>0">
                            <h3 class="list-tit">
                                <span>来源</span>
                                <span>召唤时间</span>
                            </h3>
                            <Scroll
                                class="wrapper-record"
                                :scrollbar="{}"
                                :data="recordList.length"
                            >
                            <div>
                                <ul class="list">
                                    <li v-for="(item,index) in recordList" :key="index">
                                        <div class="list-item">
                                            {{item.desc}}
                                        </div>
                                        <div class="list-item">
                                            {{item.drawDate}}
                                        </div>    
                                    </li>
                                </ul>
                            </div>
                            </Scroll>
                        </div>
                        <div class="no-date" v-else>暂时没有相关数据</div>
                </div>
            </div>
            <div v-if="showType=='con-fri-record'">
                <div class="con-fri-record con">
                        <h2 class="tit-1">邀请好友记录</h2>
                        <div class="close"  @click="closeAlert"></div>

                        <div class="has-data" v-if="recordFriList && recordFriList.length>0">
                            <h3 class="list-tit">
                                <span>好友</span>
                                <span>注册日期</span>
                                <span>是否投资</span>
                            </h3>
                            <Scroll
                                class="wrapper-record"
                                :scrollbar="{}"
                                :data="recordFriList.length"
                            >
                            <div>
                                <ul class="list">
                                    <li v-for="(item,index) in recordFriList" :key="index">
                                        <div class="list-item">
                                            <span>{{item.phoneNum}}</span>
                                        </div>
                                        <div class="list-item">
                                            <span>{{item.registerTime}}</span>  
                                        </div>
                                        <div class="list-item">
                                            <span v-if='item.invite'>已投资</span>
                                            <span v-if='item.send&&!item.invite' class="active">已提醒</span>
                                            <span
                                            v-if='!item.invite&&!item.send'
                                            class="active1"
                                            name="提醒投资"
                                            @click="tipsInvite($event,{realName:item.realName,flag:item.flag,index:index})"
                                            >提醒投资</span>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            </Scroll>
                        </div>
                        <div class="no-date" v-else>
                        暂时没有相关数据
                            <div class="btn"
                            @click="inviteFir"
                            name="马上邀请_邀请好友弹窗"
                            >马上邀请</div>
                        </div>
                </div>
                </div>
            </div>
</template>
<script>
import Scroll from "../../base/scroll";
import {isApp} from '../../js/bridge.js'
import {ShareShow, ShareCallBack} from '../../js/share.js'

// let num = 5;

export default {
  props: ["showType", "recordList", "recordFriList"],
  data() {
    return {
      ItemIndex: ""
    };
  },

  methods: {
    closeAlert() {
      this.$emit("toggleAlertRecord", false);
    },

    replaceParamVal(paramName,replaceWith) {
        var oUrl = location.href.toString();
        var re=eval('/('+ paramName+'=)([^&]*)/gi');
        var nUrl = oUrl.replace(re,paramName+'='+replaceWith);
        location = nUrl;
        window.location.href=nUrl
    },

    refreshPage(){
        this.replaceParamVal('v',new Date().getTime());
    },
    tipsInvite(e, obj) {
      AddMaiDian('remind14a',e.target)
      // this.recordFriList[index].send=true;
      this.$emit("toggleAlertRecord", false);
      this.$emit("showAlertTips", {
        type: "con-5"
      });
      this.$emit("sendMsgFun", {
        msgUser: obj.realName,
        msgFlag: obj.flag,
        itemIndex: obj.index
      });
    },
    inviteFir(e) {
      AddMaiDian('invite13a',e.target)
      this.$emit("toggleAlertRecord", false);
      ShareShow()
      if (isApp) {
        ShareCallBack()
      }
    }

  },

  components: {
    Scroll
  }
};
</script>

<style lang="scss">
@import "./alert.scss";
.wrapper-record {
  height: rem(360);
  width: rem(494);
  margin: 0 auto;
  overflow: hidden;
  position: relative;
  .bscroll-vertical-scrollbar {
    z-index: 2 !important;
    background: #d3bdda;
    opacity: 1 !important;
    border-radius: 3px;
    right: rem(15) !important;
  }
  .bscroll-indicator {
    background: #f9f1fc !important;
    border-color: #d3bdda !important;
  }
}
</style>
