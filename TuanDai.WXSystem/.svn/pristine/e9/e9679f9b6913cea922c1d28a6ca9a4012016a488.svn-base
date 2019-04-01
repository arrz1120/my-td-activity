<%@ Page Title="" Language="C#" MasterPageFile="~/pages/help/HelpMasterNew.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.help.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <title>帮助中心</title>
<link rel="stylesheet" href="/css/index.css?v=20160224">
<style type="text/css">
	.help_link ul li i{display: inline-block;width: 7px;height: 9px;background: url(/imgs/images/ico-triangle-r.png) no-repeat;background-size: 100% 100%;margin-right: 15px;vertical-align: 3px;transition: transform 0.2s linear;}
	.help_link ul li i.icon-round{width: 7px;height: 7px;background: url(/imgs/images/yuan_gray.png) no-repeat;background-size: 100% 100%;margin-right: 15px;vertical-align: 3px;}
	.help_link ul li .arrow-right{width: 7px;height: 13px;background: url(/imgs/images/ico_arrow_r3.png) no-repeat;background-size: 100% 100%;position: absolute;right: 15px;top: 23px;}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    <section  class="pl10 f13px c-212121 bb-d1d1d1 bg-fbfbf9 pt5 pb5">新手指南</section>
<section class="weixin-nav help-nav">
        <div class="nav-cn">
            <a href="help_login.aspx">
                <img src="/imgs/images/ico-n1.png">
                <p class="f12px">注册登录</p>
            </a>
            
            <a href="help_certification.aspx">
                <img src="/imgs/images/ico-n20.png">
                <p class="f12px">实名认证</p>
            </a>
            <a href="help_topup.aspx">
                <img src="/imgs/images/ico-n19.png">
                <p class="f12px">充值</p>
            </a>
        </div>
        <div class="nav-cn">
            <a href="help_investment.aspx">
                <img src="/imgs/images/ico-n11.png">
                <p class="f12px">投资</p>
            </a>
            <a href="help_receivable.aspx">
                <img src="/imgs/images/ico-n12.png">
                <p class="f12px">回款</p>
            </a>
            <a href="help_withdrawal.aspx">
                <img src="/imgs/images/ico-n13.png">
                <p class="f12px">提现</p>
            </a>
        </div>
</section>
<section  class=" pl10 f13px c-212121 bt-d1d1d1 bb-d1d1d1 bg-fbfbf9 pt5 pb5">热门问题</section>
    <div class="help_link bg-fff">
	<ul>
		<li>
			<a href="help_undertd.aspx">
				<div class="pd15 bb-e6e6e6">
					<p class="c-212121 fb f17px"><i class="icon-round rotateZ0"></i>了解团贷网</p>
					<div class="arrow-right"></div>
				</div>
			</a>
			<a href="help_members.aspx">
				<div class="pd15 bb-e6e6e6">
					<p class="c-212121 fb f17px"><i class="icon-round rotateZ0"></i>团贷网会员</p>
					<div class="arrow-right"></div>
				</div>
			</a>
			<a href="help_activity.aspx">
				<div class="pd15 bb-e6e6e6">
					<p class="c-212121 fb f17px"><i class="icon-round rotateZ0"></i>团贷网活动</p>
					<div class="arrow-right"></div>
				</div>
			</a>
			<a href="help_borrowing.aspx">
				<div class="pd15 bb-e6e6e6">
					<p class="c-212121 fb f17px"><i class="icon-round rotateZ0"></i>我要借款</p>
					<div class="arrow-right"></div>
				</div>
			</a>
			<a href="help_Sms.aspx">
				<div class="pd15 bb-e6e6e6">
					<p class="c-212121 fb f17px"><i class="icon-round rotateZ0"></i>短信通知</p>
					<div class="arrow-right"></div>
				</div>
			</a>
			<a href="help_explanation.aspx">
				<div class="pd15 bb-d1d1d1">
					<p class="c-212121 fb f17px"><i class="icon-round rotateZ0"></i>名词解释</p>
					<div class="arrow-right"></div>
				</div>
			</a>
		</li>
		<div class="pt15 bg-fbfbf9"></div>
	</ul>
</div>
<%--<section class="aboutBox">
  <a href="help_undertd.aspx"><div class="aboutTit"><b></b>了解团贷网</div></a>
</section>
<section class="aboutBox">
  <a href="help_members.aspx"><div class="aboutTit"><b></b>团贷网会员</div></a>
</section>
<section class="aboutBox">
  <a href="help_activity.aspx"><div class="aboutTit"><b></b>团贷网活动</div></a>
</section>
<section class="aboutBox">
  <a href="help_borrowing.aspx"><div class="aboutTit"><b></b>我要借款</div></a>
</section>
<section class="aboutBox">
  <a href="help_Sms.aspx"><div class="aboutTit"><b></b>短信通知</div></a>
</section>
<section class="aboutBox last">
  <a href="help_explanation.aspx"><div class="aboutTit"><b></b>名词解释</div></a>
</section>--%>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="foot" runat="server">
    <script type="text/javascript" src="/scripts/jquery.flexslider.js"></script>
    <script type="text/javascript">
        $(function () {
            //banner滑动
            $('#bannerSlider').flexslider({
                animation: "slide",
                directionNav: false
            });

            //    //公告滚动显示
            setInterval('AutoScroll("#scrollDiv")', 5000)
        });


        function AutoScroll(obj) {
            $(obj).find("ul:first").animate({
                marginTop: "-30px"
            }, 500, function () {
                $(this).css({ marginTop: "0px" }).find("li:first").appendTo(this);
            });
        }


        //ios6以下加载后隐藏地址栏
        window.onload = function () {
            if (document.documentElement.scrollHeight <= document.documentElement.clientHeight) {
                bodyTag = document.getElementsByTagName('body')[0];
                bodyTag.style.height = document.documentElement.clientWidth / screen.width * screen.height + 'px';
            }
            setTimeout(function () {
                window.scrollTo(0, 1)
            }, 0);
        }; 
</script>
</asp:Content>
