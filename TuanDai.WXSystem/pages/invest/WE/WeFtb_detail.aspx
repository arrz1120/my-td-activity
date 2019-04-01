﻿<%@ Page Language="C#" AutoEventWireup="true"   CodeBehind="WeFtb_detail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.WE.WeFtb_detail" %>
<%@ Import Namespace="System.Activities.Statements" %>
<%@ Import Namespace="Tool" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>
 
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title><%=model.IsNewHand?"新手专享复投宝": model.FTBSubType.HasValue && model.FTBSubType==3?"速盈宝":"复投宝" %>详情</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" /> 
	<link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/investProcess.css?v=<%=GlobalUtils.Version %>" />   
    <link rel="stylesheet" type="text/css" href="/css/baikedaohang.css?v=<%=GlobalUtils.Version %>" />
    <style type="text/css">
        li .c-808080 {
            width: 15%;
            display: inline-block;
        }
    </style>
    <script type="text/javascript">
        var projectId = "<%=projectId %>";
        var isWeFQB = "0";
        var backurl = "<%= GetEncodeBackUrl()%>";
    </script>
</head>
<body class="bg-f1f3f5" style="padding-bottom: 45px;">
<div id="bigDiv">
    <%= this.GetNavStr()%>
     <header class="headerMain">
        <div class="header bb-c2c2c2">
            <div class="back" onclick="javascript:window.location.href='/pages/invest/we/WE_list.aspx'">返回</div>
            <h1 class="title">计划详情</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header> 
    
    <% if(IsNewHandNewRule && model.IsNewHand){ %>
    <div class="newUserTips">        
    	<p class="f13px">新用户注册30天内，限投<%=limitInvestNum%>次，累计限额<%=limitInvestStr %></p>
    </div>
    <%} %>
    
     <!--We详情 End--> 
    <div class="detail-top-bg bb-e6e6e6 <%=IsWeFinish?"pro-finish":"pro-notFinish"%>">
		<div class="pl15 pos-r pt15 detail_tit">
			<p class="f14px c-808080 text-overflow"><%=model.ProductName %></p>
		</div>
		<div class="pt10 text-center">
			<p><span class="f13px c-ababab">参考年回报率(到期本息)</span></p>
		</div>
		<div class="rateIncome"> 
            <p><%=GetWePlanYearRate()%></p>
		</div>
       <div class="rect-box webkit-box box-center" style="width:100%;"> 
           <%=ShowWePubCach(model)%> 
           <%=ShowWeRank(model) %>  
          <% if(model.IsNewHand){ %> 
			    <div class="rect_b f11px c-ffffff text-center">新手专享</div>
               <% if(IsNewHandNewRule){ %>
			    <div class="rect_r f11px c-ffffff text-center" style="width:79px">累计限投<%=limitInvestStr %></div>
                <div class="rect_r f11px c-ffffff text-center">限投<%=limitInvestNum%>次</div> 
               <%}else{ %>
                 <div class="rect_r f11px c-ffffff text-center" style="width:79px">限投<%=limitInvestStr %></div>
               <%} %>
          <%} %> 
        </div> 
		<div class="bg005 mt5">
			<div class="clearfix pt15">
				<div class="lf w33p text-center">
					<p class="f17px c-212121"><%=ToolStatus.ConvertLowerMoney((model.PlanAmount ?? 0) - (model.OrderQty ?? 0) * (model.UnitAmount ?? 0)) %></p>
					<p class="line-h20 f12px c-ababab">剩余金额(元)</p>
				</div>
				<div class="lf w33p text-center">
					<p class="f17px c-212121"><%=model.Deadline %><%=model.DeadType==1?"个月":"天"%></p>
					<p class="line-h20 f12px c-ababab"><%=model.IsNewHand?"":"最长" %>持续服务期</p>
				</div>
				<div class="lf w33p text-center">
					<p class="f17px c-212121"><%= Convert.ToDouble(model.UnitAmount ?? 0) %>元/份</p>
					<p class="line-h20 f12px c-ababab">投资单位</p>
				</div>
			</div>
			<div class="pl15 pr15 pt15 pb11">
				<div class="pBar">
					<div class="barRate" style="width:<%= Tool.WebFormHandler.ProcessBar( (model.OrderQty ?? 0) * (model.UnitAmount ?? 0), model.PlanAmount ?? 0,2)%>%;"></div>
				</div>
				<div class="mt4 clearfix">
					<div class="lf f13px c-ababab">总金额：<%=ToolStatus.ConvertLowerMoney(model.PlanAmount)%></div>
					<div class="rf f13px c-ababab"><%= Tool.WebFormHandler.ProcessBar( (model.OrderQty ?? 0) * (model.UnitAmount ?? 0), model.PlanAmount ?? 0,2)%>%</div>
				</div>
			</div>
			<div class="bt-e6e6e6 moneySafty pr40 pl15" id="f1">
				<%--<div class="c-ababab f13px text-center"><i class="ico-suc03"></i>第三方担保专款</div>--%>
				<div class="c-ababab f13px text-center"><i class="ico-suc03"></i>第三方担保</div>
				<div class="c-ababab f13px text-center"><i class="ico-suc03"></i>电子合同</div>
				<div class="ico-arrow-r"></div>
			</div>
		</div>
		<div class="finishImg"><img src="/imgs/images/bg/pro-finish.png" /></div>
	</div>  
    <!--We详情 End--> 
    	
	<div class="is_tit bb-e6e6e6 pos-r f17px mt15 pl15 bg-fff" onclick="javascript:window.location.href='/pages/invest/SubscribeUser.aspx?type=weplan&id=<%=model.ProductId %>';">
		投资记录
		<b class="c-ababab f13px"><%=model.OrderCount??0 %></b>
		<div class="ico-arrow-r"></div>
	</div>

	<!--项目描述-->
	<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
		<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle"></i>服务简介</div>
		<div class="dropdownCon">
		    <% if (model.IsNewHand)
		       {
		    %>
            <div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15">“新手专享复投宝”是团贷网专为新注册投资者推出的新型智能投资服务工具。加入即进入持续服务期，持续服务期间投资者加入新手专享复投宝的资金将由系统在投资者认可的标的范围内分散匹配符合要求的标的，并由系统在投资者授权下将所投标的回款自动再次匹配符合要求的标的，持续服务期到期后，系统协助投资者完成债权退出。参考回报不代表对实际利息回报的承诺。</div>
            <%
               }
             else if (model.FTBSubType.HasValue && model.FTBSubType == 3)
             {
             %>
            <div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15">“速盈宝”是团贷网推出的新型智能投资工具。加入“速盈宝”即进入持有期，持有期内“速盈宝”在投资者认可的标的范围内，对符合要求的标的进行优先自动投标，并由投资者授权系统到期后自动退出。到期后如实际收益高于参考回报，超出部分作为服务费由平台收取；到期后如实际收益低于参考回报，平台将补发与差额等值的现金奖励。</div>
            <%
             }
		       else
		       {
		           %>
            <div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15">
                “复投宝”是团贷网推出的新型智能投资服务工具。加入复投宝的资金将由系统在投资者认可的标的范围内分散匹配符合要求的标的，持续服务期间内系统在投资者授权下将所投标的回款自动再次匹配符合要求的标的，投资者持续享有本复投宝服务期满<%=model.ExitLockMonth %>个月可随时申请结束服务，不结束本服务可继续享有本服务，系统最长可允许投资者持续享有本复投宝服务<%=model.Deadline %>个月。参考回报不代表对实际利息回报的承诺。
            </div>
			<div class="ftb_process">
				<div class="ftb_line"></div>
				<p><i class="ftb_i1"></i>加入复投宝<span>(<%=DateTime.Today.ToString("yyyy.MM.dd") %>)</span></p>
				<p><i class="ftb_i2"></i>锁定期(T+5)内自动匹配项目<span>(<%=DateTime.Today.AddDays(5).ToString("yyyy.MM.dd") %>)</span></p>
				<p><i class="ftb_i3"></i>项目回款<b class="ftb_i3_1"></b>回款自动投资<b class="ftb_i3_2"></b></p>
				<p><i class="ftb_i4"></i>可随时结束服务<span>(<%=DateTime.Today.AddDays(7).AddMonths(model.ExitLockMonth??0).ToString("yyyy.MM.dd") %>)</span></p>
				<p><i class="ftb_i5"></i>最长持续服务期到期<span>(<%=DateTime.Today.AddDays(6).AddMonths(model.Deadline??0).ToString("yyyy.MM.dd") %>)</span></p>
			</div>
            <%
		       } %>
			
		</div>
	</div>
    <% if (!model.IsNewHand && ( (!model.FTBSubType.HasValue) || (model.FTBSubType.HasValue && model.FTBSubType != 3)))
       {
           %>
    <!--收益规则-->
	<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
		<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>收益规则</div>
		<div class="dropdownCon hide">
			<div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15">
			    复投宝持续服务期间内，参考年回报率逐月递增，持续服务时间越长参考回报越高。结束服务时，按持续服务时间对应的参考年回报率计算收益（详见结束服务规则）。
			</div>
		</div>
	</div>

	<!--退出规则-->
	<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
		<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>结束服务规则</div>
		<div class="dropdownCon hide">
		    <p class="f14px pb5">如何结束服务</p>
            <div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15">投资者持续享有复投宝服务满<%=model.ExitLockMonth %>个月后可随时结束服务，结束服务完成时间视市场交易情况而定，结束服务时以参考年回报率计算参考回报。</div>
            <p class="f14px pb5">服务费</p>
            <div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15">结束复投宝服务时如实际收益高于参考回报，超出部分作为平台服务费由平台收取。</div>
            <br>
            <div class="c-808080 f14px pb15 text-justify pr15">结束复投宝服务时按持续服务时间对应的参考年回报率计算参考回报，越早结束服务参考回报越低。</div>
			<%--<p class="f14px pb5">到期退出</p>
			<div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15">项目期限为<%=model.Deadline %>个月（不含资金锁定期）。计划到期，系统将自动帮投资者转让债权，并在T+3个自然日内完成退出。计划到期后以参考年回报率计算并发放收益；</div>
			<p class="f14px pb5 pt15">提前退出</p>
			<div class="c-808080 f14px text-justify pr15">持有满<%=model.ExitLockMonth %>个月后可随时申请转让退出，支持全额提前退出，每笔申请退出本金至少100元。</div>
			<div class="c-808080 f14px pb15 text-justify pr15">提前退出按持有时间对应的参考年回报率进行收益计算，越早退出收益越低。</div>--%>
			<div class="quit_rule">
				<ul>
                    <% if(FTBRateList!=null && FTBRateList.Any()){
                           int rateIndex = 0;
                           int wUnit = 4;
                           decimal preYearRate = 0;
                           var index = -1;
                           foreach (var item in FTBRateList)
                           {
                               var count = FTBRateList.Where(o => o.YearRate == item.YearRate).Count();
                               index++;
                               if (model.Deadline == 36 && (item.MonthType < model.ExitLockMonth -1))
                                   continue;
                               if (index > 0 && item.YearRate == FTBRateList[index - 1].YearRate && (model.Deadline - index) != model.ExitLockMonth.Value - 1)
                                   continue;

                               if (item.MonthType > model.ExitLockMonth && preYearRate != item.YearRate)
                               {
                                   if (!(model.Deadline.Value == 24 && item.MonthType == 24))
                                       rateIndex++;
                               }
                               preYearRate = item.YearRate;
                               %>
					    <li><span class="c-808080"><%=item.MonthType==model.ExitLockMonth.Value-1?("1-"+(model.ExitLockMonth-1).ToString()):count>1&&item.MonthType > model.ExitLockMonth.Value?(item.MonthType-count+1).ToString()+"-"+item.MonthType.ToString():item.MonthType.ToString()%>月<%=item.MonthType<10?"&nbsp;&nbsp;":"" %></span><i <%=item.MonthType<model.ExitLockMonth?"class='bg_gray'":"" %> style="width:<%=65-rateIndex*wUnit%>%;"></i><span class="<%=item.MonthType<model.ExitLockMonth?"c-ababab":"c-fab600" %>"><%=ToolStatus.DeleteZero(item.YearRate)+"%"%></span></li>	 
                    <% 
                           }
                      } %>
				</ul>
			</div>
		</div>
	</div>
    <%
       } %>
	
		
	<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
		<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>投标范围</div>
		<div class="dropdownCon hide">
		    <%  string projectTypesDesc = TuanDai.WXApiWeb.CommUtils.GetProjectTypesDesc(model.ProjectTypes);
                if (projectTypesDesc.Contains("微团贷"))
		       {
		           %>
            <a href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/contractType11.html" class="is_tit block bb-e6e6e6 pos-r f14px c-808080">微团贷
				<b class="c-ababab f13px">查看合同</b>
				<div class="ico-arrow-r"></div>
			</a>
            <%
		       }  if (projectTypesDesc.Contains("供应链"))
		       {
		           %>
            <a href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/contractType19.html" class="is_tit block bb-e6e6e6 pos-r f14px c-808080">供应链
				<b class="c-ababab f13px">查看合同</b>
				<div class="ico-arrow-r"></div>
			</a>
            <%
		       }  if (projectTypesDesc.Contains("分期宝"))
		       {
		           %>
            <a href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/phkxServiceContract.html" class="is_tit block bb-e6e6e6 pos-r f14px c-808080">分期宝
				<b class="c-ababab f13px">查看合同</b>
				<div class="ico-arrow-r"></div>
			</a>
            <%
		       }
		          if (projectTypesDesc.Contains("资产标"))
		          {
                      %>
            <a href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/ContractType6.html" class="is_tit block bb-e6e6e6 pos-r f14px c-808080">资产标
				<b class="c-ababab f13px">查看合同</b>
				<div class="ico-arrow-r"></div>
			</a> 
            <%
		          }
		          if (projectTypesDesc.Contains("小微企业"))
		       {
		           %>
			<a href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/ContractType1.html" class="is_tit block bb-e6e6e6 pos-r f14px c-808080">小微企业
				<b class="c-ababab f13px">查看合同</b>
				<div class="ico-arrow-r"></div>
			</a> 
            <%
		       }%>
		</div>
	</div>
    <a href="Ftb_ZQDetail.aspx?productid=<%=model.ProductId %>" class="is_tit block bb-e6e6e6 pos-r f17px mt15 pl15 bg-fff">
			债权明细
		<div class="ico-arrow-r"></div>
	</a>
	<% if (model.IsNewHand)
	   {
        %>
    <a href="We_Question.aspx?isWeNewHand=1&productid=<%=model.ProductId %>" class="is_tit block bb-e6e6e6 pos-r f17px mt15 pl15 bg-fff">
			常见问题
			<div class="ico-arrow-r"></div>
		</a>
    <%
	   }else if (model.FTBSubType.HasValue && model.FTBSubType == 3)
	   {
	       %>
    <div class="mt15 bt-e6e6e6 bb-e6e6e6 bg-fff pl15 pr15">
			<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>常见问题</div>
			<div class="dropdownCon hide">
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">速盈宝如何计算收益？</p>
					<p class="f14px c-808080 pt12 text-justify">速盈宝收益按照：<span class="f14px c-fd6040">[投资金额 * 参考年回报率 * 计划期限 / 12]</span>计算，计划到期后如实际收益高于参考回报，超出部分作为服务费由平台收取；计划到期后如实际收益低于参考回报，平台将补发与差额等值的现金奖励。</p>
				</div>
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">速盈宝安全吗？</p>
					<p class="f14px c-808080 pt12 text-justify">速盈宝所投标的适用于安全保障计划。</p>
				</div>
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">速盈宝到期后如何退出？</p>
					<p class="f14px c-808080 text-justify">计划到期，系统将自动帮投资者转让债权，并在T+3个自然日内完成退出。</p>
				</div>
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">速盈宝是否收取服务费？</p>
					<p class="f14px c-808080 pt12 text-justify">到期退出后如实际收益高于参考回报，超出部分作为平台服务费由平台收取。</p>
				</div>
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">为什么速盈宝的计划期限是<%=model.Deadline %>个月，投资标的借款期限不一定是<%=model.Deadline %>个月呢？</p>
					<p class="f14px c-808080 pt12 text-justify">速盈宝所投标的借款期限与计划期限无关，如所投标的借款期限比<%=model.Deadline %>个月长，系统会在计划到期时自动帮您通过债权转让退出计划；如所投标的借款期限比<%=model.Deadline %>个月短，系统会在标的到期后自动帮您匹配新的标的。</p>
				</div>
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">速盈宝的计划期限（即持有期）从哪一日开始？</p>
					<p class="f14px c-808080 pt12 text-justify">速盈宝的计划期限（即持有期）自加入之日起算。</p>
				</div>
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">加入速盈宝后，相应的待收和授信额度什么时候会增加？</p>
					<p class="f14px c-808080 pt12 text-justify">速盈宝的待收和授信额度按计划的待收计算，系统会在用户加入速盈宝后即增加相应的待收和授信额度。</p>
				</div>
                <div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">加入速盈宝后，团币是如何发放的？</p>
					<p class="f14px c-808080 pt12 text-justify">1个月速盈宝的团币在加入后即发放。</p>
                    <p class="f14px c-808080 pt12 text-justify">3个月速盈宝的团币按照计划期限平均分摊至每月发放，加入后即发放第一个月的团币，下一个月的团币于次月同日发放，若遇到下一个月无同日情况（31日或2月份），则在自然月的最后一天发放。若该笔投资提前退出，则退出后剩余未发放的团币不再继续发放。</p>
				</div>
			</div>
		</div>
    <%
	   }else 
	   {
	       %>
	<!--<a href="javascript:void(0);" class="block is_tit bb-e6e6e6 pos-r f17px mt15 pl15 bg-fff" onclick="window.location.href='/pages/App/question/ftbQuestion.html';">
		常见问题
		<div class="ico-arrow-r"></div>
	</a>-->
	<!--常见问题-->
	<div class="mt15 bt-e6e6e6 bb-e6e6e6 bg-fff pl15 pr15">
			<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>常见问题</div>
			<div class="dropdownCon hide">
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">投资者加入复投宝后，如何计算持续享有复投宝服务的参考回报？</p>
					<p class="f14px c-808080 pt12 text-justify">投资者持续享有复投宝服务的参考回报按照：<span class="f14px c-fd6040">[投资金额 * 参考年回报率 * 持有时间]</span>计算（投资金额即加入复投宝的资金投标成功的金额），复投宝参考年回报率与持续服务时间相关，持续服务时间越长，结束服务时参考年回报率越高，参考回报也会越高。</p>
					<p class="f14px c-808080 text-justify">举例说明：加入最长持续服务期为36个月的复投宝10000元，全额投标成功后，如您在持续享有复投宝服务9个月15天（对应参考年回报率10.4%）时申请结束服务，参考回报：</p>	
					<p class="f14px c-808080 text-justify" id="txt-overflow">10000*10.4%*9/12+10000*10.4%*15/365=822.74。</p>	
					
				</div>
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">复投宝智能投资服务安全吗？</p>
					<p class="f14px c-808080 pt12 text-justify">加入复投宝智能投资服务后，其所投标的适用于安全保障计划。</p>
				</div>
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">如何结束复投宝服务？</p>
					<p class="f14px c-808080 pt12 text-justify">投资者持续享有复投宝服务满9个月后可随时结束服务，结束服务完成时间视市场交易情况而定，结束服务时以参考年回报率计算参考回报。</p>
				</div>
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">复投宝是否收取服务费？</p>
					<p class="f14px c-808080 pt12 text-justify">结束复投宝服务时如实际收益高于参考回报，超出部分作为平台服务费由平台收取。</p>
				</div>
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">为什么复投宝的最长持续服务期是<%=model.Deadline %>个月，投资标的借款期限不一定是<%=model.Deadline %>个月呢？</p>
					<p class="f14px c-808080 pt12 text-justify">复投宝智能投资服务投资的标的借款期限与最长持续服务期无关，如所投标的借款期限比最长持续服务期长，系统会在最长持续服务期到期时在投资者的确认下帮投资者退出债权；如所投标的借款期限比最长持续服务期短，系统会在标的到期后帮您匹配新标的。</p>
				</div>
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">什么是复投宝的资金锁定期？</p>
					<p class="f14px c-808080 pt12 text-justify">资金锁定期：T(加入复投宝当日)+5个自然日内；加入复投宝的资金将被冻结在投资者的个人存管账户，系统在投资者授权下对符合要求的标的进行优先自动投标。</p>
				</div>
				<div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">复投宝的持续服务期从哪一日开始？</p>
					<p class="f14px c-808080 pt12 text-justify">复投宝的持续服务期自资金锁定期结束次日起算。
						<br />
						举例说明：如您在10月1日加入复投宝，则10月6日锁定期结束，持续服务期自10月7日起算。
					</p>
				</div>
                <div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">加入复投宝后，相应的待收和智享额度什么时候会增加？</p>
					<p class="f14px c-808080 pt12 text-justify">投资者加入复投宝后，相应的待收是按最长持续服务期对应的参考年回报率计算；加入复投宝的资金投标成功后系统会自动增加相应的待收和智享额度；如加入的资金分多笔投标成功，相应的待收和智享额度会在每次投标成功后增加；如投资者结束复投宝服务，待收和智享额度按照当前的持有本金计算。
					</p>
				</div>
                <div class="bt-e6e6e6 pt17 pb15">
					<p class="line-h18 f14px c-212121 text-justify">加入复投宝后，团币是如何发放的？</p>
					<p class="f14px c-808080 pt12 text-justify">投资者加入复投宝服务后，相应的团币按照最长持续服务期平均分摊至每月发放，加入后即发放第一个月的团币，下一个月的团币于次月同日发放，若遇到下一个月无同日情况（31日或2月份），则在自然月的最后一天发放。若投资者申请结束本复投宝服务，则结束服务后剩余未发放的团币不再继续发放。
					</p>
				</div>
			</div>
		</div>
    <%
	   } %>	
	<div class="text-center c-ababab bt-e6e6e6 ftb_bot">
			市场有风险，投资需谨慎。查看<a class="c-fab600" href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/P2PRisk.html">《风险揭示书》</a>
	</div>

    <!--按钮区域-->
	<div class="pos-f btn-joinNow"> 
      <% if (model.StartDate > DateTime.Now && model.StatusId == 1)
        { %>
        <a href="javascript:void(0);" class="btn btnGray" style="font-size:18px;text-align:left;padding-left:20px;"  attrid="<%= model.ProductId %>" title="<%= model.ProductName %>">离开放还有：<span style="color: #ffffff;font-size:16px;" class="timeSet" count="<%= model.StartDate > DateTime.Now ? Convert.ToInt32((model.StartDate.Value - DateTime.Now).TotalSeconds) : 0 %>">00时 00分 00 秒</span></a>
        <% if (!IsApp)
           {
               %>
        <a href="javascript:void(0);" class="btn-share webkit-box" id="btnShare"><i class="ico-sprite01 ico-share"></i></a>
        <%
           } %>
        
    <% }
        else if (model.StartDate < DateTime.Now && model.OrderQty != model.TotalQty && model.StatusId == 1)
        {
    %>
        <a href="javascript:void(0)" class="btn btnYellow" id="btnJoin">马上加入</a>
        <% if (!IsApp)
           {
               %>
        <a href="javascript:void(0);" class="btn-share webkit-box" id="btnShare"><i class="ico-sprite01 ico-share"></i></a>
        <%
           } %>
        
    <%
        }
        else
        { %>
             <div class="btn btnGray">计划已满</div>
        <% if (!IsApp)
           {
               %>
		     <a href="<%=TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser?"/pages/push_switch.aspx":"/pages/concernWeChat.aspx" %>" class="btn-share webkit-box box-center"><i class="ico-clock shake"></i></a>
		     <div class="txtFrame pos-a">
			    <p class="c-694514 f13px">订阅[<%=model.IsNewHand?"新手标专享复投宝":model.FTBSubType==3?"速盈宝":"复投宝"%><%=model.IsNewHand?"":model.TypeWord%>]上线提醒</p>
			    <span onclick="$('.txtFrame').hide();"></span>
		     </div> <%
           } %>
       <% } %> 
	</div> 
     
