<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reset_LoginPassword.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.reset_LoginPassword" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>修改登录密码</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=GlobalUtils.Version %>" /><!--base-->
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->
  
</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
<div class="header">
    <div class="back" onclick="javascript:window.location.href='safety.aspx';">返回</div>
    <h1 class="title">修改登录密码</h1>
</div>
<%= this.GetNavIcon()%>
<div class="none"></div>
</header>

<div class="verification-box" id="UpdatePayPwd">
    <section class="bg-bdtopBom1-d1d1d1-notb pd10 mt20 clearfix">
        <div class="phoneCode resetPsw pr0">
            <div class="c-left">原登录密码</div>
            <input type="password" id="oldpassword" class="codeIpt" placeholder="原登录密码" />
        </div>
    </section>
    <span class="verification-3" style="color: Red; margin-left:10px;" id="oldpasswordError"></span>
    <section class="bg-bdtopBom1-d1d1d1-notb pd10 mt20 clearfix">
    <div class="phoneCode resetPsw pr0">
        <div class="c-left">新登录密码</div>
        <input type="password" id="txtNewPassword" class="codeIpt" maxlength="16" placeholder="6-16个字符，含字母、数字" onpaste="return false" oncontextmenu="return false" oncopy="return false" oncut="return false" onkeyup="this.value=this.value.replace(/^ +| +$/g,'')" />
    </div>
    </section>
    <span class="verification-3" style="color: Red; margin-left:10px;" id="txtNewPasswordError"></span>
    <section class="bg-bdtopBom1-d1d1d1-notb pd10 mt20 clearfix">
        <div class="phoneCode resetPsw pr0">
        <div class="c-left">确认新密码</div>
                <input type="password" id="txtNewPassword1" class="codeIpt" placeholder="再次输入新登录密码" />
                </div>
    </section>
    <span class="verification-3" style="color: Red; margin-left:10px;" id="txtNewPassword1Eeeor"></span>
    <span class="verification-3" style="color: Red;" id="UpdatePayPwdError"></span>
    <section class="pd15 mt5">
        <a href="javascript:UpdatePayPwd();" class="btn btnYellow">确定</a>
        <a href="/Member/safety/ResetPwd.aspx" class="c-ff7357 f14px rf">忘记密码</a>
    </section>
    </div>
   
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>    
    <script type="text/javascript" src="/scripts/TdStringHandler.js"></script>
    <script type="text/javascript" src="/scripts/Common.js?v=2015101301"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>""></script>
    <script type="text/javascript">
        var newTitle = '团贷网提醒您：';  
        function UpdatePayPwd() { 
            $("#UpdatePayPwdError").html("");
            $("#oldpasswordError").html("");
            $("#txtNewPasswordError").html("");
            $("#txtNewPassword1Eeeor").html("");
            var oldpwd = $("#oldpassword").val();
            var newspwd1 = $("#txtNewPassword").val();
            var newspwd2 = $("#txtNewPassword1").val();
            var newpassword = $("#txtNewPassword").val().replace(/[ ]/g, "");
            var pat = new RegExp("^.{6,16}$", "i");

            if (oldpwd == '') {
                $("#oldpasswordError").html("原登录密码必须填写");
                return;
            }
            if (newspwd1 == '') {
                $("#txtNewPasswordError").html("新登录密码必须填写");
                return;
            }
            if (!(/^.*?[\d]+.*$/.test(newspwd1) && /^.*?[A-Za-z].*$/.test(newspwd1) && /^.{6,16}$/.test(newspwd1))) {
                $("#txtNewPasswordError").html("格式错误，6-16个字符（必须含有字母+数字)");
                return;
            }
            if (newpassword != newspwd1) {
                $("#txtNewPasswordError").html("密码不能含有空格");
                return;
            }
            if (newspwd2 == '') {
                $("#txtNewPassword1Eeeor").html("确认登录密码必须填写");
                return;
            }
            if (newspwd2 != newspwd1) {
                $("#txtNewPassword1Eeeor").html("两次登录密码不一致");
                return;
            }
            var strOldPwd = fnStringJM(oldpwd);
            var strNewPwd = fnStringJM(newspwd1);
            $("body").showLoading("提交中...");
            $.ajax({
                type: "POST",
                url: "/ajaxCross/ajax_s1a2fe.ashx",
                dataType: "json",
                data: { Cmd: "ResetLoginPwd", oldpwd: strOldPwd, newpwd: strNewPwd },
                success: function (json) {
                    $("body").hideLoading();
                    var d = json.result;
                    if (parseInt(d) == -100) { $("#UpdatePayPwdError").html("您好，操作失败，请重试"); }
                    else if (parseInt(d) == -99) { window.location.href = "/user/login.aspx?ReturnUrl=" + window.location.href; }
                    else if (d == "1") {
                        $("body").showMessage({
                            message: "修改登录密码成功!", showCancel: false, okbtnEvent: function () {
                                window.location.href = "/Member/my_account.aspx";
                            }
                        });
                    } else {
                        $("#UpdatePayPwdError").html(json.msg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("body").hideLoading();
                    $("#UpdatePayPwdError").html("您好，操作失败，请联系客服");
                    return;
                }
            });
        }

        function Ok() {
            window.location.href = "/Member/my_userdetailinfo.aspx#safe";
        }
</script>
</body>
</html>
