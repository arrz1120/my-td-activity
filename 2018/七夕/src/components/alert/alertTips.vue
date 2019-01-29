<template>
        <div class="alert-tips"  @touchmove.prevent>
               <div class="con-1 con" v-show="showType=='con-1'" >
                    <h2 class="tit-1" v-if="state.activityTimeStauts===0">活动未开始!</h2>
                    <h2 class="tit-1" v-if="state.activityTimeStauts===2">活动已结束!</h2>
                    <p class="txt" v-if="state.activityTimeStauts===0">本次活动时间为2018年8月15日-8月21日。活动尚未开始，敬请期待！</p>
                    <p class="txt" v-if="state.activityTimeStauts===2">本次活动时间为2018年8月15日-8月21日。活动已结束，非常感谢您的关注！</p>
                    <div class="btn" @click="closeAlert">我知道了</div>
                </div>
                <div class="con-2 con"  v-show="showType=='con-2'">
                    <h2 class="tit-1">请先登录</h2>
                    <p class="txt">亲，请先登录后再参与活动哦~</p>
                    <div class="btn"  @click="toLogin" name="前往登录">前往登录</div>
                    <div class="close"  @click="closeAlert"></div>
                </div>
               <div class="con-3 con"  v-show="showType=='con-3'">
                    <h2 class="tit-2">确认消耗<span class="red">200</span>团币召唤一只喜鹊？</h2>
                    <p class="txt red">我的团币：{{tbNum}}</p>
                    <div class="btn" @click="tbCall" name="确认召唤">确认召唤</div>
                    <div class="close"  @click="closeAlert"></div>
             </div>
             <div class="con-4 con"  v-show="showType=='con-4'">
                    <h2 class="tit-2">您当前团币不足200，召唤失败~</h2>
                    <p class="txt red">我的团币：{{tbNum}}</p>
                    <div class="btn"   @click="closeAlert">我知道了</div>
             </div>
             <div class="con-5 con"  v-show="showType=='con-5'">
                    <h2 class="tit-1">提醒好友投资</h2>
                    <p class="txt">您获得的10元红包已到账，有效期7天，记得使用哟！http://t.cn/RDViK3F(好友{{sendMsg.msgUser}})</p>
                    <div class="btn" @click="sendMsgFun" name="免费发短信">免费发短信</div>
                    <div class="close"  @click="closeAlert"></div>
             </div>
             <div class="con-6 con"  v-show="showType=='con-6'">
                    <h2 class="tit-2">您的喜鹊不足，无法开宝箱~</h2>
                    <p class="txt">开启此宝箱需要累计召唤<span class="red">{{boxType}}</span>只喜鹊哦~</p>
                    <div
                      class="btn"
                      :name="boxType==3?'前往召唤喜鹊_宝箱一':'前往召唤喜鹊_宝箱二'"
                      @click="goToCallXiQue">前往召唤喜鹊</div>
                    <div class="close"  @click="closeAlert"></div>
             </div>

             <!--
            <div class="con-7 con"  v-show="showType=='con-7'">
                    <p class="txt-2">您已经是团贷网老司机了！<br>快前往召唤喜鹊助牛郎织女重逢，<br>赢88元现金红包~</p>
                    <a class="btn"  href="#strategy"  @click="goToCallXiQue">前往召唤喜鹊</a>
                    <div class="close"  @click="closeAlert"></div>
             </div>
             -->
        </div>

</template>

<script>
import { Login } from "../../js/bridge.js";
import "../../js/toast.js";
import { postMsg,getTuanbiTicket } from "../../api/api";

//

let num = 5;

export default {
  props: ["showType", "state", "boxType", "tbNum", "sendMsg"],
  data() {
    return {
      issend: true
    };
  },
  methods: {
    closeAlert() {
      this.$emit("toggleAlertTips", false);
    },
    toLogin(e) {
      AddMaiDian('login11a',e.target)
      Login();
    },
    replaceParamVal(paramName,replaceWith) {
        // window.location.reload()
        var oUrl = location.href.toString();
        var re=eval('/('+ paramName+'=)([^&]*)/gi');
        var nUrl = oUrl.replace(re,paramName+'='+replaceWith);
        location = nUrl;
        window.location.href=nUrl
    },

    refreshPage(){
        this.replaceParamVal('v',new Date().getTime());
    },
    tbCall(e) {
      AddMaiDian('sure12a',e.target)
      let vm = this
      if(this.calling){
        return
      }
      this.calling = true
      getTuanbiTicket().then(res => {
        if(res.code === 'SUCCESS') {
          if (res.data === "SUCCESS") {
            vm.$emit("toggleAlertTips", false)
            toast.show("成功召唤喜鹊",2000,function(){
              vm.refreshPage()
            })
          }
          else if (res.data === "NOT_ENOUGH") {
            vm.$emit("toggleAlertTips", false)
            toast.show("团币不足，召唤失败")
          }
          else if (res.data === "ALREADY_ACQUIRE") {
            vm.$emit("toggleAlertTips", false)
            toast.show("你已召唤喜鹊")
          }
        } else {
          toast.show("服务器繁忙，请稍后再试",2000,function(){
              vm.$emit("toggleAlertTips", false)
          })
        }
      }).catch(err => {
        toast.show("服务器繁忙，请稍后再试",2000,function(){
              vm.$emit("toggleAlertTips", false)
          })
      })
    },
    sendMsgFun(e) {
      AddMaiDian('sendmessage15a',e.target)
      postMsg(this.sendMsg.msgFlag)
        .then(res => {
          if (res.code === "SUCCESS") {
            this.$emit("toggleAlertTips", false);
            this.$emit("changeRecFriList",this.sendMsg.itemIndex);
            if (res.data === "SUCCESS") {
              toast.show("短信发送成功！");
            } else if (res.data === "ALREADY_REMAIN") {
              toast.show("已发送过短信！");
            }
          }
          if(res.code === "INTERNAL_ERROR"){
              this.$emit("toggleAlertTips", false);
              toast.show("服务器繁忙，请稍后再试");
          }
        })
        .catch(err => {
        });
    },
    goToCallXiQue(e) {
      if (this.boxType == 3) {
        AddMaiDian('callmagpie17a',e.target)
      } else {
        AddMaiDian('callmagpie19a',e.target)
      }
      this.closeAlert()
      let strategyDomOffsetTop = document.getElementById('strategy').getBoundingClientRect().top
      let scrollY=window.scrollY
      window.scrollTo(0,strategyDomOffsetTop+scrollY)
    }
  }
};
</script>

<style lang="scss" scoped>
@import "./alert.scss";
</style>
