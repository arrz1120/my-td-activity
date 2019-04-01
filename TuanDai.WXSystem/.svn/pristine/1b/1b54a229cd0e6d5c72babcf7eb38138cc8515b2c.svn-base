<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_wealth.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.my_wealth" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>我的财富</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/account.css?v=20160315002" />
</head>
<body class="bg-f1f3f5">
<%= this.GetNavStr()%>
<header class="headerMain">
	<div class="header">
		<a class="back" href="my_account.aspx">返回</a>
		<h1 class="title">我的财富</h1>
	</div>
    <%= this.GetNavIcon()%>
	<div class="none"></div>
</header>
<section class="my-treasure">
	<div class="bg-ffc11f text-center">
		<p class="c-ffffff f17px pt40">资产总额（元）</p>
		<p class="c-ffffff f45px mt30"><%=ToolStatus.ConvertLowerMoney(totalamount)  %></p>
		<img src="/imgs/images/pic-c1.png" class="mt15"/>
	</div>
	<div class="webkit-box j-link bg-fff">
		<a href="/Member/Bank/Recharge.aspx" class="box-flex1"><img src="/imgs/images/ico_arrow_r_t_1.png" />充值</a>
		<a href="/Member/withdrawal/drawmoney.aspx" class="box-flex1 bg-ffcf1f"><img src="/imgs/images/ico_arrow_r_d_1.png" />提现</a>
	</div>
	<div class="des bg-fff mt10 bb-e6e6e6">
		<p class="ml15 bb-e6e6e6">
			<span class="lf">可用资金（元）</span>
			<span class="rf">￥<%= ToolStatus.ConvertLowerMoney(accountInfo.AviMoney) %></span>
		</p>
		<p class="ml15 bb-e6e6e6">
			<span class="lf">待收本金（元）</span>
			<span class="rf">￥<%= ToolStatus.ConvertLowerMoney(accountInfo.DueInPAndI - accountInfo.DueComeInterest) %></span>
		</p>
		<p class="ml15 bb-e6e6e6">
			<span class="lf">待收利息（元）</span>
			<span class="rf">￥<%= ToolStatus.ConvertLowerMoney(accountInfo.DueComeInterest) %></span>
		</p>
		<p class="ml15 bb-e6e6e6">
			<span class="lf">待确认投标（元）</span>
			<span class="rf">￥<%= ToolStatus.ConvertLowerMoney(accountInfo.BorrowerOut) %></span>
		</p>
		<p class="ml15 bb-e6e6e6">
			<span class="lf">待确认提现（元）</span>
			<span class="rf">￥<%= ToolStatus.ConvertLowerMoney(accountInfo.DueConfirmWithdrawDeposit + accountInfo.WithdrawDepositProgress) %></span></p>
		<p class="ml15 bb-e6e6e6">
			<span class="lf">We计划待投金额（元）</span>
			<span class="rf">￥<%= ToolStatus.ConvertLowerMoney(weWaitInvestment??0) %></span>
		</p>
		<p class="ml15 pr15">
			<span class="lf">冻结资金（元）</span>
			<span class="rf">￥<%= ToolStatus.ConvertLowerMoney(accountInfo.FreezeAcount) %></span>
		</p>
	</div>
</section>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=1"></script>
</body>

</html>
