﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="shareholder.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.newaboutus.shareholder" %>
 
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
            <a href="javascript:void(0);" class="swiper-slide f13px c-626262 active">
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
            <a href="certificate.aspx" class="swiper-slide f13px c-626262">
            	资质证书
			</a>
            <a href="honor.aspx" class="swiper-slide f13px c-626262">
            	公司荣誉
			</a>
		</div>	
		<div class="opacityL pos-a hide"></div>
		<div class="opacityR pos-a"></div>
	</div>
				
	<!--股东机构-->
	<!--九鼎投资-->
	<section class="bt-d1d1d1 bb-d1d1d1 bg-fff pl15 pr15 mt15">
		<div class="shareholder_up clearfix pt15 pb15 bb-e6e6e6">
			<div class="lf roundBox">
				<img class="roundBoxImg1" src="/imgs/partner/JD.png"/>
			</div>
			<div class="lf ml20 mt7">
				<div class="fb f14px c-212121">九鼎投资</div>
				<p class="f12px c-ababab line-h18">中国最佳私募股权投资机构</p>
				<p class="f12px c-ababab line-h18">中国私募股权投资机构50强首位</p>
			</div>
		</div>
		<div class="shareholder_down pb15 pt15">
			<p class="c-212121 line-h30 f13px">昆吾九鼎投资管理有限公司（简称九鼎投资），是一家专注于股权投资及管理的专业机构。九鼎投资是在国家发展与改革委员会备案的股权投资企业，中国投资协会创业投资专业委员会副会长单位。曾蝉联2011年、2012年度“中国私募股权投资机构50强”第一名，获评“中国最佳私募股权投资机构”。</p>
		</div>
	</section>
	<!--巨人投资-->
	<section class="mt15 bt-d1d1d1 bb-d1d1d1 bg-fff pl15 pr15">
		<div class="shareholder_up clearfix pt15 pb15 bb-e6e6e6">
			<div class="lf roundBox">
				<img class="roundBoxImg2" src="/imgs/partner/JR.png"/>
			</div>
			<div class="lf ml20 mt7">
				<div class="fb f14px c-212121">巨人投资</div>
				<p class="f12px c-ababab line-h18">商界传奇人物史玉柱先生创办建立</p>
				<p class="f12px c-ababab line-h18">成功投资多家知名上市公司</p>
			</div>
		</div>
		<div class="shareholder_down pb15 pt15">
			<p class="c-212121 line-h30 f13px">巨人投资有限公司由当今中国商界最具传奇色彩的人物史玉柱创建。多年来，凭借超强的风险把控能力及卓越的前瞻意识，史玉柱成功打造了脑白金、巨人网络等知名企业。此外，还战略投资民生银行，并带领公司实现对20多家上市公司的持股或间接持股。史玉柱曾先后荣登胡润百富榜、福布斯全球富豪排行榜等，并与马云、王健林等人被评为“2013年度中国十大创新企业家”。 </p>
		</div>
	</section>
	<!--九奕投资-->
	<section class="mt15 bt-d1d1d1 bb-d1d1d1 bg-fff pl15 pr15">
		<div class="shareholder_up clearfix pt15 pb15 bb-e6e6e6">
			<div class="lf roundBox">
				<img class="roundBoxImg3" src="/imgs/partner/JY.png"/>
			</div>
			<div class="lf ml20 mt7">
				<div class="fb f14px c-212121">久奕投资</div>
				<p class="f12px c-ababab line-h18">知名股权投资机构</p>
				<p class="f12px c-ababab line-h18">中国创业投资机构综合排名19强</p>
			</div>
		</div>
		<div class="shareholder_down pb15 pt15">
			<p class="c-212121 line-h30 f13px">上海久奕投资管理有限公司是一家长期专注于一、二级市场证券投资的资产管理机构，是国内成长最快的团队之一。久奕投资曾成功投资和管理了多个股权投资基金和证券投资基金，涉足领域包括：高端制造、金融服务业、环保能源、TMT等新经济、教育培训、金融地产等等；并成功运作多个证券市场专户基金和阳光私募产品，管理资金规模逾20亿元。</p>
		</div>
	</section>
	<div class="pt15 bg-fbfbf9"></div>		
			
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
<script type="text/javascript">
  $(function () {
	var swiperNav = new Swiper('#swiperNav', {
			slidesPerView: 'auto',
	        onSlideChangeStart:function(swiperNav){
	        	if(swiperNav.activeIndex>0){
	        		$(".opacityL").removeClass('hide');
	        	}
	        	else{
	        		$(".opacityL").addClass('hide');
	        	}
	        }
   	});
  });
</script>

</body>
</html>