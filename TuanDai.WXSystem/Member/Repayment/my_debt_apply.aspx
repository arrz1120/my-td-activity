<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_debt_apply.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.my_debt_apply" %>

 <!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>债权转让</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/debt.css?v=20160301001"/>
    <!--<link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />-->
    <script type="text/javascript">
        var WebSettingEntity = { Param1Value: "<%=WebSettingEntity.Param1Value %>", Param5Value: "<%=WebSettingEntity.Param5Value%>" }; 
        var SubscribeId = "<%=TransferId%>";
        var IsOpenCGT = <%=TuanDai.WXApiWeb.GlobalUtils.IsOpenCGT.ToString().ToLower()%>;
    </script>
</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header bb-d1d1d1">
        <div class="back"  onclick="window.location.href='/Member/Repayment/my_debt_transferlist.aspx'">返回</div>
        <h1 class="title">申请转让</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>

<!--申请转让-->
	<div class="debt-apply"> 	    
	    <div class="inp-box bb-d1d1d1 bt-d1d1d1 mt15">
	    	<span class="c-212121 f17px">转让份数</span>
	    	<input type="text" placeholder="可转让0份" id="txtTransferShares" maxlength="10" />
	    </div>
	    <div class="bg-fbfbf9 pt10 pb20 pl15">
	    	<p class="f13px c-212121">转让本金:<span class="c-fd6040 f13px ml10" id="spnAmount">0</span>元</p>
	    </div>
	    <div class="inp-box bt-d1d1d1 bb-d1d1d1">
	    	<span class="c-212121 f17px">转让价格</span>
	    	<input type="text" placeholder="请输入转让价格" id="txtTransferPrice" />
	    </div>
	    <div class="bg-fbfbf9 bb-d1d1d1 pt10 pb20 pl15">
	    	<p class="f13px c-212121">价格范围:<span class="c-ababab f13px ml10" id="spnMinAmount">0</span> ~ <span class="c-ababab f13px" id="spnMaxAmount">0</span>元</p>
	    </div>
	    
	    <div class="bg-fff">
		    <div class="pt20 clearfix pl15 pr15">
		    	<div class="lf"><p class="c-212121 f13px">预计收回资金</p></div>
		    	<div class="rf"><p id="detail-btn" class="c-fd6040 f13px">查看详情</p></div>
		    </div>
		    <div class="pt20 pl10">
		    	<p class="c-fd6040 f35px" id="spnWithdrawFunds">￥0.00</p>
		    </div>
		    <div class="mt40 c-212121 f13px pl15">转让利率预览</div>
		    <div class="pt18 pl15 pb20 bb-d1d1d1">
		    	<p class="c-fd6040 f20px" id="spnYearRate">0%</p>
		    </div>
	    </div>
	    <% if (!TuanDai.WXApiWeb.GlobalUtils.IsOpenCGT)
	       { %>
	    <div class="inp-box bb-d1d1d1 bt-d1d1d1 mt15">
	    	<span class="c-212121 f17px">交易密码</span>
	    	<input type="password" placeholder="请输入交易密码"  id="txtPayPwd" maxlength="20" />
	    </div>
        	  <% } %> 
        <div class="pl10"><p class="c-fd6040" style="display:none;" id="spnErrorMsg"><i class="ico ico-warn"></i>验证码错误</p></div>
	    
        <div class="pl15 pr15 mt30 pb30">
	    	<div class="btn btnYellow" id="btnConfirmTran">确定</div>
	    </div>
	</div>
	
	<!--查看详情-->
	<div class="pos-a z-index2000 coverBox debt-apply-detail hide">
	    <div class="bb-d1d1d1 pt10 pb10 pl15 bg-fbfbf9">
	        <div class="ico-round-close" id="detail-close"></div>
	        <div class="f20px c-212121 text-center"></div>
	    </div>
	    
	    <div class="bb-dashed-d1d1d1 pl15 pt15 pb15 bg-fff">
	    	<p class="c-212121 f17px"><i class="ico ico-money2"></i>预计收回资金<span class="f25px c-fd6040 ml20" id="spnWithdrawFunds2">￥0.00</span></p>
	    </div>
	    <div class="bg-fff pt20 pb20 bb-d1d1d1">
		    <div class="clearfix">
		    	<div class="w33p text-center lf">
		    		<p class="c-ababab f13px">本金折让价格</p>
		    	</div>
		    	<div class="w33p text-center lf">
		    		<p class="c-ababab f13px">未结算利息</p>
		    	</div>
		    	<div class="w33p text-center lf">
		    		<p class="c-ababab f13px">服务费</p>
		    	</div>
		    </div>
		    <div class="clearfix pt10">
		    	<div class="w33p text-center lf">
		    		<p class="c-212121 f13px" id="spnAmount2">+0.00元</p>
		    	</div>
		    	<div class="w33p text-center lf">
		    		<p class="c-212121 f13px" id="spnInterestPayable">+0.00元</p>
		    	</div>
		    	<div class="w33p text-center lf">
		    		<p class="c-212121 f13px" id="spnCommissionsReceivable">-0.00元</p>
		    	</div>
		    </div>
	    </div>
	    
	    <div class="bt-d1d1d1 bb-e6e6e6 pt15 pr15 pb15 mt15 bg-fff">
	    	<div class="clearfix">
		    	<div class="titleMark c-ffffff bg-ffcf1f f13px lf">本金折让价格</div>
	    	</div>
	    	<div class="pl15">
		    	<p class="c-212121 f15px pt10">您的本金转让价格为<span class="f15px c-fd6040" id="spnAmount5">0.00</span>。</p>
		    	<p class="f15px c-ababab pt10">即债权转让时，本金进行折让后的价格。</p>
	    	</div>
	    </div>
	    
	    <div class="bb-d1d1d1 pt15 pr15 pb15 bg-fff">
		    	<div class="clearfix">
		    		<div class="titleMark c-ffffff bg-ffcf1f f13px lf">未结算利息</div>
		    	</div>
		    	<div class="pl15">
		    		<p class="c-212121 f15px pt10 text-justify">您转让的原标的年化利率为<span class="f15px c-fd6040"><%=ToolStatus.DeleteZero(model.InterestRate??0)%>%</span>，回款方式为<span class="f15px c-fd6040"><%=ToolStatus.ConvertRepaymentType(model.RepaymentType.Value) %></span>，距离<span class="f15px c-fd6040"><%=model.RepaymentType.Value==2?"上次回款":"投标当天" %></span>天数为<span class="f15px c-fd6040"><%=DiffDay.ToString("f0")%>天</span>，转让本金<span class="f15px c-fd6040" id="spnAmount4">0.00元</span>，未结算利息为<span class="f15px c-fd6040"  id="spnInterestPayable3">0.00元</span>。</p>
			    	<div class="c-ffcf1f f15px pt10">未结算利息=未结算时间(天)  x  转让的本金  x</div>
			    	<div class="c-ffcf1f f15px pt10 pl85">原始年化利率/365</div>
			    	<p class="f15px c-ababab pt10">不同回款方式的未结算时间不一样。</p>
			    	<p class="f15px c-ababab pt10">A.到期本息的算法:</p>
			    	<p class="f15px c-ababab pt10 pl15">到期本息的未结算时间为转让当天距离投标当天的天数</p>
			    	<p class="f15px c-ababab pt10">B.每月付息的算法:</p>
			    	<p class="f15px c-ababab pt10 pl15">每月付息的未结算时间为转让当天距离上次回款的天数</p>
		    	</div>
		    </div>
		    
		    <div class="bt-d1d1d1 bb-d1d1d1 pt15 pr15 pb15 mt15 bg-fff">
		    	<div class="clearfix">
		    		<div class="titleMark c-ffffff bg-ffcf1f f13px lf">债权转让服务费</div>
		    	</div>	
		    	<div class="pl15">
		    		<p class="c-212121 f15px pt10 text-justify">您的本金折让价格为<span class="f15px c-fd6040" id="spnAmount3">0.00元</span>，未结算利息为<span class="f15px c-fd6040"  id="spnInterestPayable2">0.00元</span>，转让服务费为<span class="f15px c-fd6040" id="spnCommissionsReceivable2">0.00元</span>。</p>
			    	<div class="c-ffcf1f f15px pt10 text-justify">转让服务费=(本金转让价     未结算利息)  x  <%= double.Parse(WebSettingEntity.Param5Value)*100 %>%</div>
			    	<p class="f15px c-ababab pt10">该服务费每成功交易一笔则即时收取，债权转让服务费由发起人支付。</p>
		    	</div>
		    </div> 		     
		    <div class="bg-fbfbf9 pt15 bb-d1d1d1"></div>
		</div>

