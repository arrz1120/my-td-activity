﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="concernWeChat.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.concernWeChat" %>

<%@ Import Namespace="Tool" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="renderer" content="webkit">
	<meta name="force-rendering" content="webkit">
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<meta content="email=no" name="format-detection" />
	<meta name="format-detection" content="telephone=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<script>
		window.mobileUtils = function (e, t) {
		var i = navigator.userAgent,
			n = /android|adr/gi.test(i),
			a = /iphone|ipod|ipad/gi.test(i) && !n;
		return {
			isAndroid: n,
			isIos: a,
			isMobile: n || a,
			isWeixin: /MicroMessenger/gi.test(i),
			isQQ: /QQ\/\d/gi.test(i),
			dpr: a ? Math.min(e.devicePixelRatio, 3) : 1,
			rem: null,
			fixScreen: function () {
			var i = this,
				n = t.querySelector('meta[name="viewport"]'),
				r = n ? n.content : "";
			if (r.match(/initial\-scale=([\d\.]+)/), r.match(/width=([^,\s]+)/), !n) {
				var o, s = t.documentElement,
				d = s.dataset.mw || 750,
				m = a ? Math.min(e.devicePixelRatio, 3) : 1;
				t.getElementsByTagName("body")[0], s.removeAttribute("data-mw"), s.dataset.dpr = m, n = t.createElement(
				"meta"), n.name = "viewport", n.content = function (e) {
				return "initial-scale=" + e + ",maximum-scale=" + e + ",minimum-scale=" + e
				}(1), s.firstElementChild.appendChild(n);
				var c = function () {
				var e = s.getBoundingClientRect().width;
				e = e > d ? d : e;
				var t = e / 16;
				i.rem = t, s.style.fontSize = t + "px"
				};
				e.addEventListener("resize", function () {
				clearTimeout(o), o = setTimeout(c, 300)
				}, !1), e.addEventListener("pageshow", function (e) {
				e.persisted && (clearTimeout(o), o = setTimeout(c, 300))
				}, !1), c()
			}
			}
		}
		}(window, document), mobileUtils.fixScreen();
	</script>
	<title>关注微信</title> 
	<link rel="stylesheet" type="text/css" href="/css/concernWeChat.css?v=20181016" />
</head>
<body>
	<div class="page">
    <div class="banner"></div>
    <div class="sec sec1">
      <h2 class="sec-tit">团贷网官方公众号</h2>
      <div class="content">
          <div class="icon-box">
            <div class="icon icon1"></div>
            <div class="icon-txt">
              <p class="p1">团贷网微服务</p>
              <p class="p2">1.首次绑定账户获30团币</p>
              <p class="p2">2.账户资金变动实时通知</p>
            </div>
          </div>
          <div class="icon-box">
            <div class="icon icon2"></div>
            <div class="icon-txt">
              <p class="p1">团贷网订阅号</p>
              <p class="p2">1.最新活动福利多多</p>
              <p class="p2">2.新闻动态每日推送</p>
            </div>
          </div>
      </div>
    </div>
    <div class="sec sec2">
        <h2 class="sec-tit">团贷网官方公众号</h2>
        <div class="step1">
          <p class="tit">第一步：关注“<span>团贷网微服务</span>”</p>
          <p class="txt">长按复制“团贷网微服务”，前往微信搜索栏粘贴，搜索并关注公众号。</p>
        </div>
        <img src="/imgs/App/concernWeChat/img1.png?v=20181018001" alt="" class="img">
        <div class="step2">
          <p class="tit">第二步：绑定团贷网账户</p>
          <p class="txt">点击【了解团贷】-【绑定账号】菜单（需登录团贷账号），进入【我的账户】点击“确认绑定”按钮，即完成账户绑定。</p>
        </div>
        <img src="/imgs/App/concernWeChat/img2.png?v=20181018001" alt="" class="img">
    </div>
  </div>
    <% if (DateTime.Now >= DateTime.Parse(ConfigHelper.getConfigString("RedPacketStartTime", "2018-11-01")) && DateTime.Now <= DateTime.Parse(ConfigHelper.getConfigString("RedPacketEndTime", "2018-11-30")))
       {
           %>
    <a class="icon-link" href="https://at.tuandai.com/huodong/tdUserBindWeixin/index.html"></a>
    <%
       } %>
	

	<script type="text/javascript" src="/scripts/jquery.min.js"></script> 
	<script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>
	<script type="text/javascript" src="/scripts/weixinapi.js?v=4.0"></script>
	<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
	<script type="text/javascript">
	wxData.isWxJsSDK = true;
	wxData.debug = false;
	wxData.img_url = "http://m.tuandai.com/imgs/sharelogo.png?v=20160407";
	wxData.title = "团贷网微信端";
	wxData.desc = "关注团贷网公众号，迈出轻松投资第一步";
	wxData.url = "<%=GlobalUtils.WebURL%>/pages/concernWeChat.aspx";
	wxData.ShareCallBack = function (res) {}; 
	</script>
</body>
</html>