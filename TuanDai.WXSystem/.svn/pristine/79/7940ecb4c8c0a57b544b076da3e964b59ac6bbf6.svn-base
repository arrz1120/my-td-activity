<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="download.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.download" %>
 <!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>下载团贷网app</title>
    <script type="text/javascript">
        var browser = {
            versions: function () {
                var u = navigator.userAgent, app = navigator.appVersion;
                return { //移动终端浏览器版本信息
                    ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                    android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或uc浏览器
                    iPhone: u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
                    iPad: u.indexOf('iPad') > -1 //是否iPad
                };
            }()
        }
        if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
            window.location.href = "http://a.app.qq.com/o/simple.jsp?pkgname=com.junte&g_f=991653";
        }
        if (browser.versions.android) {
            window.location.href = "http://a.app.qq.com/o/simple.jsp?pkgname=com.junte&g_f=991653";
        }
    </script>
</head>
<body>
</body>
</html>
