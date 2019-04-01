<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="seccessful.aspx.cs" Inherits="TuanDai.WXApiWeb.user.user.seccessful" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="format-detection" content="telephone=no">
		<title>注册成功</title>
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
        <link rel="stylesheet" href="css/reg.css?v=20161108001" />
	  </head>
	<body>
    <img src="images/dui_icon.png" class="dui_icon">
    <p class="congratulation">恭喜您，注册成功！</p>
    	<div class="j-close-box">
		<p><span id="time">10</span><span>s</span>后将自动关闭</p>
		<a href="http://m.tuandai.com" id="j_close">马上关闭</a>
	</div>
	<script src="/scripts/jquery.min.js"></script>
	<script>
		$(function(){
			var rUrl="https://m.tuandai.com";
			$("#j_close").on("click", function() {
				GoRedirect(rUrl);
			});
			var num = 10;
			var time = setInterval(function(){
				$("#time").text(--num);
				if(num <= 0){
					var rUrl="https://m.tuandai.com";
					GoRedirect(rUrl);
				}
			}, 1000);
		});
		function GoRedirect(url) {
			if (url == "") {
				window.location.href = window.location.href;
				return;
			}
			window.location.href = url;
		}
	</script>
	</body>
</html>