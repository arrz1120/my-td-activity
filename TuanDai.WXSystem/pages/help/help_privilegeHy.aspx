﻿<%@ Page Title="" Language="C#" MasterPageFile="~/pages/help/HelpMaster.Master" AutoEventWireup="true" CodeBehind="help_privilegeHy.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.help.help_privilegeHy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>超级会员</title> 
<link rel="stylesheet" type="text/css" href="/css/aboutus.css?v=20150812" /><!--关于我们-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server"> 
<section class="aboutBox ">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>1.如何成为超级会员？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">登录个人账户，点击头像右侧箭头进入“详细资料”，点击“升级会员”，需要购买一个月的超级会员，请选择月付30元；需要购买半年的超级会员，选择半年付150；需要购买一年的超级会员，选择年付288元 。</p>
  </div>
</section>
<section class="aboutBox ">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>2.积分是怎么获得的？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">目前团贷网的积分只能通过超级会员兑换，一个月超级会员兑换100积分。 </p>
  </div>
</section>
<section class="aboutBox ">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>3.超级会员时效多长？</div>
  <div class="aboutCont">
    <p class="text text_answer">(1) 超级会员根据购买费用不同，期限时间也不同，具体为：30元/月，150元/半年，288元/年；</p>
    <p class="text text_answer">(2) 积分兑换，具体标准为：100积分/月，600积分/半年，1200积分/年；</p>
  </div>
</section>
<section class="aboutBox last">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>4.投标时是超级会员，超级会员到期后，该标还能享有超级会员的服务吗？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">如您在投标时会员状态为超级会员，则在您投的这个标存续期间，您在这个标上都享受超级会员待遇，包括逾期保利，优先赔付等。即使您的超级会员已经到期，您依旧可以享受如上的超级会员待遇（提现优惠除外）。当然，如您在投标时的状态为普通会员，您无法享受超级会员的待遇。 </p>
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
