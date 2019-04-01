<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ready.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.ready.ready" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html> 
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>投资前准备</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
		<link rel="stylesheet" type="text/css" href="/css/account2.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	</head>
	<body class="bg-fff">
	    <%=GetNavStr() %>
		<div class="rd-top pos-r">
			<img src="/imgs/account/bg-rd.png?=da" alt="">
			<div class="rd-top-con pos-a text-center">
				<img src="/imgs/account/pic-rd1.png?=dada" alt="">
				<p class="f20px c-ffffff mt18">投资前准备</p>
				<p class="f12px c-ffffff mt3">完善个人信息，享受全面的投资服务</p>
			</div>
		</div>
		<div class="rd-mid webkit-box box-center">
			<div class="rd-mid-con">
				<img src="/imgs/account/ico-rd1.png">
				<div class="rd-info">
					<p class="f15px c-333333">身份信息认证</p>
					<p class="f12px c-999">完成实名认证，保障投资权益</p>
				</div>
			</div>
            <span class="ico-yes" <%=!IsIdentity?"style='opacity: 0;'":"" %>></span>
		</div>

		<div class="rd-mid webkit-box box-center mt40">
			<div class="rd-mid-con">
				<img src="/imgs/account/ico-rd2.png">
				<div class="rd-info">
					<p class="f15px c-333333">绑定银行卡</p>
					<p class="f12px c-999">绑定银行卡后可进行充值提现</p>
				</div>
			</div>
            <span class="ico-yes" <%=!IsBankCard?"style='opacity: 0;'":"" %> ></span>
		</div>

		<div class="pl15 pr15 mt54">
		    <% if (!IsIdentity){
		      %>
            <a href="<%=GlobalUtils.IsOpenCGT? "/Member/cgt/openCgt.aspx?pageType=ready":"/Member/safety/ValidateIdentity.aspx?pageType=ready" %>" class="rd-but">身份验证</a>
            <% }else if (!IsBankCard) {
            %>
            <a href="<%=GlobalUtils.IsOpenCGT? "/Member/cgt/openCgt.aspx?pageType=ready":"/Member/safety/bindBankCardNew.aspx?pageType=ready" %>" class="rd-but">绑定银行卡</a>
            <% } else { %>
            <a href="/pages/invest/WE/WE_list.aspx" class="rd-but">开始投资之旅</a>
            <% } %>
			<p class="f12px c-999 mt7 text-center">团贷网会依法保护你的隐私安全</p>
		</div>
	</body>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
</html>