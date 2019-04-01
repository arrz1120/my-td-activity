$(document).ready(
function () { 
    $(window).keypress(
        function (e) {
            if (e.keyCode == "13") {
                $("#txtUserName").blur();
                $("#txtPassword").blur();
                LoginSubmit();
            }
        });
    $("#btnLoginSubmit").click(function () {
        ValidateUserName();
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
    //var openid = $("#hdOpenId").val();
    //var emailRegex = new RegExp("^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$", "i");
    var phoneRegex = /^(?:13\d|15\d|18\d)\d{5}(\d{3}|\*{3})$/
    if (userName == "") {
        $("body").showMessage({ message: "用户名不能为空!", showCancel: false });
        //$("#pT1").show();
        //$("#pT2").hide();
        //$("#pT3").hide();
        //$("#pT4").hide();
        return false;
    } else {
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
        $("body").showMessage({ message: "密码不能为空!", showCancel: false });
        //$("#pT3").show();
        //$("#pT4").hide();
        //$("#pT1").hide();
        //$("#pT2").hide();
        return false;
    }
    else if (!(pattern1.test(password) && pattern2.test(password) && pattern3.test(password))) {
        $("body").showMessage({ message: "密码格式不正确,密码必须由字符和数字组成,且长度为6-16之间!", showCancel: false });
        //$("#spanPassword").text("密码格式不正确,密码必须由字符和数字组成,且长度为6-16之间");
        //$("#pT3").hide();
        //$("#pT4").show();
        //$("#pT1").hide();
        //$("#pT2").hide();
        return false;
    }
    else if (password.length < 6 || password.length > 16) {
        $("body").showMessage({ message: "密码有误，请输入正确密码;密码长度为6-16个字符!", showCancel: false });

        //$("#spanPassword").text("密码长度为6-16个字符");
        //$("#pT3").hide();
        //$("#pT4").show();
        //$("#pT1").hide();
        //$("#pT2").hide();
        return false;
    }
    else {
        //$("#pT3").hide();
        //$("#pT4").hide();
        return true;
    }
}
/*验证码验证*/
function ValidateCode() {
    var code = $("#txtCode").val();
    if (code == "") {
        $("#pT5").show();
        return false;
    }
    else {
        $("#pT5").hide();
        $("#pT6").hide();
        return true;
    }
}
/*登录提交*/
function LoginSubmit() {
    if (!ValidateUserName()) {
        return false;
    }
    if ($("#txtPassword").val() == "") {
        $("body").showMessage({ message: "密码不能为空!", showCancel: false });

        //$("#pT3").show();
        return false;
    }
    //$("#pT3").hide();
    //$("#pT4").hide();
    //$("#pT1").hide();
    //$("#pT2").hide();
    //$("#divTiShi").text("");  

    var userName = $("#txtUserName").val();
    var password = $("#txtPassword").val();   
    if ($('#cbRememberMe').is(':checked')) {
        var exp = new Date(); 
        exp.setTime(exp.getTime() + 30*24*60*60*1000);//当前时间+1个月
        jaaulde.utils.cookies.set("Wap_UserName", userName, { expiresAt: exp });
    }
    else {
        jaaulde.utils.cookies.del("Wap_UserName");
    }
    jaaulde.utils.cookies.set("TDW_WapUserName", userName);
    $('#btnLoginSubmit').unbind('click');
    //$('#btnLoginSubmit').removeClass('btnYellow').addClass("disabled");
    var txtUserName = fnStringJM(userName);
    var txtPassword = fnStringJM(password);
    $("#btnLoginSubmit").html("<img  style='width:18px;height:18px;' src='/imgs/images/icon/ico_btnLoading.png' alt='' />&nbsp;正在登录中...");

    $.ajax({
        async: true,
        url: "/ajaxCross/Login.ashx?cmd=LoginSubmit",
        type: "post",
        dataType: "json",
        data: { cmd: "LoginSubmit", username: txtUserName, password: txtPassword, verificationCode: "", returnUrl: $("#hd_returnUrl").val() },
        success: function (json) {
            AsyncLogin(json);            
        },
        error: function () {            
            //$("body").hideLoading();
            $("#btnLoginSubmit").html("确定");
        }
    });
};
//刷新验证码
function reload(urlString) {
    $("#imVcode").attr("src", urlString + "?id=" + Math.random());
}
//登陆后事件
function AsyncLogin(data) {
    var result = data.result;
    var msg = "";
    $("#txtPassword").val("");
    switch (result) {
        case "-100":
            location.href = "/ErrorPage.aspx";
            break;
        case "0":
            $("#dvPopmsg").hide();
            if (data.msg == "0") {
                msg = '该账户已经被冻结';               
            }
            else if (data.msg == "5") {
                msg = '输入密码有误，今天内连续输错5次，不允许再登录，您可以明天再登录，或者联系客服。';
            }
            else {
                msg = '您输入的密码有误，请重新登录！还有' + (5 - parseInt(data.msg)) + '次机会！';               
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
            //$("#dvPopmsg").hide();
            msg = data.msg;        
            break;
    }
    if (msg != "") {
        $("body").showMessage({ message: msg, showCancel: false });
        $("#btnLoginSubmit").html("确定");
    }

    $('#btnLoginSubmit').removeClass('disabled').addClass("btnYellow");
    $('#btnLoginSubmit').click(function () { LoginSubmit() });
}