<!--资金安全弹框-->
<div class="frame bg-op09 hide" id="frame1">
	<p class="f19px c-282828 pt20 pb20 text-center">资金安全</p>
	<div class="pl15 pr15">
		<%--<div class="safty_tiem">
			<div class="ico_r ico_sprite ico_bCourse11"></div>
			<p class="f17px">第三方担保专款</p>
			<p class="f13px c-808080 pb10">厦门银行存管，<%=TuanDai.WXApiWeb.CommUtils.GetBabyPlanAmountStr()%>万+第三方担保专款</p>
			<div class="bt-e6e6e6 pt10 line-h18 f11px c-ababab">
				当借款项目出现逾期时，担保公司自有资金先行垫付，若垫付资金不足则根据偿付规则启用“第三方担保专款”进行质保偿付，赔付投资者投资资金，以在一定限度内补偿出借人可能存在的回款损失。
			</div>
		</div>--%>
		<div class="safty_tiem mt15">
			<div class="ico_r ico_sprite ico_bCourse10"></div>
			<p class="f17px">第三方担保</p>
			<p class="f13px c-808080 pb10"></p>
		</div>
		<div class="safty_tiem mt15">
			<div class="ico_r ico_sprite ico_contract"></div>
			<p class="f17px">电子合同</p>
			<p class="f13px c-808080 pb10">每笔投资都会生成有效的电子合同</p>
		</div>
	</div>
	<div class="frame-close" id="close1"></div>
