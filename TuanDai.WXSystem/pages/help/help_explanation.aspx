<%@ Page Title="" Language="C#" MasterPageFile="~/pages/help/HelpMaster.Master" AutoEventWireup="true" CodeBehind="help_explanation.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.help.help_explanation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>名词解释</title> 
<link rel="stylesheet" type="text/css" href="/css/aboutus.css?v=20150812" /><!--关于我们-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <section class="aboutBox ">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>1.什么是现金金额？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0"> 可用现金金额是指可以用来直接提现或用来投资的金额。 </p>
  </div>
</section>
<section class="aboutBox ">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>2.什么是奖金余额？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0"> 奖金余额是指参与团贷网各种活动获得的奖金，奖金余额只能先用于投资，不能直接提现的金额，奖金余额只有在投资回款以后才能提现使用。 </p>
  </div>
</section>
<section class="aboutBox ">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>3.什么是待收本息金额？</div>
  <div class="aboutCont">
 <p class="text text_answer ti0"> 待收本息金额是指用户在团贷网已经投资借出，目前尚未回收的本金和利息的总额。 </p>
  </div>
</section>
<section class="aboutBox">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>4.什么是待确认投标？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0"> 待确认投标是指已经投标，但目前尚未满标的投资金额。 </p>
   </div>
</section>
<section class="aboutBox last">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>4.什么是待确认提现？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0"> 待确认提现是指团贷网用户正在申请提现中的金额。</p>
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