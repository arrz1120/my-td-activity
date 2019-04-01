<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="safety.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.safety" %>
<%@ Import Namespace="System.Web.Services.Description" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>安全中心 - 我的账户</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/safety.css?v=20150908001" />
    <!--安全中心-->
</head>
<body class="bg-f1f3f5">
    <%= this.GetNavStr()%>
    <header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:window.location.href='/Member/my_userdetailinfo.aspx';">返回</div>
        <h1 class="title">安全中心</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
    </header>
    <!--身份未验证状态-->
    <%
        if (!userModel.IsValidateIdentity)
        {%>
    <a href="ValidateIdentity.aspx" target="_self" class="safety-link pos-r block">
        <section class="safetyBox clearfix">
            <div class="lf c-212121 f14px lh22"><i class="icoBox17 ico-ex"></i>身份验证</div>
            <div class="rf f14px c-ababab lh22">未验证</div>
        </section>
        <i class="ico-arrow-r"></i>
    </a>
    <%}
    %>
    <!--身份未验证状态结束-->
    <!--身份验证通过状态-->
    <%
        if (userModel.IsValidateIdentity)
        {%>
    <a class="safety-link pos-r block">
        <section class="safetyBox clearfix">
        <span class="lf lh22 f14px c-212121"><i class="icoBox17 ico-suc-ro"></i>身份验证</span>
        <span class="lf f12px lh22 c-ababab ml10"><%=BusinessDll.StringHandler.MaskCardHolder(userModel.RealName)%>（<%=BusinessDll.StringHandler.MaskCardNo(userModel.IdentityCard)%>）</span>
    </section>
    </a>
    <div class="f12px lh20 pl15 c-ababab mt5 clearfix">身份证不允许修改、更换或注销</div>
    <%}
    %>
    <!--身份验证通过状态结束-->

    <!--手机未验证状态-->
    <%
        if (!userModel.IsValidateMobile)
        {%>
    <a href="ValidateMobile.aspx" target="_self" class="block pos-r safety-link">
        <section class="safetyBox clearfix">
            <div class="lf c-212121 f14px lh22"><i class="icoBox17 ico-ex"></i>手机验证</div>
            <div class="rf f14px c-ababab lh22">未验证</div>
        </section>
        <i class="ico-arrow-r"></i>
    </a>
    <%}
    %>
    <!--手机未验证状态结束-->
    <!--手机验证通过状态-->
    <%
        if (userModel.IsValidateMobile)
        {%>
    <section class="safetyBox bg-bdtopBom1-d1d1d1 clearfix">
        <div class="clearfix">
            <span class="lf lh22 f14px c-212121"><i class="icoBox17 ico-suc-ro"></i>手机验证</span>
            <span class="lf f12px lh22 c-ababab ml10"><%=BusinessDll.StringHandler.MaskTelNo(userModel.TelNo)%></span>
        </div>
    </section>
    <%}
    %>
    <!--手机验证通过状态结束-->
    <!--交易密码未验证状态-->
    <%
        if (IsTenderNeedPayPassword == false)
        {%>
    <a href="javascript:checkCgtCommGoUrl('trade_password.aspx')" target="_self" class="safety-link block pos-r">
        <section class="safetyBox clearfix">
            <div class="lf c-212121 f14px lh22"><i class="icoBox17 ico-ex"></i>交易密码</div>
            <div class="rf f14px c-ababab lh22">未开启</div>
        </section>
        <i class="ico-arrow-r"></i>
    </a>
    <%}
        else
        {%>
    <a href="javascript:checkCgtCommGoUrl('trade_password.aspx')" target="_self" class="safety-link block pos-r">
        <section class="safetyBox clearfix">
            <span class="lf lh22 f14px c-212121"><i class="icoBox17 ico-suc-ro"></i>交易密码</span>
            <span class="rf f12px lh22 c-ababab ml10">已设置</span>
        </section>
        <i class="ico-arrow-r"></i>
    </a>
    <%}
    %>
    <!--交易密码已设置状态-->

    <!--交易密码已设置状态结束-->
    <!--银行卡未验证状态-->
    <%
        if (string.IsNullOrWhiteSpace(BankAccountNo))
        {
            if (GlobalUtils.IsOpenCGT)
            {
    %>
    <a href="javascript:checkCgtCommGoUrl('/member/cgt/cgtBindCard.aspx')" target="_self" class="safety-link block pos-r">
        <section class="safetyBox clearfix">
            <div class="lf c-212121 f14px lh22"><i class="icoBox17 ico-ex"></i>银行卡</div>
            <div class="rf f14px c-ababab lh22">未验证</div>
        </section>
        <i class="ico-arrow-r"></i>
    </a>
    <%
            }
            else
            {
    %>
    <a href="/Member/Bank/recharge_bindCardagreement.html?v=<%=GlobalUtils.Version %>" target="_self" class="safety-link block pos-r">
        <section class="safetyBox clearfix">
            <div class="lf c-212121 f14px lh22"><i class="icoBox17 ico-ex"></i>银行卡</div>
            <div class="rf f14px c-ababab lh22">未验证</div>
        </section>
        <i class="ico-arrow-r"></i>
    </a>
    <%
            }
        }
        else
        {%>
    <section class="safetyBox bg-bdtopBom1-d1d1d1 clearfix">
         <span class="lf lh22 f14px c-212121"><i class="icoBox17 ico-suc-ro"></i>银行卡</span>
         <span class="lf f12px lh22 c-ababab ml10"><%=BusinessDll.StringHandler.MaskBankNo(BankAccountNo)%></span>
    </section>
    <div class="f12px lh20 pl15 c-ababab mt5 clearfix">如需改绑，请登录团贷PC端查看详细的改绑流程。</div>
    <%}
    %>
    <!--银行卡未验证状态结束-->
    <!--未验证状态 E-->


    <!--修改登录密码，暂时注释-->
    <a href="reset_LoginPassword.aspx" target="_self" class="safety-link block pos-r">
        <section class="safetyBox clearfix">
            <span class="lf lh22 f14px c-212121"><i class="icoBox17 ico-suc-ro"></i>登录密码</span>
            <span class="rf f12px lh22 c-ababab ml10">点击修改</span>
        </section>
        <i class="ico-arrow-r"></i>
    </a>

    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=1"></script>
    <script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
</body>
</html>
