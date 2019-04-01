﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bank_list.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.cgt.bank_list" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>支持银行列表</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/cunguan.css?v=<%=GlobalUtils.Version %>" />
</head>
<body class="bg-f1f3f5">

<div class="tips">
	<p>银行渠道可能随时调整支付限额，下表仅供参考，请以银行公告为准。</p>
</div>
<div class="pb15">
	<div class="bankList pl15 bg-fff">
		<ul>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/gongshang.png" class="gongshang" />
				<p class="f17px">中国工商银行</p>
				<p class="c-ababab line-h20">单日限额50,000元，单笔限额50,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/nongye.png" class="nongye" />
				<p class="f17px">中国农业银行</p>
				<p class="c-ababab line-h20">单日限额10,000元，单笔限额2,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/zhaoshang.png" class="zhaoshang" />
				<p class="f17px">招商银行</p>
				<p class="c-ababab line-h20">单日限额200,000元，单笔限额200,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/jianshe.png" class="jianshe" />
				<p class="f17px">建设银行</p>
				<p class="c-ababab line-h20">单日限额2000,000元，单笔限额200,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/zhongguo.png" class="zhongguo" />
				<p class="f17px">中国银行</p>
				<p class="c-ababab line-h20">单日无限额，单笔限额50,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/guangda.png" class="guangda" />
				<p class="f17px">光大银行</p>
				<p class="c-ababab line-h20">单日限额50,000元，单笔限额50,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/guangfa.png" class="guangfa" />
				<p class="f17px">广发银行</p>
				<p class="c-ababab line-h20">单日无限额，单笔无限额</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/pingan.png" class="pingan" />
				<p class="f17px">平安银行</p>
				<p class="c-ababab line-h20">单日限额100,000元，单笔限额50,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/zhongxin.png" class="zhongxin" />
				<p class="f17px">中信银行</p>
				<p class="c-ababab line-h20">单日限额5,000元，单笔限额5,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/xingye.png" class="zhongxin" />
				<p class="f17px">兴业银行</p>
				<p class="c-ababab line-h20">单日限额50,000元，单笔限额50,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/shanghai.png" class="shanghai" />
				<p class="f17px">上海银行</p>
				<p class="c-ababab line-h20">单日限额1,000,000元，单笔限额100,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/huaxia.png" class="huaxia" />
				<p class="f17px">华夏银行</p>
				<p class="c-ababab line-h20">单日限额2,000元，单笔限额1,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/pufa.png" class="pufa" />
				<p class="f17px">浦发银行</p>
				<p class="c-ababab line-h20">单日限额50,000元，单笔限额50,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/youzheng.png" class="youzheng" />
				<p class="f17px">邮政储蓄银行</p>
				<p class="c-ababab line-h20">单日限额5,000元，单笔限额5,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/jiaotong.png" class="jiaotong" />
				<p class="f17px">交通银行</p>
				<p class="c-ababab line-h20">单日限额100,000元，单笔限额10,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/xiamen.png" class="xiamen" />
				<p class="f17px">厦门银行</p>
				<p class="c-ababab line-h20">单日限额10,000元，单笔限额10,000元</p>
			</li>
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/beijing.png" class="beijing" />
				<p class="f17px">北京银行</p>
				<p class="c-ababab line-h20">单日限额500,000元，单笔限额100,000元</p>
			</li>

			<!--默认银行图标-->
			<li class="bb-e6e6e6">
				<img src="/imgs/cunguan/bank/moren.png" class="moren" />
				<p class="f17px">默认银行</p>
				<p class="c-ababab line-h20">单日限额10,000元，单笔限额10,000元</p>
			</li>
		</ul>
	</div>
</div>

   <script type="text/javascript" src="/scripts/jquery.min.js"></script>
   <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
</body>
</html>
