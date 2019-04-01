<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="invest_baot.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.invest_baot" %>

<%@ Import Namespace="TuanDai.PortalSystem.Model" %>
<%@ Import Namespace="Tool" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>投资专题页</title> 
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css?v=20160314" />
	<link rel="stylesheet" type="text/css" href="/css/index2.css?v=20160422001" />
    <%--<script src="/scripts/youku.jsapi.js" type="text/javascript"></script>--%>
    <script src="http://player.youku.com/jsapi" type="text/javascript"></script>
</head>
<body class="bg-f1f3f5">
<%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-d1d1d1">
            <div class="back" onclick="javascript:history.go(-1);"></div>
            <h1 class="title">投资专题页</h1>
        </div>
         <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>

<div class="bg-fff invset-guide">
	<a href="/pages/invest/invest_list.aspx" class="pl15 pr15 invset-guide-tit pos-r f17px c-212121">
		<i class="ico ico02"></i>投资专区
		<p class="f15px c-d1d1d1 pos-a">查看更多<i class="i-arrow-right"></i></p>
	</a>
		
	<div class="swiper-container swiper-invest" id="swiper-invest1">
		<div class="swiper-wrapper">
             <% foreach (WXProjectListInfo project in projectList)
                   { %>
		    <div class="swiper-slide">
               <a href="<%=TuanDai.WXApiWeb.invest_list.GetClickUrl(project.TypeId, project.SubTypeId , project.Id)%>">
		        <div class="bt-e6e6e6 bb-e6e6e6 ml15 mr15">
		        	<div class="bl-e6e6e6 br-e6e6e6 pt20 pb10 pl10 pr10">
				        <div class="webkit-box">
				        	<div class="box-flex1 text-left">
				        		<p class="f14px c-fd6040"><%=TuanDai.WXApiWeb.invest_list.GetProjectYearRate(project)%></p>
				        		<p class="f12px c-ababab mt5">预期年化利率</p>
				        	</div>
				        	<div class="box-flex1 text-center">
				        		<p class="f14px c-212121"><%=GetProjectShowDeadline(project) %></p>
				        		<p class="f12px c-ababab mt5">投资期限</p>
				        	</div>
				        	<div class="box-flex1 text-right">
				        		<p class="f14px c-212121"><%=GetProjectSurplusMoney(project) %></p>
				        		<p class="f12px c-ababab mt5">剩余金额</p>
				        	</div>
				        </div>
				        <div class="pt15 clearfix itemWrap">
				        	<div class="lf itemTxtBox"><p class="f13px c-808080 text-overflow"><%=TuanDai.WXApiWeb.invest_list.FilterProjectName(project.TypeId, project.Title)%></p></div>
				        	<div class="rf clearfix itemTipsBox">
				        		 <% if (!string.IsNullOrWhiteSpace(project.TuandaiRate)){ %>
    			                   <div class="lf itemTips itemTips1">加息<%=project.TuandaiRate %>></div>
                                <%} %> 
				        	</div>
				        </div>
		        	</div>
		        </div>
               </a>
		    </div> 
            <%} %>
		</div>
		<div class="invest-mark" id="mark1"></div>
	</div>
</div> 

 <div class="pl15 pr15 bg-fff">
  <h2 class="f16px c-212121">团贷介绍</h2>
  <div class="f13px c-212121 text-justify mt5">团贷网成立于2012年，是一家专注于小微企业融资服务的互联网金融信息中介平台。先后在各大城市创立了多家分公司，并计划于2015年扩展至20家。2015年6月，团贷网顺利完成了由九鼎投资领投，巨人投资、久奕投资和沈宁晨等跟投的B轮融资。机遇与挑战当前，团贷网初心不改，仍将继续发扬敢拼敢闯的创业精神，追求创新，加速实现“为3.14亿用户提供金融服务”这一企业愿景！</div>
  <div class="tdbao_video mt10">
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
    <div class="pb30 text-center f13px c-212121">王宝强正式加盟团贷网，出任团贷网首席体验官</div>
  </div>
</div>

    

    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20160422001"></script> 

    <script type="text/javascript"> 
        $(function ()
        {
            //循环计算投资专区下标题宽度
            $(".itemWrap").each(function (i) {
                var parent = $(".itemWrap").eq(i);
                var itemTipsBox = parent.find('.itemTipsBox');
                var itemTxtBox = parent.find('.itemTxtBox');
                if (itemTipsBox.length != 0) {
                    itemTxtBox.css('width', parent.width() - itemTipsBox.width() - 1);
                } else {
                    itemTxtBox.css('width', parent.width() - 1);
                }
            })

            var swiper_invest1 = new Swiper('#swiper-invest1', {
                direction: 'horizontal',
                loop: true,
                pagination: '#mark1'
            });

            $('#v1').click(function ()
            {
                $("#v1").hide();
                $('#v2').fadeIn(1000);
                $(".video-box").width($(document.body).width() - 20);
            });

        });
    </script>
</body>
</html>
