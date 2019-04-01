<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="aboutUs.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.newaboutus.aboutUs" %>

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
	<script src="http://player.youku.com/jsapi" type="text/javascript"></script>
    <style type="text/css">
   .video-box { height: 220px; padding: 3px 0; background: #FFFFFF; top: 75px; }
    #v2 { margin-left:10px;margin-right:10px; display: none; }
    .video_img img {cursor: pointer; }
    .video-box #video { z-index: 100;height: 220px; width: 100%; float: left; position: relative; } 
    </style>
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
        <a href="javascript:void(0);" class="swiper-slide f13px c-626262 active">
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

    <!--团贷简介--> 
     <section class="mt10 pd13 clearfix">
      <div class="imgBox" id="v1" style="margin:10px;"><img src="/imgs/images/knowtd_01.jpg"></div>
      <div class="video-box" id="v2" style="width:305px;display:none;">
        <div id="video">
          <script type="text/javascript">
              player = new YKU.Player('video', {
                  styleid: '0',
                  client_id: '52b3fa57e9fe17cf',
                  vid: 'XMTQ4NjUzMjg0NA==',
                  autoplay: false,
                  show_related: false
              });
          </script>
        </div>
      </div>
    </section>

	<div class="pl15 pr15 pb30 box_txt">
		<p class="c-212121 f13px">东莞团贷网互联网科技服务有限公司成立于2011年，并于2012年正式上线运营专注于小微企业融资服务的互联网金融信息平台—团贷网，2013年11月顺利完成股份制改造，成为国内首家注册资本一亿元的股份制互联网金融公司。2015年6月，团贷网完成由国内著名投资机构九鼎投资领投、巨人投资、久奕投资和沈宁晨等跟投的B轮2亿元人民币的融资，目前集团估值已经超过25亿元。2015年，为打破线下业务地域拓展的局限性，团贷网开始实施全国战略布局，目前在营业和试营业的分公司网点将近200家，主要分布在中南、西南、华北、华东地区。2016年3月，为更好适应市场发展，团贷网投资进行了全面改组，理顺了内部结构，为未来的发展奠定了坚实的基础。改组后的架构如下：</p>
		<img class="mt30" src="/imgs/images/TD_group.png?v=20160808"/>
		<p class="c-212121 f13px mt30">作为新三板公司的全资子公司，新的“团贷网”，将接受中国证监会、全国中小企业股份转让系统、股东及社会公众的监督，严格遵守《证券法》及新三板有关规定，履行信息披露义务，所有披露信息均可在有效的公众渠道查询。新的“团贷网”平台管理将更加规范、信息将更加公开、透明。 </p>
        <p class="c-212121 f13px mt30">截止2016年6月，平台累计交易量突破220亿元，平台的投资注册用户超过270万人，为投资人赚取了预期收益超过14亿元，2015年公司实缴纳税金额近1000万元。</p>
	</div>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20160201001"></script>
<script type="text/javascript">
    $(function () {  
        $('#v1').click(function () {
            $("#v1").hide();
            $('#v2').fadeIn(1000);
           $(".video-box").width($(document.body).width() - 20);
        });

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
    })
</script>

</body>
</html>
