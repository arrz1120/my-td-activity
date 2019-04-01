<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TuanDai.WXApiWeb.user.user2.Login" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="format-detection" content="telephone=no">
		<title>登陆注册</title>
		<meta name="keywords" content="团贷网,互联网金融,P2P网贷,P2P理财">
		<meta name="description" content="">
		<!--动态计算rem-->
		<script>
		    (function (doc, win) {
		        var dpr, rem, scale = 1;
		        var docEl = document.documentElement;
		        var metaEl = document.querySelector('meta[name="viewport"]');
		        var resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize';
		        metaEl.setAttribute('content', 'width=device-width,initial-scale=' + scale + ',maximum-scale=' + scale + ', minimum-scale=' + scale + ',user-scalable=no,shrink-to-fit=no');
		        docEl.setAttribute('data-dpr', dpr);
		        var recalc = function () {
		            clientWidth = docEl.clientWidth;
		            if (!clientWidth) return;
		            docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
		            if (document.body) {
		                document.body.style.fontSize = docEl.style.fontSize;
		            }
		        };
		        recalc();
		        if (!doc.addEventListener) return;
		        win.addEventListener(resizeEvt, recalc, false);
		        doc.addEventListener('DOMContentLoaded', recalc, false);
		    })(document, window);
		</script>
        <link rel="stylesheet" href="css/reg.css?v=20160830" />
	  </head>
	<body>
    	<img src="images/logo.png" class="logo logo_login">
        <a href="/user/user2/reg.aspx" class="reg_btn btn_1" id="reg_btn">马上注册</a>
        <a href="/user/user2/reg_1.aspx" class="login_btn btn_1" id="login_btn">登录</a>
	</body>
    <script src="js/zepto.min.js"></script>
 
<script type="text/javascript">

    $('#reg_btn').on('touchstart', function () {
        $(this).addClass('reg_btn_click');
    });

    $('#reg_btn').on('touchend', function () {
        $(this).removeClass('reg_btn_click');
    });

    $('#login_btn').on('touchstart', function () {
        $(this).addClass('login_btn_click');
    });

    $('#login_btn').on('touchend', function () {
        $(this).removeClass('login_btn_click');
    });

</script>
</html>
