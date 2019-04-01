(function(global) {

    /* ==================弹出框==dialog================= */
    /*
                options : {
                    title: 提示标题,
                    content: 提示内容(可传入模版）,
                    btns: [{
                        name: 按钮名称
                        cb: callback
                    }] // 若按钮数组只有一个，那么是alert，按钮数组两个，第一个为negative按钮，第二个为positive按钮
                }
            */
    function popup(options) {
        var _options = {
            "title": "",
            "content": "",
            "btns": [{
                "name": "",
                "cb": function() {}
            }, {
                "name": "",
                "cb": function() {}
            }]
        };
        _options = $.extend(_options, options || {});
        var dialog_component = $("<div/>").addClass('popup').addClass("component-dialog"),
            masker = $("<div/>").addClass("masker"),
            dialog_wrapper = $("<div/>").addClass("dialog-wrapper"),
            dialog_title = _options.title ? $("<h5/>").addClass('with-border').html(_options.title) : '',
            dialog_content = $("<div/>").addClass("dialog-content").html(_options.content),
            btns = $("<div/>").addClass("btns"),
            negative_btn = '',
            positive_btn = '',
            ne_cb = null,
            po_cb = null;
        dialog_wrapper.append(dialog_title);
        dialog_wrapper.append(dialog_content);
        if (_options.btns.length > 1) {
            negative_btn = $("<div/>").addClass("btn").addClass("btn-nav").html(_options.btns[0].name);
            positive_btn = $("<div/>").addClass("btn").addClass("btn-pos").html(_options.btns[1].name);
            btns.append(negative_btn).append(positive_btn);
            ne_cb = _options.btns[0].cb;
            po_cb = _options.btns[1].cb;
            dialog_wrapper.append(btns);
        } else {
            positive_btn = $("<div/>").addClass("btn").addClass("btn-pos").html(_options.btns[0].name);
            dialog_wrapper.append(positive_btn);
            po_cb = _options.btns[0].cb;
        }

        // dialog_wrapper.append(dialog_content).append(btns);

        dialog_component.append(masker).append(dialog_wrapper);

        $("body").append(dialog_component);
        // disableScrolling();
        Util.disableScroll();
        //事件绑定
        masker.bind("click", function(e) {
            hide(dialog_component);
        });

        negative_btn && negative_btn.bind("click", function(e) {
            ne_cb && ne_cb.call(this, arguments);
            hide(dialog_component);
        });

        positive_btn.bind("click", function(e) {
            po_cb && po_cb.call(this, arguments);
            hide(dialog_component);
        });

        function hide(target) {
            target.remove();
            // enableScrolling();
            Util.enableScroll();
        }
    }


    var Util = {
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
        toast: function(msg, duration) {
            duration = duration || 1500;
            var _toast = $("<div/>").addClass('toast').html(msg);
            $('body').append(_toast);
            setTimeout(function() {
                _toast.remove();
            }, duration);
        },

        setSessionStorage: function(key, obj) {
            obj = obj || {};
            if (window.sessionStorage) {
                window.sessionStorage[key] = JSON.stringify(obj)
            } else {
                window.mySessionStorage[key] = JSON.stringify(obj)

            }
        },
        getSessionStorage: function(key) {
            var objStr;
            if (window.sessionStorage) {
                objStr = window.sessionStorage[key];
            } else {
                objStr = window.mySessionStorage[key];
            }
            return objStr == null ? null : JSON.parse(objStr);
        },
        isIosPlatform: function() {
            if (navigator.userAgent.match(/(iPad|iPhone)/)) {
                return true;
            } else {
                return false;
            }
        },
        isAndroidPlatform: function() {
            if (navigator.userAgent.match(/(Android)/)) {
                return true;
            } else {
                return false;
            }
        },
        isWeiXin: function() {
            return (/micromessenger/i).test(navigator.userAgent.toLowerCase());
        },
        isApp: function() {
            return (/sulaidaiapp/i).test(navigator.userAgent.toLowerCase());
        },
        /* ==================禁止滚动======================== */
        disableScroll: function() {
            $(".scroll").removeClass("scroll-active");
        },
        enableScroll: function() {
            $(".scroll").addClass("scroll-active");
        },
        popup: popup,

        // 倒计时
        countdownFun: function(time, cb, cbEnd) {
            var that = this;
            var interval = setInterval(function() {
                if (time <= 1) {
                    cbEnd(time);
                } else {
                    time -= 1;
                    cb(time);
                    // that.countdownFun(time, cb, cbEnd);
                }
            }, 1000);
            return interval;
        },
        // 验证手机号码
        valiPhone: function(tel) {
            // if (!(/^1[0-9]{10}$/.test(tel))) {
            //     return false;
            // }
            // return true;
            return  /^(((13[0-9]{1})|(14[5|7])|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(tel);
        },

    }

    global.Util = Util;
})(window);