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
        }
    }

    global.Util = Util;
})(window);



function aniShow(showMask) {
    var showMask = $(showMask);
    showMask.removeClass('hide');
    showMask.find('.masker').removeClass('aniFadeOut').addClass('aniFadeIn');
    showMask.find('.pop-container').removeClass('aniHide').addClass('aniShow');
    Util.disableScroll();
}

function aniHide(hideMask) {
    var hideMask = $(hideMask);
    hideMask.find('.masker').removeClass('aniFadeIn').addClass('aniFadeOut');
    hideMask.find('.pop-container').removeClass('aniShow').addClass('aniHide');
    setTimeout(function() {
        hideMask.addClass('hide');
    }, 400);
    Util.enableScroll();
}