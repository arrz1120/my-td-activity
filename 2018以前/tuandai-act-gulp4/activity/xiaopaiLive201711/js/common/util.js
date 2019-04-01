(function(global) {
    /* ==================弹出框==dialog================= */
    /*
        options : {
            type: 弹窗类型, share--分享弹窗
            title: 提示标题,
            conClassName: alert-con的类名,
            content: 提示内容,
            btns: [{
                txt: 按钮文案
                className: 按钮类名
                cb: callback
            }] // 按钮数组为空则会默认添加一个关闭按钮, 若按钮数组只有一个，那么是cancel，按钮数组两个，第一个为confirm按钮，第二个为cancel按钮
        }
    */
    function popup(options) {
        var _options = {
            "type": "",
            "title": "",
            "conClassName": "",
            "content": "",
            "btns": [{
                "txt": "",
                "cb": function() {}
            }, {
                "txt": "",
                "cb": function() {}
            }]
        };
        _options = $.extend(_options, options || {});
        var alert_wrapper = $("<div/>").addClass("alert-wrapper"),
            mask = $("<div/>").addClass("mask"),
            alert_con = $("<div/>").addClass("alert-con " + _options.conClassName),
            cancel_cb = null,
            confirm_cb = null,
            cls_btn = $("<div/>").addClass("cls-btn");


        // 弹窗标题
        if (_options.title) {
            var _title = $("<p/>").addClass("alert-title").html(_options.title);
            alert_con.append(_title);
        }

        alert_con.append(_options.content);

        // 弹窗按钮
        if (_options.btns.length > 1) {
            var cancel_btn = $("<div/>").addClass("cancel-btn").html(_options.btns[0].txt),
                confirm_btn = $("<div/>").addClass("confirm-btn").html(_options.btns[1].txt);
            cancel_cb = _options.btns[0].cb;
            confirm_cb = _options.btns[1].cb;
            alert_con.append(cancel_btn).append(confirm_btn);
        }else if(_options.btns.length !== 0){
            confirm_btn = $("<div/>").addClass("confirm-btn one").html(_options.btns[0].txt)
            confirm_cb = _options.btns[0].cb;
            alert_con.append(confirm_btn);
        }
        
        alert_wrapper.append(mask).append(alert_con);
        $("body").append(alert_wrapper);
        // $('html').addClass('unscroll');

        //事件绑定
        mask.bind("click", function(e) {
            hide(alert_wrapper);
        });

        cancel_btn && cancel_btn.bind("click", function(e) {
            cancel_cb && cancel_cb.call(this, arguments);
            hide(alert_wrapper);
            // $("body").removeClass('unscroll');
            // $('html').removeClass('unscroll');
        });

        confirm_btn && confirm_btn.bind("click", function(e) {
            // var confirmReturn =  confirm_cb && confirm_cb.call(this, arguments);
            // confirm_cb ? confirmReturn && hide(alert_wrapper) :　hide(alert_wrapper);
            confirm_cb && confirm_cb.call(this, arguments);
            hide(alert_wrapper);
            // $("body").removeClass('unscroll');
            // $('html').removeClass('unscroll');

        });

        cls_btn.bind("click", function(e) {
            hide(alert_wrapper);
            // $("body").removeClass('unscroll');
            // $('html').removeClass('unscroll');
        });
        function hide(target) {
            target.remove();
        }
    }
    var Util = {
        isApp: function () {
            return Jsbridge.isApp();
        },
        isIOS: function() {
            return navigator.userAgent.match(/(iPad|iPhone)/);
        },
        isAndroid: function() {
            return navigator.userAgent.indexOf('Android') > -1 || navigator.userAgent.indexOf('Adr') > -1;
        },
        isWeiXin: function() {
            var ua = navigator.userAgent.toLowerCase();
            return ua.match(/MicroMessenger/i) == 'micromessenger';
        },
        pxToRem: function(px, basePx) {
            var basePx = basePx || 75;
            return px / basePx;
        },
        remToPx: function(rem, basePx) {
            var basePx = basePx || parseInt(document.querySelector("html").style.fontSize);
            return rem * basePx;
        },
        pxToPx: function(px, basePx) {
            return this.remToPx(this.pxToRem(px, basePx), basePx);
        },
        pxToRemAdapt: function(px) {
            return this.pxToRem(px, parseInt(document.querySelector("html").style.fontSize));
        },

        getParam: function(name, url) {
            if (!url) {
                url = location.href;
            }
            var paramString = url.substring(url.indexOf("?") + 1, url.length);
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = paramString.match(reg);

            if (r != null) return decodeURIComponent(r[2]);
            return null;
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
        },
        toast: function(msg, duration) {
            duration = duration || 1500;
            var _toast = $("<div/>").addClass('toast').html(msg);
            $('body').append(_toast);
            setTimeout(function() {
                _toast.remove();
            }, duration);
        },
        popup: popup
    }
    global.Util = Util;
})(window);