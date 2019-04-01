<%@ Page Title="" Language="C#" MasterPageFile="~/pages/help/HelpMaster.Master" AutoEventWireup="true" CodeBehind="help_SmsSz.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.help.help_SmsSz" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <title>短信设置</title> 
<link rel="stylesheet" type="text/css" href="/css/aboutus.css?v=20150812" /><!--关于我们-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <section class="aboutBox">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>1.开启短信服务收费吗？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">开通团贷网短信通知服务，是不用收取用户短信服务费的，请放心开通。 </p>
  </div>
</section>
<section class="aboutBox last">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>2.如何取消团贷网的邮件和站内信的提醒？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">目前只能登录团贷网PC端，进入个人中心后，在个人资料的提醒设置去开启或关闭。 </p>
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
