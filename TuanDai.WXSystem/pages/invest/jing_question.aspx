﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jing_question.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.jing_question" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>常见问题</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/invest.css?v=20151026001" /><!--借款-->

</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">常见问题</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>
<section class="issue-wrap pl15 pr15">
    <h3 class="f14px">1、什么是资产标？</h3>
    <p class="f13px border-b1px c-545454">资产标是团贷网投资人以其持有的团贷网待收资产作为质押物，向平台的其他投资人发起资金周转需求的产品。发起周转需求的投资人，其在平台的待收资产能完全覆盖其资金周转需求的总额，且有团贷网合作担保机构担保，风险可控。
    </p>
    <h3 class="f14px">2、资产标发起人能否提前结清？</h3>
    <% if (proTime < DateTime.Parse("2017-07-28"))
       {
    %>
    <p class="f13px border-b1px c-545454">资产标自发布时起，持有14天以上，可随时申请提前结清。发起方在需求期限届满前一个月及以上提前结清的，除应向投资方支付已产生的相应利息（按天计算）、剩余本金外，还应向投资方额外支付一个月的利息作为提前结清的补偿；若发起方在需求期限届满前一个月内提前结清的，则仍需向投资方支付所有需求本金及利息。</p>
    <%
       }
       else
       {
           %>
    <p class="f13px border-b1px c-545454">自资产标周转项目发布时起，持有10天以上，可申请提前结清，提前结清时除应向投资方支付已产生的相应利息（按天计算）、剩余本金外，还应向投资方额外支付提前结清违约金。违约金额=（借款本金*借款利率）*违约天数/365，违约天数根据本次项目剩余期限（最后一期还款日减去提前还款日）按天计算，剩余期限每15天算1天违约，不足15天的部分按1天违约来算。（注：若借款剩余期限≤1天，则无需收取提前还款违约金）。
    </p>
    <%
       } %>
    
    
    <h3 class="f14px">3、若资产标发起人发送逾期结清会怎样？</h3>
    <p class="f13px border-b1px c-545454">自逾期之日起30天内（包含第30天），借款人须按日缴纳剩余未还款项0.3%的违约金，投资时为超级会员的投资人可获得未还本息的0.2%的违约金，剩余部分作为平台逾期催收管理费。投资时是普通会员的投资人不能获得违约金；逾期超过30天，担保公司将于“第31个逾期日”对相关投资者进行垫付。其中，将向投资时是超级会员的投资人提供“本金+利息+滞纳金”全额垫付，向投资时是普通会员的投资人提供“本金”垫付（普通会员利息收益将在完成借款催收后再行发放）。一旦借款人存管账户内的可用余额大于或等于其发布金额的到期应付本息，系统会自动执行逾期应付款项。担保公司垫付之日起，借款人须按日缴纳垫付款项0.4%的违约金。<br/>
       注：资产标为团贷网新开发的独立产品，与团贷网相关规定冲突之处，以“资产标”专区解释为准；如资产标发布者初始待收逾期，其仍需无条件承担资产标到期还本付息之责。
    </p>
</section>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>

</body>
</html>