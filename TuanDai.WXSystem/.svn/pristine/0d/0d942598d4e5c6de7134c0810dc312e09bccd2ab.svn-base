$(document).ready(
function () {
    //$("#txtUserName").blur(function () { ValidateUserName();  });
    $("#txtMobileNumber").blur(function () {
        ValidateMobilerNumber();
    });
       
    $("#btnSendMsg").unbind("click").click(function () {
        $("body").Close();
        GetVerificationCode();
    });

    //$("#btnSendVoice").unbind("click").click(function () {
    //    $("body").Close();
    //    GetVerificationVoiceCode();
    //});
    RegisterSubmit();
});


/*验证用户名*/
function ValidateUserName() {
    var userName = $("#txtUserName").val();
    var openid = $("#hdOpenId").val();
    var pat = new RegExp("^[\\d\\a-z_A-Z]{6,20}$", "i");
    if (userName == "") {
        $("#lblUserName").text("用户名不能为空");
        $("#lblUserName").show();
        return false;
    }
    else if (userName.length < 6 || userName.length > 20) {
        $("#lblUserName").text("   用户名称的长度为6-20个字符");
        $("#lblUserName").show();
        return false;
    }
    else if (!pat.test(userName)) {
        $("#lblUserName").text("   用户名格式不正确,用户必须由字符和数字组成,且长度为6-20之间");
        $("#lblUserName").show();
        return false;
    }
    else {
        $("#lblUserName").hide();
        return true;
    }
};
/*验证用户名是否存在*/
function CheckUserName() {
    var flag = false;
    if (!ValidateMobilerNumber()) {
        return false
    }
    var userName = $("#txtMobileNumber").val();
    $.ajax({
        type: "post",
        async:false,
        url: "/ajaxCross/Login.ashx",
        data: { cmd: "CheckUserName", username: userName },
        dataType: "json",
        timeout: 3000,
        success: function (json) {
            var result = json.result;
            if (result == "1") {
                $("#lblMobileNumber").text(json.msg);
                $("#lblMobileNumber").show();
                flag= false;
            }
            else {
                $("#lblMobileNumber").hide();
                flag= true;
            }
        },
        error: function () {
            flag= false;
        }
    });
    return flag;
}
/*密码验证*/
function ValidatePassword() {
    var password = $("#txtPassword").val();
    var newpassword = $("#txtPassword").val().replace(/[ ]/g, "");
    var pattern1 = /^.*?[\d]+.*$/;
    var pattern2 = /^.*?[A-Za-z].*$/;
    var pattern3 = /^.{6,16}$/;
    if (newpassword != password) {
        $("body").showMessage({ message: "密码不能含有空格!", showCancel: false });
        //$("#lblTiShi").text("");
        //$("#lblPassword").text("密码不能含有空格");
        //$("#lblPassword").show();
        return false;
    }
    if (password == "") {
        $("body").showMessage({ message: "密码不能为空!", showCancel: false });
        //$("#lblTiShi").text("");
        //$("#lblPassword").text("密码不能为空");
        //$("#lblPassword").show();
        return false;
    }
    else if (!(pattern1.test(password) && pattern2.test(password) && pattern3.test(password))) {
        $("body").showMessage({ message: "密码格式不正确,密码必须由字符和数字组成,且长度为6-16之间！", showCancel: false });
        //$("#lblTiShi").text("");
        //$("#lblPassword").text("密码格式不正确,密码必须由字符和数字组成,且长度为6-16之间");
        //$("#lblPassword").show();
        return false;
    }
    else if (password.length < 6 || password.length > 16) {
        $("body").showMessage({ message: "密码长度为6-16个字符!", showCancel: false });
        //$("#lblTiShi").text("");
        //$("#lblPassword").text("密码长度为6-16个字符");
        //$("#lblPassword").show();
        return false;
    }
    else {
        //$("#lblPassword").hide();
        return true;
    }
};
/*手机号码验证*/
function ValidateMobilerNumber() {
    var result = false;
    var mobileNumber = $("#txtMobileNumber").val();
    var telno = $("#txtTelNo").val() || "";
    var phoneRegex = /^(?:13\d|14\d|15\d|17\d|18\d|19\d|16\d|11\d|12\d)\d{5}(\d{3}|\*{3})$/
    if (mobileNumber == "") {
        $("body").showMessage({ message: "手机号码不能为空!", showCancel: false });
        //$("#lblMobileNumber").text("手机号码不能为空");
        //$("#lblMobileNumber").show();

        result= false;
    }
    else if (!phoneRegex.test(mobileNumber)) {
        $("body").showMessage({ message: "输入手机号码格式不正确!", showCancel: false });
        //$("#lblMobileNumber").text("输入手机号码格式不正确");
        //$("#lblMobileNumber").show();
        result= false;
    }
    else if (telno != "") {
        if (!phoneRegex.test(telno)) {
            $("body").showMessage({ message: "邀请人手机号码格式不正确!", showCancel: false });
            //$("#lblTelNo").text("邀请人手机号码格式不正确");
            //$("#lblTelNo").show();
            result= false;
        }
        else {
            //$("#lblTelNo").hide();
            result= true;
        }
    }
    else {
        $.ajax({
            type: "post",
            async: false,
            url: "/ajaxCross/Login.ashx",
            data: "Cmd=CheckPhone&mobilenumber=" + mobileNumber,
            dataType: "json",
            timeout: 3000,
            success: function (jsondata) {
                var data = jsondata.result;
                if (data == "False") {
                    //$("#lblMobileNumber").hide();
                    result= true;
                }
                else {
                    var tf = GetQueryString("tdFrom");
                    if (tf == "" || tf == undefined)
                        tf = GetQueryString("tdfrom");
                    if (tf == "activity_xianjinhongbao_20170127") {
                        $("body").showMessage({ message: "哎哟喂，是您呀！放开这个红包，让新手来领取吧！",okString:"马上投资",okbtnEvent:function() {
                            window.location.href = "/pages/invest/we/we_list.aspx";
                        } });
                    }else if (jsondata.msg == "手机号已注册，可直接登录") {
                        $("body").showMessage({ message: jsondata.msg,okString:"马上登录",okbtnEvent:function() {
                            window.location.href = "/user/login.aspx";
                        } });
                    }
                    else {
                        $("body").showMessage({ message: jsondata.msg, showCancel: false });
                    }
                    
                    //$("#lblMobileNumber").text("手机已注册");
                    //$("#lblMobileNumber").show();
                    result= false;
                }
            }
        });
    }
    return result;
};
/*图形验证码验证*/
function ValidateImgCode() {
    var code = $("#txtValidNumber").val();
    if (code == "") {
        //$("#lblValidNumber").text("图形验证码不能为空");
        //$("#lblValidNumber").show();
        $("body").showMessage({ message: "图形验证码不能为空!", showCancel: false });
        return false;
    }
    else if (code.length < 4) {
        $("body").showMessage({ message: "图形验证码不能为空!", showCancel: false });
        //$("#lblValidNumber").text("图形验证码不正确");
        //$("#lblValidNumber").show();
        return false;
    } else {
        //$("#lblValidNumber").hide();
        return true;
    }
}
/*验证码验证*/
function ValidateCode() {
    var code = $("#txtCode").val();
    if (code == "") {
        $("body").showMessage({ message: "手机验证码不能为空!", showCancel: false });
        //$("#lblCode").text("手机验证码不能为空");
        //$("#lblCode").show();
        return false;
    }
    else {
        //$("#lblCode").hide();
        return true;
    }
}
/*获取手机验证码*/
function GetVerificationCode() {
    var validCode = $("#txtValidNumber").val();
    var mobileNumber = $("#txtMobileNumber").val();
    
    $.ajax({
        url: "/ajaxCross/Login.ashx",
        type: "post",
        dataType: "json",
        data: { cmd: "GetPhoneRegCode", mobilenumber: mobileNumber,ValidCode:validCode },
        success: function (json) {
            var result = json.result;
            if (result == "1") {
                $("#btncode").attr('disabled', true);
                $('#btncode').addClass("disabled");
                //$("#lblCode").text("发送成功，如未收到请稍后重新获取。");
                //$("#lblCode").show();
                $("body").showMessage({ message: "发送成功，如未收到请稍后重新获取!", showCancel: false });
                updateTimeLabel(60);
                return true;
            }
            else {
                updateTimeLabel(0);
                $("#btncode").attr('disabled', true);
                $('#btncode').addClass("disabled");
                if (json.msg=="图形验证码错误") {
                    // $("#lblValidNumber").text(json.msg);
                    //$("#lblValidNumber").show(); 
                    $("body").showMessage({ message: json.msg, showCancel: false });
                } else if (json.msg == "手机号已注册，可直接登录") {
                    $("body").showMessage({
                        message: json.msg, okString: "马上登录", okbtnEvent: function () {
                            window.location.href = "/user/login.aspx";
                        }
                    });
                }
                else {
                  //$("#lblCode").text(json.msg);
                    //  $("#lblCode").show();
                    $("body").showMessage({ message: json.msg, showCancel: false });
                }             
              
                return false;
            }
        },
        error: function () {
            $("#btncode").attr('disabled', true);
            $('#btncode').addClass("disabled");
            $("body").showMessage({ message: "网络异常，请重试!", showCancel: false });
            //$("#lblCode").text("网络异常，请重试。");
            //$("#lblCode").show();
            updateTimeLabel(0);
            return false;
        }
    });
};

