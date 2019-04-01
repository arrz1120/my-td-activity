﻿$(function () {
    $("#btnSendMobileCode").removeAttr("disabled");
    $("#txtMobilePhone").blur(function () { if ($("#txtMobilePhone").val() != "") { $("#txtMobileTip").hide(); } });
    //send code
    $('#btnSendMobileCode').click(function () { //点击发送验证码
        var mobile = $("#txtMobilePhone").val();
        if (mobile == "") {
            $("#txtMobileTip").html("请输入手机号码").show();
            return false;
        }
        else if (!isMobile(mobile)) {
            $("#txtMobileTip").html("输入手机号码错误").show();
            return;
        }
        $("#txtMobileTip").hide();
        GetVerificationCode("0");
        //$("body").showMessage({ message: "", showCancel: null, url: null });
        //$("#btnSendMsg").unbind("click").click(function () {
        //    $("body").Close();
        //    GetVerificationCode("0");
        //});
        //$("#btnSendVoice").unbind("click").click(function () {
        //    $("body").Close();
        //    GetVerificationCode("1");
        //});

        //$("#btnCancel").click(function () {
        //    $("body").Close();
        //});

    });
    $(".text-right").bind("click", function() {
        var mobile = $("#txtMobilePhone").val();
        if (mobile == "") {
            $("#txtMobileTip").html("请输入手机号码").show();
            return false;
        }
        else if (!isMobile(mobile)) {
            $("#txtMobileTip").html("输入手机号码错误").show();
            return;
        }
        $("#txtMobileTip").hide();
        GetVerificationCode("1");
    });
    var checkCount = 0;
    $('#btn_mobile_ok').click(function () {//点击下一步
        
        var mobile = $("#txtMobilePhone").val();
        if (mobile == "") {
            $("#txtMobileTip").html("请输入手机号码").show();
            return false;
        }
        else if (!isMobile(mobile)) {
            $("#txtMobileTip").html("输入手机号码错误").show();
            return;
        }
        var code = $("#txtMobileCode").val();
        if (code == "") {
            $("#txtMobileTip").hide();
            $("#txtMobileCodeTip").html("请输入手机验证码").show();
            return false;
        }
        if (checkCount == 5) {
            $("#txtMobileCodeTip").html("验证码错误次数过多，请重新获取验证码!");
            return false;
        }
        $.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "CheckResetPasswordMobileCode", code: code, mobile: mobile },
            success: function (json) {
                var result = json.result;
                if (parseInt(result) == -100) { $("#txtMobileCodeTip").html("系统繁忙，请稍候重试!").show(); } //window.location.href = "/View/NoticeMessage.aspx?status=2"; }
                if (result == 1) {
                    $("#txtMobileCodeTip").html("验证成功!");
                    if (backurl != "")
                        window.location.href = "SetNewPwd_mobile.aspx?backurl="+backurl;
                    else
                        window.location.href = "SetNewPwd_mobile.aspx";
                }
                else if (result == -1) {
                    checkCount++;
                    $("#txtMobileCodeTip").html("验证码错误!").show();
                }
                else if (result == -2 || result == -3) {
                    checkCount++;
                    $("#txtMobileCodeTip").html("验证码已过期!").show();
                }
                else if (result == 0) {
                    checkCount++;
                    $("#txtMobileCodeTip").html("请输入验证码!").show();
                }
                else {
                    checkCount++;
                    $("#txtMobileCodeTip").html("验证码错误!").show();
                }
            }
        });
    });

})

//获取手机短信验证码
function GetVerificationCode(vtype) {
    $.ajax({
        url: "/ajaxCross/ajax_s1a2fe.ashx",
        type: "post",
        dataType: "json",
        data: { Cmd: "GetResetPasswordMobileCode", MobilePhone: $("#txtMobilePhone").val(), vtype: vtype },
        success: function (json) {
            var result = json.result;
            leftsecond = 60;
            if (parseInt(result) == -100) {
                $("#btnSendMobileCode").val("发送失败");
            }
            if (result == 1) {
                checkCount = 0;
                $("#txtMobileCodeTip").html("已发送，1分钟后可重新获取。").show();
                leftsecond = 60;
                clearInterval(timer);
                timer = setInterval(setLeftTime, 1000, "1");
            }
            else {
                $("#btnSendMobileCode").val("短信验证码");
                $("#txtMobileTip").html(json.msg).show();
            }
        }
    });
}

//获取手机验证码
var timer = null;
//倒计时
var leftsecond = 60;
function setLeftTime() {
    var second = Math.floor(leftsecond);
    $("#btnSendMobileCode").hide();
    $("#codeStr").html('重新获取' + second ).show();
    $(".text-right").hide();
    leftsecond--;
    if (leftsecond < 1) {
        $("#btnSendMobileCode").show();
        $(".text-right").show();
        $("#codeStr").hide();
        $("#txtMobileCodeTip").hide();
        clearInterval(timer);
        return;
    }
}

//*判断手机号的合法性
function isMobile(str) {

    var reg0 = /^13\d{9}$/;  //13号段
    var reg1 = /^15\d{9}$/;  //15号段
    var reg2 = /^18\d{9}$/;  //18号段
    var reg3 = /^14\d{9}$/;  //14号段
    var reg4 = /^17\d{9}$/;  //14号段
    var reg5 = /^16\d{9}$/;  //14号段
    var reg6 = /^19\d{9}$/;  //14号段
    var retval = false;
    if (reg0.test(str)) retval = true;
    if (reg1.test(str)) retval = true;
    if (reg2.test(str)) retval = true;
    if (reg3.test(str)) retval = true;
    if (reg4.test(str)) retval = true;
    if (reg5.test(str)) retval = true;
    if (reg6.test(str)) retval = true;
    return retval;
}