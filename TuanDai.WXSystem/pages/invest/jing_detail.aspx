﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jing_detail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.jing_detail" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>资产标-项目详情</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/investProcess.css?v=<%=GlobalUtils.Version %>" />
    <script type="text/javascript">
        var projectId = "<%=projectId %>";
        var backurl = "<%= GetEncodeBackUrl()%>";
    </script>
</head>
<body class="bg-f1f3f5">
    <div id="bigDiv" style="padding-bottom: 57px;">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-c2c2c2">
            <a class="back" href="<%=string.IsNullOrEmpty(GoBackUrl)?"/pages/invest/invest_list.aspx":GoBackUrl %>">返回</a>
            <h1 class="title">项目详情</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header> 

        <div class="detail-top-bg <%=(model.Status ?? 0)==2?"pro-notFinish":"pro-finish"%>">
            <div class="pl15 pos-r pt15 detail_tit">
                <p class="f14px c-808080">【资】<%=model.Title %></p> 
            </div>
            <div class="pt10 text-center">
                <p><span class="f13px c-ababab">预期年化利率（<%=ToolStatus.ConvertRepaymentType(model.RepaymentType.Value)%>）</span></p>
            </div>
            <div class="rateIncome"> 
              <p><%=CommUtils.GetProjectDetailShowRate(model)%></p>
            </div>
            <div class="bg005 mt5">
                <div class="clearfix pt15">
                    <div class="lf w33p text-center">
                        <p class="f17px c-212121"><%=RemainMoney %></p>
                        <p class="line-h20 f12px c-ababab">剩余金额(元)</p>
                    </div>
                    <div class="lf w33p text-center">
                        <p class="f17px c-212121"><%=(model.Deadline??0).ToString()+((model.DeadType??0) ==1? "个月":"天") %></p>
                        <p class="line-h20 f12px c-ababab">期限</p>
                    </div>
                    <div class="lf w33p text-center">
                        <p class="f17px c-212121"><%=ToolStatus.DeleteZero(model.LowerUnit.Value) %>元/份</p>
                        <p class="line-h20 f12px c-ababab">投资单位</p>
                    </div>
                </div>
                <div class="pl15 pr15 pt15 pb11">
                    <div class="pBar">
                        <div class="barRate" style="width: <%=finishProcess%>;"></div>
                    </div>
                    <div class="mt4 clearfix">
                        <div class="lf f13px c-ababab">借款金额：<%=ToolStatus.ConvertLowerMoney(model.Amount.Value)%></div>
                        <div class="rf f13px c-ababab"><%=finishProcess%></div>
                    </div>
                     <div class="mt4 f13px c-ababab">
                        剩余时间：<%if (Tool.StrObj.StrToList("2;12;13;14;15").Contains(model.Status.ToString()) && model.TenderDate > DateTime.Now)
                               {%>
                            <span class="timeSet" enddate="<%=model.TenderDate %>" startdate="<%=model.TenderStartDate %>"  serverdate="<%=DateTime.Now %>" style="color: Black;">
                            <span id="day" style="font-size: 13px;color: #ff6600; ">00</span> 天 
                            <span id="hour" style="font-size: 13px;color: #ff6600; ">00</span> 时 
                            <span id="mini" style="font-size: 13px;color: #ff6600; ">00</span> 分 
                            <span id="sec" style="font-size: 13px;color: #ff6600;">00</span> 秒
                        </span>
                        <%}
                            else if (model.Status > 2 || model.TenderDate < DateTime.Now)
                            { %><span class="timeSet" enddate="<%=DateTime.Now %>" startdate="<%=model.TenderStartDate %>" serverdate="<%=DateTime.Now %>" style="color: none;">已结束</span>
                        <%} %>
                    </div>
                    <div class="mt4 f13px c-ababab">
                        起息日期：T（<%=InterestModel==2?"满标日":"投资日" %>）+1天
                    </div>
                    <div class="mt4 f13px c-ababab"> 
                            注：<%=InterestModel==2?"满标日指该项目满标当天的日期":"投资日指投资者投资成功的日期" %> 
                    </div>
                </div>
                <div class="bt-e6e6e6 moneySafty pr40 pl15" id="f1">
					<%--<div class="c-ababab f13px text-center"><i class="ico-suc03"></i>第三方担保专款</div> --%>
                    <div class="c-ababab f13px text-center"><i class="ico-suc03"></i>第三方担保</div>
					<div class="c-ababab f13px text-center"><i class="ico-suc03"></i>合同保障</div>
					<div class="ico-arrow-r"></div>
				</div> 
            </div>
            <div class="finishImg"><img src="/imgs/images/bg/pro-finish.png" /></div>
        </div> 

		<div class="incomeShow mt15 bt-e6e6e6 bb-e6e6e6 bg-fff">
			<div class="is_tit bb-e6e6e6 pos-r ml15 f15px" id="f2">
				投资1万元，可赚取收益<span class="f15px c-fd6040"><%=ToolStatus.ConvertLowerMoney(PreInterestRate) %></span>元
			</div>
			<div class="is_img clearfix">
				<div class="lf <%=model.RepaymentType.Value==1?"w50p":"w33p" %> text-center"><img src="/imgs/images/pic/investProcess1.png"/></div>
                <% if(model.RepaymentType.Value==2||model.RepaymentType.Value==5){ %>
				 <div class="lf w33p text-center"><img src="/imgs/images/pic/investProcess2.png"/></div>
                <%} %>
				<div class="lf <%=model.RepaymentType.Value==1?"w50p":"w33p" %> text-center"><img src="/imgs/images/pic/investProcess3.png"/></div>
			</div>
			<div class="is_Round clearfix">
				<div class="lf <%=model.RepaymentType.Value==1?"w50p":"w33p" %> text-center pos-r">
					<div class="is_line is_line1"></div>
					<i class="is_cur"></i>
				</div>
                <% if(model.RepaymentType.Value==2||model.RepaymentType.Value==5){ %>
				<div class="lf w33p text-center pos-r">
					<div class="is_line is_line2"></div>
					<i></i>
				</div>
                <%} %>
				<div class="lf <%=model.RepaymentType.Value==1?"w50p":"w33p" %> text-center pos-r">
					<div class="is_line is_line3"></div>
					<i></i>
				</div>
			</div>

			<div class="clearfix pb20">
				<div class="<%=model.RepaymentType.Value==1?"w50p":"w33p" %> lf text-center">
					<p class="f13px c-694514">开始投资</p>
					<%--<p class="f11px c-ababab line-h18">（<%=DateTime.Today.ToString("yyyy.MM.dd") %>）</p>--%>
				</div>
                <% if(model.RepaymentType.Value==2||model.RepaymentType.Value==5){ %>
				<div class="w33p lf text-center">
					<p class="f13px c-694514"><%=model.RepaymentType.Value==2?"每月赚利息":"每月回本息" %></p>
					<%--<p class="f11px c-ababab line-h18">（每月<%=DateTime.Today.AddDays(1).Day%>号回款）</p>--%>
				</div>
                <%} %>
				<div class="<%=model.RepaymentType.Value==1?"w50p":"w33p" %> lf text-center">
					<p class="f13px c-694514"><%=model.RepaymentType.Value==2?"到期回本金":(model.RepaymentType.Value==1?"到期回本息":"到期还清") %></p>
					<%--<p class="f11px c-ababab line-h18">（<%=CommUtils.GetInvestEndDay(model) %>）</p>--%>
				</div>
			</div>
		</div>
		
		<div class="is_tit bb-e6e6e6 pos-r f17px mt15 pl15 bg-fff click-respond" onclick="javascript:window.location.href='/pages/invest/SubscribeUser.aspx?type=project&id=<%=model.Id %>';">
			投资记录
			<b class="c-ababab f13px"><%=SubscribeUserCount %></b>
			<div class="ico-arrow-r"></div>
		</div>

        <!--项目描述-->
        <div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
            <div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>资产标介绍</div>
            <div class="dropdownCon hide">
                <div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15">资产标是团贷网投资人以其持有的团贷网待收资产作为质押物，向平台的其他投资人发起资金周转需求的产品。发起周转需求的投资人，其在平台的待收资产能完全覆盖其资金周转需求的总额，且有团贷网合作担保机构担保，风险可控。
                <div class="pt10 pb10 c-212121 f13px dropdownTit">资金用途：用于资金周转</div>                     
                    
                </div>                
            </div>
        </div>

        <!--借款人信息-->
        <div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15">
            <div class="pt10 pb10 c-212121 f17px pl15 dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>周转人信息</div>
            <div class="dropdownCon hide">
                <div class="h43 c-808080 f14px pl15 bg-fafafa">借款方：<%= BusinessDll.StringHandler.MaskStartPre(borrowerUserInfo.RealName, 1) %></div>
                <div class="h43 c-808080 f14px pl15 ">会员等级：<%=this.VipLevel %> 级</div> 
                <div class="h43 c-808080 f14px pl15 bg-fafafa">提前兑付：<%=this.PrepaymentTime %> 期</div>
                <div class="h43 c-808080 f14px pl15 ">准时兑付：<%=this.OnTimepayTime %> 期</div>
                <div class="h43 c-808080 f14px pl15 bg-fafafa">逾期期数：<%=this.overdueNum%> 期</div>
                    <div class="h43 c-808080 f14px pl15 ">逾期垫付： <%=this.OverdueAdvanceTime %> 期</div>
                <div class="pb15 mt15">
					<div class="pt15 pb15 c-212121 f17px ml15 bt-e6e6e6">审核记录</div>
					<div class="webkit-box investigation">
						<div class="box-flex1 text-center">
							<img src="/imgs/images/pic/id1.png">
							<p class="c-808080 f13px mt8">身份验证</p>	
						</div>
						<div class="box-flex1 text-center">
							<img src="/imgs/images/pic/id2.png">
							<p class="c-808080 f13px mt8">手机验证</p>	
						</div>
						<div class="box-flex1 text-center">
							<img src="/imgs/images/pic/id3.png">
							<p class="c-808080 f13px mt8">邮箱验证</p>	
						</div> 
						<div class="box-flex1 text-center">
							<img src="/imgs/images/pic/id5.png">
							<p class="c-808080 f13px mt8">资产验证</p>	
						</div>
					</div>
				</div>	
                <div class="">
                    <div class="pt15 c-212121 f17px bt-e6e6e6 ml15">周转记录</div>
                    <%--<div class="h43 c-808080 f14px pl15">会员等级：<%=this.VipLevel %> 级</div>
                    <div class="h43 c-808080 f14px pl15 bg-fafafa">提前还款：<%=this.PrepaymentTime %> 期</div>
                    <div class="h43 c-808080 f14px pl15">准时还款：<%=this.OnTimepayTime %> 期</div>
                    <div class="h43 c-808080 f14px pl15 bg-fafafa">待还本息：<%=Tool.MoneyHelper.ConvertLowerMoney(userCreditInfo.DueOutPAndI)%> 元</div>
                    <div class="h43 c-808080 f14px pl15">逾期未还：<%=ToolStatus.ConvertLowerMoney(this.TotalOverdue)%> 元</div>
                    <div class="h43 c-808080 f14px pl15 bg-fafafa">逾期期数：<%=this.overdueNum%> 期</div>
                    <div class="h43 c-808080 f14px pl15">逾期垫付： <%=this.OverdueAdvanceTime %> 期</div>--%>
                    <div class="h43 c-808080 f14px pl15">周转金额：<%=model.Status==4?"0":model.Status==3?ToolStatus.ConvertDetailWanMoney(model.Amount.Value):ToolStatus.ConvertDetailWanMoney(model.CastedShares*model.LowerUnit) %> 元</div>
                    <div class="h43 c-808080 f14px pl15 bg-fafafa">需兑付本息：<%=model.Status==4?"0":model.Status==3?ToolStatus.ConvertDetailWanMoney(model.Amount.Value + model.Amount.Value * model.InterestRate * model.Deadline / (model.DeadType == 1 ? 12 : 365) / 100):ToolStatus.ConvertDetailWanMoney(model.CastedShares * model.LowerUnit * (1 + model.InterestRate * model.Deadline / (model.DeadType == 1 ? 12 : 365) / 100)) %> 元</div>
                    <div class="h43 c-808080 f14px pl15">已兑付份数：<%=model.BuybackShares %> 份</div>
                    <div class="h43 c-808080 f14px pl15 bg-fafafa">已兑付金额：<%=ToolStatus.ConvertLowerMoney(repayedAmount)%> 元</div>
                    <div class="h43 c-808080 f14px pl15">待兑付本息：<%=ToolStatus.ConvertLowerMoney(duerepayAmount)%> 元</div>
                    <div class="h43 c-808080 f14px pl15 bg-fafafa">逾期金额：<%=ToolStatus.ConvertLowerMoney(overdueAmount)%> 元</div>
                </div>
                <%--<div class="bt-e6e6e6 ml15">
                    <div class="pt10 pb10 c-212121 f17px">借款描述</div>
                    <div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15"><%= model.AmountUsedDesc == null ? "" : Tool.Utils.ReplaceLineSpace(model.AmountUsedDesc) %></div>
                </div>--%>
            </div>
        </div>
        <div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15">
			<div class="pt10 pb10 c-212121 f17px pl15 dropdownTit"  id="btnQuestion"><i class="ico-sprite01 ico-triangle rotate0"></i>常见问题</div>
		</div>	
        <div class="text-center c-ababab bt-e6e6e6 ftb_bot">
			市场有风险，投资需谨慎。查看<a class="c-fab600" href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/P2PRisk.html">《风险揭示书》</a>
	    </div>
        <!--申购按钮-->
        <div class="pos-f btn-joinNow">
            <% if (DateTime.Now > DateTime.Parse(xiajia.Param3Value) && (model.Status ?? 0) == 2)
               {
                   %>
            <div class="btn btnGray loan-button-gray">已完成</div>
            <%
               } else if ((model.Status ?? 0) == 2)
              { %>
            <div class="btn btnYellow loan-button">马上投资</div>
            <a href="javascript:void(0)" class="btn-share webkit-box"><i class="ico-sprite01 ico-share"></i></a>
            <%}
              else
              { %>
            <div class="btn btnGray loan-button-gray">已满标</div>
            <%} %>
        </div>
