(function(global) {
    /* ==================弹出框==dialog================= */
    /*
        options : {
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
            confirm_cb = null;
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
            alert_con.append(confirm_btn).append(cancel_btn);
        }else{
            cancel_btn = $("<div/>").addClass("cancel-btn").html(_options.btns[0].txt);
            cancel_cb = _options.btns[0].cb;
            alert_con.append(cancel_btn);
        }
        alert_wrapper.append(mask).append(alert_con);
        $("body").append(alert_wrapper);

        //事件绑定
        // mask.bind("click", function(e) {
        //     hide(alert_wrapper);
        // });

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