<!--确认债权转让弹框-->
    <div id="dvNeedTran" class="pos-r z-index1000" style="display:none;">
	    <div class="alert webkit-box box-center">
		    <div class="alert-stop-assignment bg-fff">
			    <div class="text-center c-212121 f17px pt30 fb">确定要转让此债权吗？</div>
			    <div class="pl15 pr15 pt15 c-808080 f15px text-justify">您申请转让债权0.00元，需扣除服务0.00元。佣金将在债权被接收时即时扣除。</div>
			    <div class="clearfix bt-d1d1d1 mt30">
				    <div class="lf w50p br-e6e6e6">
					    <div class="btn c-808080 f17px" style="border-right: 1px solid #f0f0f0;" id="btnCancel">取消</div>
				    </div>
				    <div class="rf w50p">
					    <div class="btn c-ffc61a f17px" id="btnOk">确定</div>
				    </div>
			    </div>
		    </div>
	    </div> 
    </div>

<!--转让成功提示-->
<div id="dvTranSuc" class="z-index1000" style="display:none;">
    <div class="webkit-box box-center successTipsWrap">
	    <div class="successTips text-center f15px c-ffffff">
		    <i class="ico ico-success"></i>恭喜您，债权转让发布成功！
	    </div>
    </div>
</div> 

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/zqzrapply.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript">
    var zqRateSet={
        MaxRate:<%=zqzrRateSet.Param4Value%>,
        IsOpen:"<%=IsOpenRateLimit?1:0%>"
    }
</script> 
</body>
</html>