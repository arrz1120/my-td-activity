<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPayPwd.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.ResetPayPwd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>忘记交易密码 - 安全中心</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/safety.css?v=20151221001" /><!--安全中心-->
<link rel="stylesheet" type="text/css" href="/css/loan.css" /><!--借款--> 
</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
<div class="header">
    <div class="back" onclick="<%=BackURL %>">返回</div>
    <h1 class="title">忘记交易密码</h1>
</div>
<%= this.GetNavIcon()%>
<div class="none"></div>
</header>
    <section class="bg-bdtopBom1-d1d1d1 pd10 mt20 clearfix" style="display: none;">
        <div class="phoneCode bindingPhone pr0">
            <div class="c-left">手机号</div>
            <input type="text" id="txtMobilePhone" maxlength="11" class="codeIpt" placeholder="请输入手机号码" value="<%= TelNo %>" readonly="readonly">
        </div>
    </section>
    <span class="verification-3" style="color: Red; margin-left:50px; display:none;" id="txtMobileTip">手机号码不存在!</span>
    <div class="pt15 pb5 f13px pl15 c-ababab">
		您预留的手机号码为：<span class="c-fd6040 f13px"><%=BusinessDll.StringHandler.MaskTelNo(TelNo)  %></span>
	</div>
	<div class="bg-bdtopBom1-ccc pt10 pb10 pl15 pos-r">
		<span class="f14px c-212121 pos-a txt_left pl15">验证码</span>
		<div class="inp">
			<input id="txtMobileCode" class="f14px c-666" type="text" placeholder="请输入验证码" />
		</div>
		<div id="btnSendMobileCode" class="btn_right c-fac502 pos-a pr10 pl10 f12px">免费获取</div>
	</div>
    <span class="verification-3" style="color: Red; margin-left:50px; display:none;" id="txtMobileCodeTip">请输入短信验证码!</span>
	<div class="pt15 pb5 f13px pl15 c-ababab">
		请不要设置和登录密码相同的交易密码
	</div>
	<div class="bg-bdtopBom1-ccc pl15">
		<div class="pos-r bb-e6e6e6 pt10 pb10">
			<span class="f14px c-212121 pos-a txt_left">交易密码</span>
			<div class="inp">
				<input id="txtPayPwd" class="f14px c-666" type="password" placeholder="含字母和数字的6-16个字符" />
			</div>
		</div>
        <span class="verification-3" style="color: Red; margin-left:50px; display:none;" id="txtPayPwdTip">请输入交易密码!</span>
		<div class="pos-r pt10 pb10">
			<span class="f14px c-212121 pos-a txt_left">确定密码</span>
			<div class="inp">
				<input id="txtPayPwd1" class="f14px c-666" type="password" placeholder="请再输入一次您的新交易密码" />
			</div>
		</div>
        <span class="verification-3" style="color: Red; margin-left:50px; display:none;" id="txtPayPwd1Tip">第一次与这次输入不一致!</span>
	</div>
    <section class="pd15 mt5">
      <a href="javascript:void(0)" id="btn_mobile_ok" target="_blank" class="btn btnYellow">提交更新</a>
    </section>
    <%if (TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser)
      {%>
        <div class="text-center f13px lh20 pl15 c-212121 mt5 clearfix">如有疑问，请联系客服：<a href="tel:1010-1218#mp.weixin.qq.com" class="c-ff6600 f14px">1010-1218</a></div>
        <%}
    %>
    <%else 
        {%>
        <div class="text-center f13px lh20 pl15 c-212121 mt5 clearfix">如有疑问，请联系客服：<a href="tel:1010-1218" class="c-ff6600 f14px">1010-1218</a></div>
         <%}
    %>
</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/resetPayPwd.js?v=20151219"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
<script type="text/javascript" src="/scripts/jquery.extensions_code.js"></script>
</html>
