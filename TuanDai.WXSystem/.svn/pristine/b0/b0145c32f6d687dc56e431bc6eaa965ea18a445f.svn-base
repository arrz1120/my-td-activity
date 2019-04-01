<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ValidateMobile.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.ValidateMobile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>绑定手机 - 我的账户</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
    <link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->
    
</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">绑定手机</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
    </header>
    <section class="bg-bdtopBom1-d1d1d1 pd10 mt20 clearfix">
        <div class="phoneCode bindingPhone pr0">
            <div class="c-left">手机号码</div>
            <input type="text" id="txtMobileTelNo" maxlength="11"  onKeyUp="value=value.replace(/\D/g,'')" onafterpaste="value=value.replace(/\D/g,'')" class="codeIpt" placeholder="请输入手机号码">
        </div>
    </section>
    <span class="verification-3" style="color: red; margin-left:30px;" id="MobileTelNoErr"></span>
    <section class="bg-bdtopBom1-d1d1d1 pd10 mt20 clearfix">
        <div class="phoneCode bindingPhone">
            <div class="c-left">验证码</div>
            <input type="text" id="txtShortMsgCode" maxlength="6" onKeyUp="value=value.replace(/\D/g,'')" onafterpaste="value=value.replace(/\D/g,'')" class="codeIpt" placeholder="请输入验证码">
            <a id="btnSendMobileCode" class="btncode" href="javascript:void(0);">发送验证码</a>
            <span style="font-size: 12px; color:Red; float:right; position:absolute; top: 7px; right:5px;" id="Span2" class="spTip"></span>
        </div>
    </section>
    <span class="verification-3" style="color: red; margin-left:30px;" id="MsgCodeErr"></span>
    <section class="pd15 mt5">
      <a href="javascript:void(0)" id="btnSubmit" class="btn btnYellow">确定</a>
    </section>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript"  src="/scripts/ValidateMobile.js?v=20150728"></script>
    <script type="text/javascript" src="/scripts/base.js?v=1"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions_code.js"></script>
</body>
</html>
