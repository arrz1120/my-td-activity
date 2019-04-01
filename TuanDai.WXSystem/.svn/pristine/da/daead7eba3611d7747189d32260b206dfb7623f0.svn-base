//var arrBox = new Array();
//arrBox["d_money"] = "<img style='margin:2px;' src='/imgs/zhuce2.gif'/>&nbsp;请输入正确的金额，最小充值金额"+MinRecharge+"元。";
//var arrWrong = new Array();
//arrWrong["d_money"] = "<img style='margin:2px;' src='/imgs/zhuce2.gif'/>&nbsp请输入正确的金额，小数点后最多2位数。";
//var arrWrong1 = new Array();
//arrWrong1["d_money"] = "<img style='margin:2px;' src='/imgs/zhuce2.gif'/>&nbsp;输入的金额不能为空！";
//var arrWrong2 = new Array();
//arrWrong2["d_money"] = "<img style='margin:2px;' src='/imgs/zhuce2.gif'/>&nbsp;最低充值金额为" + MinRecharge + "元！";
//var arrWrong3 = new Array();
//arrWrong3["d_money"] = "<img style='margin:2px;' src='/imgs/zhuce2.gif'/>&nbsp;最低充值金额为" + MinRecharge + "元！";
//var arrWrong4 = new Array();
//arrWrong4["d_money"] = "<img style='margin:2px;' src='/imgs/zhuce2.gif'/>&nbsp;充值金额不能超过500000！";
//var arrOk = new Array();
//arrOk["d_money"] = "<img style='margin:2px;' src='/images/zhuce3.gif'/>";

//function Init() {
//    $('#t_money').click(function () { ClickBox("d_money"); });  
//}

//function BlurMoney1() {
//    var txt = "#t_money";
//    var td = "#tip";
//    var pat = /^[0-9]*(\.[0-9]{1,2})?$/;

//    var str = $(txt).val();
//    if (str == "") {
//        $(td).html(GetP("reg_wrong", arrWrong1["d_money"]));
//        return false;
//    }
//    var m = parseFloat(str);
//    if (m <= 0) {
//        $(td).html(GetP("reg_wrong", arrWrong3["d_money"]));
//        return false;
//    }

//    //限制100最小金额
//    var m = parseFloat(str); 
//    if (m > 500000) {
//        $(td).html(GetP("reg_wrong", arrWrong4["d_money"]));
//        return false;
//    }
//    if (m < MinRecharge) {
//        $(td).html(GetP("reg_wrong", arrWrong2["d_money"]));
//        return false;
//    }
//    if (pat.test(str)) {
//        //$(td).html(GetP("reg_ok", arrOk["d_money"]));
//        return true;
//    }
//    else {
//        $(td).html(GetP("reg_wrong", arrWrong["d_money"]));
//        return false;
//    }
//}

//function ClickBox(id) {
//    var ele = '#' + id;
//    $(ele).html(GetP("reg_info", arrBox[id]));
//}
//function GetP(clsName, c) {
//    return "<div class='" + clsName + "'>" + c + "</div>";
//}

//调用微信JS api 支付
function jsApiCall() {
    jQuery.ajax({
        async: false,
        type: "post",
        url: "/ajaxCross/WXPayment.ashx",
        dataType: "json",
        data: { Cmd: "GetWXJsApiParam", Amount: $("#t_money").val() },
        success: function (json) {
            if (json.result == "1") {
                var signObj = jQuery.parseJSON(json.msg);
                WeixinJSBridge.invoke(
               "getBrandWCPayRequest",
                 {
                     "appId": signObj.appId,
                     "timeStamp": signObj.timeStamp,
                     "nonceStr": signObj.nonceStr,
                     "package": signObj.package,
                     "signType": signObj.signType,
                     "paySign": signObj.paySign,
                 },
                   function (res) {
                       $("#dvPopmsg").hide();
                       if (res.err_msg == "get_brand_wcpay_request:ok") { 
                           window.location.href = "/PaymentPlatform/weixin/wxReturn.aspx";
                       } else {
                           window.location.href = "/PaymentPlatform/recharge_fail.aspx";
                       }
                   }
               );
            } else {
                $("#dvPopmsg").hide();
                alert(json.msg);
                window.location.href = "/PaymentPlatform/recharge_fail.aspx";
            }
        }
    });
}

//外面调用微信支付
function callWXPay() {
    if (typeof WeixinJSBridge == "undefined") {
        if (document.addEventListener) {
            document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);
        }
        else if (document.attachEvent) {
            document.attachEvent('WeixinJSBridgeReady', jsApiCall);
            document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
        }
    }
    else {
        jsApiCall();
    }
}
 
 