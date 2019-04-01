<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="zx_manager.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.zx_manager" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="format-detection" content="telephone=no">
		<title>周转管理</title>
        <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
        <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=GlobalUtils.Version %>" />
        <link rel="stylesheet" href="/wap/css/zhixiang/my.css?v=<%=GlobalUtils.Version %>">
		<script>window.mobileUtils = function (e, t) { var i = navigator.userAgent, n = /android|adr/gi.test(i), a = /iphone|ipod|ipad/gi.test(i) && !n; return { isAndroid: n, isIos: a, isMobile: n || a, isWeixin: /MicroMessenger/gi.test(i), isQQ: /QQ\/\d/gi.test(i), dpr: a ? Math.min(e.devicePixelRatio, 3) : 1, rem: null, fixScreen: function () { var i = this, n = t.querySelector('meta[name="viewport"]'), r = n ? n.content : ""; if (r.match(/initial\-scale=([\d\.]+)/), r.match(/width=([^,\s]+)/), !n) { var o, s = t.documentElement, d = s.dataset.mw || 750, m = a ? Math.min(e.devicePixelRatio, 3) : 1; t.getElementsByTagName("body")[0], s.removeAttribute("data-mw"), s.dataset.dpr = m, n = t.createElement("meta"), n.name = "viewport", n.content = function (e) { return "initial-scale=" + e + ",maximum-scale=" + e + ",minimum-scale=" + e }(1), s.firstElementChild.appendChild(n); var c = function () { var e = s.getBoundingClientRect().width; e = e > d ? d : e; var t = e / 16; i.rem = t, s.style.fontSize = t + "px" }; e.addEventListener("resize", function () { clearTimeout(o), o = setTimeout(c, 300) }, !1), e.addEventListener("pageshow", function (e) { e.persisted && (clearTimeout(o), o = setTimeout(c, 300)) }, !1), c() } } } }(window, document), mobileUtils.fixScreen();</script>
	</head>
	<body>
	   <%= this.GetNavStr()%>
        <div style="display: none;"><%= this.GetNavIcon()%></div>
		<div class="my">
		    <% if (GlobalUtils.IsShowZxToBorrower(WebUserAuth.UserId.Value) || new GlobalUtils().GetNewVipUserInfo(WebUserAuth.UserId.Value).Level >= 3)
               {
                   %>
			<div class="top">
				<div class="top-tab top-tab-cur">我的智享</div>
				<div class="top-tab">我的周转</div>
				<div class="top-line"></div>
			</div>
			 
			<div class="my-con">
				<div class="my-link">
					<a href="/Member/Repayment/myzx_borrow_list.aspx">发起记录<span style="line-height: 4.3em;">待结清 ：<%=ToolStatus.ConvertLowerMoney(ZxDueOutAmount) %></span><i></i></a>
					<a href="/Member/Repayment/zx_repay_plan.aspx" class="link-bt">结清计划<i></i></a>
				</div>
			</div>
			<%
               } %>
			<div class="my-con" <%=(GlobalUtils.IsShowZxToBorrower(WebUserAuth.UserId.Value) || new GlobalUtils().GetNewVipUserInfo(WebUserAuth.UserId.Value).Level >= 3)?"style=\"display: none;\"":"" %> >
				<div class="my-link">
					<a href="/Member/Repayment/borrowLog.aspx">周转记录<span style="line-height: 52.3px;">待结清 ：<%=ToolStatus.ConvertLowerMoney(fundModel.DueOutPAndI) %></span><i></i></a>
					<a href="/Member/Repayment/zc_repay_plan.aspx" class="link-bt">结清计划<i></i></a>
				</div>
			</div>
			
		</div>
	</body>
	<script src="/wap/js/lib/fastclick-jquery.js?v=<%=GlobalUtils.Version %>"></script>
	<script src="/wap/js/zhixiang/my.js?v=<%=GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
</html>

