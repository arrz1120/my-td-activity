<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="helpDetail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.helpCenter.helpDetail" %>

<%@ Import Namespace="TuanDai.WXApiWeb"  %> 
<!DOCTYPE html>
<html> 
	<head>
	    <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="apple-itunes-app" content="app-id=796440356"/>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
		<title>问题详情</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
		<link rel="stylesheet" type="text/css" href="/css/helpCenter.css?v=<%=GlobalUtils.Version %>" />
	</head> 
<body class="bg-f1f3f5">
   <%=this.GetNavStr()%>
    <header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">问题详情</h1> 
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
  </header>  
		<div class="pl15 bb-e6e6e6 bg-fff">
			<div class="ans_tit bb-e6e6e6"><%=model.Title %></div>
			<div class="ans_con">
				<%=model.Content %>
			</div>
		</div>
		<div class="ans_select clearfix bg-fff">
			<div class="w50p lf br-e6e6e6 pt10 pb10 text-center f15px hasHelp" attrtype="top"><i></i>有帮助</div>
			<div class="w50p lf br-e6e6e6 pt10 pb10 text-center f15px notHelp" attrtype="step"><i></i>没帮助</div>
		</div>
		<div class="pt8 pb8 c-ababab text-center">客服电话：1010-1218</div>
	</body>
	<script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>
	<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
	<script type="text/javascript"> 
	    $(function () {
	        var helpSelect = $(".ans_select").find('div');
	        helpSelect.click(function () {
	            var $this = $(this);
	            var feedType = $this.attr("attrtype");
	            jQuery.ajax({
	                type: "post",
	                url: "helpDetail.aspx?action=feedback&id=<%=NewsId%>&feedtype=" + feedType,
	                contentType: "application/json; charset=utf-8",
	                dataType: "json",
	                success: function (jsonstr) {
	                    if ($this.hasClass('act')) {
	                        helpSelect.removeClass('act');
	                        $this.removeClass('act');
	                    } else {
	                        helpSelect.removeClass('act');
	                        $this.addClass('act');
	                    }
	                },
	                error: function (a, b, c) {
	                    $("body").showTips("网络异常，请重试！");
	                }
	            });
	        });
	    });
	</script>

</html>