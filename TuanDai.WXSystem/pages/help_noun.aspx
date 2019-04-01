<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="help_noun.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.help_noun" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>帮助中心</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<style type="text/css">
    .rulesBox{ padding: 15px;}
    .rulesBox strong{ font-size: 1.2rem; line-height: 150%; margin-bottom: 25px; font-weight:bold;}
</style>
</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">帮助中心</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>
<section class="rulesBox clearfix pl10">
<strong>借款用户（借款人）</strong><br />
指已经或准备在团贷网发布借款项目的用户。<br />
<br />
<strong>投资用户（投资人）</strong><br />
指在团贷网完成各项安全认证的，已经或准备出借指定金额给借款项目的用户。<br />
<br />
<strong>发标</strong><br />
指借款用户在团贷网发布借款项目的行为。<br />
<br />
<strong>投标</strong><br />
指投资用户在团贷网出借指定金额给借款项目的行为。<br />
<br />
<strong>出借</strong><br />
投资用户将存管账户内的指定的金额出借给指定借款用户，以换取其借款项目的指定份数的债权的行为。<br />
<br />
<strong>债权</strong><br />
投资用户在指定期限获得借款用户归还本金和利息的权利；<br />
<br />
<strong>最小出借单位</strong><br />
债权的单价，投资用户的出借金额必须是债权单位的倍数。<br />
<br />
<strong>每月付息</strong><br />
为团贷网还款方式的一种，借款人需在借款期限内，以每月等额利息的方式还给投资人，并在最后一期一次性归还本金。<br />
<br />
<strong>一次性</strong><br />
为团贷网还款方式的一种，借款人需在还款最后期限，一次性全额本息归还给投资人。<br />
<br />
<strong>先息后本</strong><br />
为团贷网还款方式的一种，借款人需在借款时先一次性给予投资人全额利息，然后在还款最后期限，归还全额本金。<br />
<br />
<strong>逾期</strong><br />
指借款用户未能按照借款项目发布时约定的时间，对投资用户进行足额还款的状态。<br />
<br />
<strong>垫付</strong><br />
指借款项目逾期，由与团贷网合作的第三方担保机构代为偿还的动作。（普通用户保障本金，特权用户保障本息）<br />
<br />
<strong>待收本金</strong><br />
指指定借款人需在指定期限归还给投资用户的本金金额总和。<br />
<br />
<strong>借款额度</strong><br />
指团贷网根据借款人（企业）提供的信用资料及综合考察情况，对借款人授予的合理借款额度。借款人可根据借款额度将相关借款信息发布到平台，由投资人自愿申购。
</section>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
</body>
</html>
