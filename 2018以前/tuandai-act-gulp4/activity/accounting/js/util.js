(function(global) {

    var Util = {
        toast: function(msg, duration) {
            duration = duration || 1500;
            var _toast = $('<div/>').addClass('toast'),
                _msg = $('<span/>').html(msg);
            _toast.append(_msg);
            $('body').append(_toast);
            setTimeout(function() {
                _toast.remove();
            }, duration);
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

        isIosPlatform: function() {
            return navigator.userAgent.match(/(iPad|iPhone)/);
        },
        isAndroidPlatform: function() {
            return navigator.userAgent.match(/(Android)/);
        },
        isWeiXin: function() {
            var ua = navigator.userAgent.toLowerCase();
            return ua.match(/MicroMessenger/i) == 'micromessenger';
        },
        // 设计稿像素转换到实际像素
        pxTopx: function(px) {
            var _clientWidth = document.documentElement.clientWidth > 414 ? 414 : document.documentElement.clientWidth,
                _fontsize = 20 * (_clientWidth / 320);
            return px / 23.4375 / 2 * _fontsize;
        },
        initHeader: function() {
            // 点击header icon 跳转到首页
            $('.header').on('click', '.logo', function(e) {
                window.location.href = './index.html';
            });
        },
        initFooter: function() {
            var that = this;
            $('.footer').on('click', '.btn-openapp', function(e) {
                var url = ''; // ios 跳转路径
                if (that.isAndroidPlatform()) {
                    url = 'http://api.qianxiaoer88.com/app/download';
                }
                window.location.href = url;
            })
        }
    }

    global.Util = Util;
})(window);