</div>

<!--分享滑出层-->
<div class="share-popup pos-f">
	<div class="ml15 mr15 top bg-fff mt40 pos-r">
		<span class="by-l pos-a"></span>
		<span class="by-r pos-a"></span>
		<h3 class="text-center pos-r f17px"><%=model.IsNewHand?"新手标专享复投宝":model.FTBSubType==3?"速盈宝":"复投宝"%><%=model.IsNewHand?"":model.TypeWord%><span class="f17px ml15"></span></h3>
		<div class="webkit-box pt13 pb15">
			<div class="box-flex1 text-center">
				<p class="c-fd6040 f27px"><%=GetWePlanYearRate() %></p>
				<p class="c-ababab f12px">参考年回报率</p>
			</div>
			<div class="box-flex1 text-center">
				<p class="c-212121 f14px"><%=model.Deadline %><%=model.DeadType==1?"个月":"天" %></p>
				<p class="c-ababab f12px">最长持续服务期</p>
			</div>
		</div>
	</div>
	<div class="mid text-center">
		<span class="bb-d1d1d1"></span>
		<span class="c-212121 f15px">分享到</span>
		<span class="bb-d1d1d1"></span>
	</div>
	<div class="share-links webkit-box ml15 mr15">
		<a href="javascript:void(0);" class="wechat box-flex1 wxShare animated" style="display: none"><span><i></i></span>微信好友</a>  
		<a href="javascript:void(0);" class="moments box-flex1 wxShare animated" style="display: none"><span><i></i></span>朋友圈</a> 
		<a href="javascript:shareSina();" class="weibo box-flex1 webShare animated" ><span><i></i></span>新浪微博</a>
		<a href="javascript:share(2);" class="qq box-flex1 animated"><span><i></i></span>QQ</a>
		<a href="javascript:share(1);" class="qzone box-flex1 animated"><span><i></i></span>QQ空间</a>
	</div>
	<a href="javascript:void(0);" class="close-share animated"><i></i></a>
