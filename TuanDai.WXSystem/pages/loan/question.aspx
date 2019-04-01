<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="question.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.loan.question" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>常见问题</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=20160224" />
</head>
<style type="text/css">
.rotateZ0{-webkit-transform: rotateZ(0);}
.rotateZ90{-webkit-transform: rotateZ(90deg);}
.questionWrap ul li:last-child{border-bottom: 0;}
.questionWrap ul li i{display: inline-block;width: 7px;height: 9px;background: url(/imgs/images/ico-triangle-r.png) no-repeat;background-size: 100% 100%;margin-right: 15px;vertical-align: 3px;transition: transform 0.2s linear;}
.questionWrap ul li i.icon-round{width: 7px;height: 7px;background: url(/imgs/images/yuan_gray.png) no-repeat;background-size: 100% 100%;margin-right: 15px;vertical-align: 3px;}
.questionWrap ul li .arrow-right{width: 7px;height: 13px;background: url(/imgs/images/ico_arrow_r3.png) no-repeat;background-size: 100% 100%;position: absolute;right: 15px;top: 23px;}
</style>
<body class="bg-f6f7f8">
<%= GetNavStr() %>
	<header class="headerMain">
	  <div class="header bb-e6e6e6">
	    <div class="back" onClick="javascript:question-txt bb-e6e6e6.go(-1);">返回</div>
	    <h1 class="title">常见问题</h1>
	  </div>
	  <div class="none"></div>
	</header>
	
	<div class="questionWrap bg-fff">
		<ul>
			<li>
				<div class="question-tit bb-e6e6e6 pl15 pt18 pb18">
					<p class="c-212121 f17px"><i class="icon-triagle-r rotateZ90"></i>什么时候可以提前还款？</p>
				</div>
				<div class="question-txt bb-e6e6e6 bg-f6f7f8 pd15">
					<p class="c-808080 f15px text-justify">借款期限1个月以内(含一个月)的借款，需持有14天以上才可以提前还款；借款期限1个月以上的借款，可随时提前还款。</p>
				</div>
			</li>
			<li>
				<div class="question-tit bb-e6e6e6 pl15 pt18 pb18">
					<p class="c-212121 f17px"><i class="icon-triagle-r rotateZ90"></i>提前还款要还多少钱？</p>
				</div>
				<div class="question-txt bg-f6f7f8 pd15">
					<p class="c-808080 f15px text-justify">1、剩余期限≤1个月时，提前还款将支付（本金+当期所有利息）；</p>
					<p class="c-808080 f15px text-justify">2、剩余期限＞1个月时提前还款将支付（本金+当期已经产生的借款利息+1个月利息的罚息）。</p>
				</div>
			</li>
		</ul>
	</div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script> 
<script type="text/javascript">
  	$(function () {
	   	
	   	$(".questionWrap").find('li').click(function(){
			var box = $(this).find('.question-txt');
			var ico = $(this).find('.icon-triagle-r');
			if(box.hasClass('hide')){
				if(ico.hasClass('rotateZ90')){
					ico.removeClass('rotateZ90').addClass('rotateZ0');
				}else{
					ico.removeClass('rotateZ0').addClass('rotateZ90');
				}
				box.removeClass('hide');
			}else{
				if(ico.hasClass('rotateZ90')){
					ico.removeClass('rotateZ90').addClass('rotateZ0');
				}else{
					ico.removeClass('rotateZ0').addClass('rotateZ90');
				}
				box.addClass('hide');
			}
		})
    });
</script>
</body>
</html>
