<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="borrowShow.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.borrowShow" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>借入详情</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/account.css?v=2015090701" /><!--账户中心--> 
<link rel="stylesheet" type="text/css" href="/css/borrowshow.css?v=2.0" />  
</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="window.location.href='/Member/Repayment/borrowLog.aspx'">返回</div>
            <h1 class="title">借入详情</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <div class="borrowShowMain">
        <section class="hbody">
            <a href="<%=GetDetailLinkUrl(model) %>">
                <h2 class="tit"> <%=model.Title%></h2>
                <p class="f12px c-ababab">发布时间：<%=model.AddDate.ToString("yyyy-MM-dd HH:mm:ss")%> </p>
                <span class="<%=GetTipBoxCss(model)%>"> <%=GetBillStatus(model)%></span>
            </a>
        </section>
        <section class="mbody">
            <div class="hbd">
                <div class="infoMain">
                    <p class="c-ababab f12px">配资总额</p>
                    <p class="f28px c-ffcf1f pt5">¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.Amount)%></p>
                    <div class="moneyMain">
                        <div class="clearfix">
                            <p>保证金</p>
                            <p>配资资金</p>
                        </div>
                        <div class="clearfix">
                            <span>¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.DepositAmount)%></span>
                            <span>¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.CapitalFunds)%></span>
                        </div>
                    </div>
                </div>
                <div class="infoMain pt10 pb10">
                    <p class="c-ababab f12px">已借入金额</p>
                    <p class="f20px c-424242 pt5">¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.HaveBorrowedAmount)%></p>
                </div>
                <div class="rightMain">
                    <div class="circle <%=GetCircleCss(model) %>">
                        <div class="pie_left"><div class="left"></div></div>
                        <div class="pie_right"><div class="right"></div></div>
                        <div class="mask"><span><%=model.Progress%></span>%</div>
                        <div class="periods"><%=GetProcessStr(model)%></div>
                    </div>
                </div>
            </div>
        </section>
        <section class="msgBox">
            <ul>
                <li >
                    <p>利息(<%=model.InterestRate%> ％)</p>
                    <p>¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.TotalInterest)%></p>
                </li>
                <li>
                    <p>管理费</p>
                    <p>¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.BorrowPayoutCommission)%></p>
                </li>
                <li>
                    <p>账户管理费</p>
                    <p>¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.ServiceAmount)%></p>
                </li>
            </ul>
        </section>
        <% if (model.TransferStatus > 0)
           { %>
        <section class="hbody bg-bdtopBom1-ccc mt15 mb20">
            <a href="/Member/Repayment/operationInfo.aspx?id=<%=projectId%>" class="f14px block">操盘信息</a>
        </section>
        <%} %>
        <% if (model.Status == 4)
           { %>
        <section class="hbody bg-bdtopBom1-ccc mt15 mb20"> 
            <p class="liubiao">• 截止<%=model.TenderDate.ToString("yyyy年MM月dd日mm时")%>时，项目未满标。</p>
            <p class="liubiao">• 保证金已退还至可用资金。</p> 
        </section>
        <%} %>
    </div>
    
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
<script type="text/javascript">
    $(function () {
        //统计
        $('.circle').each(function (index, el) {
            var num = $(this).find('span').text() * 3.6;
            if (num <= 180) {
                $(this).find('.right').css('transform', 'rotate(' + num + 'deg)');
            }
            else {
                $(this).find('.right').css('transform', 'rotate(180deg)');
                $(this).find('.left').css('transform', 'rotate(' + (num - 180) + 'deg)');
            };
            if (num == 360) {
                $(this).addClass("finish");
            };
        });
    });
</script> 
</body>
</html>