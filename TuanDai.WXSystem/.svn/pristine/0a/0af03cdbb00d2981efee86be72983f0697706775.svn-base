$(document).ready(
function () {
    $("#txtUserName").blur(function () { ValidateUserName(); }); 
    $(window).keypress(
        function (e) {
            if (e.keyCode == "13") {
                $("#txtUserName").blur();
                $("#txtPassword").blur();
                LoginSubmit();
            }
        });
    $("#btnLoginSubmit").click(function () {
        LoginSubmit();
    });
    var cookieValue = jaaulde.utils.cookies.get("Wap_UserName");

    if (cookieValue != '' && cookieValue != null) {
        $("#txtUserName").val(cookieValue);  
    }
    else {
        $("#txtUserName").val("");
    }
});
//验证用户名
function ValidateUserName() {
    $("#divTiShi").hide();
    var userName = $("#txtUserName").val(); 
    var phoneRegex = /^(?:13\d|15\d|18\d)\d{5}(\d{3}|\*{3})$/
    if (userName == "") {
        $("#pT1").show();
        $("#pT2").hide();
        $("#pT3").hide();
        $("#pT4").hide();
        return false;
    } 
    else {
        $("#pT1").hide();
        $("#pT2").hide();
        return true;
    }
}
/*密码验证*/
function ValidatePassword() {
    $("#divTiShi").hide();
    var password = $("#txtPassword").val();
    var pattern1 = /^.*?[\d]+.*$/;
    var pattern2 = /^.*?[A-Za-z].*$/;
    var pattern3 = /^.{6,16}$/;
    if (password == "") {
        $("#pT3").show();
        $("#pT4").hide();
        $("#pT1").hide();
        $("#pT2").hide();
        return false;
    }
    else if (!(pattern1.test(password) && pattern2.test(password) && pattern3.test(password))) {
        $("#spanPassword").text("密码格式不正确,密码必须由字符和数字组成,且长度为6-16之间");
        $("#pT3").hide();
        $("#pT4").show();
        $("#pT1").hide();
        $("#pT2").hide();
        return false;
    }
    else if (password.length < 6 || password.length > 16) {
        $("#spanPassword").text("密码长度为6-16个字符");
        $("#pT3").hide();
        $("#pT4").show();
        $("#pT1").hide();
        $("#pT2").hide();
        return false;
    }
    else {
        $("#pT3").hide();
        $("#pT4").hide();
        return true;
    }
}
 
/*登录提交*/
function LoginSubmit() {
    if (!ValidateUserName()) {
        return false;
    }
    if ($("#txtPassword").val() == "") {
        $("#pT3").show();
        return false;
    } 
    $("#pT3").hide();
    $("#pT4").hide();
    $("#pT1").hide();
    $("#pT2").hide();
    $("#divTiShi").text("");
    //检测是否有绑定过
    if (CheckIsBind()) {
        return;
    }
    var userName = $("#txtUserName").val();
    var password = $("#txtPassword").val();
    var thirdparty = "";
    if (LoginType == "1")
        thirdparty = "qq";
    else if (LoginType == "2")
        thirdparty = "sina";
    else if (LoginType == "3")
        thirdparty = "weixin";

    $('#btnLoginSubmit').unbind('click');
    $('#btnLoginSubmit').removeClass('btnYellow').addClass("disabled");
    var txtUserName = fnStringJM(userName);
    var txtPassword = fnStringJM(password);
    $.ajax({
        async: true,
        url: "/ajaxCross/Login.ashx?cmd=LoginSubmit",
        type: "post",
        dataType: "json",
        data: { cmd: "LoginSubmit", username: txtUserName, password: txtPassword, returnUrl: $("#hd_returnUrl").val(), ThirdParty: thirdparty },
        success: function (json) {
            AsyncLogin(json);
        },
        error: function () {
        }
    });
}
function CheckIsBind() {
    var userName = $("#txtUserName").val();
    if (userName == "")
        return false;
    var isBind = false;
    $.ajax({
        async: false,
        url: "/ajaxCross/Login.ashx",
        type: "post",
        dataType: "json",
        data: { cmd: "CheckThirdLoginBind", username: userName },
        success: function (json) {
            if (json.result == "1") {
                isBind = false;
            } else {
                isBind = true;
                alert(json.msg);
            }
        },
        error: function () {
            isBind = false;
        }
    });
    return isBind;
}

//登陆后事件
function AsyncLogin(data) {
    var result = data.result;
    $("#txtPassword").val("");
    switch (result) {
        case "-100":
            location.href = "/ErrorPage.aspx";
            break;
        case "0":
            if (data.msg == "0") {
                $("#divTiShi").text('该账户已经被冻结');
                $("#divTiShi").show();
            }
            else if (data.msg == "5") {
                $("#divTiShi").text('输入密码有误，今天内连续输错5次，不允许再登录，您可以明天再登录，或者联系客服。');
                $("#divTiShi").show();
            }
            else {
                $("#divTiShi").text('您输入的密码有误，请重新登录！还有' + (5 - parseInt(data.msg)) + '次机会！');
                $("#divTiShi").show();
            }
            break;
        case "1":
            var returnUrl = data.msg;
            if (returnUrl == "" || returnUrl == "/") {
                window.location.href = "/Member/my_account.aspx";
            } else {
                window.location.href = returnUrl;
            }
            break;
        default:
            $("#divTiShi").text(data.msg);
            $("#divTiShi").show();
            break;
    }
    $('#btnLoginSubmit').removeClass('disabled').addClass("btnYellow");
    $('#btnLoginSubmit').click(function () { LoginSubmit() });
}