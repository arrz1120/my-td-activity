<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="set_suc.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.setAuto.set_suc" %>


<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>自动投标规则</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=20160428" />
		<link rel="stylesheet" type="text/css" href="/css/auto-invest.css?v=20160428" />
	</head>
	<body class="bg-fff">
	    <%=GetNavStr() %>
		<div class="webkit-box box-center box-vertical suc_con pb80">
			<img src="/imgs/images/icon/ico_suc.png"/>
			<p>设置成功</p>
			<div class="pl15 pr15 w100p mt45">
				<a href="auto_invest.aspx" class="btn btnYellow">完成</a>
			</div>
		</div>
        <script type="text/javascript" src="/scripts/jquery.min.js"></script>
        <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
	</body>
</html>