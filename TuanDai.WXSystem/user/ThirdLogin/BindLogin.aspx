<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BindLogin.aspx.cs" Inherits="TuanDai.WXApiWeb.user.ThirdLogin.BindLogin" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>绑定账号</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /> 
    <link rel="stylesheet" type="text/css" href="/css/safety.css" /> 
     <style type="text/css">
    .t1{ font-size: 0.9rem;color: #e84419; display: none; margin-left:20px; }
    .t1 img{ width: 12px; height: 12px; margin-top: -4px;display: inline-block;margin-right: 5px;}
    .t2{ font-size: 0.9rem;color: #e84419; display: none; margin-left:20px;}
    .t2 img{ width: 12px; height: 12px; margin-top: -4px;display: inline-block;margin-right: 5px;}
    .disabled{ color: #797979; background: #d0d0d0; border-color: #d0d0d0;}
    </style>
</head>
<body>
    <header class="headerMain">
<div class="header">
    <div class="back" onclick="javascript:window.location.href='/user/Login.aspx?ReturnUrl=<%=returnUrl %>'">返回</div>
    <h1 class="title">绑定账号</h1>
</div>
<div class="none"></div>
</header>
    <section class="bg-bdtopBom1-ccc pl15 mt20 clearfix">
		<div class="pt10 pb10 bg-bdBom1-ccc">
          <div class="phoneCode pr0 pl40">
              <div class="loginc-left"><i class="loginname"></i></div>
              <input type="text" name="txtUserName" id="txtUserName" class="codeIpt" placeholder="用户名 / 手机号">
          </div>
        </div>
        <div class="pt10 pb10">
          <div class="phoneCode pr0 pl40">
            <div class="loginc-left"><i class="loginpsd"></i></div>
            <input type="password" name="txtPassword" id="txtPassword" class="codeIpt" placeholder="登录密码">
            <input type="button" id="togglePassword" class="btneyehui" value="" />
          </div>
        </div>
	</section>
    <p class="t1" id="pT1">
        <img src="/imgs/t1.gif" alt="" id="imgT1" />用户名不能为空</p>
    <p class="t2" id="pT2">
        <img src="/imgs/t2.gif" alt="" id="imgT2" /><span id="spanUserName" style="color: Red;">用户名有误，请输入正确用户名</span></p>
    <p class="t1" id="pT3">
        <img src="/imgs/t1.gif" alt="" id="imgT3" />密码不能为空</p>
    <p class="t2" id="pT4">
        <img src="/imgs/t2.gif" alt="" id="imgT4" /><span id="spanPassword" style="color: Red;">密码有误，请输入正确密码</span></p>
    <div id="divTiShi" style="color: Red; display: none; font-size: 12px; margin-left: 20px;">
    </div> 
    <section class="pd15 mt10 pb5">
      <a href="javascript:void(0)" id="btnLoginSubmit" class="btn btnYellow">绑定已有账号</a>
    </section>
    <section class="plr15 clearfix"> 
      <a href="/Member/safety/ResetPwd.aspx" class="c-ff7357 f14px rf">忘记密码</a>
    </section> 
    <input id="hd_returnUrl" type="hidden" value="<%=returnUrl %>" />
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/icheck.min.js"></script> 
    <script type="text/javascript" src="/scripts/base.js"></script> 
    <script type="text/javascript" src="/scripts/jquery.cookies.2.2.0.js"></script>
    <script type="text/javascript" src="/scripts/TdStringHandler.js"></script>
    <script type="text/javascript" src="/scripts/Common.js?v=2015101301"></script>
    <script type="text/javascript" src="/scripts/bindlogin.js?v=2015101301"></script> 
    <script type="text/javascript">
        var LoginType = "<%=LoginType %>";
        (function ($) {
            $.fn.togglePassword = function (options) {
                var s = $.extend($.fn.togglePassword.defaults, options),
                input = $(this);

                $(s.el).bind(s.ev, function () {
                    "password" == $(input).attr("type") ?
                $(input).attr("type", "text") :
                $(input).attr("type", "password");
                    "btneyehuang" == $(s.el).attr("class") ?
                $(s.el).attr("class", "btneyehui") :
                $(s.el).attr("class", "btneyehuang");
                });
            };
            $.fn.togglePassword.defaults = {
                ev: "click"
            };
        } (jQuery));
        $(function () {
            $('#txtPassword').togglePassword({
                el: '#togglePassword'
            });
        });

    </script>
</body>
</html>
