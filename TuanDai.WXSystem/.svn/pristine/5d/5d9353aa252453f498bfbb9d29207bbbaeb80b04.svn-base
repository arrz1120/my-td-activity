<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestAppActivity.aspx.cs"
    Inherits="TuanDai.WXApiWeb.Activity.TestAppActivity" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta http-equiv="Expires" CONTENT="0"> 
    <meta http-equiv="Cache-Control" CONTENT="no-cache"> 
    <meta http-equiv="Pragma" CONTENT="no-cache"> 
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <%if (!TuanDai.WXApiWeb.WebUserAuth.IsAuthenticated)
          {%>
        <p>
            <a href="ToAppLogin">跳转到App登录</a></p>
        <p>
            <a href="ToAppRegister">跳转到App注册</a></p>
        <%}
          else
          {%>
           <p><%TuanDai.WXApiWeb.WebUserAuth.UserId.ToString(); %></p>  
      <p>  <a href="../Member/my_account.aspx">我的个人中心</a></p>
        <p>
            <a href="ToAppLoan">跳转到App我要借款</a></p>
        <p>
            <a href="ToAppStock">跳转到App股票配资</a></p>
        <p>
            <a href="ToAppInvestList">跳转到App投资列表</a></p>
        <p>
            <a href="ToAppRecharge">跳转到App充值</a></p>
        <p>
            <a href="ToAppSecurityCenter">跳转到App安全中心</a></p>
        <p>
            <a href="ToAppMobileVerify">跳转到App手机验证</a></p>
        <p>
            <a href="ToAppIdentityVerify">跳转到App身份验证</a></p>
        <p>
            <a href="ToAppTBX">跳转到App团宝箱</a></p>
        <p>
            <a href="ToAppCashRedPacket">跳转到App现金红包</a></p>
        <p>
            <a href="ToAppInvestRedPacket">跳转到App投资红包</a></p>
        <p>
            <a href="ToAppInvestCash">跳转到App投资体验金</a></p>
        <p>
            <a href="ToAppWithdrawalRoll">跳转到App提现劵</a></p>
        <p>
            <a href="ToAppPresent">跳转到App精美礼品</a></p>
        <p>
            <a href="ToAppPersonalCenter">跳转到App个人中心</a></p>
        <p>
            <a href="ToAppInviteFriend">跳转到App邀请有礼</a></p>
        <p>
            <a href="ToActivityAppInviteFriend">跳转到App1218活动邀请</a></p>
        <%}%>
    </div>
    </form>
</body>
</html>
