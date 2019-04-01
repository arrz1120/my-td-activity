<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="TuanDai.WXApiWeb.ErrorPage" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>错误页</title> 
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=20160803" />
	<style type="text/css">
		.errorBox {
			position: fixed;
			width: 100%;
			height: 100%;
			top: 0;
			left: 0;
		}
			
		.errorBox img {
			width: 58.4%;
		}
	</style> 
</head>
<body class="bg-f1f3f5">
<%= this.GetNavStr()%>
 <header class="headerMain2">
    <div class="header">
        <div class="back" onclick="javascript:window.location.href='/Index.aspx'">返回</div>
        <h1 class="title">错误页面</h1>  
    </div>
    <div class="none"></div>
</header>
 <div class="webkit-box box-center box-vertical text-center errorBox">
	<img src="/imgs/images/pic/error.png" />
	<p class="f17px mt15">抱歉！您所访问的页面出错了！</p>
</div>
 <script type="text/javascript" src="/scripts/jquery.min.js"></script>
 <script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
</body>
</html>