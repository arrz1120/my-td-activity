<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TuanDai.WXApiWeb.user.Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>会员登录-团贷网</title>
    <script type="text/javascript">
        document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
            WeixinJSBridge.call('hideToolbar');
        });
    </script>    
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/log-alert.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/baikedaohang.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />

</head>
<body>
	<div id="bigDiv">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:window.location.href='<%= TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser?"/WeiXinIndex.aspx":"/Index.aspx" %>'">返回</div>
            <h1 class="title">登录</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <div class="bg-fff wh100">
        <div class="text-center f17px pt15 pb15">登录</div>
        <div class="contentWrap pt20" id="loginConfirm">
            <div class="input-box bb-e6e6e6">
                <i class="block logSprite phone"></i>
                <input type="text" id="txtUserName" placeholder="请输入手机号码/用户名" />
            </div>
            <div class="input-box bb-e6e6e6" id="psd">
                <i class="block logSprite unlock"></i>
                <input id="txtPassword" type="password" placeholder="请输入登录密码" />
                <div class="btnsee webkit-box box-center" id="btnSee">
                    <b class="block logSprite eye-close"></b>
                </div>
            </div>
            <a href="javascript:void(0)" id="btnLoginSubmit" class="btn btnYellow mt50">确定</a>
            <div class="clearfix pt8">
                <a href="register.aspx?ReturnUrl=<%=returnUrl %>" class="lf c-ffcf1f f13px">注册</a>
                <a href="/Member/safety/ResetPwd.aspx" class="rf c-ffcf1f f13px">忘记密码</a>
            </div>
        </div>
    </div> 
    <input id="hd_returnUrl" type="hidden" value="<%=returnUrl %>" />
		
	</div>
    <script type="text/javascript" src="/scripts/jquery.min.js?v=20160422"></script>
    <script type="text/javascript" src="/scripts/jquery.cookies.2.2.0.js"></script>
    <script type="text/javascript" src="/scripts/TdStringHandler.js?v=2015101601"></script>
    <script type="text/javascript" src="/scripts/Common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js"></script>
    <script type="text/javascript" src="/scripts/Login.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20160422"></script> 
    <script type="text/javascript" src="/scripts/seo.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script> 
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript">  
        $(function () {
            $("#btnSee").click(function () {
                var $psd = $("#psd").find('input');
                var eye = $(this).find('b');
                if ($psd.attr('type') == 'password') {
                    eye.removeClass('eye-close').addClass('eye-open');
                    $psd.attr('type', 'text');
                } else {
                    eye.removeClass('eye-open').addClass('eye-close');
                    $psd.attr('type', 'password');
                }
            });
            var defaultTelNo = "<%=this.LoginTelNo%>";
            $("#txtUserName").val(defaultTelNo);
        });
    </script>

</body>
</html> 