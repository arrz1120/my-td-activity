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

    function popup(options) {

    }

    // 测试地址

    // 发送弹幕消息扣除团票
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
        // 设计稿像素转换到实际像素
        pxTopx: function (px) {
            var _clientWidth = document.documentElement.clientWidth > 414 ? 414 : document.documentElement.clientWidth,
            _fontsize = 20 * (_clientWidth / 320);
            return px / 23.4375 / 2 *  _fontsize;
        }
    }

    global.Util = Util;
})(window);