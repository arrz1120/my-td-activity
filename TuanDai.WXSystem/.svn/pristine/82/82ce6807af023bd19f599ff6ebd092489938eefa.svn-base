(function ($) { 
    var dynamicLoading = {
        css: function (path) {
            if (!path || path.length === 0) {
                throw new Error('argument "path" is required !');
            }
            var head = document.getElementsByTagName('head')[0];
            var link = document.createElement('link');
            link.href = path;
            link.rel = 'stylesheet';
            link.type = 'text/css';
            head.appendChild(link);
        },
        js: function (path) {
            if (!path || path.length === 0) {
                throw new Error('argument "path" is required !');
            }
            var head = document.getElementsByTagName('head')[0];
            var script = document.createElement('script');
            script.src = path;
            script.type = 'text/javascript';
            head.appendChild(script);
        }
    }

    //显示弹出框.
    $.fn.showMessage = function (options) {
        //弹出框默认配置.
        var defaults = {
            message: "您尚未填写个人信息，请您填写后再申请！",
            showCancel: true,
            okString: "确定",
            okbtnEvent: null,
            cancelString: "取消",
            cancelEvent: null
        };
        var options = $.extend(defaults, options);

        init($(this), options);

        var $cancel = $("#btnPopCancel");
        var $confirm = $("#btnPopOK");
        var $iknow = $("#btnPopConfirm"); 
        $cancel.unbind("click");
        $confirm.unbind("click");
        $iknow.unbind("click");

        if (options.showCancel == false) {
            if (options.okString != "确定")   //不传值时，会被确定覆盖
                $iknow.html(options.okString);//当不显示取消按钮时，修改Ok按钮的text
            $confirm.parent().parent().hide();
            $iknow.parent().show();
            if ($.isFunction(options.okbtnEvent))
                $iknow.bind('click', options.okbtnEvent);
            else {
                $iknow.bind('click', hide);
                //界面无任何按钮时，2秒自动隐藏
                //setTimeout(function () { hide(); }, 2000);
            }
        } else {
            $confirm.html(options.okString);
            $confirm.bind('click', options.okbtnEvent); 
            $cancel.html(options.cancelString);
            if ($.isFunction(options.cancelEvent))
                $cancel.bind('click', options.cancelEvent);
            else
                $cancel.bind('click', hide);
            $confirm.parent().parent().show();
            $iknow.parent().hide();
        }
        $("#divPopTips").bind("click", hide);//点击遮罩层隐藏弹框
        show(options);
    }
    $.fn.hideMessage = function () {
        hide();
    }
    //是否已经进行初始化.
    var isInit = false; 
    //初始化弹出框.
    function init($target, options) {
        if (!isInit) { 
            var html = "<div id='divPopTips' style='display:none;'>"+
                        "<div class='alert z-index1000 webkit-box box-center'>"+
                        "  <div class='alert-select pos-r' id='alertCon'>"+
	                    "    <div class='text-center c-212121 f17px pt25 pb20 pl15 pr15' id='popMsg'>" + options.message + "</div>" +
	                    "       <div class='clearfix bt-e6e6e6'>"+
	                    "		    <div class='lf w50p br-e6e6e6'>"+
	                    "			    <div class='btn c-808080 f17px br-e6e6e6' id='btnPopCancel'>取消</div>"+
                        "		    </div>"+
                        "		    <div class='rf w50p'>"+
                        "			    <div class='btn c-ffc61a f17px' id='btnPopOK'>确定</div>"+
                        "		    </div>"+
                        "	    </div>"+
                        "       <div class='bt-e6e6e6' style='display:none;'>"+
                        "		  <div class='btn c-ffc61a f17px' id='btnPopConfirm'>我知道了</div>"+
                        "	   </div>"+
                        "    </div>"+
                        "</div>" +
                        "</div>";
            $target.append(html); 

            isInit = true;
        }
    }
    
    //显示弹出框.
    function show(options) { 
         $("#popMsg").html(options.message); 
        // $("#divPopTips").fadeIn(600);
        var divPopTips = $("#divPopTips");
        divPopTips.show();
        divPopTips.find('.alert').removeClass('aniFadeOut').addClass('aniFadeIn'); 
        divPopTips.find(".alert-select").removeClass('aniHide').addClass('aniShow'); 
    }
    
    //隐藏弹出框.
    function hide() {
        //$("#divPopTips").fadeOut(600);
        var divPopTips = $("#divPopTips");
        divPopTips.find('.alert').removeClass('aniFadeIn').addClass('aniFadeOut');
        divPopTips.find(".alert-select").removeClass('aniShow').addClass('aniHide');
        setTimeout(function () {
            divPopTips.hide();
        }, 400);
    }
    
    $.toMoney = function (s, n) {
        n = n > 0 && n <= 20 ? n : 2;
        s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
        var l = s.split(".")[0].split("").reverse(),
        r = s.split(".")[1];
        t = "";
        for (i = 0; i < l.length; i++) {
            t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
        }
        return t.split("").reverse().join("") + "." + r;
    }


    var isInitMsgLoading = false;
    $.fn.showLoading = function (message) {
        if (message == undefined || message == "")
            message = "加载中...";
        initMsgLoading($(this), message);
        $("#dvPopmsg").show();
    }
    $.fn.hideLoading = function () {
        $("#dvPopmsg").hide();
    }
    function initMsgLoading($target, message) {
        if (!isInitMsgLoading) {
            dynamicLoading.css("/css/loadbar.css?v=2016042001");

            var html = "<div class='loading-box' style='display:none;z-index:1000;' id='dvPopmsg'>" +
                        "<div class='loading-tips'>" +
                        "<img src='/imgs/images/icon/ico_loading.png' alt=''>" +
                        "<span>"+message+"</span>" +
                        "</div>"+
                        "</div> ";
            $target.append(html);

            isInitMsgLoading = true;
        }
    }
    var isInitTips = false;
    //提示
    $.fn.showTips = function (message) {
        if (!isInitTips) {
            var html = "<div class='toast-tips' style='display: none;'></div>";
            $(this).append(html);
            isInitTips = true;
        }
        $('.toast-tips').html(message).fadeIn(function () {
            setTimeout(function () {
                $('.toast-tips').fadeOut();
            }, 1000);
        });
    }
})(jQuery);

