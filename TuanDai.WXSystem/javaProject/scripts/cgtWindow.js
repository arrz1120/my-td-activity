var isOpenCGT = "1";
var isOpenCgtSub = "1"; //开启存管通申购
var isOpenCgtSubWe = "1"; //开启存管通申够We计划
var isInitCgtWin = false;//是否加载了升级框
var isOpenCgtTrans = "1"; //是否开启存管通债权转让
var cookieDomain = "tuandai.com";//当前站点域名

function initCgtWin() {
    if (!isInitCgtWin) {
        var cgtWindowHtml =
       '<div class="hide" id="cgtWindow">' +
       ' <div class="alert webkit-box box-center" >' +
       '		<div class="bg-fff cgGuide">' +
       '			<div class="cg_top">' +
       '				<img class="w100p" src="/imgs/cunguan/cgGuide.png"/>' +
       '		</div>' +
       '	  <div class="cg_bottom text-center">' +
       '		<p class="f13px c-999999 pt15 pb15">——&nbsp;&nbsp;&nbsp;为积极响应国家政策&nbsp;&nbsp;&nbsp;——</p>' +
       '		<p class="f17px">团贷网个人账户全面升级为<br />银行存管账户</p>' +
       '		<div class="clearfix protectTips">' +
       '			<div class="lf f13px c-999999">' +
       '				<i class="ico_suc3"></i>资金有保障' +
       '			</div>' +
       '			<div class="rf f13px c-999999">' +
       '				<i class="ico_suc3"></i>投资更放心' +
       '			</div>' +
       '		</div>' +
       '		<div class="clearfix bt-e6e6e6 mt20">' +
       '			<a href="javascript:void(0);" id="btncgtCancel" class="block lf w50p br-e6e6e6 pt10 pb10 f17px text-center c-808080">取消</a>' +
       '			<a href="javascript:void(0);" id="btncgtGo" class="block lf w50p pt10 pb10 f17px text-center c-fab600">立即升级</a>' +
       '		</div>' +
       '	</div>' +
       '  </div>' +
       ' </div>' +
       '</div>';

        $("body").append(cgtWindowHtml);
        isInitCgtWin = true;
    }
    //取消
    $("#btncgtCancel").click(function () {
        $("#cgtWindow").addClass("hide");
    });
}　

