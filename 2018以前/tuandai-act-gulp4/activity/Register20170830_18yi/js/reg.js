﻿$(function () {
    $('.agreement input').iCheck({
        checkboxClass: 'icheckbox_square-yellow',
        radioClass: 'iradio_square-yellow',
        increaseArea: '20%'
    });
    $('#phone').val("");
    $('#passWord').val("");
    $("#txtValidNumber").val("");
    $('#messCode').val("");

    $('#phone').blur(function () { BlurTelNo(false); });
    $('#passWord').blur(function () { BlurPwd(false); });
    $('#txtValidNumber').blur(function () { BlurImgCode(); });
    $('#messCode').blur(function () { BlurCode(false); });

    $("#phone").bind("click", function () { OnClickMessage() });
    $("#txtValidNumber").bind("click", function () { OnClickMessage() });



    //用bind这种方式，否则unbind不起作用
    $("#btnReg").bind("click", function () { RegSubmit($("#btnReg")); });
    $("#btnSendMsg").bind("click", function () { sendMobileValidSMSCode(); });
});
//获取注册来源
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return "";
}

//重新加载验证码
function reloadCode(urlString) {
    $("#imgVcode").attr("src", urlString + "?id=" + Math.random());
}

//点击手机号码输入框触发
function OnClickMessage() {
    $.ajax({
        async: false,
        url: "ajax/reg.ashx",
        dataType: "json",
        data: {
            Action: "OnClickMessage"
        },
        success: function (json) {
        },
        error: function () {
        }
    });
}

//校验手机号码
function BlurTelNo(isSubmit) {
    var result = false;
    var td = "#dvPhoneError";
    var patTel = new RegExp("^(13|14|15|17|18)[0-9]{9}$", "i");
    var phoneNumber = $("#phone").val();
    if ($.trim(phoneNumber) != "") {
        if (patTel.test(phoneNumber)) {
            $.ajax({
                async: false,
                url: "ajax/reg.ashx",
                dataType: "json",
                data: {
                    Action: "CheckPhoneIsExist",
                    phoneNumber: phoneNumber
                },
                success: function (jsondata) {
                    var data = jsondata.result;
                    if (data == "false") {
                        $(td).html("");
                        result = true;
                    }
                    else {
                        $(td).html("手机号已被注册");
                        result = false;
                    }
                },
                error: function () {
                }
            });
        }
        else {
            $(td).html("输入手机号码格式不正确");
            result = false;
            $("#phone").focus();
        }
        return result;
    }
    else {
        if (isSubmit == true) {
            $(td).html("手机号码不能为空");
            $("#phone").focus();
        }
        else {
            $(td).html("");
            //不是提交注册,置为空
        }
        return false;
    }
}

//校验密码
function BlurPwd(isSubmit) {
    var txt = "#passWord";
    var td = "#dvPwdError";
    var passwordValue = $(txt).val();

    if (passwordValue.indexOf(" ") > -1) {
        $(td).html("密码不允许含有空格");
        $(txt).focus();
        return false;
    }

    if ($.trim(passwordValue) != "") {
        if (/^.*?[\d]+.*$/.test(passwordValue) && /^.*?[A-Za-z].*$/.test(passwordValue) && /^.{6,16}$/.test(passwordValue)) {
            $(td).html("");
            return true;
        }
        else {
            $(td).html("密码格式错误");
            $(txt).focus();
            return false;
        }
    }
    else {
        if (isSubmit == true) {
            $(td).html("密码不能为空");
            $(txt).focus();
        }
        else {
            $(td).html("");
            //不是提交注册,置为空
        }

        return false;
    }
}

/*图形验证码验证*/
function BlurImgCode(isGet) {
    var imgCode = $("#txtValidNumber").val();
    if ($.trim(imgCode) == "") {
        if (isGet == true) {
            $("#dvValidNumber").text("图形验证码不能为空");
            $("#dvValidNumber").show();
            $("#txtValidNumber").focus();
        }
        else {
        }
        return false;
    }
    else {
        $("#dvValidNumber").text("");
        return true;
    }
}


