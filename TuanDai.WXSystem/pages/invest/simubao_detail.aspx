﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="simubao_detail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.simubao_detail" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>私募宝-项目详情</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /> 
    <link rel="stylesheet" type="text/css" href="/css/invest.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/investProcess.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=<%=GlobalUtils.Version %>" />
    <!--借款-->
    <script type="text/javascript">
        var projectId = "<%=projectId %>";
        var backurl = "<%= GetEncodeBackUrl()%>";
    </script>
    <style type="text/css">
    	.gyl-tit{padding-left: 90px;}
        .l5{left: 5px !important;}
    </style>
</head>
<body>
<div id="bigDiv">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <a class="back" href="<%=string.IsNullOrEmpty(GoBackUrl)?"/pages/invest/invest_list.aspx":GoBackUrl %>">返回</a>
            <h1 class="title">项目详情</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <section class="wrapper-loan assetsbid-cn">
   
        <div class="pos-r gyl-tit pt15 pb15 pr15 mt7 bb-e6e6e6">
            <span class="c-212121 f14px pos-a l5">【私募宝】</span> 
            <p class="c-808080 f14px"><%=model.Title %></p>
        </div>
        <div class="info-item clearfix">
            <div class="info-l lf">
            	<p>借款总额: <span class="f16px c-ff6600"><%=Tool.MoneyHelper.ConvertLowerMoney(model.Amount??0)%></span>元</p>
            </div>
        </div>
        <div class="info-item clearfix">
            <div class="info-l lf">
                <p>
                    <%if (smbProjectEntity!=null&&smbProjectEntity.ProfitTypeId == 1)
                      {%>    预期收益<%}
                      else
                      { %>年化利率<%} %>
                    <span class="c-ff6600">
                        <%if (smbProjectEntity != null&&smbProjectEntity.ProfitTypeId == 1)
                          {%>
                        <%=ToolStatus.DeleteZero(smbProjectEntity.PreProfitRate_S??0)%>% -
                                <%=ToolStatus.DeleteZero(smbProjectEntity.PreProfitRate_E??0)%>% 
                            <% }
                          else
                          {%>
                        <%=model.InterestRate %>% 
                            <%} %> 
                    </span>
                </p>
            </div>
            <div class="info-r simubao-info-r rf">
                <p>项目期限:<span class="c-ff6600"><%=model.Deadline.HasValue ? model.Deadline.Value :0 %>个月</span></p>
            </div>
        </div>
        <div class="info-item clearfix">
            <div class="info-l lf">
                <p>出借单位:<span class="c-ff6600"><%=ToolStatus.DeleteZero(model.LowerUnit.Value) %></span><span class="c-212121">元</span></p>
            </div>
            <div class="info-r simubao-info-r rf">
                <p>收益方式:<span class="c-ff6600"><%=smbProjectEntity!=null?(smbProjectEntity.ProfitTypeId == 1?"保本浮动收益":"固定收益"):""%></span></p>
            </div>
        </div>
        <div class="info-item clearfix">
            <div class="info-l lf">
                <p>剩余份数:<span class="c-ff6600"><%=(model.Status != 3 && model.Status != 7) ? ToolStatus.diff(model.TotalShares, model.CastedShares) : "0"%></span><span class="c-212121">份</span></p>
            </div>
            <div class="info-r simubao-info-r rf">
                <p>担保机构:<span class="c-ff6600"><%=EnterpriseName%></span></p>
            </div>
        </div>
        <div class="info-item clearfix mb15">
            <div class="info-l lf">
                <p>
                    剩余时间：
                        <%if (model.Status == 2 && model.TenderDate > DateTime.Now)
                          {%>
                        <span class="timeSet" enddate="<%=model.TenderDate %>" startdate="<%=model.TenderStartDate %>" serverdate="<%=DateTime.Now %>" style="color: Black;">
                            <span id="day" style="font-size: 13px; color: #ff6600;">00</span> 天 
                            <span id="hour" style="font-size: 13px; color: #ff6600;">00</span> 时 
                            <span id="mini" style="font-size: 13px; color: #ff6600;">00</span> 分 
                            <span id="sec" style="font-size: 13px; color: #ff6600;">00</span> 秒
                        </span>
                        <%}
                          else if ((model.Status > 2 && model.Status < 12) || model.TenderDate < DateTime.Now)
                          { %><span class="timeSet" enddate="<%=DateTime.Now %>" startdate="<%=model.TenderStartDate %>"
                              serverdate="<%=DateTime.Now %>" style="color: none;">已完成</span>
                        <%}
                          else
                          {%>
                        <span class="timeSet" enddate="<%=DateTime.Now %>" startdate="<%=model.TenderStartDate %>"
                            serverdate="<%=DateTime.Now %>" style="color: none;">未开始</span>
                        <%} %>
                </p>
            </div>
        </div>
        <div class="bg-fbfbf9 bb-e6e6e6 bt-e5e5e5"><h2 class="c-212121">项目详情</h2></div>
        <div class="info-item simubao-d border-b">
            <h3 class="f14px c-fab600">项目概述</h3>
            <p class="f13px c-ababab">产品名称：<span class="c-212121 f13px"><%=smbProjectEntity.ProductName %></span></p>
            <p class="f13px c-ababab">历史业绩：<span class="c-212121 f13px"><%=smbProjectEntity.HistoryScore %></span></p>
            <p class="f13px c-ababab">基金经理：<span class="c-212121 f13px"><%=smbProjectEntity.FundManager %></span></p>
            <p class="f13px c-ababab">发行机构：<span class="c-212121 f13px"><%=smbProjectEntity.DepositOrg %></span></p>
            <p class="f13px c-ababab">资管公司：<span class="c-212121 f13px"><%=smbProjectEntity.AssetsManCompany %></span></p>
            <p class="f13px c-ababab">托管银行：<span class="c-212121 f13px"><%=smbProjectEntity.DepositBank %></span></p>
            <p class="f13px c-ababab">认购费：<span class="c-212121 f13px"><%=(smbProjectEntity.SubscribeRate ?? 0) == 0 ? "无" : GetSubscribeRate(smbProjectEntity.SubscribeRate ?? 0)%></span></p>
            <p class="f13px c-ababab">服务费：<span class="c-212121 f13px"><%=(smbProjectEntity.InvestFeeRate ?? 0)==0?"无": GetInvestFeeRate((smbProjectEntity.InvestFeeRate ?? 0),smbProjectEntity.ProfitTypeId??0)%></span></p>
            <% if (smbProjectEntity.ProfitTypeId == 1)
               { %>
            <p class="f13px c-ababab">计算净值：<span class="c-212121 f13px"><%=(smbProjectEntity.SubPrice ?? 0) == 0 ? "以满标后一个工作日的净值开始计算收益" : smbProjectEntity.SubPrice.Value.ToString()%></span></p>
            <p class="f13px c-545454 border-b pb20">结算净值：<span class="c-212121 f13px"><%=(smbProjectEntity.RepayPrice ?? 0) == 0 ? "未到结算日" : smbProjectEntity.RepayPrice.Value.ToString()%></span></p>
            <% } %>
            <p class="mt10 mb15 f12px fx-text c-ababab">风险提示：私募基金为浮动收益投资产品，有一定亏损风险，投资请谨慎。</p>
            <div class="pic-cn pr10 border-b pb20">
                <%=HttpUtility.HtmlDecode(smbProjectEntity.AppDescription)%>
            </div>
            <a href="simubao_income_trend.aspx?projectId=<%=model.Id %>">
                <div class="clearfix border-b link">
                    <h3 class="f13px lf c-212121">收益走势</h3>
                    <div class="rf">
                        <i class="ico-arrow-r"></i>
                    </div>
                </div>
            </a>
            <a href="/pages/invest/SubscribeUser.aspx?type=project&id=<%=model.Id %>">
                <div class="clearfix border-b link">
                    <h3 class="f13px lf c-212121">申购人数</h3>
                    <div class="rf">
                        <span class="c-ababab f13px"><%=SubscribeUserCount %>人</span>
                        <i class="ico-arrow-r"></i>
                    </div>
                </div>
            </a>
            <a href="simubao_question.aspx">
                <div class="clearfix border-b link">
                    <h3 class="f13px lf c-212121">常见问题</h3>
                    <div class="rf">
                        <i class="ico-arrow-r"></i>
                    </div>
                </div>
            </a>
        </div>
        <div class="bg-fbfbf9 pb75"></div> 
         <div class="text-center c-ababab bt-e6e6e6 ftb_bot">
			市场有风险，投资需谨慎。查看<a class="c-fab600" href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/P2PRisk.html">《风险揭示书》</a>
	    </div>
     </section>
 </div>
<footer> 
    <a href="javascript:void(0)" class="<%=((model.Status??0) == 2)?"loan-button":"loan-button-gray" %>"><%=((model.Status??0) == 2)?"马上投资":"已满标" %></a> 
</footer> 
    
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/jquery.cookies.2.2.0.js"></script>
    <script type="text/javascript" src="/scripts/TdStringHandler.js?v=2015101601"></script> 
    <script type="text/javascript" src="/scripts/Common.js"></script>
    <script type="text/javascript" src="/scripts/investNew.js?v=<%=GlobalUtils.Version %>"></script> 
    <script type="text/javascript" src="/scripts/noLoginInvest.js?v=<%=GlobalUtils.Version %>"></script>  
    <script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
    <script src="/scripts/zq_timedown.js" type="text/javascript"></script> 
 
</body>
</html>
