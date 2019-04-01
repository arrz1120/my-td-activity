﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplySuccess.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.loan.ApplySuccess" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>借款成功</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/loan.css" />
</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:window.location.href='/pages/loan/borrowMoney.aspx'">返回</div>
            <h1 class="title">借款成功</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <div class="loanSucBox">
        <i class="ico-succeed-big"></i>
        <div class="c-212121 f16px text-center pt15 pb15">发布成功！</div>
        <div class="mt30">
            <input type="button" id="confirm" class="btn btnYellow h52" value="确定">
        </div>
        <div class="f12px pt10 c-ababab text-center">如有疑问，请联系客服：<i class="c-fd6040">1010-1218</i></div>
    </div>

    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=1"></script>
    <script type="text/javascript">
        $(function () {

            //点击“确认”按钮.
            $("#confirm").click(function () {
                window.location.href = "BorrowMoney.aspx";
            });
        });
    </script>
</body>
</html>
