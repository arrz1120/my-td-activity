﻿<%@ Page Title="" Language="C#" MasterPageFile="~/pages/help/HelpMaster.Master" AutoEventWireup="true" CodeBehind="help_certification.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.help.help_certification" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>实名认证</title> 
<link rel="stylesheet" type="text/css" href="/css/aboutus.css?v=20150812" /><!--关于我们-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <section class="aboutBox">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>1.为什么要进行实名认证？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">团贷网为保障用户账户资金和信息的安全，需所有投资者和借款人通过身份证绑定、手机绑定、银行卡绑定以及交易密码设置。每个实名认证环节均简单快捷，团贷网也在此声明严格保密用户信息。</p>
  </div>
</section>
<section class="aboutBox">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>2.如何进行实名认证？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">团贷网为保障用户的信息安全，设立了“实名认证体系”，总共包括“身份验证”、“手机验证”、“登录密码”、“银行卡认证”、“交易密码”五项。为了给团贷新用户提供更好的体验，在用户首次注册后，只需要根据一个认证的流程走，亦可完成安全中心的设置。当用户跳过这个引导流程时，以下操作可帮用户重新完成认证。</p>
    <p class="text text_answer">(1) 在首页点击“我的账户”→点击“安全中心”。</p>
    <p class="text text_answer">(2) 根据安全中心界面所示，点击“身份验证”→填写”真实姓名“→输入“身份证号”→输入“昵称”→点击”确定“即完成身份验证”。</p>
    <p class="text text_answer">(3) “手机验证”在你注册账号时填写的手机号就已经完成手机验证，如果你想修改手机号，请登录团贷网PC端的“安全中心”进行修改。</p>
    <p class="text text_answer">(4) “绑定银行卡”根据安全中心界面所示，找到“银行卡”→点击“增加一张银行卡”→按要求输入银行账号→输入开户用户名→输入开户银行网点→点击提交。</p>
    <p class="text text_answer">(5) “交易密码”根据认证中心界面所示，找到“交易密码”→点击“立即验证”出现如下图所示界面；点击“获取验证码”→输入获取到的手机验证码→设置交易密码→再次输入交易密码→点击“确定”；即交易密码设置成功。</p>
  </div>
</section>
<section class="aboutBox">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>3.如何更换认证的银行卡？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">更换已认证的银行卡，可在团贷网PC端或者下载APP进行操作。</p>
  </div>
</section>
<section class="aboutBox">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>4.身份证认证成功后，身份证号码可以更换吗？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">身份证认证成功后本人是不可以修改的，如果你需要修改请联系我们团贷网的在线客服，也可以拨打我们的客服热线：4006-410-888。</p>
  </div>
</section>
<section class="aboutBox">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>5.使用护照号、军官证号等是否可以认证？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">如果你有这方面的需求，请联系我们团贷网的在线客服，或者拨打我们的客服热线：4006-410-888提供咨询帮助。</p>
  </div>
</section>
<section class="aboutBox last">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>6.如何提高资金账户安全？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">在设置团贷网帐户登录及交易密码时，请不要使用与身份证证件号、邮箱登录密码或手机号码等常用号码作为您的密码，此类密码是平常所说的弱密码。请尽量使用“字母+符号+数字”组合相对复杂的密码方式，以加强保障你的账户资金安全程度。 </p>
  </div>
</section>



<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script> 
<script type="text/javascript">
    $(function () {
        $(".aboutTit").on("click", function () {
            if ($(this).parent(".aboutBox").hasClass("active")) {
                $(".aboutBox").removeClass("active");
            } else {
                $(".aboutBox").removeClass("active");
                $(this).parent(".aboutBox").addClass("active");
            }
        });

    });

</script>
</asp:Content> 
