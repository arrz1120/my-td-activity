$(function() {
    $("#btnSendMobileCode").removeAttr("disabled");
    $("#txtMobilePhone").blur(function() {
        if ($("#txtMobilePhone").val() != "") {
            $("#txtMobileTip").hide();
        }
    });
    //send code
    $('#btnSendMobileCode').click(function() {
        var mobile = $("#txtMobilePhone").val();
        
        $("#txtMobileTip").hide();
        $("body").showMessage({ message: "", showCancel: null, url: null });
        $("#btnSendMsg").unbind("click").click(function() {
            $("body").Close();
            GetVerificationCode("0");
        });
        $("#btnSendVoice").unbind("click").click(function() {
            $("body").Close();
            GetVerificationCode("1");
        });

        $("#btnCancel").click(function() {
            $("body").Close();
        });

    });
    var checkCount = 0;
    $('#btn_mobile_ok').click(function() {

        var code = $("#txtMobileCode").val();
        if (code == "") {
            $("#txtMobileTip").hide();
            $("#txtMobileCodeTip").html("请输入手机验证码").show();
            return false;
        } 
        if (checkCount == 5) {
            $("#txtMobileCodeTip").html("验证码错误次数过多，请重新获取验证码!").show();
            return false;
        }
        var payPwd = $("#txtPayPwd").val();
        if (payPwd == "") {
            $("#txtPayPwdTip").html("请输入交易密码").show();
            return false;
        } 
        var payPwd1 = $("#txtPayPwd1").val();
        if (payPwd1 == "") {
            $("#txtPayPwd1Tip").html("请再次输入交易密码").show();
            return false;
        }
        if (payPwd1 != payPwd) {
            $("#txtPayPwd1Tip").html("两次输入的交易密码不一致").show();
            return false;
        }
        $.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "ResetPayPwdViaMobile", code: code, newPwd: payPwd },
            success: function(json) {
                var result = json.result;
                if (result == "1") {
                    alert('交易密码重置成功');
                    window.location.href = "/Member/my_userdetailinfo.aspx#safe";
                } else {
                    $("#txtPayPwd1Tip").html(json.msg).show();
                }
            }
        });
    });

});

//获取手机短信验证码
function GetVerificationCode(vtype) {
    $.ajax({
        url: "/ajaxCross/ajax_s1a2fe.ashx",
        type: "post",
        dataType: "json",
        data: { Cmd: "GetResetPayPwdMobileCode", MobilePhone: $("#txtMobilePhone").val(), vtype: vtype },
        success: function (json) {
            var result = json.result;
            leftsecond = 180;
            if (parseInt(result) == -100) {
                $("#btnSendMobileCode").val("发送失败");
            }
            if (result == 1) {
                $("#btnSendMobileCode").attr("disabled", "disabled");
                $("#btnSendMobileCode").addClass("disabled");
                checkCount = 0;
                $("#txtMobileCodeTip").html(json.msg).show();
                leftsecond = 180;
                clearInterval(timer);
                timer = setInterval(setLeftTime, 1000, "1");
            }
            else {
                $("#btnSendMobileCode").val("短信验证码");
                $("#txtMobileTip").html(json.msg).show();
            }
        }
    });
};

//获取手机验证码
var timer = null;
//倒计时
var leftsecond = 180;
function setLeftTime() {
    var second = Math.floor(leftsecond);
    $("#btnSendMobileCode").val("重新获取" + second + "");
    leftsecond--;
    if (leftsecond < 1) {
        $("#btnSendMobileCode").removeAttr("disabled");
        $("#btnSendMobileCode").removeClass("disabled");
        $("#btnSendMobileCode").val("短信验证码");
        $("#btnSendVoiceCode").show();
        clearInterval(timer);
        return;
    }
};