</div>
</div>
    <footer class="mt0 bt-e6e6e6">

	</footer>
<script type="text/javascript" src="/scripts/jquery.min.js"></script> 
<script type="text/javascript" src="/scripts/TdStringHandler.js?v=2015101601"></script>
<script type="text/javascript" src="/scripts/Common.js"></script> 
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/WePlanDetailNew.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script> 
<script type="text/javascript" src="/scripts/noLoginInvest.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="/scripts/weixinapi.js?v=4.0"></script>
<script type="text/javascript" src="/scripts/seo.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script> 
<script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>

<script type="text/javascript">
    var isNewHandProject = false;//是否新手标
    wxData.isWxJsSDK = true;
    wxData.debug = false;
    wxData.title = '参考年回报率<%=ToolStatus.DeleteZero(model.YearRate)%>%的自动投资神器！';
    wxData.img_url = "http://m.tuandai.com/imgs/sharelogo.png?v=20160407";
    wxData.ShareCallBack = function (res) {
        if (res == "success") {
            clearShareTip();
        }
    };
    wxData.BeforeShareCall = function (res) {
        wxData.desc = "<%=model.ProductName%>";
        var tdfrom = "WeWX160329";
        try {
            if (res == "wxfriend") {
                tdfrom = "WeWX160329";
                nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'WeWX', 'wx分享', '160329', 1, '', '', 'TDW_WX');
            } else if (res == "wxtimeline") {
                tdfrom = "WeWXFriendster160329";
                wxData.desc = '参考年回报率<%=ToolStatus.DeleteZero(model.YearRate)%>%的自动投资神器！';
                nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'WeWXFriendster', 'wx朋友圈', '160329', 1, '', '', 'TDW_WX');
            } else if (res == "qq") {
                tdfrom = "Weqq160329";
                nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'Weqq', 'QQ分享', '160329', 1, '', '', 'TDW_WX');
            } else if (res == "qqzone") {
                tdfrom = "WeQzone160329";
                nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'WeQzone', 'QQ空间分享', '160329', 1, '', '', 'TDW_WX');
            }
    } catch (ex) { }
        wxData.url = "<%=GlobalUtils.MTuanDaiURL%>/pages/invest/investShare.aspx?tdForm=" + tdfrom + "&id=<%=projectId%>";
    }
 
     

    var scrollT = "";

    function moveToTop(open, target) {
        $(open).click(function () {
            scrollT = $(window).scrollTop();
            $(target).removeClass('hide').removeClass('moveToBottom').addClass('moveToTop');
            setTimeout(function () { }, 400);
        });
    }

    function moveToBottom(close, target) {
        $(close).click(function () {
            $(window).scrollTop(scrollT);
            $(target).removeClass('moveToTop').addClass('moveToBottom');
            setTimeout(function () {
                $(target).addClass('hide');
            }, 400);
        })
    }
    //	点击分享按钮
    var isWeiXin = navigator.userAgent.toLowerCase().indexOf("micromessenger") != -1;
    var bd = document.body;

    $(function () {  
        //	分享层交互
        $("#btnShare").click(function () {
            $('.share-popup').addClass('current').bind("touchmove", function (e) {
                e.preventDefault();
            });
            $('.share-links a').addClass('bounceInUp');
            $('.close-share').addClass('bounceInUp');
        });
        $('.close-share').click(function () {
            $('.share-popup').removeClass('current');
            $('.share-links a').removeClass('bounceInUp');
            $('.close-share').removeClass('bounceInUp');
        });

        $('.wxShare').click(function () {
            sharePopup();
        });
        if (isWeiXin) {
            $(".wxShare").show();
            $(".webShare").hide();
        }
        moveToTop("#f1", '#frame1');
        moveToBottom('#close1', '#frame1');
    });
  
 

    function sharePopup() {
        if (isWeiXin) {
            if (!document.getElementById("shareTip")) {
                window.scrollTo(0, 0);
                var dom = document.createElement("div");
                dom.className = "modal-backdrop";
                dom.id = "shareTip";
                dom.innerHTML = '<div class="shareTip-box"><div class="shareTip"></div></div>';
                bd.appendChild(dom);
                dom.addEventListener("touchstart", clearShareTip, false);
            }
            return false;
        }
    }

    function clearShareTip() {
        var hintTip = document.getElementById("shareTip");
        hintTip.removeEventListener("touchstart", clearShareTip, false);
        bd.removeChild(hintTip);
    }

    function share(t) {
        var p = {
            url: "<%=GlobalUtils.MTuanDaiURL%>/pages/invest/investShare.aspx?tdForm=Weqq&id=<%=projectId%>",
            showcount: '0',/*是否显示分享总数,显示：'1'，不显示：'0' */
            desc: '<%=model.ProductName%>',/*默认分享理由(可选)*/
            summary: '团贷网（tuandai.com）,中国领先的互联网投资平台，超低门槛，期限7天-24个月任选，现在注册就送518元红包',/*分享摘要(可选)*/
            title: '参考年回报率<%=ToolStatus.DeleteZero(model.YearRate)%>%的自动投资神器！',/*分享标题(可选)*/
            site: '团贷网',/*分享来源 如：腾讯网(可选)*/
            pics: 'http://m.tuandai.com/imgs/sharelogo.png?v=20160407' /*分享图片的路径(可选)*/
        };
        var s = [];
        for (var i in p) {
            s.push(i + '=' + encodeURIComponent(p[i] || ''));
        }
        var params = s.join('&');
        if (t == 1) {
            nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'WeQzone', 'QQ空间分享', '160329', 1, '', '', 'TDW_WX');
            window.open("http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?" + params);
        }
        else {
            nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'Weqq', 'QQ分享', '160329', 1, '', '', 'TDW_WX');
            window.open("http://connect.qq.com/widget/shareqq/index.html?" + params);
        }
    };
    function shareSina() {
        var p = {
            url: "<%=GlobalUtils.MTuanDaiURL%>/pages/invest/investShare.aspx?tdForm=sina&id=<%=projectId%>",
            title: '参考年回报率<%=ToolStatus.DeleteZero(model.YearRate)%>%的自动投资神器！',
            appkey: '1343713053',
            pic: 'http://m.tuandai.com/imgs/sharelogo.png?v=20160407', /*分享图片的路径(可选)*/
            searchPic: "true"
        };
        var s = [];
        for (var i in p) {
            s.push(i + '=' + encodeURIComponent(p[i] || ''));
        }
        var params = s.join('&');
        params += "#_loginLayer_" + (new Date()).valueOf();
        nwbi_api.nwbi_logWebEvent(nwbi_userName, getNowFormatDate(), 'Wesina', '新浪分享', '160329', 1, '', '', 'TDW_WX');
        window.open("http://service.weibo.com/share/share.php?" + params);
    }

    var IsWeZnq = false;//是否是we计划4周年庆
    var DayJoinMoney = 0;//we计划4周年庆每天限制加入金额
    var DayJoinCount =0;//we计划4周年庆每天限制加入次数
</script>
</body>
</html>