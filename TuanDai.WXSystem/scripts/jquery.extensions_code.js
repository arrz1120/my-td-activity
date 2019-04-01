(function ($) {

    //弹出框默认配置.
    var defaults = {
        message: "您尚未填写个人信息，请您填写后再申请！",
        showCancel: true
    };
    $.fn.Close = function () { $.extend(hide()) }
    //显示弹出框.
    $.fn.showMessage = function (options) {

        var options = $.extend(defaults, options);

        init($(this), options);

        var $cancel = $("#cancel");
        var $confirm = $("#confirm");

        if (!options.showCancel) {
            $cancel.hide();
            $confirm.parent().css("width", "100%");
        }

        if (options.url != "") $confirm.attr("href", options.url);
        if (typeof (options.ok) == "function") {
            $confirm.unbind("click");
            $confirm.click(options.ok);
        }

        show();
    }
    //是否已经进行初始化.
    var isInit = false;

    //初始化弹出框.
    function init($target, options) {
        if (!isInit) {
            //            var html = '<section class="automaticwayBox pt15 clearfix" id="informationMain">' +
            //				         '<div class="completeBox clearfix">' +
            //					       '<input type="button" id="btnSendMsg" class="btn btnYellow h52" value="短信验证码" />' +
            //				         '</div>' +
            //                         '<div class="completeBox clearfix">' +
            //					       '<input type="button" id="btnSendVoice" class="btn btnYellow h52" value="语音验证码" />' +
            //				         '</div>' +
            //                         '<div class="completeBox clearfix">' +
            //					       '<input type="button" id="btnCancel" class="btn btnYellow h52" value="取消" />' +
            //				         '</div>' +
            //			           '</section>' +
            //			           '<div class="maskLayer hide"></div>';
            var html = '<section class="automaticwayBox pt15 clearfix" id="informationMain">' +
                       '<div class="account-pop">' +
                       '<div class="pop-cn">' +
                       '<a href="javascript:void(0)" id="btnSendMsg" class="f14px">短信验证码</a>' +
                       '<a href="javascript:void(0)" id="btnSendVoice" class="f14px">语音验证码</a>' +
                       '</div>' +
                       '<a href="javascript:void(0);" id="btnCancel" class="cancel-but f14px">取消</a>' +
                       '</div>' +
                       '</section>' +
                       '<div class="maskLayer hide"></div>';

            $target.append(html);

            var $cancel = $("#cancel");
            var $confirm = $("#confirm");
            if (options.showCancel) $cancel.click(hide);
            $confirm.click(hide);

            isInit = true;
        }
    }


    //显示弹出框.
    function show() {
        $(".maskLayer").fadeIn();
        $("#informationMain").animate({
            bottom: "0"
        }, 200)
    }

    //隐藏弹出框.
    function hide() {
        $(".maskLayer").fadeOut();
        $("#informationMain").animate({
            bottom: "-430px"
        }, 200);
    }
})(jQuery);