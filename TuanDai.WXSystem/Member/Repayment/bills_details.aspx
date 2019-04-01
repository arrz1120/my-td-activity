<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bills_details.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.bills_details" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>账单详情</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/account2.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
   
</head>
<body class="bg-f1f3f5">
    <%=GetNavStr() %>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:history.go(-1);">返回</div>
            <h1 class="title">我的账单</h1>
        </div>
        <div class="none"></div>
    </header>
    <section class="bill-details-box bg-fff">
        <div class="top pl15 pr15 bb-e6e6e6">
            <p class="f15px c-212121">[<%=GetBillTitle(model) %>]<%=GetBillType(model) %></p>
        </div>
        <div class="figure text-center">
            <p class="f50px <%=model.PayOutAmount>0?"c-212121":"c-fd6040" %> "><%= model.PayOutAmount>0?"-":"+"%><%=(model.PayOutAmount??0) > 0 ? (model.PayOutAmount??0).ToString("N2") : (model.InAmount??0).ToString("N2")%></p>
            <P class="f12px c-ababab">（账户余额: <%= model.Amount.ToString("N2") %>）</P>
        </div>

        <div class="explain pos-r ml15 mr15 bt-dashed-d1d1d1">
            <span class="f15px c-808080 pos-a">账单说明</span>
            <div class="f15px c-212121 text-right"><%=GetBillDesc(model) %></div>
        </div>
        <div class="explain pos-r ml15 mr15 pb25">
            <span class="f15px c-808080 pos-a">创建时间</span>
            <div class="f15px c-212121 text-right"><%=model.BillDate.ToString("yyyy.MM.dd   HH:mm:ss") %></div>
        </div>
        <% if (!string.IsNullOrEmpty(model.Title))
           {
               %>
        <div class="explain pos-r ml15 mr15 pb25">
            <span class="f15px c-808080 pos-a">项目</span>
            <div class="f15px c-212121 text-right"><%=model.Title %></div>
        </div>
        <%
           } %>
    </section>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
</body>
</html>
