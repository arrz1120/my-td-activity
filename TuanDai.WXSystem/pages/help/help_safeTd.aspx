<%@ Page Title="" Language="C#" MasterPageFile="~/pages/help/HelpMaster.Master" AutoEventWireup="true" CodeBehind="help_safeTd.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.help.help_safeTd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>团贷网安全保障</title> 
<link rel="stylesheet" type="text/css" href="/css/aboutus.css?v=20150812" /><!--关于我们-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <section class="aboutBox">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>1.我在团贷网投资有哪些保障？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">在团贷网投资，可享受五“心”级保障，让您的投资享有强有力的保障： </p>
    <p class="text text_answer ti0">(1) 平台资金第三方托管； </p>
    <p class="text text_answer ti0">(2) 多层次业务架构保障； </p>
    <p class="text text_answer ti0">(3) 第三方担保机构保障； 	</p>
    <p class="text text_answer ti0">(4) 专业的风控团队保障； </p>
    <p class="text text_answer ti0">(5) 三千万应急基金。 </p>
    <p class="text text_answer ti0">除此团贷网会员可以享受保障本金，团贷网超级会员享受安全保障的服务 </p> 
  </div>
</section>
<section class="aboutBox">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>2.什么是第三方资金托管？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">团贷网平台借贷完全托管第三方支付机构腾讯财付通，在团贷网上的所有投资和借贷资金流动不经过团贷网的银行账户，这一举措更符合P2P的借贷理念以及避免因平台资金与交易双方资金交叉所带来的困扰。 </p>
  </div>
</section>
<section class="aboutBox">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>3.担保公司担保的额度是多少？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">目前团贷网平台的合作担保公司有9家，不同的担保公司担保的项目也是不同的。一般来说担保公司的担保总额度是不超过注册资金的10倍。为了保障项目的安全，团贷网平台单笔借款金额都是在500万以内，且会根据不同的项目和担保公司的整体运营情况的选择不同的担保方，所以投资用户完全可以不用担心担保公司担保额度的问题。</p>
  </div>
</section>
<%--<section class="aboutBox last">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>4.什么是应急基金？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">团贷网为保障平台投资用户的资金不受借贷者逾期或者其他突发事件的影响，为给用户提供强有力的资金保障体系，团贷网于2013年12月正式成立团贷网应急基金，并保证基金账户日常额度不低于三千万人民币。</p>
  </div>
</section>--%>
<section class="aboutBox">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>4.什么是第三方担保？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">为了保证借款人按时还款、投资人获取收益有保障，团贷网积极与具有资质实力雄厚的第三方担保机构合作，提供稳定可靠的资金保障。目前，与团贷网的合作担保机构已经达到10家左右。</p>
  </div>
</section>
<section class="aboutBox last">
  <div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>5.什么是“质量保障服务”？</div>
  <div class="aboutCont">
    <p class="text text_answer ti0">“质量保障服务”是团贷网为保障用户资金安全而特别设立的风险拨备制度。该计划资金主要由团贷网合作的第三方担保方拨付设立，并于银行开设第三方账户，在借款项目出现逾期或坏账的情况下，系统自动执行垫付。</p>
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