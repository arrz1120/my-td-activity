<style lang="scss">
  .app{
    min-height: 100vh;
    height: rem(1202);
    // overflow: hidden;
    position: relative;
  }
  .bg{
    height: 100%;
    overflow: hidden;
  }
  .content{
    position: relative;
    z-index: 2;
  }
  .banner{
    padding-top: rem(123);
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
  .write-box{
    @include wh(714,706);
    background: #fff;
    border-radius: 4px; 
    margin: rem(110) auto 0;
    padding-top: rem(36);
    position: relative;
    .input-box{
        padding-left: rem(54);
    }
    .input-flex{
        display: flex;
        padding-bottom: rem(44);
        align-items: center;
        position: relative;
        span{
            color: #a77d41;
            font-size: rem(30);
            width: rem(156);
            display: block;
            text-align: justify;
        }
        input{
            display: block;
            border: 1px solid #c4a579;
            color: #a77d41;
            border-radius: 4px;
            @include wh(446,81);
            padding: 0 rem(10);
        }
        .tips{
            color: #ff3c00;
            position: absolute;
            top: rem(81);
            left: rem(166);
            line-height: rem(44);
        }
    }
    .textarea{
      width: rem(613);
      position: relative;
      margin: 0 auto;
      textarea{
        display: block;
        @include wh(613,277);
        border: 1px solid #b49261;
        border-radius: 4px;
        padding: rem(20);
        color: #a77d41;
        resize: none;
      }
      .ta-tips{
        text-align: right;
        color: #a77d41;
        margin-top: rem(21);
      }
      .tips{
          color: #ff3c00;
          position: absolute;
          top: rem(298);
          left: rem(10);
      }
    }
    .btn{
      display: block;
      width: rem(578);
      text-align: center;
      color: #5c2907;
      font-size: rem(40);
      padding: rem(30) 0;
      border-radius: rem(46);
      position: absolute;
      left: 50%;
      bottom: 0;
      transform: translate(-50%,50%);
      background: linear-gradient(to bottom,#ffe240,#f4a901);
    }
  }
</style>

<template>
  <section class="app">
    <bg></bg>
    <div class="content">
      <div class="banner">
        <div class="logo"></div>
        <div class="b-tit1"></div>
        <div class="b-tit2">记录你最难忘的中秋故事</div>
      </div>
      <div class="write-box">
          <div class="input-box">
              <div class="input-flex">
                  <span>文章标题：</span>
                  <input 
                      type="text" 
                      @input="onInput($event,{maxLength: 30, tipsIndex: 1})"
                      @compositionend="inputEnd($event,{maxLength: 30, tipsIndex: 1})"
                      placeholder="请填写30字以内的标题~"
                      ref="title"/>
                  <p class="tips" v-show="tips1.show">{{tips1.val}}</p>
              </div>
              <div class="input-flex">
                  <span>昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</span>
                  <input 
                    type="text" 
                      placeholder="请填写10字以内的昵称~"
                      @input="onInput($event,{maxLength: 10, tipsIndex: 2})"
                      @compositionend="inputEnd($event,{maxLength: 10, tipsIndex: 2})"
                    ref="nickName"/>
                  <p class="tips" v-show="tips2.show">{{tips2.val}}</p>
              </div>
          </div>
          <div class="textarea">
            <textarea 
              class="textarea" 
              placeholder="请输入800到3000字的文章内容~" 
              @compositionstart="inputStart"
              @input="onInput($event,{maxLength: 3000})"
              @compositionend="inputEnd($event,{maxLength: 3000})"
              ref="article"></textarea>
            <p class="ta-tips">{{txtLen + '/3000'}}</p>
            <p class="tips" v-show="tips3.show">{{tips3.val}}</p>
          </div>
          <div class="btn" @click="commit" name="马上投稿_1b">马上投稿</div>
      </div>
    </div>
    <tipsAlert
      @hideAlert="hideTipsAlert"
      :show="showTipsAlert.show"
      :showType="showTipsAlert.showType"
    ></tipsAlert>
  </section>
</template>

<script>
import Bg from './components/bg'
import tipsAlert from './components/alert/tips'
import {sendArticle} from './api/api.js'

export default {
  data() {
    return {
      isCnInput: false,
      txtLen: 0, 
      tips1: {
          show: false,
          val: ''
      },
      tips2: {
          show: false,
          val: ''
      },
      tips3: {
          show: false,
          val: ''
      },
      showTipsAlert: {
        show: false,
        showType: ''
      },
      areaLength: 0,
      inputing: false,
      areaModel: ''
    }
  },
  methods: {
    inputStart(e) {
      this.isCnInput = true;
    },
    inputEnd(e,param) {
      this.isCnInput = false
      let len = e.target.value.length
      let {maxLength,tipsIndex} = param
      if(len > maxLength) {
          len = maxLength
          e.target.value = e.target.value.substring(0,maxLength)
          if(tipsIndex){
            this.showTips(tipsIndex,{
                show: true,
                val: e.target.getAttribute('placeholder')
            })
          }
      }
      if(!tipsIndex){
        this.txtLen = len
      }
    },
    onInput(e,param) {
      if(this.isCnInput) return
      let len = e.target.value.length
      let {maxLength,tipsIndex} = param
      if(len > maxLength) {
          len = maxLength
          e.target.value = e.target.value.substring(0,maxLength)
          if(tipsIndex){
            this.showTips(tipsIndex,{
                show: true,
                val: e.target.getAttribute('placeholder')
            })
          }
      }
      if(!tipsIndex){
        this.txtLen = len
      }
    },
    showTips(idx,opt) {
        clearTimeout(this.timer)
        this.timer = setTimeout(() => {
            this.tips1.show = false
            this.tips2.show = false
            this.tips3.show = false
            clearTimeout(this.timer)
        },2000)
        if(idx === 1) {
            this.tips1 = opt
            return
        } 
        else if(idx === 2) {
            this.tips2 = opt
            return
        }
        else if(idx === 3) {
            this.tips3 = opt
            return
        }
    },
    commit(e) {
        AddMaiDian('write1b', e.target)
        let {title,nickName,article} = this.$refs
        if(title.value === ''){
            this.showTips(1,{
                show: true,
                val: '标题不能为空'
            })
            return
        }
        if(title.value.length > 30) {
          this.showTips(1,{
                show: true,
                val: '请填写30字以内的标题~'
            })
            return
        }
        if(nickName.value === ''){
            this.showTips(2,{
                show: true,
                val: '请填写昵称~'
            })
            return
        }
        if(nickName.value.length > 10) {
          this.showTips(2,{
                show: true,
                val: '请填写10字以内的昵称~'
            })
            return
        }
        if(article.value === ''){
            this.showTips(3,{
                show: true,
                val: '文章不能为空'
            })
            return
        }
        if(article.value.length < 800) {
          this.showTips(3,{
                show: true,
                val: '请填写800字及以上的文章~'
            })
            return
        }
        if(article.value.length > 3000) {
          this.showTips(3,{
                show: true,
                val: '请填写3000字及以内的文章~'
            })
            return
        }
        sendArticle({
          title: title.value,
          nickName: nickName.value,
          article: article.value
        }).then(res => {
            this.showTipsAlert = {
              show: true,
              showType: 'thx'
            }
        }).catch(err => {
          if(err) {
            this.showErr()
          }
        })
      },
      hideTipsAlert() {
        this.showTipsAlert = false
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
    tipsAlert
  }
}
</script>