//检验 手机验证码
function BlurCode(isSubmit) {
    var td = "#dvCodeError";
    var messCode = $("#messCode").val();
    var pat = new RegExp("^[0-9]{6}$", "i");

    if ($.trim(messCode) != "") {
        if (!pat.test(messCode)) {//格式不正确
            $(td).html("验证码错误,请重新输入");
            $("#messCode").focus();
            return false;
        }
        else {
            $(td).html("");
            return true;
        }
    }
    else {
        if (isSubmit == true) {
            $(td).html("请输入验证码");
            $("#messCode").focus();
        }
        else {
            $(td).html("");
        }

        return false;
    }
}

/*团贷网注册协议*/
function checkagree() {
    return true;
    //if ($('#agreexieyi').hasClass('checked')) {
    //    return true;
    //}
    //else {
    //    alert("注册成为团贷网会员，一定要同意团贷网协议");
    //    $('#agreexieyi').addClass('checked');
    //    return false;
    //}
}

//提交注册
function RegSubmit(ctrl) {
    if (checkagree() && BlurTelNo(true) && BlurPwd(true) && BlurCode(true)) {
        $(ctrl).unbind("click");
        var vOldBtnRegText = $("#btnReg").html();
        $("#btnReg").html("正在提交注册信息...");
        //调整注册来源，由原来的from，增加一个tdfrom 
        var from = "tgPhoneRegister";
        var regFrom = GetQueryString("tdfrom");
        var channelFrom = GetQueryString("channel");

        if (regFrom == "" || regFrom == null) {
            regFrom = GetQueryString("from");
            if (regFrom == "" || regFrom == null) {
                regFrom = getCookie("tdfrom");
                if (regFrom == "" || regFrom == null || regFrom == "null") {
                    regFrom = from;
                }
            }
        }

        //wps推广
        var wps_userid = GetQueryString("userid");
        var wps_from = GetQueryString("extra")
        if (wps_userid && wps_from) {
            regFrom = "wps_" + wps_from + "_" + wps_userid;
        }

        $.ajax({
            async: false,
            url: "ajax/reg.ashx",
            dataType: "json",
            type: "POST",
            data: {
                Action: "User_Insert_Phone",
                Phone: $("#phone").val(),
                Pwd: $("#passWord").val(),
                phoneCode: $("#messCode").val(),
                registerFrom: regFrom,
                extendKey: GetQueryString("extendkey"),
                tdfrom: GetQueryString("tdfrom"),
                activityCode: GetQueryString("activityCode")

            },
            success: function (returnJsonData) {
                if (returnJsonData.result == 1) {
                    window.location.href = "/phone/common/register_succeed.aspx?tdfrom=" + regFrom;
                }
                else {
                    $("#dvCodeError").html(returnJsonData.message);
                    $("#btnReg").html(vOldBtnRegText);
                    $("#btnReg").click(function () { RegSubmit($("#btnReg")); });
                }

            },
            error: function () {
                $("#btnReg").html(vOldBtnRegText);
                $(ctrl).click(function () { RegSubmit("#btnReg"); });
            }
        });
    }
}



