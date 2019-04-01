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
            title: 提示标题,
            content: 提示内容,
            btns: [{
                name: 按钮名称
                cb: callback
            }] // 若按钮数组只有一个，那么是alert，按钮数组两个，第一个为negative按钮，第二个为positive按钮
        }
    */
    function popup(options) {
        var _options = {
            "msg": ""
            // "title": "",
            // "content": "",
            // "btns": [{
            //     "name": "",
            //     "cb": function() {}
            // }, {
            //     "name": "",
            //     "cb": function() {}
            // }]
        };
        _options = $.extend(_options, options || {});
        var alert_wrapper = $("<div/>").addClass("alert-wrapper"),
            mask = $("<div/>").addClass("mask"),
            alert_con = $("<div/>").addClass("alert-con"),
            alert_msg = $("<div/>").addClass("alert-msg").html(_options.msg),
            alert_btns = $("<div/>").addClass("alert-btns"),
            cancel_btn = $("<span/>").addClass("alert-btn").html('取消'),
            confirm_btn = $("<a/>").addClass("alert-btn").html('呼叫').attr('href',"tel:" + _options.msg);
            // negative_btn = '',
            // positive_btn = '',
            // ne_cb = null,
            // po_cb = null;
        alert_btns.append(cancel_btn).append(confirm_btn);
        alert_con.append(alert_msg).append(alert_btns);
        alert_wrapper.append(mask).append(alert_con);

        $("body").append(alert_wrapper);
        // disableScrolling();
        Util.disableScroll();
        //事件绑定
        mask.bind("click", function(e) {
            hide(alert_wrapper);
        });

        cancel_btn && cancel_btn.bind("click", function(e) {
            hide(alert_wrapper);
        });

        confirm_btn.bind("click", function(e) {
            hide(alert_wrapper);
        });

        function hide(target) {
            target.remove();
            // enableScrolling();
            Util.enableScroll();
        }
    }
    function execIsAuth() {
        $.ajax({
            url: '/user/isAuth',
            dataType: 'json',
            method: 'post',
            success: function(data){
                console.log(data);
                if(!data.login){
                    // 未登录弹窗出合格者认证弹窗
                    $(".mask-renzheng").show();
                    toAuth()
                }else{
                    if(!data.realNameAuth){
                        //已登录未实名弹出合格者认证弹窗窗
                        $(".mask-renzheng").show();
                        toAuth()
                    }else{
                        if(!data.riskEval){
                            //合格投资者认定弹窗
                            $(".mask-renzheng").show();
                            toAuth()
                        }
                    }
                }
            }, error: function(jqXHR, textStatus, errorMsg){
                console.error("请求失败：" + errorMsg);
            }
        });
    }
    function toAuth() {
        $(".toAuth").click(function(){
            window.location.href= "identity.html";
        })
    }

    // 测试地址
    var IP_OPERA = 'http://10.103.8.188:1022/v1/';

    // 发送弹幕消息扣除团票
    var SEND_BARRAGE = IP_OPERA + 'live/send-bullet-screen';
    var Util = {
        openApi: IP_OPERA,
        getElemetByTarget: function(target, cls, until) { //获取某个元素的父级或同级dom节点
            var result = target;
            if (!result) { //不存在target
                return false;
            }
            var classList = Array.from(result.classList); //转换成数组

            // 寻找到until类名位置为止，默认为body
            if (classList.indexOf(until) > -1 || result.tagName.toLocaleLowerCase() === "body") {
                return false;
            }

            if (classList.indexOf(cls) > -1) { //存在该类名
                return result;
            } else {
                return this.getElemetByTarget(result.parentElement, cls);
            }
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
        /* ==================禁止滚动======================== */
        disableScroll: function() {
            $(".scroll").removeClass("scroll-active");
        },
        enableScroll: function() {
            $(".scroll").addClass("scroll-active");
        },
        popup: popup,
        /* 
            config: {
                url: 请求路径,
                type: 请求类型，
                dataType: 返回的数据类型，
                cbOk: 成功回调，
                cbErr: 失败回调，
                cbCp: 完成回调
            }
        */
        Ajax: function(config) {
            var me = this;
            $.ajax({
                timeout: 20 * 1000,
                url: config.url,
                type: config.type,
                data: config.data,
                dataType: config.dataType,
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                beforeSend: function(xhr, settings) {
                    // xhr.setRequestHeader("If-Modified-Since", "0");
                    config.beforeSend && config.beforeSend(xhr, settings);

                },
                success: function(data, textStatus, jqXHR) {
                    config.success && config.success(data, textStatus, jqXHR);
                },
                error: function(e, xhr, type) {
                    config.error && config.error(e, xhr, type);
                },
                complete: function(xhr, status) {
                    config.complete && config.complete(xhr, status);
                }
            });
        },
        execIsAuth: execIsAuth,
    }

    global.Util = Util;
})(window);
