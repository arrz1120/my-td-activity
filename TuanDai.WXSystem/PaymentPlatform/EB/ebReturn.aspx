<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ebReturn.aspx.cs" Inherits="TuanDai.WXApiWeb.PaymentPlatform.EB.ebReturn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>充值处理</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/account.css?v=20151216001" /><!--账户中心-->
</head>
<body>
 <%= this.GetNavStr()%>
<header class="headerMain">
	    <div class="header">
	        <div class="back" onclick="javascript:window.location.href='<%=GoReturnUrl %>';">返回</div>
	        <h1 class="title">充值处理</h1>
	    </div>
	    <div class="none"></div>
        <%= this.GetNavIcon()%>
	</header>
   <section class="pl15 pr15 clearfix">
       <i class="ico-pig mt40"></i>
       <div class="f14px c-808080 text-center mt30 clearfix">正在为您处理充值申请，<br/>请留意个人账户中充值记录的状态</div>
       <div class="mt30 clearfix"><a href="<%=GoReturnUrl %>" class="btn btnYellow">确定</a></div>
   </section>
   <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
</body>
</html>