<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="invest_fail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.invest_fail" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>投资失败</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/pay.css" />
</head>
<body class="bg-f1f3f5">
<header class="headerMain">
	<div class="header bb-c2c2c2">
		<h1 class="title">投资失败</h1>
		<a href="<%=FinishUrl %>" class="j-finish">完成</a>
	</div>
	<div class="none"></div>
</header>
<div class="invest-r-con">
	<div class="con-top bg-fff bb-e6e6e6">
		<img src="/imgs/images/invest-f.png"/>
		<p class="text-center c-212121 f17px">
				<%= errorMsg %>
		</p>
	</div>
	<div class="con-bottom bb-e6e6e6 bt-e6e6e6 bg-fff">
		<div>
			<p class="lf">
				<img src="/imgs/images/ico-i2.png"/>
				<span class="f15px">投资金额</span>
			</p>
			<p class="rf f15px">￥<%=ToolStatus.ConvertLowerMoney(PayMoney) %></p>
		</div>
		<p></p>
	</div>

	<div class="j-con text-center mt30">
		<a href="<%=GoOnUrl %>" class="btnYellow	btn c-ffffff f18px"><img src="/imgs/images/ico-arrow-right.png" class="mr10"/>继续投资</a>
		<a href="/Member/myaccount_p2pmore.aspx" class="mt15 f13px text-underline">查看账户余额</a>
	</div>

</div>



</body>
</html>
