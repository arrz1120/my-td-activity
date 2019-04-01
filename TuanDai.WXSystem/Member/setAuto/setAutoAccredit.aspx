﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="setAutoAccredit.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.setAuto.setAutoAccredit" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>团贷网网站自动受托工具授权书</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/pay.css?v=20160317" />

</head>
<body class="bg-f1f3f5">
    <%= this.GetNavStr()%>
	<header class="headerMain">
	    <div class="header bb-c2c2c2">
	        <div class="back" onclick="window.location.href='auto_invest.aspx'">返回</div> 
            <h1 class="title">团贷网网站自动受托工具授权书</h1>
	    </div>
        <%= this.GetNavIcon()%>
	    <div class="none"></div>
	</header>

	<h3 class="text-center pt30 c-212121 f17px">《团贷网网站自动受托工具授权书》</h3>
	<div class="acc-con pl15 pr15 pb25">
		<p class="title">1.协议主体及效力</p>
		<p class="text-ind">《团贷网网站自动受托工具授权书》（以下称“本协议 ”）的双方主体为团贷网网站（域名：www.tuandai.com）的运营商东莞团贷网互联网科技服务有限公司（以下简称的“团贷网”均指团贷网网站及东莞团贷网互联网科技服务有限公司）与团贷网注册会员。</p>
		<p class="text-ind">本协议经团贷网注册会员通过在团贷网点击设置自动受托条件、成功开启自动受托功能、确认已阅读并同意签署本协议后立即生效。</p>
		<p class="title">2.自动受托工具释义</p>
		<p>自动受托工具，是指符合条件的团贷网注册会员通过在团贷网系统内设置个人自动受托工具的投资条件并启用该自动受托功能后，全权授权团贷网，根据注册会员设置的投资条件及团贷网规定的自动受托工具说明，通过运行自动受托系统帮助已启用自动受托功能的注册会员加入We、We+自动服务或承接智享转让等用户自主选择的产品或服务。</p>
		<p class="title">3.申请条件</p>
		<p>已经过团贷网的会员认证并在有效期内的注册会员，均可在团贷网系统设置自动受托条件并开启自动投资功能。</p>
		<p class="title">4.自动受托工具说明</p>
		<p>团贷网按已在团贷网公示的《团贷网自动受托工具说明》为有效开启自动受托工具的会员提供服务。团贷网会员必须在签署本协议之前认真阅读并充分理解团贷网已公示的《团贷网自动受托工具说明》。团贷网会员一旦签署本协议即表示并完全接受《团贷网自动受托工具说明》。《团贷网自动受托工具说明》为本协议附件，与本协议具有同等法律效力。</p>
		<p class="title">5.自动受托工具的启用</p>
		<p>符合条件的团贷网注册会员按照团贷网规定的设置程序设置自动受托的投资条件后，只要复选“我已阅读并同意签署团贷网自动受托工具授权书”并按照团贷网规定的程序开启自动受托功能的，团贷网注册会员的行为即表示同意并签署了本协议及《团贷网自动受托工具说明》。自动受托功能设置成功后，该注册会员立即享受团贷网提供的自动受托工具服务。</p>
		<p class="title">6.自动受托工具的终止</p>
		<p>团贷网注册会员成功设置并启用团贷网自动受托工具功能后，发生以下情形之一的，团贷网将有权终止该注册会员的自动受托工具功能：</p>
		<p class="text-ind">（1）团贷网注册会员的服务功能终止的；</p>
		<p class="text-ind">（2）会员手动关闭工具并不再开启的；</p>
		<p class="text-ind">（3）会员因违反团贷网公布的各项规则及所签署的各类协议（包括与团贷网签署的协议、通过团贷网与团贷网其它用户签署的协议）的约定，团贷网认为应当终止该会员的自动受托工具功能的；</p>
		<p class="text-ind">（4）其它团贷网认为应当终止注册会员的自动受托功能的情形。</p>
		<p class="title">7.声明与保证</p>
		<p class="no-ind">团贷网注册会员声明并保证如下：</p>
		<p class="text-ind">（1）已认真阅读并完全理解本协议全部条款，对本协议条款的含义及相应的法律后果已完全知晓并充分理解，自愿接受本协议全部内容。</p>
		<p class="text-ind">（2）已认真阅读通过自动受托工具所要签署的全部格式合同的全部条款，已对该全部合同条款的含义及相应法律后果完全知晓并充分理解。</p>
		<p class="text-ind">（3）通过团贷网自动受托工具受托成功的，即视为注册会员已全部签署本协议及相关附件，注册会员接受并保证基于自动受托所产生的全部法律后果均由注册会员承担并保证完全履行全部合同。</p>
		<p class="title">8.规则变动</p>
		<p>团贷网有权不时按照实际需求，修改《团贷网自动受托工具说明》,以准确地反映团贷网的会员权益。《团贷网自动受托工具说明》的所有修改,团贷网会在更改之日在网站公示并即时生效。团贷网会员应不时地注意《团贷网自动受托工具说明》的变更,如不同意规则变更的内容，应立即自己操作取消自动受托功能，否则，本协议继续有效。</p>
		<p class="title">9.条款独立性</p>
		<p>本协议中部分条款根据相关法律法规等的规定无效或部分无效的，该等无效不影响本协议项下其他条款的效力。</p>
		<p class="title">10、其他</p>
		<p>团贷网公布的所有条款、其他规则声明及注册会员在团贷网点击确认签署的电子文件、协议等是本协议的附件，与本协议具有同等的法律效力；本协议未约定的，以团贷网公布的条款规则为准，若团贷网公告的规则和条款与本协议不一致的，则以本协议为准。</p>
	</div>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
</body>
</html>