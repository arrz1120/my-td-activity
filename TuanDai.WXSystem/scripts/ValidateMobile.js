$(function () {
    $("#txtMobileTelNo").blur(function () { if ($("#txtMobileTelNo").val() != "") { $("#MobileTelNoErr").hide(); } });
})
$("#btnSendMobileCode").click(function () {
    if (ValidateMobilerNumber()) {
        $("body").showMessage({ message: "", showCancel: null, url: null });
    }
    $("#btnSendMsg").unbind("click").click(function () {
        $("body").Close();
        sendMobileValidSMSCode("0");
    });
    $("#btnSendVoice").unbind("click").click(function () {
        $("body").Close();
        sendMobileValidSMSCode("1");
    });

    $("#btnCancel").click(function () {
        $("body").Close();
    });
});
$("#btnSubmit").click(function () {
    if (!ValidateMobilerNumber()) {
        return false;
    }
    if (!ValidateCode()) {
        return false;
    }
    
    $.ajax({
        url: "/ajaxCross/ajax_s1a2fe.ashx",
        type: "post",
        dataType: "json",
        data: { Cmd: "msgcheckcode2", code: $("#txtShortMsgCode").val(), tel: $("#txtMobileTelNo").val() },
        success: function (jsondata) {
            var d = jsondata.result;
            var msg = jsondata.msg;
            if (parseInt(d) == -100) { $("#MsgCodeErr").text("系统繁忙：请重试！"); $("#MsgCodeErr").show(); return; }
            if (parseInt(d) > 0) {
                location.href = "/Member/my_userdetailinfo.aspx#safe";
            }
            else {
                var msgid = "#MsgCodeErr";
                $(msgid).show();
                if (d == "-2" || d == "-3") {
                    $(msgid).text("验证失败或者校验码失效，请重新获取");
                }
                if (d == "-1") {
                    $(msgid).text("验证码错误或已失效，请重新获取！");
                }
                if (d == "0") {
                    $(msgid).text("系统繁忙，请重新输入！");
                }
                if (d == "-6") {
                    $(msgid).text("验证码已过期");
                }
                if (d == "-7") {
                    $(msgid).text(msg);
                }
            }
        }
    });
});

function ValidateCodeTelNo(telNo, code, msgtelnoid, msgcodeid) {
    if (!ValidateTelNo(telNo, msgtelnoid)) {
        return false;
    }
    if (!ValidateCode(code, msgcodeid, "tel")) {
        return false;
    }

    return true;
}

/*手机号码验证*/
function ValidateMobilerNumber() {
    var mobileNumber = $("#txtMobileTelNo").val();
    var phoneRegex = /^(?:13\d|14\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$/
    if (mobileNumber == "") {
        $("#MobileTelNoErr").text("手机号码不能为空");
        $("#MobileTelNoErr").show();
        return false;
    }
    else if (!phoneRegex.test(mobileNumber)) {
        $("#MobileTelNoErr").text("输入手机号码格式不正确");
        $("#MobileTelNoErr").show();
        return false;
    }
    else {
        $("#MobileTelNoErr").hide();
        return true;
    }
};
/*验证码验证*/
function ValidateCode() {
    var code = $("#txtShortMsgCode").val();
    if (code == "") {
        $("#MsgCodeErr").text("手机验证码不能为空");
        $("#MsgCodeErr").show();
        return false;
    }
    else {
        $("#MsgCodeErr").hide();
        return true;
    }
}

//获取手机验证码
//倒计时
var leftsecond = 180;
var msg = "";
var timer = null;
function sendMobileValidSMSCode(vtype) {
    $("#btnSendMobileCode").hide();
    $("#MsgCodeErr").hide();
    $("#btnSendMobileCode").attr("href", "javascript:void(0);");
    $("#btnSendMobileCode").css("cursor", "default");
    $(".spTip").eq(0).html("短信发送中...");
    jQuery(".spTip").eq(0).show();
    jQuery.ajax({
        url: "/ajaxCross/ajax_s1a2fe.ashx",
        type: "post",
        dataType: "json",
        data: { Cmd: "getMobileMSCode", phoneNum: $("#txtMobileTelNo").val(), vtype: vtype },
        success: function (json) {
            var result = json.result;
            leftsecond = 180;
            if (parseInt(result) == -100) { $("#MsgCodeErr").text("系统繁忙：请重试！"); $("#MsgCodeErr").show(); return; }
            else if (parseInt(result) == -99) { window.location.href = "/user/login.aspx?ReturnUrl=" + window.location.href; }
            if (parseInt(result) > 0) {
                leftsecond = 180;
                msg = "发送成功";
                clearInterval(timer);
                timer = setInterval(setLeftTime, 1000, "1");
                $("#btnSendMobileCode").attr("href", "javascript:void(0);");
                $("#btnSendMobileCode").css("cursor", "default");
                $("#btnSendMobileCode").css("text-decoration", "none");
            }
            else if (result == "-20") {
                $("#btnSendMobileCode").show();
                jQuery(".spTip").eq(0).hide();
                $("#MsgCodeErr").text(json.msg);
                $("#MsgCodeErr").show();
                return false;
            }
            else {
                leftsecond = 180;
                msg = "发送失败，";
                clearInterval(timer);
                timer = setInterval(setLeftTime, 1000, "1");
                $("#btnSendMobileCode").attr("href", "javascript:void(0);");
                $("#btnSendMobileCode").css("cursor", "pointer");
            }
        }
    });
}

function setLeftTime() {
    var second = Math.floor(leftsecond);
    $(".spTip").eq(0).html(msg + second + "秒后可重发");
    leftsecond--;
    if (leftsecond < 1) {
        $("#btnSendMobileCode").show();
        jQuery(".spTip").eq(0).hide();
        clearInterval(timer);
        try {
            $("#btnSendMobileCode").attr("href", "javascript:void(0);");
            $("#btnSendMobileCode").css("cursor", "pointer");
        } catch (E) { }
        return;
    }
}