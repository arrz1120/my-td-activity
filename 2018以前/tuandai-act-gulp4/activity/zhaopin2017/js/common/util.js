(function(global) {
    var Util = {
        isIOS: function() {
            return navigator.userAgent.match(/(iPad|iPhone)/);
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
        toast: function(msg, duration) {
            duration = duration || 1500;
            var _toast = $("<div/>").addClass('toast').html(msg);
            $('body').append(_toast);
            setTimeout(function() {
                _toast.remove();
            }, duration);
        }
    }
    global.Util = Util;
})(window);