//检测弹窗开通存管提示
function checkIsOpen(sign) {
    var isopen = false;
    var _sign = "tixian";
    if (undefined == sign || null == sign || "" == sign)
        _sign = "";
    else
        _sign = sign;
    //未登录状态不需弹框
    if (!base_isCookieLogin()) {
        isopen = true;
        return isopen;
    }
    //有传入类型时不取Cookie
    if (_sign == "") {
        var ckisopen = CookieHelper.getCookie("WXIsOpenCgt");
        if (ckisopen == "1") {
            isopen = true;
            return isopen;
        }
    }

    //从ashx中加载开关配置
    $.ajax({
        url: "/ajaxCross/ajax_cgt.ashx",
        type: "post",
        dataType: "json",
        async: false,
        cache: false,
        data: { cmd: "GetShowQuanStatus", opertype: _sign },
        success: function (data) {
            var msgJson = JSON.parse(data.msg);
            mWebUrl = msgJson.murl;
            isOpenCGT = msgJson.isOpenCGT;
            isOpenCgtSub = msgJson.isOpenCgtSub;
            isOpenCgtSubWe = msgJson.isOpenCgtSubWe;
            isOpenCgtTrans = msgJson.isOpenCgtTrans;
            cookieDomain = msgJson.domainName;
            CookieHelper.delCookie("WXIsOpenCgt");
            if (isOpenCGT != "1") {
                isopen = true; //未开启存管时
                return;
            }
            if (data == null || data == undefined) {

            } else if (data.result == "-99") {
                isopen = true; //未登录状态
            }
            else if (data.result == "5") {
                initCgtWin(); 
                $("#btncgtGo").attr("href", "/Member/cgt/cgtBindCard.aspx");
                $("#cgtWindow").removeClass("hide");
                isopen = false;
            }
            else if (data.result == "4") {//设置银行卡信息 
                initCgtWin(); 
                $("#btncgtGo").attr("href", "/Member/cgt/cgtBindCard.aspx");
                $("#cgtWindow").removeClass("hide");
                isopen = false; 
            }
            else if (data.result == "1") {//已经开通  
                isopen = true;
                CookieHelper.setCookie("WXIsOpenCgt", "1", 1, cookieDomain);
            }
            else if (data.result == "2") {//未激活 
                initCgtWin(); 
                $("#btncgtGo").attr("href", "/Member/cgt/activeCgt.aspx");
                $("#cgtWindow").removeClass("hide");
                isopen = false;
            }
            else if (data.result == "0") {//未开通 
                initCgtWin(); 
                $("#btncgtGo").attr("href", "/Member/cgt/openCgt.aspx");
                $("#cgtWindow").removeClass("hide");
                isopen = false;
            }
            else if (data.result == "-2" || data.result == "-3" || data.result == "-4" || data.result == "-10" || data.result == "-9") {
                if ($.isFunction($("body").showMessage)) {
                    $("body").showMessage({
                        message: "请先完善存管账户信息！", showCancel: true, okString: "马上完善", cancelString: "取消",
                        okbtnEvent: function () {
                           window.location.href = "/Member/safety/pre_invest.aspx";
                        }
                    });
                } else {
                    alert("请先完善存管账户信息！");
                    window.location.href = "/Member/safety/pre_invest.aspx";
                }
                isopen = false;
            }
            //else if (data.result == "-9") {
            //    if ($.isFunction($("body").showMessage)) {
            //        $("body").showMessage({
            //            message: "您的身份信息或银行卡信息有误，<br />请联系客服核对及修改", okString: "<a class='btn c-ffc61a f17px' href='tel:400-641-0888'>联系客服</a>", cancelString: "暂不联系"
            //        });
            //    } else {
            //        alert("您的身份信息或银行卡信息有误，请联系客服核对及修改：400-641-0888");
            //    }
            //    isopen = false;
            //}
            else if (data.result == "3") {
                isopen = false;
                $.ajax({
                    url: "/ajaxCross/ajax_cgt.ashx",
                    dataType: "json",
                    data: { "cmd": "USER_AUTHORIZATION" },
                    type: "POST",
                    success: function (json) {
                        if (json) {
                            window.location.href = unescape(json.msg);
                        }
                    },
                    error: function () { }
                });
            }
            else {
                isopen = true;
            }
        }
    });
    //存入当前url,在存管通处理后跳转
    if (isopen == false) {
        CookieHelper.setCookie("wxcurgocgturl", window.location.href, 1, cookieDomain);
    }
    return isopen;
} 

//申购散标跳转
function checkCgtSubGoUrl(linkUrl) {
    if (isOpenCGT == "0" || isOpenCgtSub == "0") {
        window.location.href = linkUrl;
        return false;
    }
    var isOpen = checkIsOpen();
    if (isOpen) {
        window.location.href = linkUrl;
        return false;
    }
    
    return true;
}

//申购We计划跳转
function checkCgtSubWeGoUrl(linkUrl) {
    if (isOpenCGT == "0" || isOpenCgtSubWe == "0") {
        window.location.href = linkUrl;
        return false;
    }
    var isOpen = checkIsOpen();
    if (isOpen) {
        window.location.href = linkUrl;
        return false;
    } 
    return true;
}

//通用的存管检测并跳转
function checkCgtCommGoUrl(linkUrl) {
    if (isOpenCGT == "0") {
        window.location.href = linkUrl;
        return false;
    }
    var sign = "";
    if (linkUrl.toLowerCase().indexOf("recharge.aspx") != -1) {
        sign = "recharge";
    } else if (linkUrl.toLowerCase().indexOf("drawmoney.aspx") != -1) {
        sign = "tixian";
    }
    var isOpen = checkIsOpen(sign);
    if (isOpen) {
        window.location.href = linkUrl;
        return false;
    }
    return true;
}