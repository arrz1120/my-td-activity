<%@ Page Title="" Language="C#" MasterPageFile="~/pages/help/HelpMaster.Master" AutoEventWireup="true" CodeBehind="help_activityCy.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.help.help_activityCy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <title>活动参与</title> 
<link rel="stylesheet" type="text/css" href="/css/aboutus.css?v=20150812" /><!--关于我们-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
<section class="aboutBox last">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>1.如何参加团贷网的活动？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">为了回馈团贷网用户们的支持，团贷网目前有两种活动形式：</p>
    <p class="text text_answer">(1) 常规活动：如“登录手机APP，签到送会员”和“邀请好友注册送现金”等活动，该类活动在平台均有常规入口。</p>
    <p class="text text_answer">(2) 节假日活动：指的是团贷网在节假日发布的有奖活动，该类活动参与方式与活动内容，请关注团贷网的活动通知。</p>
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