</div>

    <!----------------------弹框----------------------->
	<!--资金安全弹框-->
    <div class="frame bg-op09 hide" id="frame1">
    	<p class="f19px c-282828 pt20 pb20 text-center">资金安全</p>
    	<div class="pl15 pr15">
	    	<%--<div class="safty_tiem">
	    		<div class="ico_r ico_sprite ico_bCourse11"></div>
	    		<p class="f17px">第三方担保专款</p>
	    		<p class="f13px c-808080 pb10">厦门银行存管，<%=TuanDai.WXApiWeb.CommUtils.GetBabyPlanAmountStr()%>万+第三方担保专款</p>
	    		<div class="bt-e6e6e6 pt10 line-h18 f11px c-ababab">
	    			当周转项目出现逾期时，担保公司自有资金先行垫付，若垫付资金不足则根据偿付规则启用“第三方担保专款”进行质保偿付，赔付投资者投资资金，以在一定限度内补偿出借人可能存在的回款损失。
	    		</div>
	    	</div>--%> 
            <div class="safty_tiem mt15">
	    		<div class="ico_r ico_sprite ico_bCourse10"></div>
	    		<p class="f17px">第三方担保</p>
	    		<p class="f13px c-808080 pb10"><%=assureModel!=null?assureModel.FullName:"" %></p>
	    	</div>
	    	<div class="safty_tiem mt15">
	    		<div class="ico_r ico_sprite ico_contract"></div>
	    		<p class="f17px">合同保障</p>
	    		<p class="f13px c-808080 pb10">每笔投资都会生成有效的电子合同</p>
	    	</div>
    	</div>
    </div>
    <div class="pos-f frame-law-b hide" id="frame1-b">
		<div class="opa_cover"></div>
		<div class="frame-close" id="close1"></div>
    </div>
