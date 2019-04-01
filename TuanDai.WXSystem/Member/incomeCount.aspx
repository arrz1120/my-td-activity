<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="incomeCount.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.incomeCount" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>资金统计</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
		<link rel="stylesheet" type="text/css" href="/css/account2.css?v=<%=GlobalUtils.Version %>" />
	</head>

	<body class="bg-f1f3f5">
        <%= GetNavStr() %>
		<div class="bg-fff">
			<div class="pt25">
				<div class="incomeTit text-center pos-r">
					<div class="f15px bg-fff tit_txt">资产总额</div>
					<div class="tit_line"></div>
				</div>
				<div class="allAmo"><%=ToolStatus.ConvertLowerMoney(totalamount)%></div>
			</div>
			
			<div id="c1" style="width: 100%;height: 250px;"></div>
			<div class="c1_lable" id="c1_lable">
				<div class="text-center c-ababab pb8">资产总额的构成</div>
				<div class="clearfix">
					<div class="w33p lf">
						<p class="c-808080"><i class="c_i1"></i>可用资金</p>
						<p class="line-h16 c_p2"><%=ToolStatus.ConvertLowerMoney(fundAccountInfo.AviMoney) %></p>
					</div>
					<div class="w33p lf">
						<p class="c-808080"><i class="c_i3"></i>待收本金</p>
						<p class="line-h16 c_p2"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.DueInPAndI - fundAccountInfo.DueComeInterest) %></p>
					</div>
					<div class="w33p lf">
						<p class="c-808080"><i class="c_i5"></i>待收利息</p>
						<p class="line-h16 c_p2"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.DueComeInterest) %></p>
					</div>
				</div>
				<div class="clearfix pt20 pb20">
					<div class="w33p lf">
						<p class="c-808080"><i class="c_i4"></i>待确认投标</p>
						<p class="line-h16 c_p2"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.BorrowerOut) %></p>
					</div>
					<div class="w33p lf">
						<p class="c-808080"><i class="c_i2"></i>待确认提现</p>
						<p class="line-h16 c_p2"><%= ToolStatus.ConvertLowerMoney(fundAccountInfo.DueConfirmWithdrawDeposit + fundAccountInfo.WithdrawDepositProgress) %></p>
					</div>
                    <div class="w33p lf">
						<p class="c-808080"><i class="c_i7"></i>冻结资金</p>
						<p class="line-h16 c_p2"><%=fundAccountInfo.FreezeAcount.HasValue?ToolStatus.ConvertLowerMoney(fundAccountInfo.FreezeAcount):"0.00" %></p>
					</div>
					<%--<div class="w33p lf">
						<p class="c-808080"><i class="c_i6"></i>We计划待投</p>
						<p class="line-h16 c_p2"><%= ToolStatus.ConvertLowerMoney(weWaitInvestment) %></p>
					</div>--%>
				</div> 
			</div>
		</div>
			
		<div class="mt10 bt-e6e6e6 bg-fff pt25">
			<div class="incomeTit text-center pos-r">
				<div class="f15px bg-fff tit_txt">净赚收益</div>
				<div class="tit_line"></div>
			</div>
			<div class="allAmo"><%=ToolStatus.ConvertLowerMoney(totalInAmount -totalPayAmount)%></div>
			<!--<div id="c2" style="height: 250px;"></div>
			<div class="xAxis clearfix">
				<div class="lf f10px c-808080"><%=DateTime.Now.AddDays(-7).ToString("yyyy.MM.dd") %></div>
				<div class="rf f10px c-808080"><%=DateTime.Now.ToString("yyyy.MM.dd") %></div>
			</div>-->
			
			<div class="tabBox bt-e6e6e6 mt20 bg-fff">
				
				<div class="tabTit f15px ml15 pos-r bb-e6e6e6">累计收益：<span class="f15px"><%=ToolStatus.ConvertLowerMoney(totalInAmount)%></span><i class="ico-arrow-r" style="-webkit-transform: rotateZ(-90deg);"></i></div>
				
				<div class="tabCon">
                    <div class="triChart" id="triChart1">
						<div class="per-box per-box1">
							<div class="per-num" id="num1"></div>
							<div class="tri-box webkit-box">
								<div id="yellowLeft"></div>
								<div id="yellowRight"></div>
							</div>
						</div>
						<div class="per-box per-box2">
							<div class="per-num" id="num2"></div>
							<div class="tri-box webkit-box">
								<div id="redLeft"></div>
								<div id="redRight"></div>
							</div>
						</div>
						<div class="per-box per-box3">
							<div class="per-num" id="num3"></div>
							<div class="tri-box webkit-box">
								<div id="greenLeft"></div>
								<div id="greenRight"></div>
							</div>
						</div>
                        <div class="per-box per-box14">
							<div class="per-num" id="num14"></div>
							<div class="tri-box webkit-box">
								<div id="grayLeft"></div>
								<div id="grayRight"></div>
							</div>
						</div>
                        <div class="per-box per-box15">
							<div class="per-num" id="num15"></div>
							<div class="tri-box webkit-box">
								<div id="purpleLeft"></div>
								<div id="purpleRight"></div>
							</div>
						</div>
					</div>
					
					<div class="c1_lable c2_lable pb18" id="lable1">
						<div class="clearfix pt30">
							<div class="w33p lf">
								<p class="c-808080"><i class="c_i1"></i>已收利息</p>
								<p class="line-h16 c_p2" id="m1"><%=ToolStatus.ConvertLowerMoney(NetEarningsInterest)%></p>
							</div>
							<div class="w33p lf">
								<p class="c-808080"><i class="c_i3"></i>逾期收益</p>
								<p class="line-h16 c_p2" id="m2"><%=ToolStatus.ConvertLowerMoney(profitmodel.overDueAmount)%></p>
							</div>
                        	<div class="w33p lf">
								<p class="c-808080"><i class="c_i7"></i>红包收益</p>
								<p class="line-h16 c_p2" id="m3"><%=ToolStatus.ConvertLowerMoney(profitmodel.prizeAmount) %></p>
							</div>
						</div>
                        <div class="clearfix pt20">
							<div class="w33p lf">
								<p class="c-808080"><i class="c_i5"></i>活动奖励</p>
								<p class="line-h16 c_p2" id="m14"><%=ToolStatus.ConvertLowerMoney(fundAccountInfo.RewardMoney??0)%></p>
							</div>
							<div class="w33p lf">
								<p class="c-808080"><i class="c_i4"></i>推广收益</p>
								<p class="line-h16 c_p2" id="m15"><%=ToolStatus.ConvertLowerMoney(profitmodel.extenderMoney) %></p>
							</div>
						</div>	
					</div>
					<div class="delayTips c-ababab pb15"><i></i>数据维护，红包累计收益更新或有延迟</div>
				</div>
			</div>
			            	
			<div class="tabBox bg-fff bt-e6e6e6">
				<div class="tabTit f15px ml15 pos-r bb-e6e6e6">累计支出：<span class="f15px"><%= ToolStatus.ConvertLowerMoney(totalPayAmount)%></span><i class="ico-arrow-r" style="-webkit-transform: rotateZ(-90deg);"></i></div>
                
				<div class="tabCon">
					<div class="triChart" id="triChart2">
						<div class="per-box per-box4">
							<div class="per-num" id="num4"></div>
							<div class="tri-box webkit-box">
								<div id="redLeft2"></div>
								<div id="redRight2"></div>
							</div>
						</div>
						<div class="per-box per-box5">
							<div class="per-num" id="num5"></div>
							<div class="tri-box webkit-box">
								<div id="greenLeft2"></div>
								<div id="greenRight2"></div>
							</div>
						</div>
						<div class="per-box per-box6">
							<div class="per-num" id="num6"></div>
							<div class="tri-box webkit-box">
								<div id="yellowLeft2"></div>
								<div id="yellowRight2"></div>
							</div>
						</div>
						<div class="per-box per-box7">
							<div class="per-num" id="num7"></div>
							<div class="tri-box webkit-box">
								<div id="grayLeft2"></div>
								<div id="grayRight2"></div>
							</div>
						</div>
					</div>
					<div class="c1_lable c2_lable pb18" id="lable2">
						<div class="clearfix pt30">
							<div class="w33p lf">
								<p class="c-808080"><i class="c_i3"></i>提现费用</p>
								<p class="line-h16 c_p2" id="m4"><%=ToolStatus.ConvertLowerMoney(fundAccountInfo.TotalWithdrawDepositHandRecharge??0)%></p>
							</div>
							<div class="w33p lf">
								<p class="c-808080"><i class="c_i7"></i>购买会员</p>
								<p class="line-h16 c_p2" id="m5"><%=ToolStatus.ConvertLowerMoney(fundAccountInfo.TotalPayOutMember ?? 0)%></p>
							</div>
							<div class="w33p lf">
								<p class="c-808080"><i class="c_i1"></i>已付利息</p>
								<p class="line-h16 c_p2" id="m6"><%=ToolStatus.ConvertLowerMoney(paymodel.RepayedInterest)%></p>
							</div>
						</div>
						<div class="clearfix pt20">
							<div class="w33p lf">
								<p class="c-808080"><i class="c_i5"></i>支付佣金</p>
								<p class="line-h16 c_p2" id="m7"><%=ToolStatus.ConvertLowerMoney((fundAccountInfo.TotalInvestCommission??0)+(fundAccountInfo.BorrowCommission??0))%></p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<section class="mt10 bt-e6e6e6 bg-fff bb-e6e6e6">
			<div class="td_age text-center">
				<%=userModel.AddDate.Value.ToString("yyyy.MM.dd") %>注册，已加入团贷网
                <% if (JoinTDDay.ToString().Length > 0)
                   {
                       for (int i = 0; i < JoinTDDay.ToString().Length; i++)
                       {
                           %>
                           <span><%=JoinTDDay.ToString().Substring(i,1) %></span> 
                <%
                       }
                   } %>
				天！
			</div>
			<div class="incomePart pos-r">
				<div class="pt15 pb15 ml15 mr15 bt-e6e6e6">
					<div class="clearfix">
						<div class="partOpt text-center w50p lf br-e6e6e6">
							<p class="c-999">累计投资</p>
							<p class="f18px mt4"><%=ToolStatus.ConvertLowerMoney(fundAccountInfo.TotalInvest??0)%></p>
						</div>
						<div class="partOpt text-center w50p lf">
							<p class="c-999">累计借款</p>
							<p class="f18px mt4"><%=ToolStatus.ConvertLowerMoney(fundAccountInfo.TotalBorrow??0)%></p>
						</div>
					</div>
				</div>
				<div class="pt15 pb15 ml15 mr15 bt-e6e6e6">
					<div class="clearfix">
						<div class="partOpt text-center w50p lf br-e6e6e6">
							<p class="c-999">累计充值</p>
							<p class="f18px mt4"><%=ToolStatus.ConvertLowerMoney(TotalRecharge) %></p>
						</div>
						<div class="partOpt text-center w50p lf">
							<p class="c-999">累计提现</p>
							<p class="f18px mt4"><%=ToolStatus.ConvertLowerMoney(TotalWithDrawal) %></p>
						</div>
					</div>
				</div>
				<div class="partCenter webkit-box box-center">
					<i></i>
				</div>
			</div>
		</section>
		

	</body>
	<script type="text/javascript" src="/scripts/jquery.min.js"></script>
	<script type="text/javascript" src="/scripts/echarts1.js"></script>
	<script type="text/javascript" src="/scripts/fastclick.js"></script>
	<script type="text/javascript" src="/scripts/Common.js?v=<%=GlobalUtils.Version %>"></script>
	<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
	<script type="text/javascript">
	    function c1() {
	        //计算白色填充区域的值
	        var whiteValue = 0;
	        var arr = [] , dataConfig = [];
	        var c1_num = $("#c1_lable").find('.c_p2');
	        $(c1_num).each(function (i,item) {
	            var html = parseFloat($(item).html().replaceAll(",",""));
	            arr.push(html);
	            whiteValue += html;
	        })
	        if(whiteValue == 0){
				dataConfig = [{
						value: '1',
						name: '',
						itemStyle: {normal: {color: '#e6e6e6'}}
					},{
						value: '1',
						name: '',
						itemStyle: {normal: {color: 'rgba(255,255,255,0)'}}
					}]
			}else{
				dataConfig = [{
						value: arr[0],
						name: '可用资金',
						itemStyle: {normal: {color: '#ffc260'}}
					}, {
						value: arr[1],
						name: '待收本金',
						itemStyle: {normal: {color: '#f5897f'}}
					}, {
						value: arr[2],
						name: '待收利息',
						itemStyle: {normal: {color: '#8992b8'}}
					}, {
						value: arr[3],
						name: '待确认投标',
						itemStyle: {normal: {color: '#bc95a7'}}
					}, {
						value: arr[4],
						name: '待确认提现',
						itemStyle: {normal: {color: '#f9ac78'}}
					}, {
						value: arr[5],
						name: 'We计划待投',
						itemStyle: {normal: {color: '#5ba6b3'}}
					}, {
						value: arr[6],
						name: '冻结资金',
						itemStyle: {normal: {color: '#2ab8aa'}}
					}, {
						value: whiteValue,
						name: '白色填充',
						itemStyle: {normal: {color: 'rgba(255,255,255,0)'}}
					}]
			}
	        //初始化饼图
	        var myChart = echarts.init(document.getElementById('c1'));
	        var option = {
	            tooltip: { show: false, },
	            legend: { show: false, },
	            series: [{
	                name: '访问来源',
	                type: 'pie',
	                legendHoverLink: false,
	                hoverAnimation: false,
	                silent: true,
	                selectedOffset: 0,
	                radius: ['75', '125'],
	                startAngle: '-180',
	                avoidLabelOverlap: false,
	                label: {
	                    normal: { show: false, }
	                },
	                labelLine: { normal: {} },
	                data: dataConfig
	            }]
	        };
	        myChart.setOption(option);
	    }
        
        function setStyle1(h1, h2, h3, h4, h5) {
            if (h1 > 0 && h1 < 0.27) h1 = 0.27;
            if (h2 > 0 && h2 < 0.27) h2 = 0.27;
            if (h3 > 0 && h3 < 0.27) h3 = 0.27;
            if (h4 > 0 && h4 < 0.27) h4 = 0.27;
            if (h5 > 0 && h5 < 0.27) h5 = 0.27;
            var triH = $(window).width()*0.27;
			if(triH>120){
				triH = 120;
			}
			$("#yellowLeft").css({
				'borderBottom' : (h1*triH)+'px solid #ffca72',
				'borderLeft' : (h1*triH/2)+'px solid transparent',
			});
			$("#yellowRight").css({
				'borderBottom' : (h1*triH)+'px solid #ffc260',
				'borderRight' : (h1*triH/2)+'px solid transparent'
			});
			$("#redLeft").css({
				'borderBottom' : (h2*triH)+'px solid #f7988f',
				'borderLeft' : (h2*triH/2)+'px solid transparent'
			});
			$("#redRight").css({
				'borderBottom' : (h2*triH)+'px solid #f5897f',
				'borderRight' : (h2*triH/2)+'px solid transparent'
			});
			$("#greenLeft").css({
				'borderBottom' : (h3*triH)+'px solid #3cc2b5',
				'borderLeft' : (h3*triH/2)+'px solid transparent'
			});
			$("#greenRight").css({
				'borderBottom' : (h3*triH)+'px solid #2ab8aa',
				'borderRight' : (h3*triH/2)+'px solid transparent'
			});
			$("#grayLeft").css({
				'borderBottom' : (h4*triH)+'px solid #98a0c2',
				'borderLeft' : (h4*triH/2)+'px solid transparent'
			});
			$("#grayRight").css({
				'borderBottom' : (h4*triH)+'px solid #8992b8',
				'borderRight' : (h4*triH/2)+'px solid transparent'
			});
			$("#purpleLeft").css({
				'borderBottom' : (h5*triH)+'px solid #c5a3b3',
				'borderLeft' : (h5*triH/2)+'px solid transparent'
			});
			$("#purpleRight").css({
				'borderBottom' : (h5*triH)+'px solid #bc95a7',
				'borderRight' : (h5*triH/2)+'px solid transparent'
			});
			var winWidth = $(window).width();
			var perBox1 = $(".per-box1");
			var perBox2 = $(".per-box2");
			var perBox3 = $(".per-box3");
			var perBox4 = $(".per-box14");
			var perBox5 = $(".per-box15");
			var w = perBox1.outerWidth()+perBox2.outerWidth()+perBox3.outerWidth()+perBox4.outerWidth()+perBox5.outerWidth();
			perBox1.css({
				'left':(winWidth-w)/2+10
			});
			perBox2.css({
				'left':(winWidth-w)/2+perBox1.outerWidth()+5,
			});
			perBox3.css({
				'left':(winWidth-w)/2+perBox1.outerWidth()+perBox2.outerWidth(),
			});
			perBox4.css({
				'left':(winWidth-w)/2+perBox1.outerWidth()+perBox2.outerWidth()+perBox3.outerWidth()-5,
			});
			perBox5.css({
				'left':(winWidth-w)/2+perBox1.outerWidth()+perBox2.outerWidth()+perBox3.outerWidth()+perBox4.outerWidth()-10,
			});
        }

        function setStyle2(h1, h2, h3, h4) {
            if (h1 > 0 && h1 < 0.27) h1 = 0.27;
            if (h2 > 0 && h2 < 0.27) h2 = 0.27;
            if (h3 > 0 && h3 < 0.27) h3 = 0.27;
            if (h4 > 0 && h4 < 0.27) h4 = 0.27;
            $("#redLeft2").css({
				'borderBottom' : (h1*112)+'px solid #f7988f',
				'borderLeft' : (h1*56)+'px solid transparent',
			});
			$("#redRight2").css({
				'borderBottom' : (h1*112)+'px solid #f5897f',
				'borderRight' : (h1*56)+'px solid transparent'
			});
			$("#greenLeft2").css({
				'borderBottom' : (h2*112)+'px solid #3cc2b5',
				'borderLeft' : (h2*56)+'px solid transparent'
			});
			$("#greenRight2").css({
				'borderBottom' : (h2*112)+'px solid #2ab8aa',
				'borderRight' : (h2*56)+'px solid transparent'
			});
			$("#yellowLeft2").css({
				'borderBottom' : (h3*112)+'px solid #ffca72',
				'borderLeft' : (h3*56)+'px solid transparent'
			});
			$("#yellowRight2").css({
				'borderBottom' : (h3*112)+'px solid #ffc260',
				'borderRight' : (h3*56)+'px solid transparent'
			});
			$("#grayLeft2").css({
				'borderBottom' : (h4*112)+'px solid #98a0c2',
				'borderLeft' : (h4*56)+'px solid transparent'
			});
			$("#grayRight2").css({
				'borderBottom' : (h4*112)+'px solid #8992b8',
				'borderRight' : (h4*56)+'px solid transparent'
			});
            var winWidth = $(window).width();
            var perBox4 = $(".per-box4");
            var perBox5 = $(".per-box5");
            var perBox6 = $(".per-box6");
            var perBox7 = $(".per-box7");
            var w = perBox4.outerWidth() + perBox5.outerWidth() + perBox6.outerWidth() + perBox7.outerWidth();
            perBox4.css({
                'left': (winWidth - w) / 2 + 10
            });
            perBox5.css({
                'left': (winWidth - w) / 2 + perBox4.outerWidth() + 5
            });
            perBox6.css({
                'left': (winWidth - w) / 2 + perBox4.outerWidth() + perBox5.outerWidth()
            });
            perBox7.css({
                'left': (winWidth - w) / 2 + perBox4.outerWidth() + perBox5.outerWidth() + perBox6.outerWidth() - 5
            });
        }

        function c3(){
			var m1 = parseFloat($("#m1").html().replaceAll(",", ""));
			var m2 = parseFloat($("#m2").html().replaceAll(",", ""));
			var m3 = parseFloat($("#m3").html().replaceAll(",", ""));
            var m4 = parseFloat($("#m14").html().replaceAll(",", ""));
			var m5 = parseFloat($("#m15").html().replaceAll(",", ""));
			var max;
			var m12345 = Number(m1 + m2 + m3 + m4 +m5);
			if(m12345 == 0){
				$("#num1,#num2,#num3,#num14,#num15").html('');
				$("#triChart1").css('height','0');
			    $("#lable1").css({
			        'padding-top': '0',
			        'margin-top': '-27px'
			    });
			}else{
				if(m1>m2 && m1>m3 && m1>m4 && m1>m5){
					max = m1;
				}else{
					if(m2>m3&&m2>m4&&m2>m5){
						max = m2;
					}else{
						if(m3>m4&&m3>m5){
							max = m3;
						}else{
							if(m4>m5){
								max = m4;
							}else{
								max = m5;
							}
						}
					}
				}
				var per1 = m1/max;
				var per2 = m2/max;
				var per3 = m3/max;
				var per4 = m4/max;
				var per5 = m5/max;
				setStyle1(per1,per2,per3,per4,per5);
	            $("#num1").html(parseFloat(m1 / m12345 * 100).toFixed(2) + "%");
	            $("#num2").html(parseFloat(m2 / m12345 * 100).toFixed(2) + "%");
	            $("#num3").html(parseFloat(m3 / m12345 * 100).toFixed(2) + "%");
	            $("#num14").html(parseFloat(m4 / m12345 * 100).toFixed(2) + "%");
	            $("#num15").html(parseFloat(m4 / m12345 * 100).toFixed(2) + "%");
            }
        }

        function c4() {
            var m1 = parseFloat($("#m4").html().replaceAll(",", ""));
            var m2 = parseFloat($("#m5").html().replaceAll(",", ""));
            var m3 = parseFloat($("#m6").html().replaceAll(",", ""));
            var m4 = parseFloat($("#m7").html().replaceAll(",", ""));
            var max;
            var m1234 = parseFloat(m1 + m2 + m3 + m4);
            if(m1234==0){
            	$("#num4,#num5,#num6,#num7").html('');
				$("#triChart2").css('height','0');
				$("#lable2").css({
					'padding-top':'0',
					'margin-top':'-27px'
				})
            }else{
	            if (m1 > m2 && m1 > m3 && m1 > m4) {
	                max = m1;
	            } else {
	                if (m2 > m3 && m2 > m4) {
	                    max = m2;
	                } else {
	                    if (m3 > m4) {
	                        max = m3;
	                    } else {
	                        max = m4;
	                    }
	                }
	            }
	
	            var per1 = m1 / max;
	            var per2 = m2 / max;
	            var per3 = m3 / max;
	            var per4 = m4 / max;
	            setStyle2(per1, per2, per3, per4);
	            $("#num4").html(parseFloat(m1 / m1234 * 100).toFixed(2) + "%");
	            $("#num5").html(parseFloat(m2 / m1234 * 100).toFixed(2) + "%");
	            $("#num6").html(parseFloat(m3 / m1234 * 100).toFixed(2) + "%");
	            $("#num7").html(parseFloat(m4 / m1234 * 100).toFixed(2) + "%");
            }
        }
        function tab() {
            $(".tabTit").click(function () {
                var i = $(this).find('i');
                var next = $(this).next();
                if (next.css('display') == 'none') {
                    next.slideDown(300);
                    i.css('-webkit-transform', 'rotateZ(-90deg)');
                } else {
                    next.slideUp(300);
                    i.css('-webkit-transform', 'rotateZ(90deg)');
                }
            });
        }
        c1();
        //c2();
        c3();
        c4();
        tab();

        //金额格式化(无四舍五入)
        function fmoney2(s) {
            s = parseFloat(Round2((s + "").replace(/[^\d\.-]/g, ""))).toFixed(2) + "";
            var l = s.split(".")[0].split("").reverse(),
                    r = s.split(".")[1];
            t = "";
            for (i = 0; i < l.length; i++) {
                t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
            }
            return t.split("").reverse().join("") + "." + r;
        }

        $(function () {
            var list = $(".per-num");
            $(list).each(function (ind, item) {
                var per = parseFloat($(item).html().replaceAll(",", ""));
                if (per <=0) {
                    $(item).hide();
                } else {
                    $(item).hide();
                }
            });
        });
	</script>

</html>