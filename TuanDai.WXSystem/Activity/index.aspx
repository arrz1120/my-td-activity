<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="TuanDai.WXApiWeb.Activity.index" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>团贷公益</title>
<link rel="stylesheet" type="text/css" href="/css/global.css?v=20160412" />
<link rel="stylesheet" type="text/css" href="/css/activity.css?v=20160412" />
</head>
<body class="bg-f1f3f5">
<%= this.GetNavStr()%>
<header class="headerMain">
  <div class="header">
    <div class="back" onclick="javascript:history.go(-1);">返回</div>
    <h1 class="title">团贷公益</h1>
  </div>
  <%= this.GetNavIcon()%>
  <div class="none"></div>
</header>
     
<div class="pd15">
<% if (model.List.Any()) {  %>
    <div class="act-list">
        <% foreach (var Item in model.List)
        { %>  
        <div class="act-item mt18 click-respond">
           <a href="<%= Item.LinkUrl %>">
			    <img src="<%=Item.ImageUrl %>"/>
			    <div class="act-txt pos-r"> 
				    <p class="f15px" style="line-height: 48px !important;"><%=StrReplace(Item.Title)%></p>
				    <%--<p class="f10px c-ababab line-h18"><%=Convert.ToDateTime(Item.StartDate).ToString("yyyy-MM-dd") %>至<%=Convert.ToDateTime(Item.EndDate).ToString("yyyy-MM-dd")%></p>--%>
				    <i class="ico-arrow-r"></i> 
			    </div>
           </a>
		</div> 
        <%}%>
    </div>      
<%}else{ %>
<div class="act-none webkit-box box-center box-vertical">
	<img src="/imgs/images/pic/act-none.png"/>
	<p class="f17px mt15">暂无进行中活动哦!</p>
</div>
<%} %> 
</div>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script> 
<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script> 
</body>
</html>
