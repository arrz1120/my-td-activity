<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="page_url.aspx.cs" Inherits="TuanDai.WXApiWeb.PaymentPlatform.Baofu.page_url" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>充值成功</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->
</head>
<body>
<header class="headerMain">
	    <div class="header">
	        <div class="back" onclick="javascript:history.go(-1);">返回</div>
	        <h1 class="title">充值成功</h1>
	    </div>
	    <div class="none"></div>
	</header>
   <section class="pl15 pr15 clearfix">
       <i class="ico-pig mt40"></i>
       <div class="f18px c-212121 text-center mt30 clearfix">充值成功</div>
       <div class="mt30 clearfix"><a href="/Member/my_account.aspx" class="btn btnYellow">确定</a></div>
   </section>
</body>
</html>
