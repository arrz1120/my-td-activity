<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="yesterdayIncome.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.yesterdayIncome" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>昨日预期收益</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
		<link rel="stylesheet" type="text/css" href="/css/account2.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	</head>
	<body class="bg-f2f2f0">
	    <%=GetNavStr() %>
		<div class="yesterdayIncome pb30 bb-e6e6e6">
			<p class="f17px c-a55200 text-center">昨日预期收益<i class="ico_doubt bgSize" id="incomeDetail"></i></p>
			<div class="amo text-center fb c-f96f00"><%=ToolStatus.ConvertLowerMoney(YesterdayIncome) %></div>
			<div class="yi_tit c-999999 f13px text-center pos-r">
				<span class="yi_tit_l"></span>
				<span class="yi_tit_r"></span>
				如何赚取更多收益
			</div>
			<div class="pr15 mt25">
				<div class="clearfix">
					<div class="pl15 lf w50p" onclick="JAVASCRIPT:window.location.href='https://hd.tuandai.com/weixin/Invite/InviteIndex.aspx';">
						<div class="yi_nav">
							<div class="ico_nav ico_nav1"></div>
							<p class="f14px">邀请有礼</p>
							<p class="c-ababab line-h20">多重好礼等你拿</p>
						</div>
					</div>
					<div class="pl15 lf w50p" onclick="JAVASCRIPT:window.location.href='https://m.tuandai.com/Activity/index.aspx';">
						<div class="yi_nav">
							<div class="ico_nav ico_nav2"></div>
							<p class="f14px">热门活动</p>
							<p class="c-ababab line-h20">更多惊喜留给你</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="mt10 pl15 pr15 pb10 bg-fff bt-e6e6e6">
			<div class="champion clearfix pt10 pb12">
				<div class="champion_img lf">
					<img src="<%=string.IsNullOrEmpty(ubi.HeadImage)?"/imgs/users/avatar/bav_head.gif?v=20160714":ubi.HeadImage %>"/>
					<div class="champion_bgImg bgSize"></div>
				</div>
				<div class="champion_txt lf pt6">
					<p class="f13px">来自<%=string.IsNullOrEmpty(ubi.BankProvice)?"广东省":ubi.BankProvice %>的团粉<span class="f13px c-fa7d00"><%=SubStringTelNo(ubi.TelNo) %></span></p>
					<p class="f13px mt3">待收收益<span class="f13px c-fa7d00"><%=ToolStatus.ConvertLowerMoney(sa.DueComeInterest) %></span>元</p>
				</div>
			</div>
			<p class="c-999999">该用户青睐的投资项目</p>
			<div class="yi_invest">
				<p><%=model.ProductName %></p>
				<div class="webkit-box yi_row">
					<div class="f15px c-f77b00"><%=GetYearRate(model.YearRate) %></div>
					<div class="f15px"><span class="f18px"><%=model.Deadline %></span><%=model.DeadType==1?"个月":"天" %></div>
					<a href="<%=model.DetailUrl %>" class="f15px c-ffffff text-center block">抢购</a>
				</div>
			</div>
		</div>
		
		<!--弹窗-->
		<div class="alert webkit-box box-center hide" id="alert">
			<div class="alert-select pl25 pr15 yi_alert pos-r">
				<div class="yi_alertTit c-999999 text-center f15px">昨日预期收益怎么计算？</div>
				<div class="yi_alertTxt pt15 pl10 pr20">
					<p class="f17px text-justify pt11 c-333333">1.昨日预期收益=所投每个标的待收益/投资期限（日为单位）+红包+合伙人收益+返现等（除充值、回款外的所有收益）</p>
					<p class="f17px text-justify pt11 c-333333">2.该预期收益数据仅供参考</p>
				</div>
				<div class="yi_close bgSize"></div>
			</div>
		</div>
		
		<script type="text/javascript" src="/scripts/jquery.min.js"></script>
		<script src="/scripts/fastclick.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
		<script type="text/javascript">
		    //禁止弹窗滑动
		    $(".alert").each(function(i, item) {
		        $(item).on('touchmove', function(e) {
		            e.preventDefault();
		        });
		    });

		    //动画显示弹框
		    function alertShow(eleId, alertId) {
		        var $alert = $(alertId);
		        $(eleId).click(function() {
		            $alert.removeClass('hide').removeClass('aniFadeOut').addClass('aniFadeIn');
		            $alert.find('.yi_alert').removeClass('aniHide').addClass('aniShow');
		        });
		    }

		    //动画隐藏弹框
		    function alertHide(alertObj) {
		        alertObj.removeClass('aniFadeIn').addClass('aniFadeOut');
		        alertObj.find('.yi_alert').removeClass('aniShow').addClass('aniHide');
		        setTimeout(function() {
		            alertObj.addClass('hide');
		        }, 400);
		    }

		    alertShow('#incomeDetail', '#alert');

		    $('.yi_close').click(function() {
		        alertHide($(this).parent().parent());
		    });
		</script>
	</body>
</html>
