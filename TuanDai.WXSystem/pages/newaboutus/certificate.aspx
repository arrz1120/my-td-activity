﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="certificate.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.newaboutus.certificate" %>

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
            <a href="partner.aspx" class="swiper-slide f13px c-626262">
            	合作伙伴
			</a>
            <a href="safety.aspx" class="swiper-slide f13px c-626262">
            	安全保障
			</a>
            <a href="history.aspx" class="swiper-slide f13px c-626262">
            	发展历程
			</a>
            <a href="javascript:void(0);" class="swiper-slide f13px c-626262 active">
            	资质证书
			</a>
            <a href="honor.aspx" class="swiper-slide f13px c-626262">
            	公司荣誉
			</a>
		</div>	
		<div class="opacityL pos-a"></div>
		<div class="opacityR pos-a"></div>
	</div>
	
	<!--资质证书-->
	<div class="swiperPageWrap">
		<div class="swiper-container2 bg-fbfbf9" id="swiperPage">
	        <div class="swiper-wrapper">
	            <div class="swiper-slide">
	            	<div class="imgBox bg-fbfbf9"><img src="/imgs/file/V1.7/zz_big01.jpg" alt="" /></div>
	            	<div class="f12px c-212121 text-center pl15 pr15">《团贷数据分析软件著作权登记证书》</div>
				</div>
	            <div class="swiper-slide">
	            	<div class="imgBox bg-fbfbf9"><img src="/imgs/file/V1.7/zz_big02.jpg" alt="" /></div>
	            	<div class="f12px c-212121 text-center pl15 pr15">《团贷网P2P投融资信息管理软件著作权登记证书》</div>
				</div>
	            <div class="swiper-slide">
	            	<div class="imgBox bg-fbfbf9"><img src="/imgs/file/V1.7/zz_big03.jpg" alt="" /></div>
	            	<div class="f12px c-212121 text-center pl15 pr15">《团贷网P2P信息管理IOS客户端著作权登记证书》</div>
				</div>
	            <div class="swiper-slide">
	            	<div class="imgBox bg-fbfbf9"><img src="/imgs/file/V1.7/zz_big04.jpg" alt="" /></div>
	            	<div class="f12px c-212121 text-center pl15 pr15">《团贷网P2P信息管理安卓客户端著作权登记证书》</div>
				</div>
	            <div class="swiper-slide">
	            	<div class="imgBox bg-fbfbf9"><img src="/imgs/file/V1.7/zz_big05.jpg" alt="" /></div>
	            	<div class="f12px c-212121 text-center pl15 pr15">《团贷网风控管理软件著作权登记证书》</div>
				</div>
	            <div class="swiper-slide">
	            	<div class="imgBox bg-fbfbf9"><img src="/imgs/file/V1.7/zz_big08.jpg" alt="" /></div>
	            	<div class="f12px c-212121 text-center pl15 pr15">《团贷网资金管理软件著作权登记证书》</div>
				</div>
	            <div class="swiper-slide">
	            	<div class="imgBox bg-fbfbf9"><img src="/imgs/file/V1.7/zz_big07.jpg" alt="" /></div>
	            	<div class="f12px c-212121 text-center pl15 pr15">《团贷网营业执照》</div>
				</div>
	            <div class="swiper-slide">
	            	<div class="imgBox bg-fbfbf9"><img src="/imgs/file/V1.7/zz_big06.jpg" alt="" /></div>
	            	<div class="f12px c-212121 text-center pl15 pr15">《团贷网国际域名注册证书》</div>
				</div>
	            <div class="swiper-slide">
	            	<div class="imgBox imgBox9 bg-fbfbf9"><img src="/imgs/file/V1.7/zz_big09.png" alt="" /></div>
	            	<div class="f12px c-212121 text-center pl15 pr15">《中华人民共和国信息安全等级保护三级认证》</div>
				</div>
			</div>
			<div class="pageMark text-center">
				<p class="c-212121 f20px"><span class="c-fac23a f20px" id="mark">01</span>/<span class="f12px">09</span></p>
			</div>
		</div>	
	</div>
	<div class="alert" id="alert" style="display: none;">
		<div class="imgScale">
			<img id="imgScale" src="/imgs/file/V1.7/zz_big01.jpg"/>
		</div>
	</div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20160202"></script>
<script type="text/javascript">
  	$(function () {
		var swiperNav = new Swiper('#swiperNav', {
				slidesPerView: 'auto',
		        initialSlide:3,
		        onSlideChangeStart:function(swiperNav){
		        	if(swiperNav.activeIndex>0){
		        		$(".opacityL").removeClass('hide');
		        	}
		        	else{
		        		$(".opacityL").addClass('hide');
		        	}
		        }
	   	});
		var swiperPage = new Swiper('#swiperPage', {
		       speed:600,
		       direction: 'horizontal',
		       slidesPerView: '1',
		       onSlideChangeStart:function(swiperPage){
		       		$("#mark").html('0'+(swiperPage.activeIndex+1));
		       }
	   	});
	   	
	   	$("#swiperPage").find('.swiper-slide').click(function(){
	   		var src	= $(this).find('img').attr('src');
	   		$('#imgScale').attr('src',src);
	   		$("#alert").show();
	   	})
	   	
	   	$('#alert').click(function(){
	   		$(this).hide();
	   	});
    });
</script>

</body>
</html>