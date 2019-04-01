﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FinanceDrawSuccess.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.FinanceDrawSuccess" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>兑换成功</title>
    <link rel="stylesheet" type="text/css" href="css/main.css?v=20150608" />
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
        function runDownLoad(){
            if (browser.versions.iPhone || browser.versions.iPad || browser.versions.ios) {
                window.location.href = "http://a.app.qq.com/o/simple.jsp?pkgname=com.junte&g_f=991653";
            }
            if (browser.versions.android) {
                window.location.href = "http://a.app.qq.com/o/simple.jsp?pkgname=com.junte&g_f=991653";
            }
        }
    </script>
</head>
<body>
<section class="wrapper">
    <div class="main pos-r">
        <img src="imgs/logo.png" alt="" class="logo"/>
        <img src="imgs/p2.png" alt="" class="p2"/>
        <p class="seuc-text">下载团贷APP或登陆团贷官网个人<br/>
            中心团宝箱即可领取投资红包！</p>
        <div class="link-box">
            <a href="javascript:runDownLoad();" class="dl-app">下载团贷APP</a>
            <a href="http://m.tuandai.com" class="in-td">进入团贷官网</a>
        </div>
    </div>
</section>

</body>
</html>