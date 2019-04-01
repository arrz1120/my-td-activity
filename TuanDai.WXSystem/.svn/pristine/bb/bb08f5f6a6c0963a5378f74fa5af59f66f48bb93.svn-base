<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AuthorizeSuccess.aspx.cs" Inherits="TuanDai.WXApiWeb.user.ThirdLogin.AuthorizeSuccess" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>第三方登录</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base--> 
<link rel="stylesheet" type="text/css" href="/css/account.css?v=2015090701" /><!--账户中心--> 
</head>
<body>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">第三方登录</h1>
    </div>
    <div class="none"></div>
</header>
<section class="pl15 pr15 mt30 clearfix">
      <i class="ico-succeed-big"></i>
       <div class="f18px c-212121 text-center mt30 clearfix">授权成功！</div> 
</section> 
<section class="loginseltitle mt30 way text-center"><span class="c-ababab f14px">您可以选择</span></section>

<section class="pl15 pr15 clearfix">
  <div class="mt30"> 
     <a href="/user/ThirdLogin/BindLogin.aspx?ReturnUrl=<%=returnUrl%>&code=<%=code%>" class="btn btnYellow">绑定已有账号</a>
  </div>    
   <div class="mt20">  
      <a href="/user/ThirdLogin/GotoLogin.aspx?ReturnUrl=<%=returnUrl%>&code=<%=code%>" class="btn btnWhite c-fac502">立即进入团贷网</a>
   </div>
</section>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20150623"></script> 
</body>
</html>