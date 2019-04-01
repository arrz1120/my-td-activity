<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="downloadGuide.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.downloadGuide" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>下载团贷APP，周转更方便</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	</head>
	<body class="bg-f1f3f5">
	    <%=GetNavStr() %>
		<div class="pl15 pr15 pt20 pb20">
			<img class="w100p" src="/imgs/images/pic/downloadGuide.png"/>
			<a href="javascript:void(0);" class="btn btnYellow mt25 download">下载团贷APP，周转更方便</a>
		</div>
        <script type="text/javascript" src="/scripts/jquery.min.js"></script>
        <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
        <script type="text/javascript">
            var browser = {
                versions: function() {
                    var u = navigator.userAgent, app = navigator.appVersion;
                    return {
                        //移动终端浏览器版本信息
                        ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                        android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或uc浏览器
                        iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
                        iPad: u.indexOf('iPad') > -1, //是否iPad
                    };
                }(),
            };
            $(".download").click(function () {
                if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
                    window.location.href = "http://www.tuandai.com/app/install.aspx";
                }
                else if (browser.versions.android) {
                    window.location.href = "http://image.tuandai.com/tuandaiapp/tuandai.apk";
                } else {
                    window.location.href = "http://hd.tuandai.com/weixin/tuandaiAppNew/IndexApp.aspx?type=weixinapp";
                }
            });

        </script>
	</body>
</html>
