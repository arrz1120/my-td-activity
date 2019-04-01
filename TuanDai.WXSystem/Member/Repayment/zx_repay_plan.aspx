<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="zx_repay_plan.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.zx_repay_plan" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>结清计划</title>
        <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
        <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=GlobalUtils.Version %>" />
		<link rel="stylesheet" href="/wap/css/zhixiang/plan.css?v=<%=GlobalUtils.Version %>">
        <style type="text/css">
            .yearItem {
                background-color: #f6f7f8;
            }
        </style>
	</head>
	<script type="text/javascript">
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

	<body>
        <%= this.GetNavStr()%>
    <div style="display: none;"><%= this.GetNavIcon()%></div>
		<div class="rmWidth rmNav clearfix">
			<div class="w1 lf f30rem c-808080 text-overflow pl20rem">日期</div>
			<div class="w4 lf f30rem text-overflow text-right">待结清</div>
		</div>

		<div class="monthListWrap">
			<div class="monthList">
				
			</div>
		</div>

		<div id="more" class="loadMore" dataValue="1">加载更多</div>

		<div class="dateAlert hide" id="dateAlert">
			<div class="d_top"><span id="alert_today">2018年03月19日</span><i id="closeAlert"></i></div>
			<div class="d_tit"><i></i>待结清：<span id="dueOutAmount"></span></div>
            <div id="list1">
			    <div class="d_list pb10" id="d1">
				    <%--<div class="pl10 pt10 pr10">
					    <div class="d_item">
						    <p>结清金额:<span class="c-fd6040 r_money">1,535.63</span></p>
						    <p class="c-ababab pt7">(<span class="c-ababab">本金:1,500.00</span><span class="c-ababab ml15">利息:35.63</span>)</p>
						    <div class="clearfix proName pt8">
							    <div class="lf text-overflow">[资产标]资产标171218112638779</div>
							    <div class="rf c-ababab">待结清（1/3)</div>
						    </div>
					    </div>
				    </div>--%>
			    </div>
            </div>
		</div>
        
     

		<script src="/wap/js/lib/fastclick-jquery.js?v=<%=GlobalUtils.Version %>"></script>
        <script src="/scripts/jquery.min.js"></script>
        <script type="text/javascript" src="/scripts/Common.js?v=<%=GlobalUtils.Version %>"></script>
        <script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
        <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>
		<script type="text/javascript">
		    //显示弹框
		    function openAlert(obj) {
		        $(document).scrollTop(0);
		        var parent = obj.parent();
		        var today = parent.attr('year') + '年' + parent.attr('month') + '月' + obj.attr('day') + '日';
		        $("#alert_today").html(today);
		        LoadDetail(obj);
		        $("#dateAlert").removeClass('hide').removeClass('moveToBottom').addClass('moveToTop');
		        setTimeout(function () {
		            $("#bigDiv").addClass('hide');
		        }, 300);
		    }

		    //隐藏弹框
		    $("#closeAlert").click(function () {
		        $("#dateAlert").removeClass('moveToTop').addClass('moveToBottom');
		        $("#bigDiv").removeClass('hide');
		        setTimeout(function () {
		            $("#dateAlert").addClass('hide');
		        }, 300);
		    });

		    $(function() {
		        LoadList("empty");
		        $("#more").click(function () {
		            if (parseInt($(this).attr("dataValue")) >= 11) {
		                $(this).addClass("hide");
		            }
		            $(this).attr("dataValue", parseInt($(this).attr("dataValue")) + 1);
		            LoadList("123");
		        });
		    });
		    pageIndex = 1;
		    function LoadList(flag) {
		        $("body").showLoading("加载中...");
		        if (flag == "empty") {
		            $(".monthList").html("");
		        }
		        var startDate = $("#more").attr("dataValue");
		        $.ajax({
		            type: "post",
		            url: "/ajaxCross/BorrowAjax.ashx",
		            dataType: "json",
		            async: true,
		            data: {
		                Cmd: "GetZxReturnAndPayMonths",
		                startDate: startDate
		            },
		            success: function (jsonstr) {
		                $("body").hideLoading();
		                //jsonstr = JSON.parse(jsonstr);
		                if (jsonstr.list && jsonstr.list.length > 0) {
		                    var html = new Array();
		                    var row = "";
		                    var yearStr = "";
		                    var flag = 0;
		                    $(jsonstr.list).each(function (index, item) {
		                        if (parseFloat(item.payMoney) > 0) {
		                            if ((index > 0 && item.myMonth.substr(0, 4) != jsonstr.list[index - 1].myMonth.substr(0, 4)) || (flag == 0 && item.myMonth.substr(0, 4) != $(".monthItem:last").attr("year"))) {
		                                yearStr = '<div class="yearItem">' + item.myMonth.substr(0, 4) + '年</div>';
		                            } else {
		                                yearStr = '';
		                            }
		                            row = yearStr + '<div class="rmWidth rmItem monthItem clearfix" onclick="javascript:clickMonth(this);" year="' + item.myMonth.substr(0, 4) + '" month="' + item.myMonth.substr(4, 2) + '">' +
                                        '<div class="w1 lf f30rem text-overflow pl20rem"><span>' + item.myMonth.substr(4, 2) + '月</span></div>' +
                                        '<div class="w4 lf f30rem text-overflow text-right">' + fmoney1(item.payMoney) + '</div>' +
                                        '<i class="ico-arrow-r rotateZ_90"></i>' +
                                        '</div>';
		                            html.push(row);
		                            flag++;
		                        }
		                    });
		                    $(".monthList").append(html);
		                } else {

		                }
		            },
		            error: function (a, b, c) {
		                $("body").hideLoading();
		            }
		        });
		    }
		    //点击月份事件
		    function clickMonth(item) {
		        if (!$(item).next().hasClass("dayList")) {
		            var year = $(item).attr("year");
		            var month = $(item).attr("month");
		            $("body").showLoading("加载中...");
		            $.ajax({
		                async: false,
		                type: "post",
		                url: "/ajaxCross/BorrowAjax.ashx",
		                dataType: "json",
		                data: {
		                    Cmd: "GetZxReturnAndPayDetail",
		                    year: year, month: month
		                },
		                success: function (jsonstr) {
		                    $("body").hideLoading();
		                    //jsonstr = JSON.parse(jsonstr);
		                    if (jsonstr.length > 0) {
		                        $(item).after('<div class="dayList hide" year="' + year + '" month="' + month + '"></div>');
		                        var html = new Array();
		                        var row = "";
		                        $(jsonstr).each(function (ind, rowItem) {
		                            if (parseFloat(rowItem.payMoney) > 0) {
		                                row = '<div onclick="javascript:openAlert($(this));" class="rmWidth rmItem dayItem clearfix" day="' + rowItem.myDate.substr(6, 2) + '" date="' + rowItem.myDate.substr(0, 10) + '" returnMoney="' + fmoney2(rowItem.returnMoney) + '" repayMoney="' + fmoney1(rowItem.payMoney) + '">' +
                                        '<div class="w1 lf f30rem text-overflow"><span>' + rowItem.myDate.substr(6, 2) + '</span></div>' +
                                        '<div class="w4 lf f30rem text-overflow text-right">' + fmoney1(rowItem.payMoney) + '</div>' +
                                        '<i class="ico-arrow-r"></i>' +
                                        '</div>';
		                                html.push(row);
		                            }
		                        });
		                        $(item).next().append(html);
		                    }
		                },
		                error: function () {
		                    $("body").hideLoading();
		                }
		            });
		        }

		        //点击当前月份下的Div
		        var dayList = $(item).next();
		        if (dayList.hasClass('hide')) {
		            $(item).find('i').removeClass('rotateZ_90').addClass('rotateZ90');
		            dayList.removeClass('hide').removeClass('dayListHide').addClass('dayListShow');
		        } else {
		            $(item).find('i').removeClass('rotateZ90').addClass('rotateZ_90');
		            dayList.removeClass('dayListShow').addClass('dayListHide');
		            setTimeout(function () {
		                dayList.addClass('hide');
		            }, 300);
		        }
		        $(".dateAlert").height(document.body.scrollHeight);

		    };
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
		    function fmoney1(s) {
		        return parseFloat(s) > 0 ? fmoney2(parseFloat(s) + 0.01) : 0.00;
		    }
		    
		    //加载弹框信息
		    function LoadDetail(li) {
		        $("body").showLoading("加载中...");
		        var date = $(li).attr("date");
		        var repayMoney = $(li).attr("repaymoney");
		        $.ajax({
		            url: "/ajaxCross/BorrowAjax.ashx",
		            type: "post",
		            dataType: "json",
		            async: false,
		            data: {
		                Cmd: "GetZxReturnAndPayByDay",
		                Date: date
		            },
		            success: function (json) {
		                $("body").hideLoading();
		                $("#dueOutAmount").html((repayMoney));
		                if (json.length > 0) {
		                    $("#d1").html("");
		                    var jlStr = "";
		                    var row = "";
		                    $(json).each(function (index, item) {
		                        if (parseFloat(item.Amount) + parseFloat(item.InterestAmout) + parseFloat(item.JiangLi) > 0 && item.IsReturn != "1") {
		                            if (parseFloat(item.JiangLi) > 0) {
		                                jlStr = '<span class="d_itemTips">奖励:' + fmoney1(item.JiangLi) + '</span>';
		                            } else {
		                                jlStr = '';
		                            }
		                            row = '<div class="pl10 pt10 pr10">' +
                                                '<div class="d_item">' +
                                                    '<p>结清金额:<span class="c-fd6040 r_money">' + fmoney1(parseFloat(item.Amount) + parseFloat(item.InterestAmout) + parseFloat(item.JiangLi)) + '</span>' + jlStr + '</p>' +
                                                    '<p class="c-ababab pt7">(<span class="c-ababab">本金:' + fmoney2(item.Amount) + '</span><span class="c-ababab ml15">利息:' + fmoney1(item.InterestAmout) + '</span>)</p>' +
                                                    '<div class="clearfix proName pt8">' +
                                                        '<div class="lf text-overflow">' + item.Title + '</div>' +
                                                        '<div class="rf c-ababab">待结清（' + item.Periods + '/' + item.Deadline + ')</div>' +
                                                    '</div>' +
                                                '</div>' +
                                            '</div>';
		                            $("#d1").append(row);
		                        }
		                    });
		                }
		            },
		            error: function () {
		                $("body").hideLoading();
		            }
		        });
		    }
		</script>
	</body>

</html>
