<%@ Page Title="" Language="C#" MasterPageFile="~/pages/help/HelpMaster.Master" AutoEventWireup="true" CodeBehind="help_SmsYc.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.help.help_SmsYc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <title>接收异常</title> 
<link rel="stylesheet" type="text/css" href="/css/aboutus.css?v=20150812" /><!--关于我们-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <section class="aboutBox ">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>1.注册收不到短信验证码怎么办？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0"> 如果您在注册团贷网的注册过程中，在规定时间内获取不到短信验证码，可采用以下方式获取：</p>
     <p class="text text_answer">(1) 点击“语音”获取短信验证码，点击过后会收到400来电，您只需接听来电，获取验证码，并输入验证码；</p>
      <p class="text text_answer">(2) 您也可以拨打客服热线4006-410-888寻求帮助。 </p>
  </div>
</section>
<section class="aboutBox last">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>2.开启短信通知服务但收不到短信怎么办？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0"> 您可以拨打客服热线4006-410-888寻求帮助。</p>
  </div>
</section>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
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
