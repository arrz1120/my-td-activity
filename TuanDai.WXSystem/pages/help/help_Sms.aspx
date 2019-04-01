<%@ Page Title="" Language="C#" MasterPageFile="~/pages/help/HelpMaster.Master" AutoEventWireup="true" CodeBehind="help_Sms.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.help.help_Sms" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<title>短信通知</title> 
<link rel="stylesheet" type="text/css" href="/css/aboutus.css?v=20150812" /><!--关于我们-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <section class="aboutBox">
  <a href="help_SmsSz.aspx"><div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>1.短信设置</div></a>
</section>
<section class="aboutBox last">
  <a href="help_SmsYc.aspx"><div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>2.接收异常</div></a>
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
