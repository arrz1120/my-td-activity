<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="partner.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.newaboutus.partner" %>
 <!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>关于我们</title>
	<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
	<link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css"/>
	<script src="/scripts/youku.jsapi.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="/css/aboutUs_v1.7.css?v=20160216"/>
</head>
<body class="bg-fbfbf9">
<% if (strType != "mobileapp")
   { %>
 <%= this.GetNavStr()%>
<header class="headerMain">
  <div class="header">
    <div class="back" onclick="javascript:window.location.href='/Index.aspx'">返回</div>
    <h1 class="title">关于我们</h1>
  </div>
  <%= this.GetNavIcon()%>
  <div class="none"></div>
</header>
<%} %>

<div class="swiper-container1 border-bottom" id="swiperNav">
        <div class="swiper-wrapper">
            <a href="aboutUs.aspx" class="swiper-slide f13px c-626262">
            	团贷简介
			</a>
            <a href="shareholder.aspx" class="swiper-slide f13px c-626262">
            	股东机构
			</a>
            <a href="javascript:void(0);" class="swiper-slide f13px c-626262 active">
            	合作伙伴
			</a>
            <a href="safety.aspx" class="swiper-slide f13px c-626262">
            	安全保障
			</a>
            <a href="history.aspx" class="swiper-slide f13px c-626262">
            	发展历程
			</a>
            <a href="certificate.aspx" class="swiper-slide f13px c-626262">
            	资质证书
			</a>
            <a href="honor.aspx" class="swiper-slide f13px c-626262">
            	公司荣誉
			</a>
		</div>	
		<div class="opacityL pos-a"></div>
		<div class="opacityR pos-a"></div>
	</div>
	
	<!--合作伙伴-->
	<div class="bg-fbfbf9 pb40">
		<div class="partnerBox pl15 pr15">
			<a href="<%= TuanDai.WXApiWeb.GlobalUtils.ActivityWebsiteUrl %>/weixin/partner/jrtz.html">
				<div class="partnerImgBox"><img src="/imgs/partner/partner1.png"/></div>
				<p class="c-212121 f12px mt15">巨人投资</p>
			</a>
			<a href="<%= TuanDai.WXApiWeb.GlobalUtils.ActivityWebsiteUrl %>/weixin/partner/jdtz.html">
				<div class="partnerImgBox"><img src="/imgs/partner/partner2.png"/></div>
				<p class="c-212121 f12px mt15">九鼎投资</p>
			</a>
			<a href="<%= TuanDai.WXApiWeb.GlobalUtils.ActivityWebsiteUrl %>/weixin/partner/jytz.html">
				<div class="partnerImgBox"><img src="/imgs/partner/partner3.png"/></div>
				<p class="c-212121 f12px mt15">久奕投资</p>
			</a>
		</div>
		<div class="partnerBox pl15 pr15">
			<%--<a href="<%= TuanDai.WXApiWeb.GlobalUtils.ActivityWebsiteUrl %>/weixin/partner/jxjr.html">
				<div class="partnerImgBox"><img src="/imgs/partner/partner4.png"/></div>
				<p class="c-212121 f12px mt15">九信金融</p>
			</a>--%>
            <a href="http://www.gdnybank.com/">
				<div class="partnerImgBox"><img src="/imgs/partner/partner11.png"/></div>
				<p class="c-212121 f12px mt15">南粤银行</p>
			</a>
			<a href="<%= TuanDai.WXApiWeb.GlobalUtils.ActivityWebsiteUrl %>/weixin/partner/fzcm.html">
				<div class="partnerImgBox"><img src="/imgs/partner/partner5.png"/></div>
				<p class="c-212121 f12px mt15">分众传媒</p>
			</a>
			<a href="https://www.baidu.com/">
				<div class="partnerImgBox"><img src="/imgs/partner/partner6.png"/></div>
				<p class="c-212121 f12px mt15">百度</p>
			</a> 
		</div>
		<div class="partnerBox pl15 pr15">
			<a href="https://www.tenpay.com/v2/">
				<div class="partnerImgBox"><img src="/imgs/partner/partner7.png"/></div>
				<p class="c-212121 f12px mt15">财付通</p>
			</a>			
			<a href="http://www.lianlianpay.com/">
				<div class="partnerImgBox"><img src="/imgs/partner/partner9.png"/></div>
				<p class="c-212121 f12px mt15">连连支付</p>
			</a>
            <a href="https://www.baofoo.com/">
				<div class="partnerImgBox"><img src="/imgs/partner/partner10.png"/></div>
				<p class="c-212121 f12px mt15">宝付支付</p>
			</a>
		</div>
		 
	</div>
			
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20160201"></script>
<script type="text/javascript">
  $(function () {
	var swiperNav = new Swiper('#swiperNav', {
			slidesPerView: 'auto',
	        initialSlide:'1',
	        onSlideChangeStart:function(swiperNav){
	        	if(swiperNav.activeIndex>0){
	        		$(".opacityL").removeClass('hide');
	        	}
	        	else{
	        		$(".opacityL").addClass('hide');
	        	}
	        }
   	});
  })	
</script>

</body>
</html>