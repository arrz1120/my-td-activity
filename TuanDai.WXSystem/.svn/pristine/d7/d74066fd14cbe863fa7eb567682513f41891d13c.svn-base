<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fqbao_detail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.fqbao_detail" %>
<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>分期宝-项目详情</title> 
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/investProcess.css?v=<%=GlobalUtils.Version %>" />
    <script type="text/javascript">
        var projectId = "<%=projectId %>";
        var backurl = "<%= GetEncodeBackUrl()%>";
    </script>
</head>
<body  class="bg-f1f3f5">
<div id="bigDiv">
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
				<p class="f14px c-808080">【分】<%=model.Title %></p>
				<div class="round-btn"  onclick="javascript:window.location.href='/pages/invest/SubscribeUser.aspx?type=project&id=<%=model.Id %>';"><i class="ico-record"></i>加入记录</div>
			</div>
			<div class="pt10 text-center">
				<p><span class="f13px c-ababab">预期年化利率（<%=ToolStatus.ConvertRepaymentType(model.RepaymentType.Value)%>）</span></p>
			</div>
			<div class="rateIncome mt10">
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
                <div class="bt-e6e6e6 f13px c-ababab text-center pt4 pb4">
					截止时间：<%if (model.Status == 2 && model.TenderDate > DateTime.Now){%>
                     <span class="timeSet" enddate="<%=model.TenderDate %>" startdate="<%=model.TenderStartDate %>"
                        serverdate="<%=DateTime.Now %>" style="color: Black;">
                        <span id="day" style="font-size: 16px;color: #ff6600; ">00</span> 天 
                        <span id="hour" style="font-size: 16px;color: #ff6600; ">00</span> 时 
                        <span id="mini" style="font-size: 16px;color: #ff6600; ">00</span> 分 
                        <span id="sec" style="font-size: 16px;color: #ff6600;">00</span> 秒
                    </span>
                    <%}
                      else if (model.Status > 2 || model.TenderDate < DateTime.Now)
                      { %><span class="timeSet" enddate="<%=DateTime.Now %>" startdate="<%=model.TenderStartDate %>"
                          serverdate="<%=DateTime.Now %>" style="color: none;">已结束</span>
                    <%} %>
				</div>
                <div class="bt-e6e6e6 moneySafty pr40 pl15" id="f1">
					<%--<div class="c-ababab f13px text-center"><i class="ico-suc03"></i>第三方担保专款</div> --%>
                    <div class="c-ababab f13px text-center"><i class="ico-suc03"></i>第三方担保</div>
					<div class="c-ababab f13px text-center"><i class="ico-suc03"></i>合同保障</div>
					<div class="ico-arrow-r"></div>
				</div> 

			 </div>
			<div class="finishImg"><img src="/imgs/images/bg/pro-finish.png"/></div> 
		</div>
    
	     <div class="incomeShow mt15 bt-e6e6e6 bb-e6e6e6 bg-fff">
			<div class="is_tit bb-e6e6e6 pos-r ml15 f15px">
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
			<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>项目描述</div>
			<div class="dropdownCon hide">
				<div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15">借款人为团贷网合作机构--<%=Organization.RealName%>的学员，<%=Organization.ProjectDesc%></div>
			</div>
		</div> 
		<!--风控措施-->
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
			<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>风控措施</div>
			<div class="dropdownCon hide">
				<div class="c-808080 f14px text-justify pr15 span_txt pos-r"><span class="f14px c-808080">•</span>团贷网严格借款人信用风险审核；</div>
				<div class="c-808080 f14px text-justify pr15 span_txt pos-r"><span class="f14px c-808080">•</span>团贷网审核合作机构，确保合作机构具有经营资质；</div>
                <div class="c-808080 f14px text-justify pr15 span_txt pos-r"><span class="f14px c-808080">•</span>采用资金定向支付方式 ，确保借款人的借款用于机构消费；</div>
				<div class="pb15 bb-e6e6e6 c-808080 f14px text-justify pr15 span_txt pos-r"><span class="f14px c-808080">•</span>借款人已提供<%=AuthHtml%>。</div>
			</div>
		</div> 
		
	  <!--资料展示-->
       <% if(imageList!=null && imageList.Count>0){ %>
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
			<div class="pt10 pb10 c-212121 f17px dropdownTit slideTit"><i class="ico-sprite01 ico-triangle rotate0"></i>资料展示</div>
			<div class="dropdownCon hide">
				<div class="swiper-container swiper1 pb15" id="swiper1">
					<div class="swiper-wrapper">
                        <% foreach(var item in imageList){ %>
						<div class="swiper-slide">
							<img data-src="<%=item.ImageSource %>" class="swiper-lazy" />
							<div class="swiper-lazy-preloader"></div>
						</div> 
                        <%} %>
					</div>
				</div>
			</div>	
		</div>
      <%} %>
		
      <% if (userApply.OrgTypeId != 5) { %>
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15">
			<div class="pt10 pb10 c-212121 f17px pl15 dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>借款方信息</div>
			<div class="dropdownCon hide">
                <%if(IdentityTypeId==1){ %>
			        <div class="h43 c-808080 f14px pl15">教育程度：<%=applyEducation.Education%></div>
                    <div class="h43 c-808080 f14px pl15 bg-fafafa">毕业日期：<%=applyEducation.GraduateDate.ToString("yyyy-MM-dd")%></div>
                    <div class="h43 c-808080 f14px pl15">学校：<%=applyEducation.School%></div>
                    <div class="h43 c-808080 f14px pl15 bg-fafafa">专业：<%=applyEducation.Specialty%></div>
                    <div class="h43 c-808080 f14px pl15">班级：<%=string.IsNullOrEmpty(applyEducation.EduClass)?string.Empty:applyEducation.EduClass.Remove(1,applyEducation.EduClass.Length-1)+"***"%></div>
                    <div class="h43 c-808080 f14px pl15 bg-fafafa">宿舍地址：<%=string.IsNullOrEmpty(applyEducation.Address)?string.Empty:applyEducation.Address.Remove(1,applyEducation.Address.Length-1)+"***"%></div> 
                <%}else{ %>
                    <div class="h43 c-808080 f14px pl15">借款方：<%=BusinessDll.StringHandler.MaskStartPre(borrowUserInfo.RealName, 1) %></div>
				    <div class="h43 c-808080 f14px pl15 bg-fafafa">年龄：<%= TuanDai.WXApiWeb.CommUtils.GetAge(borrowUserInfo.Birthday)%></div>
				    <div class="h43 c-808080 f14px pl15">性别：<%= TuanDai.WXApiWeb.CommUtils.GetSex(borrowUserInfo.Birthday,borrowUserInfo.sex)%></div>
				    <div class="h43 c-808080 f14px pl15 bg-fafafa">手机号码：<%=string.IsNullOrEmpty(borrowUserInfo.TelNo) ? string.Empty : (borrowUserInfo.TelNo.Length != 11 ? "保密" : borrowUserInfo.TelNo.Replace(borrowUserInfo.TelNo.Substring(3, 5), "*****"))%></div>
				    <div class="h43 c-808080 f14px pl15">工作城市：<%=userDetai.UnitAreaCode%></div>
				    <div class="h43 c-808080 f14px pl15 bg-fafafa">所属行业：<%=ToolStatus.ConvertCompanyIndustry(userDetai.CompanyIndustryTypeId)%></div>
				    <div class="h43 c-808080 f14px pl15">月均收入：<%=userDetai.MonthlyInComeAmount.HasValue?Math.Round(userDetai.MonthlyInComeAmount.Value,2):0%>元</div>
				    <div class="h43 c-808080 f14px pl15 bg-fafafa">职位：<%=userDetai.Position%></div>
				    <div class="h43 c-808080 f14px pl15">住房情况：<%=ToolStatus.ConvertHouseStatus(userDetai.HouseFactor)%></div>
				    <div class="h43 c-808080 f14px pl15 bg-fafafa">学历：<%=ToolStatus.ConvertEducationStatus(userDetai.Education)%></div>
				    <div class="h43 c-808080 f14px pl15">婚姻状况：<%=ToolStatus.ConvertMarrayStatus(userDetai.MarrayStatus)%></div>
                <%} %>
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
						<div class="box-flex1 text-center">
							<img src="/imgs/images/pic/id5.png">
							<p class="c-808080 f13px mt8">机构验证</p>	
						</div>
					</div>
				</div>	
				<div class="bb-e6e6e6">
					<div class="pt15 c-212121 f17px bt-e6e6e6 ml15">信用档案</div>
					<div class="h43 c-808080 f14px pl15">申请借款：<%=creditInfo.ApplyBorrowProjectCount %>笔</div>
					<div class="h43 c-808080 f14px pl15 bg-fafafa">成功借款：<%=creditInfo.SuccessBorrowProjectCount %> 笔</div>
					<div class="h43 c-808080 f14px pl15">借款总额：<%=ToolStatus.ConvertLowerMoney(creditInfo.TotalBorrowAmount) %>元</div>
					<div class="h43 c-808080 f14px pl15 bg-fafafa">逾期金额：<%=ToolStatus.ConvertLowerMoney(creditInfo.TOverdueCIofborrower)%>元</div>
					<div class="h43 c-808080 f14px pl15">逾期期数：<%=creditInfo.OverdueNum %> 期</div>
					<div class="h43 c-808080 f14px pl15 bg-fafafa">还清笔数：<%=creditInfo.PayOffProjectCount %> 笔</div>
					<div class="h43 c-808080 f14px pl15">待还本息：<%=ToolStatus.ConvertLowerMoney(creditInfo.DueOutPAndI)%>元</div>
				</div>
			</div>
		</div>
		<%} %>
		
	
      <% if (userApply.OrgTypeId == 5) { %>
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15">
			<div class="pt10 pb10 c-212121 f17px pl15 dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>业务模型</div>
			<div class="dropdownCon hide">
				<div class="pl20 pt18 pb25 pos-r">
					<div class="firmModule h302"></div>
					<div class="pos-a firm_txt">
						<p class="c-808080 f14px"><i class="ico-suc01"></i>借款学生发起分期购物申请</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>分期乐初审，线下当面验证学生各项资料</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>分期乐总部复审</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>打包债权，向团贷网申请借款</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>团贷网审核</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>发标借款</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>满标，分期乐按期还本息</p>
						<p class="c-808080 f14px"><i class="ico-suc01"></i>到期结清</p>
					</div> 
				</div>
			</div>
		</div>	 
	  <%}  %> 

   <!--弹框--> 
   <div class="slide2 hide">
		<div class="slide-close"></div>
		<div class="slide-big">
			<div class="swiper-container3" id="swiper3">
				<div class="swiper-wrapper"></div>
			</div>
		</div>
		<div class="mark"></div>
	</div>
    <div class="text-center c-ababab bt-e6e6e6 ftb_bot">
			市场有风险，投资需谨慎。查看<a class="c-fab600" href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/P2PRisk.html">《风险揭示书》</a>
	</div>
    <!--申购按钮--> 
    <div class="pos-f btn-joinNow">
        <%if ((model.Status ?? 0)==2){ %>
          <div class="btn btnYellow loan-button">马上投资</div>
          <a href="javascript:void(0);" class="btn-share webkit-box"><i class="ico-sprite01 ico-share"></i></a> 
        <%}else{ %>
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
	    			当借款项目出现逾期时，担保公司自有资金先行垫付，若垫付资金不足则根据偿付规则启用“第三方担保专款”进行质保偿付，赔付投资者投资资金，以在一定限度内补偿出借人可能存在的回款损失。
	    		</div>
	    	</div>--%> 
            <div class="safty_tiem mt15">
	    		<div class="ico_r ico_sprite ico_bCourse10"></div>
	    		<p class="f17px">第三方担保</p>
	    		<p class="f13px c-808080 pb10">东莞市志诚非融资性担保有限公司</p>
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
<script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
<script type="text/javascript" src="/scripts/zq_timedown.js"></script> 
<script type="text/javascript" src="/scripts/TdStringHandler.js?v=2015101601"></script> 
<script type="text/javascript" src="/scripts/Common.js"></script>  
<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/investNew.js?v=<%=GlobalUtils.Version %>"></script> 
<script type="text/javascript" src="/scripts/noLoginInvest.js?v=<%=GlobalUtils.Version %>"></script> 
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

    var swiper1 = undefined;
    var swiper3 = undefined; 

    function initSwiper1() {
        swiper1 = new Swiper('#swiper1', {
            slidesPerView: 'auto',
            preloadImages: false,
            watchSlidesVisibility: true,
            lazyLoading: true,
            lazyLoadingOnTransitionStart: true
        });
        swiper1.on('tap', function () {
            $(".slide2").removeClass('hide');
            var idx = swiper1.clickedIndex;
            if (idx == 0) {
                $("#nowMark").html('1/');
            } 
            var sHtml = $("#swiper1").find('.swiper-wrapper').html();
            //转化成大图
            sHtml = sHtml.replace(new RegExp("_S.", 'g'), ".");

            $("#swiper3").find('.swiper-wrapper').html(sHtml);
            swiper3 = new Swiper('#swiper3', {
                initialSlide: idx,
                slidesPerView: '1',
                spaceBetween: 1,
                preloadImages: false,
                lazyLoading: true,
                lazyLoadingOnTransitionStart: true,
                onSlideChangeEnd: function (swiper3) {
                    console.log(swiper3.activeIndex + 1);
                    $("#nowMark").html((swiper3.activeIndex + 1) + '/');
                }
            });
        });
    }
    $(function () {
        var len = $("#swiper1").find('.swiper-slide').length;
        $(".mark").html("<p><span id='nowMark'>1/</span>" + len + "</p>");

        $('.slide-close').click(function () {
            $('.slide2').addClass('hide');
            swiper3.destroy(true, true);
            swiper3 = undefined;
        });
        //栏目显示切换
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
            if ($(this).hasClass('slideTit')) {
                initSwiper1();
            }
        });
         moveToTop("#f1", '#frame1,#frame1-b');
        moveToBottom('#close1','#frame1,#frame1-b');
    });
   
</script>
</body>
</html>
