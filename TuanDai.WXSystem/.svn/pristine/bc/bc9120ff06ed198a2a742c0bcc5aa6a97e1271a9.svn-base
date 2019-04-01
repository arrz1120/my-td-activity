<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register_TradePassWord.aspx.cs" Inherits="TuanDai.WXApiWeb.user.Register_TradePassWord" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>设置交易密码</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--base-->
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js"></script>
</head>
<body>
    <header class="headerMain2">
        <div class="header">
            <h1 class="title">设置交易密码</h1>
            <div class="text"><a href="javascript:;" onclick="location.replace('<%=this.returnUrl == ""?"/index.aspx":this.returnUrl %>')">跳过</a></div>
        </div>
        <div class="none"></div>
    </header>
    <section class="flow-wrap">
        <div class="flow-pic pos-r">
            <p class="flow1 pos-a text-center f13px c-ababab">
                <span class="on pos-r">
                    <i class="sign pos-a"><img src="/imgs/images/ico-y.png"/></i>
                </span>
                身份证认证
            </p>
            <p class="flow2 pos-a text-center f13px c-ababab">
                <span class="on pos-r"></span>
                设置交易密码
            </p>
            <p class="flow3 pos-a text-center f13px c-ababab">
                <span></span>
                绑定银行卡
            </p>
        </div>
    </section>

    <section class="bg-bdtopBom1-d1d1d1 mt20 clearfix">
        <div class="pt10 pb10 bb-e6e6e6 pl15">
            <div class="phoneCode pr0 pl1">
                <div class="c-left w1">交易密码</div>
                <input type="password" name="txtNewPassword" id="txtNewPassword" maxlength="16" class="codeIpt" placeholder="由6-16个字符+数字组成" onpaste="return false" oncontextmenu="return false" oncopy="return false" oncut="return false" onkeyup="this.value=this.value.replace(/^ +| +$/g,'')">
            </div>
            <span class="verification-3" style="color: Red; " id="txtNewPasswordError"></span>
        </div>
        
        <div class="pt10 pb10 pl15">
            <div class="phoneCode pr0 pl1">
                <div class="c-left w1">确认密码</div>
                <input type="password" id="txtNewPassword1" class="codeIpt" placeholder="再次输入新交易密码">
            </div>
            <span class="verification-3" style="color: Red;" id="txtNewPassword1Eeeor"></span>
        </div>
    </section>
    
    <section class="text-center mt15">
        <span class="verification-3" style="color: Red;" id="UpdatePayPwdError"></span>
        <p class="f14px c-ababab">本交易密码用于投资、提现等，请妥善保管。
        </p>
    </section>

    <section class="pd15 mt15">
        <a href="javascript:UpdatePayPwd();" class="btn btnYellow">下一步</a>
    </section>

    <section class="pd15 mt60 text-center">
        <%if (TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser)
      {%>
        <p class="c-ababab f14px">如有疑问，请联系客服：<a href="tel:1010-1218#mp.weixin.qq.com" class="inline-block c-f86420 txt-uline f14px">1010-1218</a></p>
        <%}
        %>
        <%else 
        {%>
            <p class="c-ababab f14px">如有疑问，请联系客服：<a href="tel:1010-1218" class="inline-block c-f86420 txt-uline f14px">1010-1218</a></p>
        <%}
        %>
    </section>
    <script type="text/javascript">
        function UpdatePayPwd() {
            $("#UpdatePayPwdError").html("");
            $("#oldpasswordError").html("");
            $("#txtNewPasswordError").html("");
            $("#txtNewPassword1Eeeor").html("");
            var oldpwd = "";
            var newspwd1 = $("#txtNewPassword").val();
            var newspwd2 = $("#txtNewPassword1").val();
            var newpassword = $("#txtNewPassword").val().replace(/[ ]/g, "");
            var pat = new RegExp("^.{6,16}$", "i");
            if (newspwd1 == '') {
                $("#txtNewPasswordError").html("新交易密码必须填写");
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
                $("#txtNewPassword1Eeeor").html("确认新交易密码必须填写");
                return;
            }
            if (newspwd2 != newspwd1) {
                $("#txtNewPassword1Eeeor").html("两次交易密码不一致");
                return;
            }
            $.ajax({
                type: "POST",
                url: "/ajaxCross/ajax_s1a2fe.ashx",
                dataType: "json",
                data: { Cmd: "Register_UpdatePayPwd", oldpwd: oldpwd, newpwd: newspwd1 },
                success: function (json) {
                    var d = json.result;
                    if (parseInt(d) == -100) { $("#UpdatePayPwdError").html("您好，操作失败，请重试"); }
                    else if (parseInt(d) == -99) { window.location.href = "/user/login.aspx?ReturnUrl=" + window.location.href; }
                    else if (d == "1") {
                        window.location.replace("Register_BindBankCard.aspx?ReturnUrl=<%=returnUrl %>");
                    } else {
                        $("#UpdatePayPwdError").html(json.msg);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("#UpdatePayPwdError").html("您好，操作失败，请联系客服");
                    return;
                }
            });
        }
</script>
</body>
</html>
