﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPwd.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.ResetPwd" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>忘记密码 - 安全中心</title>
<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
<link rel="stylesheet" type="text/css" href="/css/pay.css?v=<%=GlobalUtils.Version %>" />
</head>
<body class="bg-f6f7f8">
<%= this.GetNavStr()%>
<header class="headerMain">
<div class="header bb-e6e6e6">
    <div class="back" onclick="<%=BackURL %>">返回</div>
    <h1 class="title">忘记密码</h1>
    <a href="javascript:void(0);" class="header-list-icon">  <img src="/imgs/images/header-list-icon01.png"></a>
</div>
<%= this.GetNavIcon()%>
<div class="none"></div>
</header>
    <div class="mt15">
        <div class="inpBox34 bt-e6e6e6 bb-e6e6e6">
           <span class="f17px c-212121">手机号码</span>
            <input type="text" id="txtMobilePhone" maxlength="11" placeholder="请输入手机号码">
        </div>
    </div>
    <span class="verification-3 c-fd6040 ml15" style="display:none;" id="txtMobileTip">手机号码不存在!</span>
    <div class="mt15">
        <div class="inpBox34 bt-e6e6e6 bb-e6e6e6">
            <span class="f17px c-212121">验证码</span>
            <input type="text" id="txtMobileCode" maxlength="6" placeholder="请输入验证码">
            <div class="sendCode" id="btnSendMobileCode">发送验证码</div>
            <div class="sendCode" id="codeStr" style="display: none;">发送验证码</div>
        </div>
    </div>
    <span class="verification-3 c-fd6040 ml15" style="display:none;" id="txtMobileCodeTip">请输入短信验证码!</span>
    
    <div class="f13px c-999999 text-right pr15 mt5">收不到验证码 ? 使用<span class="f13px c-fd6040">语音验证码</span></div>
	<div class="pl15 pr15 mt25">
		<a class="btn btnYellow" id="btn_mobile_ok" target="_blank">下一步</a>
	</div>
    <%if (TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser)
      {%>
        <div class="text-center f13px lh20 pl15 c-212121 mt5 clearfix">如有疑问，请联系客服：<a href="tel:1010-1218#mp.weixin.qq.com" class="c-ff6600 f13px">1010-1218</a></div>
        <%}
    %>
    <%else 
        {%>
        <div class="text-center f13px lh20 pl15 c-999999 mt5 clearfix">如有疑问，请联系客服：<a href="tel:1010-1218" class="c-ff6600 f13px">1010-1218</a></div>
         <%}
    %>
</body>
    <script type="text/javascript">
        var backurl = "<%= backurl%>";
    </script>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/resetpwd.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions_code.js"></script>
</html>