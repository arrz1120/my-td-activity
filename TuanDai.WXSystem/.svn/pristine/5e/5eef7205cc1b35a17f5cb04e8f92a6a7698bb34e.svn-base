<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="invest_list_empty.aspx.cs" Inherits="TuanDai.WXApiWeb.invest_list_empty" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>投资项目</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /> 
    <link rel="stylesheet" type="text/css" href="/css/invest.css" />
</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:window.location.href='<%= TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser?"/WeiXinIndex.aspx":"/Index.aspx" %>'">返回</div>
        <h1 class="title">投资项目</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header> 
<section class="screen-invest">
    <div class="invest-box" id="invest_box">
        <div class="screen-nav-cn hd">
            <ul>
                <li><a href="javascript:void(0)">默认</a></li>
                <li class="on"><a href="javascript:void(0)">利率</a></li>
                <li><a href="javascript:void(0)">期限</a></li>
            </ul>
        </div>
        <div class="invest-cn bd" id="invest_cn">
            <div class="con">
                <div class="not-invest-cn">
                    <img src="/imgs/images/invest-pic1.png" alt=""/>
                    <div class="invest-text">
                        <p class="f14px">全部标都被抢完了！</p>
                        <p class="c-d3aa73">设置自动投标，让团贷网为你抢标！</p>
                        <a href="/pages/setAuto/auto_invest.aspx">去设置</a>
                    </div>
                 </div>
            </div>
            <div class="con">
                <div class="not-invest-cn">
                    <img src="/imgs/images/invest-pic1.png" alt=""/>
                    <div class="invest-text">
                        <p class="f14px">全部标都被抢完了！</p>
                        <p class="c-d3aa73">设置自动投标，让团贷网为你抢标！</p>
                        <a href="/pages/setAuto/auto_invest.aspx">去设置</a>
                    </div>
                 </div>
            </div>
            <div class="con">
                <div class="not-invest-cn">
                    <img src="/imgs/images/invest-pic1.png" alt=""/>
                    <div class="invest-text">
                        <p class="f14px">全部标都被抢完了！</p>
                        <p class="c-d3aa73">设置自动投标，让团贷网为你抢标！</p>
                        <a href="/pages/setAuto/auto_invest.aspx">去设置</a>
                    </div>
                 </div>
            </div>
        </div>
    </div>
</section>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/TouchSlide.1.1.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
<script type="text/javascript">
    TouchSlide({
        slideCell: "#invest_box",
        endFun: function (i) { //高度自适应
            var bd = document.getElementById("invest_cn");
            bd.parentNode.style.height = bd.children[i].children[0].offsetHeight + "px";
            if (i > 0) bd.parentNode.style.transition = "200ms"; //添加动画效果
        }
    });
</script>
</body>
</html>
