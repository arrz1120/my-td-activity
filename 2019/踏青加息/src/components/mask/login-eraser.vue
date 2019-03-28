<template>
  <div class="mask-normal">
    <p class="mask-p1 pt30">登录有礼</p>
    <div class="login-eraser">
      <div class="le-content">
          <img :src="loginEraser.prizeImage" alt="">
          <p>{{loginEraser.prizeName}}</p>
      </div>  
      <!-- <div class="opacity-cover" v-if="!loginEraser.able"></div> -->
      <div class="finger finger-move" v-if="loginEraser.able && !loginEraser.begin"></div>
      <canvas ref="scoreEraser" v-if="!loginEraser.finish"></canvas>
    </div>
    <p class="le-p2">活动期间，用户每日首次登录活动页面即可获得一次额外的刮奖机会。</p>
  </div>
</template>

<script>
import * as util from '../../js/lib/util'
import Eraser from '../../js/lib/eraser.js'
import {loginDraw} from '../../api/baseAPI'

export default {
  mounted() {
      this.initLoginEraser()
  },
  data() {
    return {
      loginEraser: {
        begin: false,
        prizeName: "",
        prizeImage: "",
        finish: false,
        able: true
      }
    };
  },
  methods: {
    initLoginEraser() {
      const vm = this;
      new Eraser(this.$refs.scoreEraser, {
        width: util.rem(400),
        height: util.rem(196),
        touchSize: 20,
        cover: require('../../assets/images/login-eraser-cover.png'),
        onErase() {
          const { loginEraser } = vm;
          if (loginEraser.begin || loginEraser.finish) {
            return;
          }
          loginEraser.begin = true;
          loginDraw().then(res => {
            const {prizeName,typeId} = res
            if(typeId == 1){
                loginEraser.prizeImage = require('../../assets/images/lottery/hb.png')
            }
            else if(typeId == 2){
                loginEraser.prizeImage = require('../../assets/images/lottery/jxq.png')
            }
            loginEraser.prizeName = prizeName
})
        },
        onComplete() {
          vm.loginEraser.able = false;
          vm.loginEraser.finish = true;
          vm.$emit('showCloseBtn')
        }
      });
    }
  }
};
</script>

