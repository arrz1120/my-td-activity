<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="auto_rule.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.setAuto.auto_rule" %>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>自动投标规则</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
		<%--<link rel="stylesheet" type="text/css" href="/css/auto-invest.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />--%>
        <style type="text/css">
			/*自动投标规则*/
			.auto-invest-rule{padding: 16px 16px 60px;}
			.auto-invest-rule p{ font-size: 15px; color: #212121;text-align: justify; line-height: 25px; padding-bottom: 6px;}
			.auto-invest-rule .ti25{text-indent:25px; }
		</style>
	</head>
	<body class="bg-f6f7f8">
	    <%=GetNavStr() %>
	<div class="auto-invest-rule">
		<p>1、新标上线即会启动自动投标功能。</p>
		<p>2、单笔投标金额若超过所投标借款总额的50%，则以总标额的50%为上限向下取该标最小出借单位的整数倍进行投标。</p>
		<p>3、自动投标功能设置中若没有设置预留金额，系统将默认用户账户内全部可用余额用于自动投标。</p>
		<p>4、投标排序规则如下：</p>
		<p class="ti25"> a ) 投标顺序按照开启自动投标的时间先后进行排序；</p>
		<p class="ti25"> b ) 每个用户投标后，重新回到队尾，依次循环进行投标；</p>
		<p class="ti25"> c ) 轮到用户进行投标时，若没有标符合用户设置的自动投标条件，视为自动放弃此次投标机会，重新排队；</p>
		<p class="ti25"> d ) 轮到用户投标时，若同时有多个标符合自动投标设置，则按照优先级根据用户第一条设置进行投标；</p>
		<p class="ti25"> e ) 新增、修改、暂停、启用自动投标方案后会重新排队。</p>
	</div>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
	</body>
</html>