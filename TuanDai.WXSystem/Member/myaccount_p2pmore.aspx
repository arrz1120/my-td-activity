<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="myaccount_p2pmore.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.myaccount_p2pmore" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head >
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>P2P</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/account2_new.css?v=<%=GlobalUtils.Version %>" />
</head>
<body class="bg-f7f9fa">
    <%= GetNavStr()%>
		<%--<div class="licaiBanner">
			<div class="clearfix">
				<div class="lf w50p pl15">
					<p class="lcb_p1">总资产  (元)</p>
					<p class="lcb_p2"><%=ToolStatus.ConvertLowerMoney(pageModel.P2PSumAmount) %></p>
				</div>
				<div class="lf w50p pl15">
					<p class="lcb_p1">可用余额  (元)</p>
					<p class="lcb_p2"><%=ToolStatus.ConvertLowerMoney(pageModel.P2PAviAmount) %></p>
				</div>
			</div>
			<div class="lcb_line"></div>
			<a href="javascript:checkCgtCommGoUrl('/Member/withdrawal/drawmoney.aspx')" class="lcb_btn tx"><i class="ico_licai ico_tx"></i>提现</a>
			<a href="javascript:checkCgtCommGoUrl('/Member/Bank/Recharge.aspx')" class="lcb_btn cz"><i class="ico_licai ico_cz"></i>充值</a>
		</div>--%>
		
		<div class="acount-link bg-fff">
            <div class="click-respond linkBox">
				<i class="ico_licai ico_lc5"></i>
				<a href="/Member/Repayment/return_pay_list.aspx" class="bb-e6e6e6">回款/还款计划<i class="ico-arrow-r"></i></a>
			</div>
			<div class="click-respond linkBox">
				<i class="ico_licai ico_lc1"></i>
				<a href="/Member/Repayment/my_return_date.aspx" class="bb-e6e6e6">财富日历<i class="ico-arrow-r"></i><%=NextReturnDay %></a>
			</div>
			<div class="click-respond linkBox">
				<i class="ico_licai ico_lc2"></i>
				<a href="/Member/Repayment/my_return_list.aspx" class="bb-e6e6e6">投资记录<i class="ico-arrow-r"></i><span>待收本息：<%=ToolStatus.ConvertLowerMoney(fundModel.DueInPAndI) %>元</span></a>
			</div>
			<div class="click-respond linkBox">
				<i class="ico_licai ico_lc3"></i>
				<a href="/Member/Repayment/borrowLog.aspx" class="bb-e6e6e6">借款记录<i class="ico-arrow-r"></i><span>待还本息：<%=ToolStatus.ConvertLowerMoney(fundModel.DueOutPAndI) %>元</span></a>
			</div>
			<div class="click-respond linkBox">
				<i class="ico_licai ico_lc4"></i>
				<a href="/Member/Repayment/my_bills.aspx" class="bb-e6e6e6">账单<i class="ico-arrow-r"></i></a>
			</div>
            <div class="click-respond linkBox">
				<i class="ico_licai ico_lc6"></i>
				<a href="/Member/Repayment/my_debt_carry_list.aspx" <%=vipInfo.Level>4?"class='bb-e6e6e6'":"" %> >债权转让<i class="ico-arrow-r"></i></a>
			</div>
            <% if (vipInfo.Level > 4)
               {
                   %>
            <!--新增会员中心入口-->
			<div class="click-respond linkBox">
				<i class="ico_more ico_m6"></i>
				<a href="/pages/invest/debt_list.aspx">会员专享<i class="ico-arrow-r"></i></a>
			</div>
			
            <%
               } %>
            
		</div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script> 
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
</body>
</html>
