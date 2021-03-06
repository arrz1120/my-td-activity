﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="zhaiquan_question.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.zhaiquan_question" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>常见问题</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/debt.css?v=20160223"/>
</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header bb-e6e6e6">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">常见问题</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>
<div class="questionWrap bg-fff">
		<ul>
			<li>
				<div class="question-tit bb-e6e6e6 pl15 pt13 pb13">
					<p class="c-212121 f17px"><i class="icon-triagle-r rotateZ90"></i>什么样的债权可以转让？</p>
				</div>
				<div class="question-txt bb-e6e6e6 bg-fbfbf9 pd15">
					<p class="c-808080 f15px text-justify">投资团贷网项目借款和微团贷并持有债权超过3个月即可进行转让。债权转让发布还受平台其他产品状态的限制，以下状态下不允许转让债权：</p>
					<p class="c-808080 f15px text-justify">A.发债权转让时，该转让标处于逾期状态时不允许转让，若转让时没有处于逾期，但在转让中时债权变为逾期状态，系统将会把债权停止转让。</p>
					<p class="c-808080 f15px text-justify">B.单个债权能分拆进行债权转让，但是不能同时分拆成多笔转让。</p>
				</div>
			</li>
			<li>
				<div class="question-tit bb-e6e6e6 pl15 pt13 pb13">
					<p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>转让的债权标的有效期多久？</p>
				</div>
				<div class="question-txt bb-e6e6e6 bg-fbfbf9 pd15 hide">
					<p class="c-808080 f15px text-justify">债权标的一个自然日内有效，当天24:00时前未成功转让部分，会由系统自动下线。</p>
					<p class="c-808080 f15px text-justify">案例：A君2月2日上午10点时发布债权转让标的，若2月2日24点前有部分债权未转让成功，则24点时系统会自动下线该标的。</p>
				</div>
			</li>
			<li>
				<div class="question-tit bb-e6e6e6 pl15 pt13 pb13">
					<p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>购买的债权还可以再次转让吗？</p>
				</div>
				<div class="question-txt bb-e6e6e6 bg-fbfbf9 pd15 hide">
					<p class="c-808080 f15px text-justify">可以，购买债权并持有债权超过3个月即可进行再次转让。</p>
				</div>
			</li>
			<li>
				<div class="question-tit bb-e6e6e6 pl15 pt13 pb13">
					<p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>名词解释：</p>
				</div>
				<div class="question-txt bb-e6e6e6 bg-fbfbf9 pd15 hide">
					<p class="c-212121 f15px">本金折让价格</p>
					<p class="c-808080 f15px pt15 text-justify">即债权转让时，本金进行折让后的价格。折让系数为0.98-1.0，支持两位小数，即允许降价或原价转让，不允许提高价格转让。</p>
					<p class="c-212121 pt15 f15px">未结算利息</p>
					<p class="c-ffcf1f f15px pt15 text-justify">未结算利息=未结算时间(天)  x  转让的本金  x  </p>
					<p class="c-ffcf1f f15px pt10 pl85 text-justify">原始年化利率/365</p>
					<p class="c-808080 f15px pt15 text-justify">不同回款方式的未结算时间不一样。</p>
					<p class="c-212121 f15px pt15 text-justify">A.到期本息的算法:</p>
					<p class="c-808080 f15px pt15 pl15 text-justify">到期付息的未结算时间为转让当天距离上次回款的天数</p>
					<p class="c-212121 f15px pt15 text-justify">B.每月付息的算法:</p>
					<p class="c-808080 f15px pt15 pl15 text-justify">每月付息的未结算时间为转让当天距离上次回款的天数</p>
				</div>
			</li>
			<li>
				<div class="question-tit bb-e6e6e6 pl15 pt13 pb13">
					<p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>债权转让保障方式怎么样?</p>
				</div>
				<div class="question-txt bb-e6e6e6 bg-fbfbf9 pd15 hide">
					<p class="c-808080 f15px">债权转让适用于安全保障体系，此外债权转让的标的其他担保保障等与原项目完全相同。</p>
				</div>
			</li>
			<li>
				<div class="question-tit bb-e6e6e6 pl15 pt13 pb13">
					<p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>债权转让的年化利率怎么计算？</p>
				</div>
				<div class="question-txt bb-e6e6e6 bg-fbfbf9 pd15 hide">
					<p class="c-ffcf1f f15px">[待收收益+(本金-本金折让后价格)]/（未结算利息+本金折让后价格)/剩余天数*365*100%；</p>
					<p class="c-808080 pt15 f15px">案例：A君投资了一个期限为6个月，年化利率为20%，还款方式为到期本息的标的1000元，持有173天后进行债权转让。此时，剩余的期限是11天，转让时选择原价全额转让，则此时的年化利率计算如下：</p>
					<p class="c-808080 pt15 f15px">(1000元*11天/365天x 20%+0)/(1000 x173天/365天x 20%+1000)/11天x 365天x 100%=18.26%</p>
					<p class="c-ababab pt15 f15px">（具体年化率利率与小数点精确的位数有关，有可能显示上稍有误差）</p>
				</div>
			</li>
			<li>
				<div class="question-tit pl15 clearfix pb13 pt13" style="">
					<i class="icon-triagle-r rotateZ0 lf mt6"></i>
					<p class="c-212121 f17px pl20">为什么转让出来的利率有时候比原项目少，有时候比原项目多？</p>
				</div>
				<div class="question-txt bt-e6e6e6 bg-fbfbf9 pd15 hide">
					<p class="c-808080 f15px">因为承接者承接时所支付的本金是含有先垫付利息部分，所以若债权转让者原价转让时，理论上承接者的利率是低于原有利率的。实际上，承接者所垫付的利息在下一期就会原价归还，所以实际年化利率是与原项目一样的。此外，若债权转让者以低于原价的价格转让时，承接者的利率就会高于原有项目的利率。</p>
				</div>
			</li>
			<li>
				<div class="question-tit bt-e6e6e6 bb-e6e6e6 pl15 pt13 pb13">
					<p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>债权转让服务费怎么收取？</p>
				</div>
				<div class="question-txt bb-e6e6e6 bg-fbfbf9 pd15 hide">
					<p class="c-808080 f15px">债权转让服务费=转让总额*0.7%，该服务费每成功交易笔则即时收取，债权转让服务费由发起人支付。</p>
				</div>
			</li>
			<li>
				<div class="question-tit bb-e6e6e6 pl15 pt13 pb13">
					<p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>在哪个地方可以操作债权转让？</p>
				</div>
				<div class="question-txt bb-e6e6e6 bg-fbfbf9 pd15 hide">
					<p class="c-808080 f15px">可在我的账号-投资记录-债权转让列表中操作债权转让。</p>
				</div>
			</li>
            <li>
				<div class="question-tit bb-e6e6e6 pl15 pt13 pb13">
					<p class="c-212121 f17px"><i class="icon-triagle-r rotateZ0"></i>承接债权转让标有什么规则吗？</p>
				</div>
				<div class="question-txt bb-e6e6e6 bg-fbfbf9 pd15 hide">
					<p class="c-808080 f15px">用户第一次承接单个转让标时，需要校验短信验证码才能完成承接；短信验证码校验成功后，如再次承接该转让标时无需校验短信验证码即可完成承接。每个账号承接债权转让标时每天最多可获取8条短信验证码；短信验证码60s内不支持重发。</p>
				</div>
			</li>
		</ul>
	</div>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/iscroll.js"></script>
<script type="text/javascript" src="/scripts/base.js"></script>
<script type="text/javascript">
  	$(function () {

  	    $(".questionWrap").find('li').click(function() {
  	        var box = $(this).find('.question-txt');
  	        var ico = $(this).find('.icon-triagle-r');
  	        if (box.hasClass('hide')) {
  	            if (ico.hasClass('rotateZ90')) {
  	                ico.removeClass('rotateZ90').addClass('rotateZ0');
  	            } else {
  	                ico.removeClass('rotateZ0').addClass('rotateZ90');
  	            }
  	            box.removeClass('hide');
  	        } else {
  	            if (ico.hasClass('rotateZ90')) {
  	                ico.removeClass('rotateZ90').addClass('rotateZ0');
  	            } else {
  	                ico.removeClass('rotateZ0').addClass('rotateZ90');
  	            }
  	            box.addClass('hide');
  	        }
  	    });
  	});
</script>
</body>
</html>