<footer></footer> 
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.cookies.2.2.0.js"></script>
<script type="text/javascript" src="/scripts/TdStringHandler.js?v=2015101601"></script>
<script type="text/javascript" src="/scripts/Common.js"></script>
<script type="text/javascript" src="/scripts/zq_timedown.js" ></script> 
<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/investNew.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/noLoginInvest.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>

<% if ((model.Status ?? 0) == 2)
   { %>
<script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="/scripts/weixinapi.js?v=4.1"></script>
<script type="text/javascript" src="/scripts/detailShare.js?v=20160415006"></script>
<script type="text/javascript">
    ShareObj.projecttitle = "<%=model.Title%>";
    ShareObj.projectrate = "<%=model.InterestRate%>";
    ShareObj.projectdeadline = "<%=model.Deadline%>";
    ShareObj.projectdeadtype = "<%=model.DeadType%>";
    ShareObj.wxsharetitle = "我在团贷发现了一个不错的项目，你也来看看吧！";
    ShareObj.wxsharedesc = "年化利率<%=ToolStatus.DeleteZero(model.InterestRate)%>%，期限<%=model.Deadline%><%=model.DeadType==1?"个月":"天"%>，<%=ToolStatus.ConvertRepaymentType(model.RepaymentType.Value)%>";
    ShareObj.shareurl = "<%=GlobalUtils.MTuanDaiURL%><%=HttpContext.Current.Request.RawUrl %>"; 
</script>
<%} %>
<script type="text/javascript">  
    var scrollT = "";
    function moveToTop(open, target) {
        $(open).click(function () {
            scrollT = $(window).scrollTop();
            $(target).removeClass('hide').removeClass('moveToBottom').addClass('moveToTop');
            setTimeout(function () {
            	$("#bigDiv").hide();
            }, 400);
        });
    }

    function moveToBottom(close, target) {
        $(close).click(function () {
        	$("#bigDiv").show();
            $(window).scrollTop(scrollT);
            $(target).removeClass('moveToTop').addClass('moveToBottom');
            setTimeout(function () {
                $(target).addClass('hide');
            }, 400);
        })
    }

    $(function () {
        $("#btnQuestion").click(function () {
            window.location.href = "/pages/invest/jing_question.aspx?proTime=<%=model.AddDate.HasValue?model.AddDate.Value.ToString("yyyy-MM-dd"):"2017-08-02"%>";
        });
        $(".dropdownTit").click(function () {
            var next = $(this).next();
            var triangle = $(this).find('i');
            if (next.hasClass('hide')) {
                triangle.removeClass('rotate0');
                next.removeClass('hide');
            } else {
                triangle.addClass('rotate0');
                next.addClass('hide');
            }
        });
        moveToTop("#f1", '#frame1,#frame1-b');
        moveToBottom('#close1','#frame1,#frame1-b');
    }) 
</script>
</body>
</html>
