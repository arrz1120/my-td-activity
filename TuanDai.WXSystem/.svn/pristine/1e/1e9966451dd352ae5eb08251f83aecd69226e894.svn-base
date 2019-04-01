//设置新密码
$(function () {
    //新密码
    $("#txtpwd").blur(function () {
        BlurPwd();
    });
    //新密码
    $("#txtpwd2").blur(function () {
        BlurPwd1();
    });
    
    $("#temp1 input").keypress(function (e) {
        if (e.keyCode == "13")
            $("#btnSubmit").click();
    });
    $("#btnSubmit").click(function () {
        if (!BlurPwd()) {
            return false;
        }
        if (!BlurPwd1()) {
            return false;
        }
        if (BasicCheck()) {
            //ShowMsg('提交中，请稍后...', '0', '', '');
            $("body").showLoading("提交中，请稍候...");
            var newPassWord = fnStringJM($.trim($("#txtpwd2").val()));
            $.ajax({
                url: "/ajaxCross/ajax_s1a2fe.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "ResetPasswordByMobile", password: newPassWord},
                success: function (json) {
                    $("body").hideLoading();
                    var d = parseInt(json.result);
                    if (parseInt(d) == -100) { ShowMsg('系统异常，请稍后操作!', '0', '', ''); }
                    if (d > 0) {
                        //setTimeout(, 5000);
                        if (backurl != "") {
                            $("body").showMessage({ message: "恭喜，密码修改成功！",showCancel:false,okString:"确定",okbtnEvent:function() {
                                window.location.href = backurl;
                            }});
                            //ShowMsg('恭喜，密码修改成功！', '0', '确定', backurl);
                        }
                        else {
                            $("body").showMessage({
                                message: "恭喜，密码修改成功！", showCancel: false, okString: "重新登录", okbtnEvent: function () {
                                    window.location.href = '/user/login.aspx';
                                }
                            });
                            //ShowMsg('恭喜，您的新密码已修改成功！', '1', '重新登录', '/user/login.aspx');
                        }
                    } else if (json.msg == "新密码不能跟旧密码一样") {
                        $("body").showMessage({
                            message: "密码重置失败:"+json.msg, showCancel: false
                        });
                    } else if (d == -1) {
                        $("body").showMessage({
                            message: "密码重置失败:请确保填写信息正确或者已经失效！", showCancel: false
                        });
                        //ShowMsg('密码重置失败:请确保填写信息正确或者已经失效！', '0', '', '');
                    }
                    else if (d == -2) {
                        $("body").showMessage({
                            message: "密码重置失败:新登录密码不能与交易密码相同！", showCancel: false
                        });
                        //ShowMsg('密码重置失败:新登录密码不能与交易密码相同！', '0', '', '');
                    }
                    else {
                        $("body").showMessage({
                            message: json.msg+"<br />请联系客服<a href='tel:1010-1218'>1010-1218</a>！", showCancel: false
                        });
                        //ShowMsg('您好，您的密码重置失败，请联系客服！', '0', '', '');
                    }
                },
                error: function () {
                    $("body").hideLoading();
                    $("body").showMessage({
                        message: "系统繁忙，请稍候再试！", showCancel: false
                    });
                    //ShowMsg('系统异常，请稍后操作。', '0', '', '');
                }
            });
        }
    });
})

function BlurPwd() {
    var str = $.trim($("#txtpwd").val());
    var password = $("#txtpwd").val().replace(/[ ]/g, "");
    var pattern1 = /^.*?[\d]+.*$/;
    var pattern2 = /^.*?[A-Za-z].*$/;
    var pattern3 = /^.{6,16}$/;
    if (password != str) {
        $("#txtpwdTip").html("密码不能含有空格").show();
        return false;
    }
    if (str == "") {
        $("#txtpwdTip").html("新密码不能为空").show();
        return false;
    }
    else if (!(pattern1.test(password) && pattern2.test(password) && pattern3.test(password))) {
        $("#txtpwdTip").html("密码必须由字符和数字组成,且长度为6-16之间").show();
        return false;
    }
    else if (str.length < 6 || str.length > 16) {
        $("#txtpwdTip").html("密码长度为6-16个字符").show();
        return false;
    }
    else {
        $("#txtpwdTip").hide();
        return true;
    }
}

function BlurPwd1() {
    var pat = new RegExp("^.{6,16}$", "i");
    var str = $.trim($("#txtpwd2").val());
    if (str == "") {
        $("#txtpwd2Tip").html("确认密码不能为空").show();
        return false;
    }
    else if (str != $.trim($("#txtpwd").val())) {
        $("#txtpwd2Tip").html("新密码输入不一致").show();
        return false;
    }
    else {
        $("#txtpwd2Tip").hide();
        return true;
    }
}

function BasicCheck() {
    var isok2 = BlurPwd();
    var isok3 = BlurPwd1();
    if (isok2 && isok3) {
        return true;
    }
    else {
        return false;
    }
}

function Done() {
    $(".maskLayer").fadeOut();
    $("#affirmLoanMain").animate({
        bottom: "-430px"
    }, 200)
    $("#tip").animate({
        bottom: "-430px"
    }, 200)
}

function ShowMsg(msg, isShowOk, okValue, url) {
    $(".maskLayer").fadeIn();
    $("#msg").html(msg);
    if (isShowOk == "1" && url != "") {
        $("#btnOk").html(okValue);
        $("#btnOk").attr("href", url);
        $("#btnCancel").val("取消");
        $("#btnOk").parent().show();

    } else {
        $("#btnCancel").val("确定");
        if (url != "") {
            $("#btnCancel").bind("click", function () {
                window.location.href = url;
            });
        }
        $("#btnOk").parent().hide();
    }
    var bottom = (document.documentElement.clientHeight - document.getElementById("tip").offsetHeight) / 2;
    $("#affirmLoanMain").animate({
        bottom: "-430px"
    }, 200)

    $("#tip").animate({
        bottom: bottom
    }, 200)
}