/*获取手机语音验证码*/
function GetVerificationVoiceCode() {
    var mobileNumber = $("#txtMobileNumber").val();
    var validCode = $("#txtValidNumber").val();
    $.ajax({
        url: "/ajaxCross/Login.ashx",
        type: "post",
        dataType: "json",
        data: { cmd: "GetPhoneRegVoiceCode", mobilenumber: mobileNumber,ValidCode:validCode },
        success: function (json) {
            var result = json.result;
            if (parseInt(result) == -100) { $("#lblCode").text("系统繁忙，请稍候重试");}
            if (result == "1") {
                $("#btncode").attr('disabled', true);
                $('#btncode').addClass("disabled");
                $("body").showMessage({ message: "发送成功，如未收到请稍后重新获取!", showCancel: false });
                //$("#lblCode").text("发送成功，如未收到请稍后重新获取。");
                //$("#lblCode").show();
                updateTimeLabel(60);
                return true;
            }
            else {
                updateTimeLabel(0);
                $(".btncode").attr('disabled', true);
                $('.btncode').addClass("disabled");
                if (json.msg == "图形验证码错误") {
                    $("body").showMessage({ message: json.msg, showCancel: false });
                    //$("#lblValidNumber").text(json.msg);
                    //$("#lblValidNumber").show();
                } else if (json.msg == "手机号已注册，可直接登录") {
                    $("body").showMessage({
                        message: json.msg, okString: "马上登录", okbtnEvent: function () {
                            window.location.href = "/user/login.aspx";
                        }
                    });
                }
                else {
                    $("body").showMessage({ message: json.msg, showCancel: false });
                    //$("#lblCode").text(json.msg);
                    //$("#lblCode").show();
                }
                
                return false;
            }
        },
        error: function () {
            $("#btncode").attr('disabled', true);
            $('#btncode').addClass("disabled");
            $("body").showMessage({ message: "网络异常，请重试!", showCancel: false });
            //$("#lblCode").text("网络异常，请重试。");
            //$("#lblCode").show();
            
            updateTimeLabel(0);
            return false;
        }
    });
};