var sendCount = 0;
var timer = null;
var leftsecond = 180; //倒计时
var mbTest = /^(13|14|15|17|18)[0-9]{9}$/;
//获取手机验证码
function sendMobileValidSMSCode() {
    
    var phoneNumber = $("#phone").val();
    if (phoneNumber == "") {
        $("#dvPhoneError").html("手机号码不能为空");
        $("#dvPhoneError").show();
        $("#dvPhoneError").focus();
        return;
    }

    //if (!BlurImgCode(true)) {
    //    $("#txtValidNumber").focus();
    //    return;
    //}

    $("#dvCodeError").html("");

    $("#btnSendMsg").unbind();
    //var validCode = $("#txtValidNumber").val();
    if (mbTest.test(phoneNumber)) {
        if (sendCount > 0) {
            $("#btnSendMsg").val("重新发送中...");
        } else {
            $("#btnSendMsg").val("短信发送中...");
        }
        sendCount++;
        $("#dvPhoneError").html("");
        $.ajax({
            async: false,
            type: 'POST',
            url: "ajax/reg.ashx",
            dataType: "json",
            data: {
                Action: "GetPhoneRegCode",
                phoneNumber: phoneNumber
                //sVerCode: validCode
            },
            success: function (returnJsonData) {
                var result = returnJsonData.result;
                if (returnJsonData.result == "1") {
                    clearInterval(timer);
                    leftsecond = 180;
                    timer = setInterval(setLeftTime, 1000, "1");
                    $("#phone").attr("readonly", true);
                }
                else {
                    switch (result) {
                        case "0":
                        case "-1":
                        case "-2":
                        case "-3":
                        case "-4":
                        case "-5":
                        case "-6":
                            $("#dvCodeError").html(returnJsonData.message);
                            reloadCode('/ajaxhander/ValidateCode.ashx')
                            $("#btnSendMsg").bind("click", function () {
                                sendMobileValidSMSCode();
                            });
                            $("#phone").removeAttr("readonly");
                            $("#btnSendMsg").val("获取验证码");
                            $("#txtValidNumber").val("");
                            $("#txtValidNumber").focus();
                            break;
                        case "-7":
                        case "-8":
                            $("#dvPhoneError").html(returnJsonData.message);
                            reloadCode('/ajaxhander/ValidateCode.ashx')
                            $("#btnSendMsg").bind("click", function () {
                                sendMobileValidSMSCode();
                            });
                            $("#phone").removeAttr("readonly");
                            $("#btnSendMsg").val("获取验证码");
                            $("#txtValidNumber").val("");
                            $("#txtValidNumber").focus();
                            break;
                        case "-180"://未够180秒
                            var seconds = returnJsonData.message.split("_")[1];
                            $("#dvCodeError").html("发送太频繁，请在" + seconds + "秒后可重发");
                            reloadCode('/ajaxhander/ValidateCode.ashx')
                            leftsecond = seconds;
                            clearInterval(timer);
                            timer = setInterval(setLeftTime, 1000, "1");
                            $("#phone").attr("readonly", true);
                            $("#txtValidNumber").val("");
                            $("#txtValidNumber").focus();
                            break;
                        case "-190":
                            $("#dvCodeError").html("今天发送次数过多,请明天再试");
                            reloadCode('/ajaxhander/ValidateCode.ashx')
                            $("#btnSendMsg").bind("click", function () {
                                sendMobileValidSMSCode();
                            });
                            $("#phone").removeAttr("readonly");
                            $("#btnSendMsg").val("获取验证码");
                            break;
                        default:
                            $("#dvCodeError").html("刷新页面重试");
                            reloadCode('/ajaxhander/ValidateCode.ashx')
                            $("#btnSendMsg").bind("click", function () {
                                sendMobileValidSMSCode();
                            });
                            $("#phone").removeAttr("readonly");
                            $("#btnSendMsg").val("获取验证码");
                            break;
                    }
                }
            },
            error: function () {
                $("#dvCodeError").html("刷新页面重试");
                reloadCode('/ajaxhander/ValidateCode.ashx')
                $("#btnSendMsg").bind("click", function () {
                    sendMobileValidSMSCode();
                });
                $("#phone").removeAttr("readonly");
                $("#btnSendMsg").val("获取验证码");
            }
        });
    }
    else {
        $("#btnSendMsg").bind("click", function () {
            sendMobileValidSMSCode();
        });
    }
}

function setLeftTime() {
    var second = Math.floor(leftsecond);
    $("#btnSendMsg").val(second + "秒后可重发");
    leftsecond--;
    if (leftsecond < 1) {
        $("#btnSendMsg").val("获取验证码");
        clearInterval(timer);
        try {
            $("#btnSendMsg").bind("click", function () { sendMobileValidSMSCode(); });
            $("#phone").removeAttr("readonly");
        } catch (E) { }
        return;
    }
}