(function(global) {
    (function() {
        var pendingRequests = {};

        function generatePendingRequestKey(options) {
            var key = options.url + '?' + options.data;
            return key;
        }

        function storePendingRequest(key, xhr) {
            xhr.pendingRequestKey = key;
            pendingRequests[key] = xhr;
        }

        $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
            console.log("----ajaxPrefilter-----")

            // 不重复发送相同请求
            var key = generatePendingRequestKey(options);
            if (!pendingRequests[key]) {
                storePendingRequest(key, jqXHR);
            } else {
                // or do other
                jqXHR.abort();
            }

            var complete = options.complete;
            options.complete = function(jqXHR, textStatus) {
                // clear from pending requests
                pendingRequests[jqXHR.pendingRequestKey] = null;
                if ($.isFunction(complete)) {
                    complete.apply(this, arguments);
                }
            };
        });
    })()

    /* ==================弹出框==dialog================= */
    /*
     options : {
     type: 弹窗类型 0 - 为普通弹窗 | 1 - 未中奖弹窗 | 其他 - 中奖弹窗
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
            "type": 0,
            "icon": "",
            "msg": "",
            "tips": "",
            "btns": [{
                "name": "",
                "cb": function() {}
            }, {
                "name": "",
                "cb": function() {}
            }]
        };
        _options = $.extend(_options, options || {});
        var dialog_component = $("<div/>").addClass('popup').addClass("dialog"),
            masker = $("<div/>").addClass("ismasker").removeClass('aniFadeOut').addClass('aniFadeIn'),
            dialog_wrapper = $("<div/>").addClass("dialog-wrapper").removeClass('aniHide').addClass('aniShow'),
            dialog_icon = _options.icon ? $("<div/>").addClass("dialog-icon").html('<img src="../images/prize/' + _options.icon + '.png" class="' + _options.icon + '">'): '',
            dialog_msg = $("<p/>").addClass('dialog-msg').html(_options.msg),
            dialog_tips = _options.tips ? $("<p/>").addClass('dialog-tips').html(_options.tips) : '',
            btns = $("<div/>").addClass("btns"),
            close_btn  = $("<div/>").addClass("close-btn"),
            negative_btn = '',
            positive_btn = '',
            ne_cb = null,
            po_cb = null;

        if (_options.type === 0) {
            dialog_wrapper.addClass("msg-dialog");
            dialog_wrapper.append(dialog_icon).append(dialog_msg).append(dialog_tips).append(close_btn);
        }else if(_options.type === 1) {
            dialog_wrapper.addClass("nologin-dialog");
            dialog_wrapper.append(dialog_icon).append(dialog_msg).append(dialog_tips).append(close_btn);
        }else if(_options.type === 2){
            dialog_wrapper.addClass("nowin-dialog");
            dialog_wrapper.append(dialog_icon).append(dialog_msg).append(dialog_tips).append(close_btn);
        }else {
            dialog_wrapper.append(dialog_icon).append(dialog_msg).append(dialog_tips).append(close_btn);
        }

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
        Util.disableScroll();


        close_btn.bind("click", function(e) {
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
            target.find('.ismasker').removeClass('aniFadeIn').addClass('aniFadeOut');
            target.find('.dialog-wrapper').removeClass('aniShow').addClass('aniHide');
            setTimeout(function() {
                target.remove();
            }, 400);
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
        msgDialog: function(option){
            popup({
                "type": 0,
                "icon": option.icon,
                "msg": option.msg,
                "tips": option.tips,
                "btns": option.btns
            });
        },
        noLogin: function(option){
            popup({
                "type": 1,
                "msg": option.msg,
                "tips": option.tips,
                "btns": option.btns
            });
        },
        nowinDialog: function(option){
            popup({
                "type": 2,
                "icon": option.icon,
                "msg": option.msg,
                "btns": option.btns
            });
        },
        winDialog: function(option){
            popup({
                "type": 3,
                "icon": option.icon,
                "msg": option.msg,
                "tips": option.tips,
                "btns": option.btns
            });
        },
        aniShow: function (showMask) {
            var showMask = $(showMask);
            showMask.removeClass('hide');
            showMask.find('.masker').removeClass('aniFadeOut').addClass('aniFadeIn');
            showMask.find('.pop-container').removeClass('aniHide').addClass('aniShow');
            Util.disableScroll();
        },
        aniHide:function (hideMask) {
            var hideMask = $(hideMask);
            hideMask.find('.masker').removeClass('aniFadeIn').addClass('aniFadeOut');
            hideMask.find('.pop-container').removeClass('aniShow').addClass('aniHide');
            setTimeout(function() {
                hideMask.addClass('hide');
            }, 400);
            Util.enableScroll();
        }

    }

    global.Util = Util;
})(window);




