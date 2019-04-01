<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="appdown.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.appdownload" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>团贷网触屏版</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<style type="text/css">
	html{ height: 100%;}
	body{ position: relative;}
    .banner{width: 100%; height: 92.5%; background: url('/imgs/images/bannerAPPdownload.png');background-position: 50% 50%;-moz-background-size:cover;-webkit-background-size:cover;-o-background-size:cover;background-size:cover;}
    .btnBox{ width: 100%; padding: 0 45px; height: 42px; position: absolute; bottom: 2%; left: 0; z-index: 100;}
    @media screen and (max-height:480px) {
    	.btnBox{ bottom: 5%;}
	}
</style>
</head>
<body>
    <%= this.GetNavStr()%>
   <header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">下载应用</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
  </header>
    <div class="banner">
    	<div class="btnBox"><a href="/pages/download.aspx" target="_blank" class="btn btnYellow">立即下载</a></div>
    </div>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
</body>
</html>