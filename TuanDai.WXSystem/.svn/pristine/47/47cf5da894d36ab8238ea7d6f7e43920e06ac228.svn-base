<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_return_details.aspx.cs"
    Inherits="TuanDai.WXApiWeb.Member.Repayment.my_return_details" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>回款详情</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=20160413" /> 
</head>
<body class="bg-f1f3f5 pb20">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <a class="back"  href="<%=string.IsNullOrEmpty(GoBackUrl)?"/Member/Repayment/my_return_list.aspx?tab="+tab:GoBackUrl %>">返回</a>
            <h1 class="title">回款详情</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header> 

    <div class="detail-top-bg bb-e6e6e6 pt10">
		<div class="pl15 pos-r detail_tit" style="padding-right: 100px;">
			<p class="f14px c-212121 text-overflow"><%=projectInfo.Title %></p>
		</div>
		<div class="pt25 text-center f13px c-ababab pos-r">预期总收益<%=GetProjectPlusRate() %></div>
		<div class="f37px c-fd6040 text-center pt10"><%= ToolStatus.ConvertLowerMoney(projectInfo.Type==23? xmbDSInterest:subscribeInfo.InterestAmount??0) %><%=GetPlusRateMoney() %></div>
		<div class="pt10 text-center f13px c-ababab"><span class="f13px c-ababab mr10"><%=CommUtils.GetProjectDeadLine(projectInfo) %></span>年化利率<%=ToolStatus.DeleteZero(projectInfo.InterestRate)%>%<span class="f13px c-ababab ml10"><%=ToolStatus.ConvertRepaymentType(projectInfo.RepaymentType??0) %></span></div>
		<div class="bg005 mt30">
			<div class="pl15 pt10 pb11 pos-r">
				<p class="f17px c-212121">投资金额：<%=ToolStatus.ConvertLowerMoney(subscribeInfo.Amount)%></p>
				<p class="line-h19 f13px c-ababab"><%=subscribeInfo.AddDate.Value.ToString("yyyy-MM-dd HH:mm")%>&nbsp;<%=subscribeInfo.IsVip?"超级会员":"普通会员" %>&nbsp;<%=TenderMode%></p>
				<a class="lookProject c-ababab f13px" href="<%=CommUtils.GetContractUrl(projectInfo.Type??0,subscribeInfo.ContractNo,subscribeInfo.TranId.HasValue) %>">查看合同<i class="ico-right"></i></a>
			</div>
		</div>
	</div> 
	
	 
    <% if (Status == "投标中" || Status == "等待满标")
       { %>
	<div class="bg-fff mt20">
		<div class="pl15 pt10 pb11">
			<p class="f17px c-212121">等待满标</p>
			<p class="line-h19 f13px c-ababab"><%=projectInfo.AuditDate.Value.AddDays(3).ToString("yyyy-MM-dd") %>前未满标，投资金额将退回</p>
		</div>
	</div> 
    <%}
       else if (Status == "已流标") {%>
    <div class="bg-fff mt20">
		<div class="pl15 pt10 pb11">
			<p class="f17px c-212121">已流标</p> 
            <p class="line-h19 f13px c-ababab"><%=subscribeInfo.StatusDate1.HasValue?subscribeInfo.StatusDate1.Value.ToString("yyyy-MM-dd")+"流标":"" %> 投资金额已退还</p>
		</div>
	</div> 
    <%}else{ %>
    <!------- --回款中--------------- -->
	<div class="bg-fff mt20">
		<div class="bt-e6e6e6 bb-e6e6e6">
			<div class="pt10 pb10 pl15 pr15 clearfix">
				<div class="lf f17px"><%=Status %>（<%=subscribeInfo.RefundedMonths %>/<%=subscribeInfo.TotalRefundMonths %>）</div>
                <% if(lastCycleDate.HasValue){ %>
				<div class="rf f13px c-ababab"><%=lastCycleDate.Value.ToString("yyyy-MM-dd") %>到期</div>
                <%} %>
			</div>
		</div>
		<div class="pl15">
		    <% if (hasBackList.Any())
              { %>
			<div class="bb-e6e6e6">
				<div class="pt8 pb8 f17px return_tit"><i class="icon-triagle-r rotateZ0"></i>已回款:<span class="f17px c-ffcf1f ml8">￥<%=ToolStatus.ConvertLowerMoney(GetSumListAmount(hasBackList)) %></span></div>
				<div class="return_txt hide">
                    <%foreach (SubscribeInfo item in this.hasBackList)
                      {  %>
                    <div class="bb-e6e6e6">
					    <div class="mt2 f17px pl15  c-ababab"><%=GetShowAmount(item) %></div>
					    <div class="clearfix mt1 pl20 pr15 pb10">
						    <div class="lf f13px c-ababab"><%=GetShowAmountDesc(item) %></div>
						    <div class="rf f13px c-ababab"><%=item.CycDate.ToString("yyyy-MM-dd") %>&nbsp;已回款</div>
					    </div>
                    </div>
                    <%} %>
				</div>
			</div>
			<%} %>

           <% if(dueBackList.Any()){ %>
			<div class="bb-e6e6e6">
				<div class="pt8 pb8 f17px return_tit"><i class="icon-triagle-r rotateZ90"></i>待回款:<span class="f17px c-ababab ml8">￥<%=ToolStatus.ConvertLowerMoney(GetSumListAmount(dueBackList)) %></span></div>
				<div class="return_txt">
                    <% foreach (SubscribeInfo item in this.dueBackList)
                       { %>
					<div class="bb-e6e6e6">
						<div class="mt2 f17px pl15 pt8 c-ababab"><%=GetShowAmount(item) %></div>
						<div class="clearfix mt1 pl20 pr15 pb10">
							<div class="lf f13px c-ababab"><%=GetShowAmountDesc(item) %></div>
							<div class="rf f13px c-ababab"><%=item.CycDate.ToString("yyyy-MM-dd") %>&nbsp;<%= (!item.IsBorrow && item.PenaltyAmount > 0)?"<span class='f13px c-fd6040'>已逾期</span>":"待回款"%></div>
						</div>
                        <%　if (!item.IsBorrow && item.OverDueInterest >0 && item.PenaltyAmount > 0)
                           {　 %>
                         <div class="c-ababab f13px pl15 pb10">已逾期<%=item.OverDueDay%>天 逾期利息￥<%= ToolStatus.ConvertLowerMoney(item.OverDueInterest)%> 滞纳金￥<%= ToolStatus.ConvertLowerMoney(item.PenaltyAmount)%></div>  
                        <%} %>
					</div> 
				    <%} %>
				</div>
			</div>
            <%} %>
		</div>
	</div>	
    <%} %>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript">
    $(function () {
        $('.return_tit').click(function() {
            var box = $(this).next();
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
