<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="youxindai_detail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.youxindai_detail" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<%@ Register Src="~/usercontrol/NewBorrowerUserPages.ascx" TagPrefix="uc1" TagName="NewBorrowerUserPages" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>有信贷-项目详情</title>
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
		<div class="detail-top-bg <%=(model.Status ?? 0) > 2 && model.Status != 12 && model.Status != 13 && model.Status != 14 && model.Status != 15?"pro-finish":"pro-notFinish"%>">
			<div class="pl15 pos-r pt15 detail_tit">
				<p class="f14px c-808080"><%=model.Title%></p>
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
			<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>项目描述</div>
			<div class="dropdownCon hide">
				<div class="c-808080 f14px pb15 bb-e6e6e6 text-justify pr15">  
                <p class="pb15 c-808080 f14px pt15" >项目为信用借款，借款方信用状态良好，还款能力较强，同时有第三人承诺在借款人不能偿还借款时，按约定承担连带担保责任。
                </p>
               <% if (model.AddDate <= DateTime.Parse(regulaSet.Param1Value))
                     { %>
                   <p class="pb15 c-808080 f14px pt15">借款用途：主要用于短期流动资金周转</p>
                <%} %> 
				</div>
			</div>
		</div>
		
		<!--风控措施-->
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
			<div class="pt10 pb10 c-212121 f17px dropdownTit"><i class="ico-sprite01 ico-triangle rotate0"></i>风险评估及还款保障措施</div>
			<div class="dropdownCon hide">
                  <% if (model.AddDate <= DateTime.Parse(regulaSet.Param1Value))
                     { %>
				<div class="pb15 c-808080 f14px text-justify pr15 span_txt pos-r"><span class="f14px c-808080">•</span>项目均经过资产端风控团队严格把关，贷前利用大数据智能风控系统--天秤系统进行多维度风险检测及授信，人工严格复审。贷后实时跟进借款人还款记录，若借款人发生逾期，担保方将及时垫付，并采取多种措施对借款人进行催收，追究借款人责任，最大程度保障投资人资金安全；</div>
				<div class="pb15 c-808080 f14px text-justify pr15 span_txt pos-r"><span class="f14px c-808080">•</span>天秤专注于提供大数据风控解决方案，是由一系列系统平台组成的互联网金融大数据智能风控系统。该系统涵盖了反欺诈、综合评估、贷后监控等功能，既可提供单个数据产品服务，又可提供整套的风控解决方案，以满足小额信贷、消费金融、P2P、垂直金融等平台在风险控制方面的需求；</div>
                <div class="pb15 c-808080 f14px text-justify pr15 span_txt pos-r"><span class="f14px c-808080">•</span>本项目适用安全保障计划，由第三方担保公司连带担保；</div>
                <div class="pb15 c-808080 f14px text-justify pr15 span_txt pos-r"><span class="f14px c-808080">•</span>第三人为借款人向担保公司提供反担保，且第三人拥有房产或车产，提供相应的资产证明，担保能力较强，可在借款人不能偿还借款时，承担连带担保责任。</div>
                <%}else{ %>
                   <div class="pb15 c-808080 f14px text-justify pr15 span_txt pos-r"><b>资金用途：</b><br /><%=projectXDInfo.FundUse %></div>
                   <div class="pb15 c-808080 f14px text-justify pr15 span_txt pos-r"><b>风险评估：</b><br /><%=projectXDInfo.RiskAssessment %></div>
                   <div class="pb15 c-808080 f14px text-justify pr15 span_txt pos-r"><b>还款保障措施：</b><br />
                        <%=projectXDInfo.RepaymentAssure %>
                    </div>
                <%} %>
			</div>
		</div>
		
		<!--资料展示-->
       <% if(imageList!=null && imageList.Count>0){ %>
		<div class="bt-e6e6e6 bb-e6e6e6 bg-fff mt15 pl15">
			<div class="pt10 pb10 c-212121 f17px dropdownTit slideTit"><i class="ico-sprite01 ico-triangle rotate0"></i>相关资料</div>
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
					</div>
				</div>	
				<div class="bb-e6e6e6">
					<div class="pt15 c-212121 f17px ml15 bt-e6e6e6">信用档案</div>
					<div class="h43 c-808080 f14px pl15">申请借款(笔)：<%=creditInfo.ApplyBorrowProjectCount %></div>
                    <div class="h43 c-808080 f14px pl15 bg-fafafa">成功借款(笔)：<%=creditInfo.SuccessBorrowProjectCount%></div>
                    <div class="h43 c-808080 f14px pl15">借款总额(元)：<%=ToolStatus.ConvertLowerMoney(creditInfo.TotalBorrowAmount)%></div>
                    <div class="h43 c-808080 f14px pl15 bg-fafafa">逾期金额(元)：<%=ToolStatus.ConvertLowerMoney(creditInfo.TOverdueCIofborrower)%></div>
					<div class="h43 c-808080 f14px pl15">逾期期数(期)：<%=creditInfo.OverdueNum %></div> 
                    <div class="h43 c-808080 f14px pl15 bg-fafafa">还清笔数(笔)：<%=creditInfo.PayOffProjectCount %></div>
					<div class="h43 c-808080 f14px pl15 ">待还本息(元)：<%=ToolStatus.ConvertLowerMoney(creditInfo.DueOutPAndI)%></div>
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
        <%if ((model.Status ?? 0) > 2 && model.Status != 12 && model.Status != 13 && model.Status != 14 && model.Status != 15)
          { %>
          <div class="btn btnGray loan-button-gray">已结束</div>
        <%}
          else
          {
              %>
          <div class="btn btnYellow loan-button">马上投资</div>
          <a href="javascript:void(0);" class="btn-share webkit-box"><i class="ico-sprite01 ico-share"></i></a> 
        <%
          } %> 
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
	    		<p class="f13px c-808080 pb10">东莞市江辉非融资性担保有限公司</p>
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