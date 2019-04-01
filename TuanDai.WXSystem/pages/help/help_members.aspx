<%@ Page Title="" Language="C#" MasterPageFile="~/pages/help/HelpMaster.Master" AutoEventWireup="true" CodeBehind="help_members.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.help.help_members" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>团贷网会员</title> 
<link rel="stylesheet" type="text/css" href="/css/aboutus.css?v=20150812" /><!--关于我们-->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <section class="aboutBox">
  <a href="help_ordinaryHy.aspx"><div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>1.普通会员？</div></a>
</section>
<section class="aboutBox last">
  <a href="help_privilegeHy.aspx"><div class="aboutTit aboutTit_nonebg aboutTit_r"><b></b>2.超级会员？</div></a>
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