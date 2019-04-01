<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="kuailaidai_detail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.kuailaidai_detail" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>快来贷-项目详情</title>
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
	        <h1 class="title">快来贷-项目详情</h1>
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
						保障方式：第三方担保专款+志诚担保
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
				<div class="c-808080 f14px text-justify pr15 text-in30">快来贷（东莞市银众实业投资有限公司）是一家从民间金融华丽转身的互联网金融公司，于2011年创立于广东东莞，经国家工商、银监部门审核下发营业执照，注册资本3000万。公司立足于服务小微企业及社会年轻人。基于所服务人群暂时的资金不足，但成长空间巨大的特性，为其提供快捷便利的民间金融务。</div>
				<div class="c-808080 text-justify pr15 text-in30">东莞市银众实业投资有限公司成立至今，先后与平安银行、南粤银行、华润银行等各大银行合作，代理一系列信用贷款产品。服务线下客户超过20311笔，促成交易达56386万元。为众多的年轻人提供了及时的资金帮助，在东莞业内具有较好的声誉。</div>
				<div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15 text-in30">东莞市银众实业投资有限公司经过多年的积累及对互联网运营的反复论证。厚积薄发推出快来贷线上平台，平台面向年轻人提供互联网金融中介信息服务。通过与互联网大数据平台（反欺诈数据、网络行为数据、个人征信）的深度对接，加之人脸精密识别技术及民间金融从业经历沉淀的大数据分析模型的建立，让平台在产品、风控水平及客户体验感都较同业有着较大领先优势。</div>
			</div>
		</div>
		
		<!--风控措施-->
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
			<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>风控措施</div>
			<div class="dropdownCon hide">
				<div class="c-808080 f14px text-justify pr15 span_txt pos-r"><span class="f14px c-808080">•</span>快来贷推介标的经多重审核机制复查——初审，由快来贷工作人员线下面对面审核借款人资料真实性，再由快来贷风控中心对其进行大数据分析，网络及社会行为查证及进行各种有效数据复核，对信誉良好品行兼优的年轻人给予借款。</div>
				<div class="c-808080 f14px text-justify pr15 span_txt pos-r"><span class="f14px c-808080">•</span>快来贷在团贷网申请借款时，团贷网再次对借款人信息进行第三轮审核。所借款人群为在校大学生群体及信誉良好有稳定收入来源渠道的年轻人，稳定度高容易追收，且单笔借款金额小、风险分散。</div>
				<div class="pb15 bb-e6e6e6 c-808080 f14px text-justify pr15 span_txt pos-r"><span class="f14px c-808080">•</span>作为债权转让方的快来贷，公司本身运转良好，有优秀的风控团队和风控措施，并承担转让标的的还款责任。同时，该项目以待付金额的10%作为保证金，存入团贷网质量保障服务，接受银行监管。</div>
			</div>
		</div>
		
		<!--资料展示
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
			<div class="pt10 pb10 c-212121 f17px dropdownTit slideTit"><i class="ico-sprite01 ico-triangle"></i>资料展示</div>
			<div class="dropdownCon hide">
				<div class="swiper-container swiper1 pb15" id="swiper1">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<img data-src="/imgs/file/V1.7/zz_big01.jpg" class="swiper-lazy">
							<div class="swiper-lazy-preloader"></div>
						</div>
						<div class="swiper-slide">
							<img data-src="/imgs/file/V1.7/zz_big02.jpg" class="swiper-lazy">
							<div class="swiper-lazy-preloader"></div>
						</div>
						<div class="swiper-slide">
							<img data-src="/imgs/file/V1.7/zz_big03.jpg" class="swiper-lazy">
							<div class="swiper-lazy-preloader"></div>
						</div>
						<div class="swiper-slide">
							<img data-src="/imgs/file/V1.7/zz_big04.jpg" class="swiper-lazy">
							<div class="swiper-lazy-preloader"></div>
						</div>
						<div class="swiper-slide">
							<img data-src="/imgs/file/V1.7/zz_big05.jpg" class="swiper-lazy">
							<div class="swiper-lazy-preloader"></div>
						</div>
						<div class="swiper-slide">
							<img data-src="/imgs/file/V1.7/pic2.jpg" class="swiper-lazy">
							<div class="swiper-lazy-preloader"></div>
						</div>
						<div class="swiper-slide">
							<img data-src="/imgs/file/V1.7/pic3.jpg" class="swiper-lazy">
							<div class="swiper-lazy-preloader"></div>
						</div>
						<div class="swiper-slide">
							<img data-src="/imgs/file/V1.7/zz_big06.jpg" class="swiper-lazy">
							<div class="swiper-lazy-preloader"></div>
						</div>
						<div class="swiper-slide">
							<img data-src="/imgs/file/V1.7/pic5.jpg" class="swiper-lazy">
							<div class="swiper-lazy-preloader"></div>
						</div>
						<div class="swiper-slide">
							<img data-src="/imgs/file/V1.7/pic6.jpg" class="swiper-lazy">
							<div class="swiper-lazy-preloader"></div>
						</div>
						<div class="swiper-slide">
							<img data-src="/imgs/file/V1.7/pic7.jpg" class="swiper-lazy">
							<div class="swiper-lazy-preloader"></div>
						</div>
					</div>
				</div>
			</div>	
		</div>
		-->
		
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15">
			<div class="pt10 pb10 c-212121 f17px pl15 dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>借款方信息</div>
			<div class="dropdownCon hide">
				<div class="h43 c-808080 f14px pl15">借款方：<%=BusinessDll.StringHandler.MaskStartPre(borrowUserInfo.RealName,1)%></div>
				<div class="h43 c-808080 f14px pl15 bg-fafafa">年龄：<%=CommUtils.GetAge(fq_ItemSetsProjectInfo.IdentityCard)%></div>
				<div class="h43 c-808080 f14px pl15">性别：<%=TuanDai.WXApiWeb.CommUtils.GetSex(fq_ItemSetsProjectInfo.IdentityCard,borrowUserInfo.sex)%></div>
				<div class="h43 c-808080 f14px pl15 bg-fafafa">手机号码：<%=BusinessDll.StringHandler.MaskTelNo(fq_ItemSetsProjectInfo.TelNo)%></div>
				<div class="h43 c-808080 f14px pl15">所在城市：<%=BusinessDll.StringHandler.MaskStartPre(fq_ItemSetsProjectInfo.Address,4)%></div>
				<div class="h43 c-808080 f14px pl15 bg-fafafa">所属行业：<%=fq_ItemSetsProjectInfo.CompanyIndustryTypeId%></div>
				<div class="h43 c-808080 f14px pl15">月均收入：<%=fq_ItemSetsProjectInfo.MonthlyIncome%>元</div>
				<div class="h43 c-808080 f14px pl15 bg-fafafa">职位：<%=fq_ItemSetsProjectInfo.Position%></div>
				<div class="h43 c-808080 f14px pl15">住房情况：<%=fq_ItemSetsProjectInfo.IsHaveHouse?"有":"无"%></div>
				<div class="h43 c-808080 f14px pl15 bg-fafafa">学历：<%=fq_ItemSetsProjectInfo.Education%></div>
				<div class="h43 c-808080 f14px pl15">婚姻状况：<%=fq_ItemSetsProjectInfo.MarrayStatus?"已婚":"未婚"%></div>
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
						<p class="c-808080 f14px"><i class="ico-suc01"></i>借款学生发起分期购物申请</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i><%=organization.ShortName %>初审，线下当面验证学生各项资料</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i><%=organization.ShortName %>总部复审</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>打包债权，向团贷网申请借款</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>团贷网审核</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>发标借款</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>满标，快来贷按期还本息</p>
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
