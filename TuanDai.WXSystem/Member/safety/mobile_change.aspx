<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mobile_change.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.mobile_change" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>绑定手机号码</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/cunguan.css?20161220001" />
</head>
<body class="bg-f1f3f5">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-c2c2c2">
            <div class="back" onclick="javascript:history.go(-1);">返回</div>
            <h1 class="title">绑定手机号码</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>

    <div class="pt10">
        <div class="bg-fff pl15">
            <div class="inputBox webkit-box bt-e6e6e6">
                <div class="inpName">手机号码</div>
                <div class="inp">
                    <input type="text" value="<%=TelNo %>" readonly="readonly" /></div>
            </div>
            <div class="inputBox bt-e6e6e6">
                <a href="mobile_change_step1.aspx?t=<%=TelNo %>&s=<%=Tool.DESC.StringToHex(TelNo) %>" class="block pt10 pb10 c-fab600 f15px">更换注册时绑定的手机号码</a>
                <i class="ico-arrow-r"></i>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="/scripts/jquery.min.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script>
    
    </script>
</body>
</html>
