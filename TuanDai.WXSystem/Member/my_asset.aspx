<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_asset.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.my_asset" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>我的资产</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/account.css?v=2015090701" /><!--账户中心-->
</head>
<body>
    <%= this.GetNavStr()%>
   <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:window.location.href='/Member/my_account.aspx'">返回</div>
            <h1 class="title">我的资产</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>

    <div class="assetBox clearfix">
        <section class="as-hd">
            <div class="hd"><i class="ico-asset"></i>净赚利息(元)</div>
            <div class="bd"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.NetEarningsInterest)%></div>
        </section>

         <section class="as-cont">
            <div class="hd">
                <p class="f12px c-ababab">可用资金总额(元)</p>
                <p class="f18px c-424242"><%=ToolStatus.ConvertLowerMoney(fundAccountInfo.AviMoney + fundAccountInfo.RewardMoney)%></p>
            </div>
            <div class="bd">
                <div class="Cont">
                    <p class="tit"><span>可用现金(元)</span></p>
                    <p class="num"><%=ToolStatus.ConvertLowerMoney(fundAccountInfo.AviMoney)%></p>
                </div>
                <div class="Cont red">
                    <p class="tit"><span>奖金金额(元)</span></p>
                    <p class="num"><%=ToolStatus.ConvertLowerMoney(fundAccountInfo.RewardMoney)%></p>
                </div>
            </div>
        </section> 
         
        <section class="as-cont">
            <div class="hd">
                <p class="f12px c-ababab">累计投资(元)</p>
                <p class="f18px c-424242"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.TotalInvest)%></p>
            </div>
            <div class="bd">
                <div class="Cont">
                    <p class="tit"><span>待回收资金(元)</span></p>
                    <p class="num"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.RecoverBorrowOut)%></p>
                </div>
                <div class="Cont">
                    <p class="tit"><span>已回收资金(元)</span></p>
                    <p class="num"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.IncomeBorrow)%></p>
                </div>
            </div>
        </section>

         <section class="as-cont">
            <div class="hd">
                <p class="f12px c-ababab">累计借入(元)</p>
                <p class="f18px c-424242"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.TotalBorrow)%></p>
            </div>
            <div class="bd bd2">
                <div class="clearfix">
                    <div class="Cont">
                        <p class="tit"><span>申请借款总额(元)</span></p>
                        <p class="num"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.CompetitiveTenderBorrow)%></p>
                    </div>
                    <div class="Cont">
                        <p class="tit"><span>偿还中借款(元)</span></p>
                        <p class="num"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.RepayingBorrorw)%></p>
                    </div>
                </div>
                <div class="clearfix">
                    <div class="Cont">
                        <p class="tit"><span>还清的借款(元)</span></p>
                        <p class="num"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.RepayedBorrow)%></p> 
                    </div>
                    <div class="Cont">
                        <p class="tit"><span>累计利息成本(元)</span></p>
                        <p class="num"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.TotalInterestCost)%></p>
                    </div>
                </div>
            </div>
        </section>  
    </div>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
<script type="text/javascript"> 
    $(function () {
        $(".as-cont .hd").click(function () {
            $(this).toggleClass("hover");
            $(this).parent(".as-cont").find(".bd").slideToggle();
        });
    });
</script>
</body>
</html>