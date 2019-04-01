(function(global) {

    /* ==================弹出框==dialog================= */
    /*
                options : {
                    type: 弹窗类型 0 - 为普通弹窗 | 1 - 中奖弹窗 ,
                    icon: 图标,
                    msg: 弹窗文字,
                    tips: 提示文字,
                    title: 提示标题,
                    content: 提示内容(可传入模版）,
                    btns: [{
                        name: 按钮名称
                        cb: callback
                    }] // 若按钮数组只有一个，那么是alert，按钮数组两个，
                }
     */

    function popup(options) {
        var _options = {
            "title": "",
            "conClassName": "",
            "icon": "",
            "iconTxt": "",
            "txt": "",
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
            confirm_cb = null;
        // 弹窗标题
        if (_options.title) {
            var _title = $("<p/>").addClass("alert-title").html(_options.title);
            alert_con.append(_title);
        }

        // alert_con.append(_options.content);

        // 弹窗图标
        if (_options.icon) {
            var _icon = $("<div/>").addClass("alert-icon").html('<img src="../images/prize/' + _options.icon + '.png" class="' + _options.icon + '">');
            alert_con.append(_icon);
        }

        // 弹窗图标上的文字
        if (_options.iconTxt) {
            var _iconTxt = $("<div/>").addClass("icon-txt").html('<span class="' + _options.icon + '">' + _options.iconTxt + '</span>');
            alert_con.append(_iconTxt);
        }

        // 弹窗内容
        if (_options.txt) {
            var _txt = $("<div/>").addClass("txt").html(_options.txt);
            alert_con.append(_txt);
        }

        // 弹窗按钮
        if (_options.btns.length > 1) {
            var cancel_btn = $("<div/>").addClass("cancel-btn").html(_options.btns[0].txt),
                confirm_btn = $("<div/>").addClass("confirm-btn").html(_options.btns[1].txt);
            cancel_cb = _options.btns[0].cb;
            confirm_cb = _options.btns[1].cb;
            alert_con.append(confirm_btn).append(cancel_btn);
        } else {
            confirm_btn = $("<div/>").addClass("confirm-btn").html(_options.btns[0].txt);
            confirm_cb = _options.btns[0].cb;
            alert_con.append(confirm_btn);
        }
        alert_wrapper.append(mask).append(alert_con);
        $("body").append(alert_wrapper);

        //事件绑定
        // mask.bind("click", function(e) {
        //     hide(alert_wrapper);
        // });


        alert_wrapper.on('touchmove', function(e) {
            e.preventDefault();
        });

        cancel_btn && cancel_btn.bind("click", function(e) {
            cancel_cb && cancel_cb.call(this, arguments);
            hide(alert_wrapper);
        });

        confirm_btn && confirm_btn.bind("click", function(e) {
            // var confirmReturn =  confirm_cb && confirm_cb.call(this, arguments);
            // confirm_cb ? confirmReturn && hide(alert_wrapper) :　hide(alert_wrapper);
            confirm_cb && confirm_cb.call(this, arguments);
            hide(alert_wrapper);
        });

        function hide(target) {
            target.remove();
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
            var ua = navigator.userAgent.toLowerCase();
            if (ua.match(/MicroMessenger/i) == 'micromessenger') {
                return true;
            } else {
                return false;
            }
        },
        disableScroll: function() {
            $(".scroll").removeClass("scroll-active");
        },
        enableScroll: function() {
            $(".scroll").addClass("scroll-active");
        },
        popup: popup

    }

    global.Util = Util;
})(window);