<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="noticedetails.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.news.noticedetails" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>公告详情</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/helpCenter.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/baikedaohang.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <style type="text/css">
        .noticeDetail p {
            font-size: 15px !important;
            line-height: 30px;
        }
        .noticeDetail p span{
            font-size: 15px !important;
        }
        .noticeDetail  span{
            font-size: 15px !important;
        }
    </style>
</head>
<body class="bg-fff">
	<div id="bigDiv">
    <%= this.GetNavStr()%>
    <div class="pt17 pb18 ml15 pr15 bb-e6e6e6">
        <p class="f17px fb text-overflow"><%=strTitle%></p>
        <p class="c-ababab line-h16 2016-06-15 mt3"><%=strAddDate%></p>
    </div>

    <div class="noticeDetail pl15 pr15">
        <%=strContent%>
    </div>
		
	</div>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/seo.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
    	$(function(){
    		$(".noticeDetail").find('table').css('width','100%');
    	})
    </script>
</body>
</html>
