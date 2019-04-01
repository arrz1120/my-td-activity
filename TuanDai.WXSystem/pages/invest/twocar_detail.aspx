﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="twocar_detail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.twocar_detail" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<%@ Register Src="~/usercontrol/NewBorrowerUserPages.ascx" TagPrefix="uc1" TagName="NewBorrowerUserPages" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>供应链-项目详情</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css" /> 
    <link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/investProcess.css?v=<%=GlobalUtils.Version %>" /> 
    <!--借款-->
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

<div class="dropContainer"> 
		<div class="detail-top-bg <%=(model.Status ?? 0)==2?"pro-notFinish":"pro-finish"%>">
			<div class="pl15 pos-r pt15 detail_tit">
				<p class="f14px c-808080">【供】<%=model.Title%></p>
				<div class="round-btn" onclick="javascript:window.location.href='/pages/invest/SubscribeUser.aspx?type=project&id=<%=model.Id %>';"><i class="ico-record"></i>加入记录</div>
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
                            <%=InterestModel==2?"满标日指该项目满标当天的日期":"投资日指投资者投资成功的日期" %> 
                    </div>
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
				</div>
                <% if(model.RepaymentType.Value==2||model.RepaymentType.Value==5){ %>
				<div class="w33p lf text-center">
					<p class="f13px c-694514"><%=model.RepaymentType.Value==2?"每月赚利息":"每月回本息" %></p>
				</div>
                <%} %>
				<div class="<%=model.RepaymentType.Value==1?"w50p":"w33p" %> lf text-center">
					<p class="f13px c-694514"><%=model.RepaymentType.Value==2?"到期回本金":(model.RepaymentType.Value==1?"到期回本息":"到期还清") %></p>
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
			<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>项目介绍</div>
			<div class="dropdownCon hide">
				<div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15">  
                <p class="pb15 c-808080 f14px pt15" >企业简介：借款人是某公司的法人，该公司主要经营二手车辆买卖，该公司位于某二手车市场内，租用市场内的铺位，受市场方管理和监督，质押车辆进出场受到市场的监管。公司经营状况良好，还款能力强。
                </p>
                    <p class="pb15 c-808080 f14px pt15">风控意见：风控部门通过企业资质审核、分析融资企业各项经营数据（销售额、质押车辆信息等），对企业的借款事宜进行审核评估后予以认可，已评审过会通过。</p>
                <p class="pb15 c-808080 f14px pt15">借款用途：用于经营。</p>
				</div>
			</div>
		</div>
		
		<!--还款保障措施-->
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
			<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>还款保障措施</div>
			<div class="dropdownCon hide">
				<div class="pb15 c-808080 f14px text-justify pr15 span_txt pos-r">①企业经营收入、应收账款回收是本项目主要还款来源；</div>
				<div class="pb15 c-808080 f14px text-justify pr15 span_txt pos-r">②项目担保方东莞市志诚非融资性担保有限公司连带责任担保。</div>
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
		
		<!--借款人信息-->
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15">
			<div class="pt10 pb10 c-212121 f17px pl15 dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>借款方信息</div>
			<div class="dropdownCon pb20 hide">                
                <uc1:NewBorrowerUserPages runat="server" ID="NewBorrowerUserPages" /> 

				<!--审核记录-->
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
							<img src="/imgs/images/pic/id6.png">
							<p class="c-808080 f13px mt8">实地认证</p>	
						</div>
					</div>
				</div>	
				<div class="pb15">
					<div class="pt15 c-212121 f17px ml15 bt-e6e6e6 pb15">借入记录</div>
					<div class="table-wrap pos-r bl-e6e6e6 br-e6e6e6 ml15">
					<div class="pos-a"></div>
					<div class="table-left pos-a br-e6e6e6">
						<P class="bb-e6e6e6 bt-e6e6e6">项目</P>
						<P class="bb-e6e6e6">成功<%=model.Type == 1 ? "出让" : "借款" %></P>
						<P class="bb-e6e6e6">成功<%=model.Type == 1 ? "回购" : "还款" %></P>
						<P class="bb-e6e6e6">逾期违约</P>
						<P class="bb-e6e6e6">累计利息成本</P>
						<P class="bb-e6e6e6">逾期还款率</P>
					</div>
					<div class="swiper-container table-right" id="swiper4">
						<div class="swiper-wrapper">
							<div class="swiper-slide br-e6e6e6 bt-e6e6e6">
								<P class="bb-e6e6e6">最近一个月</P>
								<P class="bb-e6e6e6"><%=this.oneMonthSuccess %>份</P>
								<P class="bb-e6e6e6"><%=this.oneMonthCys %>份</P>
								<P class="bb-e6e6e6"><%=this.oneMonthOver %>份</P>
								<P class="bb-e6e6e6"><%=ToolStatus.DeleteZero(model.InterestRate) %>%</P>
								<P class="bb-e6e6e6"><%=this.oneMonthBadrate %>%</P>
							</div>
							<div class="swiper-slide br-e6e6e6 bt-e6e6e6">
								<P class="bb-e6e6e6">最近半年</P>
								<P class="bb-e6e6e6"><%=this.sixMonthSuccess %>份</P>
								<P class="bb-e6e6e6"><%=this.sixMonthCys %>份</P>
								<P class="bb-e6e6e6"><%=this.sixMonthOver %>份</P>
								<P class="bb-e6e6e6"><%=ToolStatus.DeleteZero(model.InterestRate) %>%</P>
								<P class="bb-e6e6e6"><%=this.sixMonthBadrate %>%</P>
							</div>
							<div class="swiper-slide br-e6e6e6 bt-e6e6e6">
								<P class="bb-e6e6e6">最近一年</P>
								<P class="bb-e6e6e6"><%=this.twelveMonthSuccess %>份</P>
								<P class="bb-e6e6e6"><%=this.twelveMonthCys %>份</P>
								<P class="bb-e6e6e6"><%=this.twelveMonthOver %>份</P>
								<P class="bb-e6e6e6"><%=ToolStatus.DeleteZero(model.InterestRate) %>%</P>
								<P class="bb-e6e6e6"><%=this.twelveMonthBadrate %>%</P>
							</div>
							<div class="swiper-slide br-e6e6e6 bt-e6e6e6">
								<P class="bb-e6e6e6">历史合计</P>
								<P class="bb-e6e6e6"><%=model.TotalSumShares %>份</P>
								<P class="bb-e6e6e6"><%=model.BuybackShares %>份</P>
								<P class="bb-e6e6e6"><%=model.badShares %>份</P>
								<P class="bb-e6e6e6"><%=ToolStatus.DeleteZero(model.InterestRate) %>%</P>
								<P class="bb-e6e6e6"><%=calcrate(model.TotalSumShares ?? 0, model.badShares ?? 0) %>%</P>
							</div>

						</div>
					</div>
				</div>
				</div>
			</div>
		</div>
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
	    	</div> --%>
            <div class="safty_tiem mt15">
	    		<div class="ico_r ico_sprite ico_bCourse10"></div>
	    		<p class="f17px">第三方担保</p>
	    		<p class="f13px c-808080 pb10"><%=CommUtils.GetBorrowerGuaranteeFullName(model)%></p>
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
<script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.cookies.2.2.0.js"></script> 
<script type="text/javascript" src="/scripts/TdStringHandler.js?v=2015101601"></script>      
<script type="text/javascript" src="/scripts/Common.js"></script> 
<script type="text/javascript" src="/scripts/zq_timedown.js" ></script>      
<script type="text/javascript" src="/scripts/investNew.js?v=<%=GlobalUtils.Version %>"></script> 
<script type="text/javascript" src="/scripts/noLoginInvest.js?v=<%=GlobalUtils.Version %>"></script> 
<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
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
    //	10.24新增
    function theSwiper() {
        var swiper4 = new Swiper('#swiper4', {
            initialSlide: 0,
            slidesPerView: 'auto',
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
                //	10.24新增
                theSwiper();
            } else {
                triangle.addClass('rotate0');
                next.addClass('hide');
            }
            if ($(this).hasClass('slideTit')) {
                initSwiper1();
            }
        });

        $(".area_sd").click(function () {
            var ico = $(this).find('i');
            var t_slideDown = $("#t_slideDown");
            if (t_slideDown.hasClass('t_slideDown')) {
                t_slideDown.removeClass('t_slideDown');
                ico.css('transform', 'rotateZ(-180deg)');
            } else {
                t_slideDown.addClass('t_slideDown');
                ico.css('transform', 'rotateZ(0)');
            }
        });
        moveToTop("#f1", '#frame1,#frame1-b');
        moveToBottom('#close1', '#frame1,#frame1-b');
    });

</script> 
</body>
</html>

