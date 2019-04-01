(function() {
  var utils = {
    // 普通弹窗 
    // options = {
    // content: 信息
    // callback: 按钮回调
    // }

    message: function(options) {
      var msg = typeof options === 'string' ? options : options.message;
      popup({
        "message": msg,
        "btn": {
          style: options.btn_style || 'btn-message',
          text: options.btn_text || '确认',
          callback: options.callback
        },
        "tips_text": options.tips_text
      });
    },
    toast: function(msg, duration) {
      duration = duration ? duration : 1500;
      var _toast = $('<div/>').addClass('toast').html(msg);
      $('body').append(_toast);
      setTimeout(function() {
        _toast.remove();
      }, duration);
    },
    pxToRem: function(px, basePx) {
      var basePx = basePx || 23.4375;
      return px / basePx / 2;
    },
    remToPx: function(rem, basePx) {
      var basePx = basePx || parseFloat(document.querySelector("html").style.fontSize);
      return rem * basePx;
    },
    pxToPx: function(px, basePx) {
      return this.remToPx(this.pxToRem(px, basePx), basePx);
    },
    getParam: function(name, url) {
      if (!url) {
        url = location.href;
      }
      var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
      var returnValue;
      for (var i = 0; i < paraString.length; i++) {
        var tempParas = paraString[i].split('=')[0];
        var parasValue = paraString[i].split('=')[1];
        if (tempParas === name)
          returnValue = parasValue;
      }

      if (!returnValue) {
        return "";
      } else {
        if (returnValue.indexOf("#") != -1) {
          returnValue = returnValue.split("#")[0];
        }
        return returnValue;
      }
    },
    getCookie: function(name) {
      var arr, reg = new RegExp("(^|)" + name + "=([^;]*)(;|$)");
      if (arr = document.cookie.match(reg)) {
        return unescape(arr[2]);
      } else {
        return null;
      }
    },
    isLogined: function() { //判断tuandaiw或tuandaiapp_t是否存在，存在则认为app已登录
      var loginToken;
      if (Jsbridge && Jsbridge.isApp() && !Jsbridge.isCorrectVersion('5.1.2', true)) { //如果app版本小于5.1.2
        loginToken = this.getCookie('tuandaiapp_t'); //tuandaiapp_t 对应url中的t 5.1.2之前的loginToken
      } else {
        loginToken = this.getCookie('tuandaiw');
      }
      return !!loginToken; //如果loginToken存在，则表示已经登录成功
    },
    openLogin: function(ReturnUrl, force) { //force为是否强制打开登录，为false时，在已经登录状态，不再打开登录
      if (!force && this.isLogined()) {
        return false;
      }
      // 在app内，正常情况则打开app登录，否则打开web登录页面
      if (Jsbridge && Jsbridge.isApp() && this.getCookie("tuandaiapp_s") !== 2) { //tuandaiapp_s 对应url中的s，当s=2时~表示app获取登录状态异常
        Jsbridge.toAppLogin();
      } else {
        ReturnUrl = ReturnUrl ? ReturnUrl : window.location.href;
        ReturnUrl = encodeURIComponent(ReturnUrl);
        window.location.href = "https://passport.tdw.cn/2login?ret=" + ReturnUrl;
      }
    }
  }

  window.Utils = utils;
})();