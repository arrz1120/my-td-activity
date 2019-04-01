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
        /* ==================禁止滚动======================== */
        disableScroll: function() {
            $('.scroll').removeClass('scroll-active');
        },
        enableScroll: function() {
            $('.scroll').addClass('scroll-active');
        },

        // 设计稿像素转换到实际像素
        pxTopx: function(px) {
            var _clientWidth = document.documentElement.clientWidth > 414 ? 414 : document.documentElement.clientWidth,
                _fontsize = 20 * (_clientWidth / 320);
            return px / 23.4375 / 2 * _fontsize;
        }
    }

    global.Util = Util;
})(window);