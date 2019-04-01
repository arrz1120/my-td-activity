<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="xmb_detail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.xmb_detail" %>

<%@ Import Namespace="Tool" %>
<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>项目宝-项目详情</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=GlobalUtils.Version %>" /> 
    <link rel="stylesheet" type="text/css" href="/css/invest.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/investProcess.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=<%=GlobalUtils.Version %>" />
    <style type="text/css">
        .info-item .info-r{ width: 155px;text-align: left;}
        .gyl-tit{padding-left: 90px;}
        .l5{left: 5px !important;}
    </style>
    <!--借款-->
     <script type="text/javascript">
         var projectId = "<%=projectId %>";
         var backurl = "<%= GetEncodeBackUrl()%>";
    </script>
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
    <div id="wrapperdetail">
        <div id="scroller">
            <div id="pullDown"  style="display:none;">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div> 
<!--下拉刷新 Start-->
       <%-- <div class="bg-f2f2f2 mt5">
            <h2><%= model.Title%></h2>
        </div>--%>
         <div class="pos-r gyl-tit pt15 pb15 pr15 bb-e6e6e6">
            <span class="c-212121 f14px pos-a l5">【项目宝】</span> 
            <p class="c-808080 f14px"><%=model.Title %></p>
        </div>
        <div class="info-item clearfix border-b1">
            <div class="info-l lf">
                <p>借款总额:<span class="f16px c-ff6600"><%= ToolStatus.ConvertDetailWanMoney(model.Amount.Value)%></span>元</p>
            </div>
        </div>
        <div class="info-item clearfix">
            <div class="info-l lf">
                <% if (model.Type == 23)
                   {
                %>
                <p>年化收益:<span class="c-ff6600"><%= xmbModel.MinInterestRate.Value%>-<%= xmbModel.MaxInterestRate.Value%>%</span><img id="detail_B" onclick="showAlert();" src="/imgs/images/state9.png"></p>
                <%
                   }
                   else
                   {
                %>
                <p>年化收益:<span class="c-ff6600"><%= xmbModel.MinInterestRate%>%</span></p>
                <%
                   } %>
            </div>
            <div class="info-r rf">
                <% if (model.Type == 23)
                   {
                %>
                <p>借款期限:<span class="c-ff6600"><%= xmbModel.MinDeadLine%>-<%= xmbModel.MaxDeadLine%></span><span class="c-212121">个月</span></p>
                <%
                   }
                   else
                   {
                %>
                <p>借款期限:<span class="c-ff6600"><%= xmbModel.MinDeadLine%></span><span class="c-212121">个月</span></p>
                <%
                   } %>
            </div>
        </div>
        <div class="info-item clearfix">
            <div class="info-l lf">
                <p>出借单位:<span class="c-ff6600"><%= ToolStatus.DeleteZero(model.LowerUnit)%></span><span class="c-212121">元</span></p>
            </div>
            <%--<div class="info-r rf">
                <p>计息方式:<span class="c-ff6600">即投即计息</span></p>
            </div>--%>
        </div>
        <div class="info-item clearfix">
            <div class="info-l lf">
                <p>剩余份数:<span class="c-ff6600"><%=(model.Status != 3 && model.Status !=6)?ToolStatus.diff(model.TotalShares, model.CastedShares):"0"%></span><span class="c-212121">份</span></p>
            </div>
            <div class="info-r rf">
                <p>担保方式:<span class="c-ff6600"><%=EnterpriseName%></span></p>
            </div>
        </div>
        <div class="info-item clearfix mb15">
            <div class="info-l lf">
                <p>还款方式:<span class="c-212121 c-ff6600"><%=ToolStatus.ConvertRepaymentType(model.RepaymentType.Value) %></span></p>
            </div>
            <% if (model.TuandaiRate > 0)
                {
                        %>
                    <div class="info-r rf">
                        <p>团贷奖励:<span class="c-212121 c-ff6600"><%=model.TuandaiRate %>%</span></p>
                    </div>
                    <%      
                }%>
        </div>
        <div class="info-item clearfix mb15">
            <div class="info-l lf">
                <p>
                    剩余时间：
                <span class="c-212121">
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
                </span>
                </p>
            </div>
        </div>
        <% if (model.Type == 23 && IsSMBGuQuan==false)
           {
        %>
        <div class="tips text-left">
            本项目无固定期限，以资金实际使用时间为准。利率随时间变化而变化， 时间越长利率越高。
        </div>
        <% }           
           if(IsSMBGuQuan){ %>
             <div class="tips text-center mt10">
		    	风险提示：私募股权投资有一定风险，请谨慎投资。
		    </div>
        <%} %>


        <div class="bg-fbfbf9 bb-e6e6e6 bt-e5e5e5"><h2 class="c-212121">借款详情</h2></div>
        <div class="info-item simubao-d gyl-bd">
            <% if(IsSMBGuQuan){ %>
             <!--资金用途-->
          <div class="border-b pb20">
	        <h3 class="f14px c-fab600">基金信息</h3>
	        <div class="clearfix">
		        <div class="info-l lf">
		            <p class="f13px c-ababab">产品名称<span class="c-212121 f13px"><%=xmbModel.ProductName %></span></p>
		        </div>
		    </div>
		    <div class="clearfix">
		        <div class="info-l lf">
		            <p class="f13px c-ababab">管理机构<span class="c-212121 f13px"><%=xmbModel.DepositOrg %></span></p>
		        </div>
		    </div>
		    <div class="clearfix">
		        <div class="info-l lf">
		            <p class="f13px c-ababab">存续期限<span class="c-212121 f13px"><%=xmbModel.GoOnDeadLine %>年</span></p>
		        </div>
		       
		    </div> 
            <div class="clearfix">
                <div class="info-l lf">
		            <p class="f13px c-ababab">投资方向<span class="c-212121 f13px"><%= xmbModel.InvestAspect%></span></p>
		        </div>
            </div>
		    <div class="clearfix">
		        <div class="info-l lf">
		            <p class="f13px c-ababab">资本类型<span class="c-212121 f13px"><%=xmbModel.CapitalType %></span></p>
		        </div>
		    </div> 
	       </div>
           <!--投资范围-->
            <%if(!string.IsNullOrEmpty(xmbModel.InvestRange)){ %>
		    <div class="border-b pb20">
                <h3 class="f14px c-fab600">投资范围</h3>
                <%=xmbModel.InvestRange %>
            </div>
            <%} %>

	        <!--投资亮点-->
            <%if(!string.IsNullOrEmpty(xmbModel.InvestHighlight)){ %>
		    <div class="border-b pb20">
                <h3 class="f14px c-fab600">投资亮点</h3>
                 <%=xmbModel.InvestHighlight %>
             </div>
            <%} %>

            <%} %>

            <% if (!string.IsNullOrEmpty(xmbModel.AmountUsedDesc))
               { %>
            <div class="border-b pb20">
                <h3 class="f14px c-fab600">资金用途</h3>
                <p class="f12px c-545454 pr10"><%=xmbModel.AmountUsedDesc %></p>
            </div>
            <% }%> 

            <% if (!string.IsNullOrEmpty(xmbModel.ProjectDescription))
               {%>
            <div class="border-b pb20">
                <h3 class="f14px c-fab600">项目简介</h3>
                <p class="f12px c-545454 pr10"><%=xmbModel.ProjectDescription %></p>
            </div>
            <%}%>

            <% if (!string.IsNullOrEmpty(xmbModel.ProjectProspect))
               {%>
            <div class="border-b pb20">
                <h3 class="f14px c-fab600">项目前景</h3>
                <p class="f12px c-545454 pr10"><%=xmbModel.ProjectProspect %></p>
            </div>
            <%}%>

            <% if (!string.IsNullOrEmpty(xmbModel.ProfitBudget))
               {%>
            <div class="border-b pb20">
                <h3 class="f14px c-fab600">盈利预测</h3>
                <p class="f12px c-545454 pr10"><%=xmbModel.ProfitBudget %> </p>
            </div>
            <%}%>

            <% if (!string.IsNullOrEmpty(xmbModel.ProfitBudget))
               {%>
            <div class="pb20">
                <h3 class="f14px c-fab600">还款保障</h3>
                <p class="f12px c-545454 pr10"><%=xmbModel.RepaymentSecurity %> </p>
            </div>
            <%}%> 

            <%if(IsSMBGuQuan==false){ %>
            <!--借款人信息-->
            <div class="pr10 border-b pb20 company-info">
                <h3 class="f14px c-fab600">借款人信息</h3>
                <p class="f13px">公司名称<span class="f13px"><%=borrowerUserInfo.RealName.Length<3?borrowerUserInfo.RealName:BusinessDll.StringHandler.MaskStarPre3(borrowerUserInfo.RealName)%></span></p>
                <p class="f13px">组织机构代码<span class="f13px"><%=BusinessDll.StringHandler.MaskStarPre3(borrowerUserInfo.IdentityCard)%></span></p>
                <p class="f13px">注册时间<span class="f13px"><%=Tool.SafeConvert.ToDateTime(borrowerUserInfo.AddDate).ToString("yyyy-MM-dd")%></span></p>
            </div>

            <!--审核信息-->
            <div class="pr10 border-b pb20 company-info">
                <h3 class="f14px c-fab600">借款人信息</h3>
                <div class="verifyInfo pr10">
                    <div class="f14px">
                        <img src="/imgs/images/ico-loan1.png" />身份认证
                    </div>
                    <div class="f14px">
                        <img src="/imgs/images/ico-loan2.png" />手机认证
                    </div>
                    <div class="f14px">
                        <img src="/imgs/images/ico-loan3.png" />实地认证
                    </div>
                    <div class="f14px">
                        <img src="/imgs/images/ico-loan4.png" />邮箱认证
                    </div>
                </div>
            </div>

            <!--借款人信用档案-->
            <div class="files border-b">
                <h3 class="f14px c-fab600">借款人信用档案</h3>
                <div class="clearfix">
                    <div class="info-l lf">
                        <p>成功<%=model.Type == 1 ? "借入" : "出让" %>:<span class="c-000"><%=model.TotalSumShares ?? 0 %>份</span></p>
                    </div>
                    <div class="info-r rf">
                        <p>成功<%=model.Type == 1 ? "还款" : "回购" %>:<span class="c-000"><%=model.BuybackShares ?? 0 %>份</span></p>
                    </div>
                </div>
                <div class="clearfix">
                    <div class="info-l lf">
                        <p>累计利息成本: <span class="c-000"><%=ToolStatus.DeleteZero(model.InterestRate) %>%</span></p>
                    </div>
                    <div class="info-r rf">
                        <p>逾期违约:<span class="c-000"><%=model.badShares ?? 0 %>份</span></p>
                    </div>
                </div>
                <div class="clearfix">
                    <div class="info-l lf">
                        <p>逾期还款率:<span class="c-000"><%=allMonthBadrate %>%</span></p>
                    </div>
                </div>
            </div>
            <%} %>
        </div>

        <!--申购人数-->
        <div class="bg-fbfbf9 h20 bb-e6e6e6"></div>
       <!--股权新增的-->
       <div class="pb40 bg-fbfbf9">
        <% if(IsSMBGuQuan){ %>
        <a href="xmb_guanlijigou.aspx?projectid=<%=projectId %>">
            <div class="clearfix border-b ml10 sg-people btNone bg-fff">
                <h3 class="f13px lf">管理机构</h3>
                <div class="rf">
                    <i class="ico-arrow-r"></i>
                </div>
            </div>
        </a>
        <%} %>
        <a href="xmb_progress.aspx?projectid=<%=projectId%>">
            <div class="clearfix border-b ml10 sg-people btNone bg-fff">
                <h3 class="f13px lf">项目进展</h3>
                <div class="rf">
                    <i class="ico-arrow-r"></i>
                </div>
            </div>
        </a>
        <a href="/pages/invest/SubscribeUser.aspx?type=project&id=<%=model.Id %>">
            <div class="clearfix border-b ml10 sg-people btNone bg-fff">
                <h3 class="f13px lf">申购人数</h3>
                <div class="rf">
                    <span class="c-ababab f13px"><%=SubscribeUserCount %>人</span>
                    <i class="ico-arrow-r"></i>
                </div>
            </div>
        </a>       
        <a href="/pages/invest/xmb_question.aspx">
            <div class="clearfix border-b ml10 sg-people btNone bg-fff">
                <h3 class="f13px lf">常见问题</h3>
                <div class="rf">
                    <i class="ico-arrow-r"></i>
                </div>
            </div>
        </a> 
        <!--<div class="bg-fbfbf9"></div>-->
            </div>
        </div>
        </div>
        <div class="text-center c-ababab bt-e6e6e6 ftb_bot">
			市场有风险，投资需谨慎。查看<a class="c-fab600" href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/P2PRisk.html">《风险揭示书》</a>
	    </div>
        </section>
        </div>
        <footer>
            <%--<% if (TuanDai.WXApiWeb.WebUserAuth.IsAuthenticated)
               {
            %>--%>
            <a href="javascript:void(0)" class="<%=((model.Status??0) == 2)?"loan-button":"loan-button-gray" %>"><%=((model.Status??0) == 2)?"马上投资":"已满标" %></a>
            <%--<%
               }
               else
               {
                   %>
            <div class="pl10 pr5" style="width:46%; float: left;"><a href="/user/login.aspx?ReturnUrl=<%=HttpContext.Current.Request.Url %>" target="_self" class="userBtn btnRed">登录</a></div>
            <div class="pl10 pr5" style="width:46%; float: left;"><a href="/user/register.aspx?ReturnUrl=<%=HttpContext.Current.Request.Url %>" target="_self" class="userBtn btnYellow">注册</a></div>
            <%
               } %>--%>
          
        </footer>
            
    

    <!--弹窗-->
    <div class="alert bg-opacity07 zIndex250" id="alert" style="display: none;">
        <div class="alert_bg">
            <div class="alert_wp">
                <div class="alert_close" id="close" onclick="closeAlert()">
                </div>
                <div class="alert_tit">
                    <p>年化利率随资金使用时间变化而变化，时间越长利率越高</p>
                </div>
                <div class="tableB">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr class="th">
                            <td>资金使用时间（月）</td>
                            <td>对应年化利率</td>
                        </tr>
                        <% if (rateRangeList!=null && rateRangeList.Count > 0)
                           {
                               foreach (var item in rateRangeList)
                               { %>
                                        <tr>
                                        <td>
                                            <%=item.MinDeadLine == 0 ? "时间≤"+item.MaxDeadLine+"个月" : string.Format("{0}＜时间≤{1}个月",item.MinDeadLine -1 ,item.MaxDeadLine)  %> 
                                        </td>
                                        <td>
                                             <%=ToolStatus.DeleteZero(item.YearRate.Value) %>%
                                        </td>
                                       </tr>     
                                     <%}} %>   
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/jquery.cookies.2.2.0.js"></script>
    <script type="text/javascript" src="/scripts/TdStringHandler.js?v=2015101601"></script> 
    <script type="text/javascript" src="/scripts/Common.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js"></script>
    <script type="text/javascript" src="/scripts/scrollDetail.js"></script>
    <script type="text/javascript" src="/scripts/investNew.js?v=<%=GlobalUtils.Version %>"></script> 
    <script type="text/javascript" src="/scripts/noLoginInvest.js?v=<%=GlobalUtils.Version %>"></script> 
    <script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/zq_timedown.js" ></script>
    <script type="text/javascript">
        $(function () {
            iScroll.onLoadData = refreshPage;
        });
        function showAlert() {
            $("#alert").show();
        }
        function closeAlert() {
            $("#alert").hide();
        } 
    </script>
</body>
</html>
