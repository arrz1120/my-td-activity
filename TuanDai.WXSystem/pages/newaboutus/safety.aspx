<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="safety.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.newaboutus.safety" %>

 
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
	<script src="/scripts/youku.jsapi.js" type="text/javascript"></script>
	<style type="text/css">
		@media only screen and (max-width: 320px) {
			.pl40{padding-left: 30px !important;}
			.pr40{padding-right: 30px !important;}
		}
	</style>
</head>
<body class="bg-fbfbf9 pb25">
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
            <a href="javascript:void(0);" class="swiper-slide f13px c-626262 active">
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
	
	<!--安全保障-->
    <div class="bb-d1d1d1 bt-d1d1d1 bg-fff mt15">
    	<div class="clearfix pt25 pb25 pl40 pr40">
    		<div class="lf">
    			<div class="picBox"><img src="/imgs/images/safety1.png"/></div>
    		</div>
    		<div class="rf">
    			<div class="c-ffa200 f16px mt20">公信力强</div>
    			<div class="f12px c-212121 mt15">实力雄厚的公司股东背景</div>
    		</div>
    	</div>
    	<div class="clearfix pt25 pb25 pl40 pr40 bg-fbfbf9">
    		<div class="lf">
    			<div class="c-ffa200 f16px mt20">稳健性好</div>
    			<div class="f12px c-212121 mt15">完善的投资保障机制</div>
    		</div>
    		<div class="rf">
    			<div class="picBox"><img src="/imgs/images/safety2.png"/></div>
    		</div>
    	</div>
    	<div class="clearfix pt25 pb25 pl40 pr40">
    		<div class="lf">
    			<div class="picBox"><img src="/imgs/images/safety3.png"/></div>
    		</div>
    		<div class="rf">
    			<div class="c-ffa200 f16px mt20">优质度佳</div>
    			<div class="f12px c-212121 mt15">严格的风控流程管理</div>
    		</div>
    	</div>
    	<div class="clearfix pt25 pb25 pl40 pr40 bg-fbfbf9">
    		<div class="lf">
    			<div class="c-ffa200 f16px mt20">可靠性强</div>
    			<div class="f12px c-212121 mt15">独立的资金第三方资金托管</div>
    		</div>
    		<div class="rf">
    			<div class="picBox"><img src="/imgs/images/safety4.png"/></div>
    		</div>
    	</div>
    	<div class="clearfix pt25 pb25 pl40 pr40">
    		<div class="lf">
    			<div class="picBox"><img src="/imgs/images/safety5.png"/></div>
    		</div>
    		<div class="rf">
    			<div class="c-ffa200 f16px mt20">安全性高</div>
    			<div class="f12px c-212121 mt15">银行级的网站技术保障</div>
    		</div>
    	</div>
    	
    </div>
			
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20160202001"></script>
<script type="text/javascript">
    $(function () { 
        var swiperNav = new Swiper('#swiperNav', {
            slidesPerView: 'auto',
            initialSlide: '2',
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