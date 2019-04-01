<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cgtBindCard.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.cgt.cgtBindCard" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
		<link rel="stylesheet" type="text/css" href="/css/cunguan.css?v=<%=GlobalUtils.Version %>" />
		<title>绑定银行卡</title>
	</head>
	<body class="bg-f1f3f5">
  <div id="bigDiv">
	    <%=GetNavStr() %>
	   <div class="step clearfix bg-fff">
			<div class="w50p lf text-center stepActive">
				<span>1</span>添加银行卡
			</div>
			<div class="w50p lf text-center">
				<span>2</span>绑定银行卡
			</div>
			<i class="arrow1"></i>
		</div>
		
		<div class="tips">
			<p>投资前请添加一张您的常用银行卡，充值、提现只能通过此卡，最大程度保证您的资金安全。</p>
		</div> 

		<div class="bg-fff">
			<div class="inputBox webkit-box bb-e6">
				<div class="inpName">真实姓名</div>
				<div class="inp"><input type="text" placeholder="请输入真实姓名" id="txtRealName" <%=model.IsValidateIdentity?"value='"+model.RealName+"'  readonly='readonly'":"" %>/></div>
			</div>
            <div class="inputBox webkit-box bb-e6">
				<div class="inpName">证件类型</div>
				<div class="inp selectDiv">
					<select class="f15px" id="txtCardType"  <%=model.IsValidateIdentity?"value='"+model.IdentityCard+"'  disabled='disabled'":"" %>>
						<option value="1" <%=iCardType==1?"selected='selected'":""%>>身份证</option>
						<option value="2" <%=iCardType==2?"selected='selected'":""%>>港澳通行证</option>
						<option value="4" <%=iCardType==4?"selected='selected'":""%>>护照</option>
						<option value="3" <%=iCardType==3?"selected='selected'":""%>>外国人永久居住证</option>
					</select>
				</div>
               <% if(!model.IsValidateIdentity){ %>
				<div class="ico-arrow-r"></div>
               <%} %>
			</div>
			<div class="inputBox webkit-box bb-e6">
				<div class="inpName">证件号码</div>
				<div class="inp"><input type="text" placeholder="请输入证件号码" id="txtIdentity" <%=model.IsValidateIdentity?"value='"+model.IdentityCard+"'  readonly='readonly'":"" %>/></div>
			</div>
		</div>
		
		<div class="bg-fff mt20 bt-e6">
			<div class="inputBox webkit-box bb-e6">
				<div class="inpName">银行卡号</div>
				<div class="inp"><input type="text" placeholder="请输入银行卡号码" id="txt_bankCard" <%=bankInfo!=null && bankInfo.respData != null && !string.IsNullOrEmpty(bankInfo.respData.bankNo)?"value='"+bankInfo.respData.bankNo+"'":"" %>/></div>
				<a href="/html/App/bank_list.html?type=weixinapp" class="supportBank">支持银行</a>
			</div> 
			<div class="inputBox webkit-box bb-e6">
				<div class="inpName">预留手机</div>
				<div class="inp"><input type="text" placeholder="请输入银行预留手机号" id="txtTelNo" value="<%=PreTelNo %>"/></div>
			</div>
		</div> 

        <div class="pl15 pr15 pt20">
			<a href="javascript:void(0);" class="btn btnYellow" id="btnGoCgt" opertype="bindcard">前往存管页面绑定</a>
		</div>		 
  </div> 
            
      <div class="jumpPage webkit-box box-center box-vertical h100p hide" id="jumpPage">
		<div class="jump_loading"></div>
		<p>即将前往存管页面</p>
	 </div>

</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/cgt_bankcard.js?v=<%=GlobalUtils.Version %>"></script> 
<script type="text/javascript">
    var cardType = "<%=iCardType%>";
    cookieDomain = "<%=GlobalUtils.CookieDomain %>";
</script>
</html>