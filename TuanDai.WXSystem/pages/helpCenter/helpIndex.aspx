﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="helpIndex.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.helpCenter.helpIndex" %>

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
		<title>帮助中心</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
		<link rel="stylesheet" type="text/css" href="/css/helpCenter.css?v=20161223001" />
	</head> 
 <body class="bg-f1f3f5">
 <%=this.GetNavStr()%>
    <header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">帮助中心</h1> 
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
  </header> 
		<div class="qBox bg-fff">
			<ul>
                <% if(hotQueList!=null && hotQueList.Any()){
                       foreach (TuanDai.News.Contract.WXHelpDetialInfo item in hotQueList)
                       { 
                        %>
				<li class="click-respond"><a href="/pages/helpCenter/helpDetail.aspx?id=<%=item.Id%>"><%=Tool.StrObj.CutString(item.Title, 20) %><i class="ico-arrow-r"></i></a></li> 
                <%}
                }else{ %>
                   <li class="click-respond">暂无热门问题数据</li>
                <%} %>
			</ul>
		</div>
		<div class="sBox bg-fff mt10">
            <% if (categroyList != null && categroyList.Any())
               {
                   for (int pIndex = 0; pIndex < categroyList.Count-1; pIndex++) 
                   {%>
                   <%if(pIndex%3==0){ %>
			          <div class="clearfix <%=pIndex>0?"bt-e6e6e6":""%>">
                    <%} %>
				    <a class="block w33p br-e6e6e6 text-center lf click-respond" href="/pages/helpCenter/secondQuestion.aspx?typeid=<%=categroyList[pIndex].Id %>">
					    <div class="sImg sImg1"><img src="<%=categroyList[pIndex].ImageUrl %>" /></div>
					    <p><%=categroyList[pIndex].CategoryName %></p>
				    </a> 
                   <% if((pIndex-2)%3==0){ %>
			         </div>
                 <%} %>
            <%}%>
                    <a class="block w33p br-e6e6e6 text-center lf click-respond" href="/Member/MemberCenter/memberQuestion.aspx">
					    <div class="sImg sImg13"><img src="/imgs/images/icon/helpCenter/ico_h13.png" /></div>
					    <p>会员</p>
				    </a> 
              <%} %> 
		</div>
		<div class="pt8 pb8 c-ababab text-center">客服电话：1010-1218</div>
	</body>
	<script type="text/javascript" src="/scripts/jquery.min.js"></script>
	<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version%>"></script> 
</html>
