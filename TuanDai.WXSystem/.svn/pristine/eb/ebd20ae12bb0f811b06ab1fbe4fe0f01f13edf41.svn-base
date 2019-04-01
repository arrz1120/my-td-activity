<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="binding_card_suc.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.binding_card_suc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>绑定银行卡成功 - 我的账户</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
    <link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
</head>
<body>
    <section class="bindingBox clearfix">
       <i class="ico-note-big"></i>
       <div class="f18px c-212121 text-center mt30 clearfix">成功提交绑定银行卡申请</div>
       <div class="text-center f14px c-ababab mt5 clearfix">（<%=userModel.BankType == 9999 ? userModel.otherBankName : Tool.EnumHelper.GetDescriptionFromEnumValue(typeof(ConstString.BankType), userModel.BankType)%><%=BusinessDll.StringHandler.MaskBankNo(userModel.BankAccountNo)%>）</div>
       <div class="mt30 clearfix"><a href='safety.aspx' class="btn btnYellow">确定</a></div>
   </section>
</body>
</html>
