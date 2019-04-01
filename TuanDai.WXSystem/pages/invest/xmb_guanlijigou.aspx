<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="xmb_guanlijigou.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.xmb_guanlijigou" %>

 <!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>管理机构</title>
	<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
	<link rel="stylesheet" type="text/css" href="/css/invest.css?v=20151120001" /><!--借款-->
	
	</head>
	<body>
   <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:window.location.href='/pages/invest/xmb_detail.aspx?projectid=<%=projectId%>';">返回</div>
            <h1 class="title">管理机构</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header> 

		<div class="info-item simubao-d gyl-bd plpr15">
	        <div class="pb20">
	            <h3 class="f14px c-ffcf1f">管理机构</h3>
	            <%=xmbModel.DepositOrgDesc %>
	        </div> 
	    </div>  
	    
		<div class="info-item simubao-d gyl-bd plpr15">
	        <div class="pb20">
	            <h3 class="f14px c-ffcf1f">管理团队</h3>
	             <%=xmbModel.DepositTeam %>
	        </div> 
	    </div>      
	</body>
    <script type="text/javascript" src="/scripts/jquery.min.js?v=20151120"></script> 
    <script type="text/javascript" src="/scripts/base.js?v=20151116001"></script>
</html>