function updateTimeLabel(time) {
    var btn = $("#btncode");
    btn.fadeIn(1000);
    btn.val(time <= 0 ? "获取验证码" : ("重新发送" + (time) + ""));
    var hander = setInterval(function () {
        if (time <= 0) {
            clearInterval(hander);
            btn.val("获取验证码");
            btn.attr("disabled", false);
            //$("#lblTiShi").text("");
            //$("#lblTiShi").hide();
            $('#btncode').removeClass("disabled");
        }
        else {
            btn.val("重新发送" + (time--) + "");
        }
    }, 1000);
};
/*团贷网注册协议*/
function checkagree() {
    if ($('#agreexieyi').is(':checked')) {
        $("#lblAgree").hide();
        return true;
    } else {
//        $("#lblAgree").text("注册失败：注册成为团贷网会员，一定要同意团贷网协议。");
        //        $("#lblAgre").show();
        alert("注册失败：注册成为团贷网会员，一定要同意团贷网协议。");
        return false;
    }
}
/*注册*/
function RegisterSubmit() {
    $("#btnSubmit").click(function () { 
        //if (!checkagree()) {
        //    return false;
        //}
        
        if (!ValidateMobilerNumber()) {
            return false;
        }
        //if (!ValidateImgCode()) {
        //    return false;
        //}
        if (!ValidateCode()) {
            return false;
        }
        if (!ValidatePassword()) {
            return false;
        }

        $("#dvPopmsg").show();
        
        var userName = $("#txtUserName").val();
        var password = $("#txtPassword").val();
        var validCode = $("#txtValidNumber").val();
        var mobileNumber = $("#txtMobileNumber").val();
        var verificationCode = $("#txtCode").val();
        var telno = $("#txtTelNo").val();
        var extendKey = $("#hd_extendKey").val();
        var returnUrl = $("#hd_returnUrl").val();
        var tdfrom = $("#hd_tdFrom").val();

        var strPwd = fnStringJM(password);

        $("#btnSubmit").html("<img  style='width:18px;height:18px;' src='/imgs/images/icon/ico_btnLoading.png' alt='' />&nbsp;正在注册中...");


        $.ajax({
            url: "/ajaxCross/Login.ashx",
            type: "post",
            dataType: "json",
            data: { cmd: "Register", username: userName, password: strPwd, ValidCode: validCode, mobilenumber: mobileNumber, verificationCode: verificationCode, telno: telno, extendKey: extendKey, from: tdfrom },
            success: function (json) {
                var result = json.result;
                if (result == "1") {
                    $("#txtUserName").val("");
                    $("#txtPassword").val("");
                    $("#txtMobileNumber").val("");
                    $("#txtCode").val("");
                    if (returnUrl == undefined || returnUrl == "") {
                        returnUrl = "//m.tuandai.com/Member/My_account.aspx";
                    }
                    if (json.msg != "" && json.msg.indexOf("http") > -1) {
                        location.href = json.msg + encodeURI(returnUrl);
                    }
                    else {
                        location.href = returnUrl;
                    }
                } else if (json.msg == "手机号已注册，可直接登录") {
                    $("body").showMessage({
                        message: json.msg, okString: "马上登录", okbtnEvent: function () {
                            window.location.href = "/user/login.aspx";
                        }
                    });
                }
                else {
                    $("body").showMessage({ message: json.msg, showCancel: false });
                    $("#btnSubmit").html("注册");
                    //$("#dvPopmsg").hide();
                    //$("#lblTiShi").text(json.msg);
                    //$("#lblTiShi").show();
                }
            },
            error: function () {
                $("body").showMessage({ message: json.msg, showCancel: false });
                $("#btnSubmit").html("注册");
                //$("#dvPopmsg").hide();
                //$("#lblTiShi").text(json.msg);
                //$("#lblTiShi").show();
            }
        });
    });
};


