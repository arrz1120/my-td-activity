<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="huafei_detail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.huafei_detail" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>话费分期-项目详情</title>
<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
<link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=<%=GlobalUtils.Version %>" />
<link rel="stylesheet" type="text/css" href="/css/investProcess.css?v=<%=GlobalUtils.Version %>" /> 
</head>
<script type="text/javascript">
    var projectId = "<%=projectId %>";
    var backurl = "<%= GetEncodeBackUrl()%>";
</script>
<body class="bg-f1f3f5">
    <div id="bigDiv"> 
    <%= this.GetNavStr()%>
	<header class="headerMain">
	    <div class="header bb-c2c2c2">
	        <div class="back" onclick="javascript:history.go(-1);"></div>
	        <h1 class="title">话费分期-项目详情</h1>
	        <div class="text"><a href="automatic_rules.html"><i class="rf ico-info mt15"></i></a></div>
	    </div>
	    <div class="none"></div>
	</header>
	
		<div class="detail-top-bg <%=(model.Status ?? 0)==2?"pro-notFinish":"pro-finish"%>">
			<div class="pl15 pos-r pt15 detail_tit">
				<p class="f14px c-808080 text-overflow"><%=model.Title %></p>
				<div class="round-btn" onclick="javascript:window.location.href='/pages/invest/SubscribeUser.aspx?type=project&id=<%=model.Id %>';"><i class="ico-record"></i>加入记录</div>
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
						<p class="f17px c-212121"><%=ToolStatus.ConvertLowerMoney(CommUtils.GetProjectSurplusAmount(model)) %></p>
						<p class="line-h20 f12px c-ababab">剩余金额(元)</p>
					</div>
					<div class="lf w33p text-center">
						<p class="f17px c-212121"><%=model.Deadline %><%=model.DeadType==1?"个月":"天" %></p>
						<p class="line-h20 f12px c-ababab">期限</p>
					</div>
					<div class="lf w33p text-center">
						<p class="f17px c-212121"><%=ToolStatus.DeleteZero(model.LowerUnit) %>元/份</p>
						<p class="line-h20 f12px c-ababab">投资单位</p>
					</div>
				</div>
				<div class="pl15 pr15 pt15 pb11">
					<div class="pBar">
						<div class="barRate" style="width: <%=finishProcess%>;"></div>
					</div>
					<div class="mt4 clearfix">
						<div class="lf f13px c-ababab">借款金额：<%=ToolStatus.ConvertLowerMoney(model.Amount) %></div>
						<div class="rf f13px c-ababab"><%=finishProcess%></div>
					</div>
				</div>
				<%--<div class="pl15">
					<div class="bt-e6e6e6 f13px c-ababab text-center pt11 pb11 line-h20">
						保障方式：第三方担保专款<%=CommUtils.GetBorrowerGuaranteeName(model) %>
					</div>
				</div>--%>
			</div>
			<div class="finishImg"><img src="/imgs/images/bg/pro-finish.png"/></div>
		</div>
		
		<a href="/pages/invest/SubscribeUser.aspx?type=project&id=<%=model.Id %>" class="is_tit block click-respond bb-e6e6e6 pos-r f17px mt15 pl15 bg-fff">
			投资记录
			<b class="c-ababab f13px"><%=SubscribeUserCount %></b>
			<div class="ico-arrow-r"></div>
		</a>
		
		<!--项目描述-->
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
			<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>项目描述</div>
			<div class="dropdownCon hide">
                 <p class="pb15 c-808080 f14px">
                     <%= organization.OrgDecription%>
                </p> 
			</div>
		</div>
		
		<!--风控措施-->
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
			<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>风控措施</div>
			<div class="dropdownCon hide">
				<p class="pb15 c-808080 f14px">
                    <%= string.IsNullOrEmpty(organization.ProjectDesc) ? "• 项目经多重审核机制复查—— 初审，由"+organization.ShortName+"工作人员线下审核借款人资料真实性，再由"+organization.ShortName+"总部风控中心复审；"+organization.ShortName+"推介项目至团贷网时，团贷网再次对借款人信息进行第三轮抽查。<br/>• 作为项目推介方的"+organization.ShortName+"，公司本身运转良好，拥有优秀的风控团队和风控措施。<br/>• 本项目适用团贷网100%本息保障计划，由第三方担保公司连带担保。" : organization.ProjectDesc %>
                </p>
			</div>
		</div>
		 
		
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15">
			<div class="pt10 pb10 c-212121 f17px pl15 dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>借款方信息</div>
			<div class="dropdownCon hide">
				<div class="h43 c-808080 f14px pl15">借款方：<%=BusinessDll.StringHandler.MaskStartPre(borrowUserInfo.RealName,1)%></div>
				<div class="h43 c-808080 f14px pl15">居住城市：<%=BusinessDll.StringHandler.MaskStartPre(Tool.WebFormHandler.CutString(fq_ItemSetsProjectInfo.Address,6),3)%></div>
                <div class="h43 c-808080 f14px pl15 bg-fafafa">手机号码：<%=BusinessDll.StringHandler.MaskTelNo(fq_ItemSetsProjectInfo.TelNo)%></div>
                <div class="h43 c-808080 f14px pl15">性别：<%=TuanDai.WXApiWeb.CommUtils.GetSex(fq_ItemSetsProjectInfo.IdentityCard,borrowUserInfo.sex)%></div>
				<div class="h43 c-808080 f14px pl15 bg-fafafa">年龄：<%=CommUtils.GetAge(fq_ItemSetsProjectInfo.IdentityCard)%></div>				
				 
				<div class="pb15">
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
					</div>		
				</div>	
				<div class="bb-e6e6e6">
					<div class="pt15 c-212121 f17px bt-e6e6e6 ml15">信用档案</div>
					<div class="h43 c-808080 f14px pl15">申请借款：<%=creditInfo.ApplyBorrowProjectCount %>笔</div>
					<div class="h43 c-808080 f14px pl15 bg-fafafa">成功借款：<%=creditInfo.SuccessBorrowProjectCount%>笔</div>
					<div class="h43 c-808080 f14px pl15">借款总额：<%=ToolStatus.ConvertLowerMoney(creditInfo.TotalBorrowAmount) %>元</div>
					<div class="h43 c-808080 f14px pl15 bg-fafafa">逾期金额：<%=ToolStatus.ConvertLowerMoney(creditInfo.TOverdueCIofborrower)%>元</div>
					<div class="h43 c-808080 f14px pl15">逾期期数：<%=creditInfo.OverdueNum %>期</div>
					<div class="h43 c-808080 f14px pl15 bg-fafafa">还清笔数：<%=creditInfo.PayOffProjectCount %>笔</div>
					<div class="h43 c-808080 f14px pl15">待还本息：<%=ToolStatus.ConvertLowerMoney(creditInfo.DueOutPAndI)%>元</div>
				</div>
			</div>
		</div> 
		
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15">
			<div class="pt10 pb10 c-212121 f17px pl15 dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>业务模型</div>
			<div class="dropdownCon hide">
				<div class="pl20 pt18 pb25 pos-r">
					<div class="firmModule h302"></div>
					<div class="pos-a firm_txt">
						<p class="c-808080 f14px"><i class="ico-suc01"></i>借款人申请借款</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>运营商员工当面，验证借款人和各项资料</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i> <%=organization.ShortName %>风控中心复审</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i> <%=organization.ShortName %>向团贷网推荐标的</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i> 大数据风控系统，"天秤"审核</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>发标借款</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>满标，借款人按期还款，第三方担保公司担保</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>到期结清</p>
					</div>
					
				</div>
			</div>
		</div>	
	<div class="text-center c-ababab bt-e6e6e6 ftb_bot">
			市场有风险，投资需谨慎。查看<a class="c-fab600" href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/P2PRisk.html">《风险揭示书》</a>
	</div>	
	<div class="pos-f btn-joinNow">
		<%if ((model.Status ?? 0)==2){ %>
          <div class="btn btnYellow loan-button">马上投资</div>
        <a href="javascript:void(0);" class="btn-share webkit-box"><i class="ico-sprite01 ico-share"></i></a> 
        <%}else{ %>
           <div class="btn btnGray loan-button-gray">已满标</div>
        <%} %> 
	</div>
	</div>
	<!--弹框-->
	
	<div class="slide2 hide">
			<div class="slide-close">
				
			</div>
			<div class="slide-big">
				<div class="swiper-container3" id="swiper3">
					<div class="swiper-wrapper"></div>
				</div>
			</div>
			<div class="mark">
				<!--<p><span id="nowMark">5/</span>11</p>-->
			</div>
		</div>
    <footer></footer>  
</body>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.cookies.2.2.0.js"></script>
<script type="text/javascript" src="/scripts/zq_timedown.js" ></script> 
<script type="text/javascript" src="/scripts/TdStringHandler.js?v=2015101601"></script> 
<script type="text/javascript" src="/scripts/Common.js"></script>  
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script> 
<script type="text/javascript" src="/scripts/investNew.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script> 
<script type="text/javascript" src="/scripts/noLoginInvest.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script> 
<script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>

<% if((model.Status ?? 0)==2){ %>
<script type="text/javascript" src="/scripts/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="/scripts/weixinapi.js?v=4.0"></script> 
<script type="text/javascript" src="/scripts/detailShare.js?v=20160415006" ></script> 
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
        moveToBottom('#close1', '#frame1,#frame1-b');
        moveToTop("#f2", '#frame2,#frame2-b');
        moveToBottom('#close2', '#frame2,#frame2-b');
    });
</script>
</html>
