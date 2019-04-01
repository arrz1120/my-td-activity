<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="incomeCount.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.fundStatistics.incomeCount" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>资金统计</title>
		<link rel="stylesheet" type="text/css" href="/Member/fundStatistics/css/fundStatistics.css?v=<%=GlobalUtils.Version %>" />
		<link rel="stylesheet" type="text/css" href="/Member/fundStatistics/css/swiper-3.4.0.min.css?v=<%=GlobalUtils.Version %>" />
	</head>

	<body>

		<script>
		    (function (doc, win) {
		        var dpr, rem, scale = 1;
		        var docEl = document.documentElement;
		        var metaEl = document.querySelector('meta[name="viewport"]');
		        var resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize';
		        metaEl.setAttribute('content', 'width=device-width,initial-scale=' + scale + ',maximum-scale=' + scale + ', minimum-scale=' + scale + ',user-scalable=no,shrink-to-fit=no');
		        docEl.setAttribute('data-dpr', dpr);
		        var recalc = function () {
		            clientWidth = docEl.clientWidth;
		            if (!clientWidth) return;
		            docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
		            if (document.body) {
		                document.body.style.fontSize = docEl.style.fontSize;
		            }

		        };
		        recalc();
		        if (!doc.addEventListener) return;
		        win.addEventListener(resizeEvt, recalc, false);
		        doc.addEventListener('DOMContentLoaded', recalc, false);
		    })(document, window);
		</script>

		<%=GetNavStr() %>
		<section class="sec01">
			<p class="p1_1 text-center">资产总额</p>
			<p class="p1_2 text-center">
				<%= ToolStatus.ConvertLowerMoney(totalamount+(ZxFundModel.DueInAmount_DQ??0)+(ZxFundModel.DueInInterest_DQ??0))%>
			</p>
			<div class="lqBox clearfix" id="swiper-tab1">
				<div class="w50p text-center lf lq-item lq-item-cur">
					<p class="lq_p1">P2P：<%=ToolStatus.ConvertLowerMoney(totalamount-(ZxFundModel.DueInAmount_P2P??0)-(ZxFundModel.DueInInterest_P2P??0)) %></p>
					<div class="active-line"></div>
				</div>
				<div class="w50p text-center lf lq-item">
					<p class="lq_p1">智享：<%=ToolStatus.ConvertLowerMoney((ZxFundModel.DueInAmount_DQ??0)+(ZxFundModel.DueInAmount_P2P??0)+(ZxFundModel.DueInInterest_P2P??0)+(ZxFundModel.DueInInterest_DQ??0)) %></p>
					<div class="active-line"></div>
				</div>
			</div>
			<div class="lqSlide">
				<div class="swiper-container" id="swiper1">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<div class="frame frame1">
								<div class="frame-tit">资产总计：<%=ToolStatus.ConvertLowerMoney(totalamount-(ZxFundModel.DueInAmount_P2P??0)-(ZxFundModel.DueInInterest_P2P??0)) %></div>
								<div class="frame_row">
									<div class="lfBox lfBox1">
										<p><span class="markRound f_mark1"></span>待收本金</p>
										<p>
											<%= ToolStatus.ConvertLowerMoney((fundAccountInfo.DueInPAndI??0) - (fundAccountInfo.DueComeInterest??0)-(ZxFundModel.DueInAmount_P2P??0)) %>
										</p>
									</div>
									<div class="lfBox lfBox2">
										<p><span class="markRound f_mark1"></span>预期待收利息</p>
										<p>
											<%= ToolStatus.ConvertLowerMoney((fundAccountInfo.DueComeInterest??0)-(ZxFundModel.DueInInterest_P2P??0)) %>
										</p>
									</div>
									<div class="lfBox lfBox3">
										<p><span class="markRound f_mark1"></span>可用余额</p>
										<p>
											<%=ToolStatus.ConvertLowerMoney(fundAccountInfo.AviMoney??0) %>
										</p>
									</div>
								</div>
								<div class="frame_row mt18">
									<div class="lfBox lfBox1">
										<p><span class="markRound f_mark1"></span>冻结资金</p>
										<p>
											<%=fundAccountInfo.FreezeAcount.HasValue?ToolStatus.ConvertLowerMoney(fundAccountInfo.FreezeAcount):"0.00" %>
										</p>
									</div>
									<div class="lfBox lfBox2">
										<p><span class="markRound f_mark1"></span>提现在途资金</p>
										<p>
											<%= ToolStatus.ConvertLowerMoney((fundAccountInfo.DueConfirmWithdrawDeposit??0)) %>
										</p>
									</div>

									<div class="lfBox lfBox3">
										<p><span class="markRound f_mark1"></span>投资待满标</p>
										<p>
											<%= ToolStatus.ConvertLowerMoney((fundAccountInfo.BorrowerOut??0)) %>
										</p>
									</div>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div class="frame frame2">
								<div class="frame-tit">资产总计：<%=ToolStatus.ConvertLowerMoney((ZxFundModel.DueInAmount_DQ??0)+(ZxFundModel.DueInAmount_P2P??0)+(ZxFundModel.DueInInterest_P2P??0)+(ZxFundModel.DueInInterest_DQ??0)) %></div>
								<div class="frame_row">
									<div class="lfBox lfBox1">
										<p><span class="markRound f_mark1"></span>待收本金</p>
										<p>
											<%=ToolStatus.ConvertLowerMoney((ZxFundModel.DueInAmount_DQ??0)+(ZxFundModel.DueInAmount_P2P??0)) %>
										</p>
									</div>
									<div class="lfBox lfBox2">
										<p><span class="markRound f_mark1"></span>预期待收利息</p>
										<p>
											<%=ToolStatus.ConvertLowerMoney((ZxFundModel.DueInInterest_P2P??0)+(ZxFundModel.DueInInterest_DQ??0)) %>
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<div class="split split1">
			<div class="ico_bgleft"></div>
			<div class="imgLine imgLine1 margin-auto"></div>
			<div class="ico_bgright"></div>
		</div>
		<section class="sec02">
			<div class="secTop text-center">
				<p class="st_p1">投资收益</p>
				<p class="st_p2">
					<%=ToolStatus.ConvertLowerMoney((fundAccountInfo.NetEarningsInterest??0 )+ (fundAccountInfo.DueComeInterest??0)+(ZxFundModelFromDq.DueInInterest??0)+(ZxFundModel.ReceivedInterest_DQ??0)+(ZxFundModel.DueInInterest_DQ??0)) %>
				</p>
				<div class="clearfix income-wrap">
					<div class="income-line"></div>
					<div class="w50p lf ti-28">
						<p class="income-p1">自动投标服务<span class="income-num"><%=ToolStatus.ConvertLowerMoney((fundAccountInfo.NetEarningsInterest??0 )+ (fundAccountInfo.DueComeInterest??0)-(ZxFundModel.ReceivedInterest_P2P??0)-(ZxFundModel.DueInInterest_P2P??0)) %></span></p>
						<p class="income-p2"><span class="markRound markOrange"></span>已收利息<span class="income-num"><%=ToolStatus.ConvertLowerMoney((fundAccountInfo.NetEarningsInterest??0)-(ZxFundModel.ReceivedInterest_P2P??0)) %></span></p>
						<p class="income-p3"><span class="markRound markRed"></span>预期待收利息<span class="income-num"><%=ToolStatus.ConvertLowerMoney((fundAccountInfo.DueComeInterest??0)-(ZxFundModel.DueInInterest_P2P??0)) %></span></p>
					</div>
					<div class="w50p lf ti-70">
						<p class="income-p1">智享<span class="income-num"><%=ToolStatus.ConvertLowerMoney((ZxFundModel.DueInInterest_DQ??0)+(ZxFundModel.DueInInterest_P2P??0)+(ZxFundModel.ReceivedInterest_DQ??0)+(ZxFundModel.ReceivedInterest_P2P??0)) %></span></p>
						<p class="income-p2"><span class="markRound markOrange"></span>已收利息<span class="income-num"><%=ToolStatus.ConvertLowerMoney((ZxFundModel.ReceivedInterest_DQ??0)+(ZxFundModel.ReceivedInterest_P2P??0)) %></span></p>
						<p class="income-p3"><span class="markRound markRed"></span>预期待收利息<span class="income-num"><%=ToolStatus.ConvertLowerMoney((ZxFundModel.DueInInterest_DQ??0)+(ZxFundModel.DueInInterest_P2P??0)) %></span></p>
					</div>
				</div>
			</div>
		</section>
		
		<div class="split">
			<div class="imgLine imgLine1 margin-auto"></div>
		</div>

		<section class="sec03">
			<div class="secTop text-center">
				<p class="st_p1">其它收益</p>
				<% if (ConfigHelper.getConfigString("IsOpenIncomeWH", "0") == "0")
                   {
                %>
				<p class="st_p2">
					<%=ToolStatus.ConvertLowerMoney(profitmodel.prizeAmount+profitmodel.extenderMoney) %>
				</p>
				<%
                   }
                   else
                   {
                       %>
				<p class="st_p2 f52px">数据统计中...</p>
				<%
                   } %>
			</div>
			<% if (ConfigHelper.getConfigString("IsOpenIncomeWH", "0") == "0")
                   {
                %>
			<div class="otherIncome">
				<div class="other-part">
					<p><span class="markRound markOrange"></span>红包收益<span class="other-num" id="hbIncome"><%=ToolStatus.ConvertLowerMoney(profitmodel.prizeAmount) %></span></p>
				</div>
				<div class="other-part">
					<p><span class="markRound markRed"></span>邀请收益<span class="other-num" id="inviteIncome"><%=ToolStatus.ConvertLowerMoney(profitmodel.extenderMoney) %></span></p>
				</div>
			</div>
			
			<div class="oiBar">
				<div class="oiBarPer hbBar" id="bar1"></div>
				<div class="oiBarPer inviteBar" id="bar3"></div>
			</div>
			<%
                   }
                   else
                   {
                       %>
			<p class="dataRepair text-center">我们会不定期地对其它收益的数据进行整理<br />统计，请耐心等候</p>
			<div class="oiBar oiBarNone"></div>
			<%
                   } %>
		</section>

		<div class="split">
			<div class="ico_bgleft"></div>
			<div class="imgLine imgLine1 margin-auto"></div>
			<div class="ico_bgright"></div>
		</div>

		<section class="sec04">
			<div class="secTop text-center">
				<p class="st_p1">支出总计</p>
				<p class="st_p2">
					<%=ToolStatus.ConvertDetailWanMoney(totalPayAmount+(ZxPayOutBorrow)+(ZxFundModel.DueOutInterest_DQ??0)+(ZxFundModel.PaidInterest_DQ??0)) %>
				</p>
			</div>
			<div class="clearfix iChartBox" id="iChartBox3">
				<div class="lf">
					<div class="iDataNum iDataNum2">
						<p class="iData_p1">已付利息</p>
						<p class="iData_p2">
							<%=ToolStatus.ConvertLowerMoney((fundAccountInfo.NetPayOutInterest ?? 0)+(ZxFundModel.PaidInterest_DQ??0)) %>
						</p>
					</div>
					<div class="iDataNum iDataNum1">
						<p class="iData_p1">购买会员</p>
						<p class="iData_p2">
							<%=ToolStatus.ConvertLowerMoney(fundAccountInfo.TotalPayOutMember ?? 0) %>
						</p>
					</div>
					<div class="iDataNum iDataNum3">
						<p class="iData_p1">提现费用</p>
						<p class="iData_p2">
							<%=ToolStatus.ConvertLowerMoney((fundAccountInfo.TotalWithdrawDepositHandRecharge??0))%>
						</p>
					</div>
					<div class="iDataNum iDataNum4">
						<p class="iData_p1">支付佣金</p>
						<p class="iData_p2">
							<%=ToolStatus.ConvertLowerMoney((fundAccountInfo.TotalInvestCommission??0)+(fundAccountInfo.BorrowCommission??0)+(ZxPayOutBorrow))%>
						</p>
					</div>
					<div class="iDataNum iDataNum5">
						<p class="iData_p1">待付利息</p>
						<p class="iData_p2">
							<%=ToolStatus.ConvertLowerMoney((fundAccountInfo.DuePayOutInterest??0)+(ZxFundModel.DueOutInterest_DQ??0)) %>
						</p>
					</div>
				</div>
				<div class="chartBox" id="iDataBox">
					<div class="chartImg chartRed"></div>
					<div class="chartImg chartOrange"></div>
					<div class="chartImg chartPurple"></div>
					<div class="chartImg chartGreen"></div>
					<div class="chartImg chartBlue"></div>
					<div class="chartLineBox">
						<span class="y_num"></span>
						<div class="chartLine"></div>
					</div>
					<div class="chartLineBox">
						<span class="y_num"></span>
						<div class="chartLine"></div>
					</div>
					<div class="chartLineBox">
						<span class="y_num"></span>
						<div class="chartLine"></div>
					</div>
					<div class="chartLineBox">
						<span>0</span>
						<div class="chartLine"></div>
					</div>
				</div>
			</div>
		</section>

		<div class="split">
			<div class="imgLine imgLine3 margin-auto"></div>
		</div>

		<section class="sec06">
			<div class="dayCount text-center">
				<%=userModel.AddDate.Value.ToString("yyyy.MM.dd") %>注册，已加入团贷网
				<% if (JoinTDDay.ToString().Length > 0)
        {
            for (int i = 0; i < JoinTDDay.ToString().Length; i++)
            {
                 %>
				<span><%=JoinTDDay.ToString().Substring(i,1) %></span>
				<%
            }
        } %> 天！
			</div>
		</section>

		<div class="split">
			<div class="imgLine imgLine3 margin-auto"></div>
		</div>

		<section class="sec07">
			<div class="incomePart">
				<!--<div class="clearfix">
					<div class="partOpt text-center w50p lf bre6">
						<p>累计投资</p>
						<p>
							<%=ToolStatus.ConvertLowerMoney((fundAccountInfo.TotalInvest??0)+DqFundModel.TotalInvest)%>
						</p>
					</div>
					<div class="partOpt text-center w50p lf">
						<p>累计借款</p>
						<p>
							<%=ToolStatus.ConvertLowerMoney((fundAccountInfo.TotalBorrow??0)+DqFundModel.TotalBorrow)%>
						</p>
					</div>
				</div>-->
				<div class="clearfix">
					<div class="partOpt text-center w50p lf bre6">
						<p>累计充值</p>
						<p>
							<%=ToolStatus.ConvertLowerMoney(TotalRecharge) %>
						</p>
					</div>
					<div class="partOpt text-center w50p lf">
						<p>累计提现</p>
						<p>
							<%=ToolStatus.ConvertLowerMoney((fundAccountInfo.TotalWithdrawDeposit??0)) %>
						</p>
					</div>
				</div>
				<div class="imgLine imgLine3 margin-auto"></div>
				<div class="partCenter">
					<i></i>
				</div>
			</div>
		</section>
	</body>
	<script type="text/javascript" src="/scripts/jquery.min.js?v=<%=GlobalUtils.Version %>"></script>
	<script src="/Member/fundStatistics/js/swiper-3.4.0.jquery.min.js?v=<%=GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
	<script src="/Member/fundStatistics/js/script.js?v=<%=GlobalUtils.Version %>" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
	<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>

</html>