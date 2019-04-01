<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="account_bindsuc.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.account_bindsuc" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>绑定成功</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
		<link rel="stylesheet" type="text/css" href="/css/pay.css?v=<%=GlobalUtils.Version %>" />
        <!--账户中心-->
        <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	</head>

	<body class="bg-fff">
	    <%= this.GetNavStr()%>
        <div style="display: none;"><%= this.GetNavIcon()%></div>
		<div class="text-center">
			<div class="big-ico-box02 mt50">
				<img src="/imgs/images/icon/ico_suc.png" />
			</div>
			<p class="mt25 f17px c-212121">
				<span class="f17px c-fab600"><%=string.IsNullOrEmpty(weiXinNickName)?"当前微信号":weiXinNickName %></span>与<%=tel %><br />
				团贷账户绑定成功
			</p>
		</div>

		<div class="pl15 pr15 mt45">
			<a class="btn btnYellow" id="confirm">确定</a>
		</div>
	</body>
	<script type="text/javascript" src="/scripts/jquery.min.js?v=<%=GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/Common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        $("#confirm").click(function() {
            window.location.href = "account_manager.aspx";
        });
    </script>
</html>