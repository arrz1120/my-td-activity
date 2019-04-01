<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="withdrawal_suc.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.withdrawal.withdrawal_suc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>提现成功</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->
</head>
<body>
 <%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:window.location.href='/Member/my_account.aspx'">返回</div>
        <h1 class="title">提现完成</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>

<section class="withdrawalBox clearfix">
    <i class="ico-withdrawal-suc"></i>
    <div class="f18px c-212121 text-center mt30 clearfix">已提交提现申请！
    </div>
    <div class="f18px c-212121 text-center mt5 clearfix">提现<%= ToolStatus.ConvertLowerMoney(Amout)%>元到您的<%=DrawType==2?"银行卡":"微信钱包" %>中</div>
    <% if(DrawType==2){ %>
    <div class="text-center f14px c-ababab mt5 clearfix">（<%=userModel.BankType == 9999 ? userModel.otherBankName : Tool.EnumHelper.GetDescriptionFromEnumValue(typeof(ConstString.BankType), userModel.BankType)%><%=BusinessDll.StringHandler.MaskBankNo(userModel.BankAccountNo)%>）</div>
    <%} %>
    <div class="mt30 clearfix"><a href="/Member/my_account.aspx" class="btn btnYellow">确定</a></div>
</section>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
</body>
</html>
