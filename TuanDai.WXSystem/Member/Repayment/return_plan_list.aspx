﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="return_plan_list.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.return_plan_list" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>回款计划</title>
    <link rel="stylesheet" type="text/css" href="/css/remPage.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <Style>
        .btnYellow {
            background-color: #ffcf1f;
            height: 42px;
            color: #fff;
            line-height: 42px;
            font-size: 15px;
            text-align: center;
        }
       
        .yearItem {
            background-color: #f6f7f8;
        }
        
    </Style>
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
    <div class="loading-box" id="cMloading">
        <div class="loading-tips">
            <img src="/imgs/images/icon/ico_loading.png" alt=""><span>加载中...</span>
        </div>
    </div>
    <div class="float-jump" style="bottom: 57px;">
        <a href="/Index.aspx">
            <img src="/imgs/images/icon/ico_toHome.png"></a>   <a href="/Member/my_account.aspx">
                <img src="/imgs/images/icon/ico_toAccount.png"></a>
    </div>
    <div class="rmWidth rmNav clearfix">
        <div class="w1 lf f30rem c-808080 text-overflow pl20rem">日期</div>
        <div class="w2 rf f30rem c-808080 text-overflow text-left">待回款</div>
    </div>

    
    <div class="monthListWrap">
        <div class="monthList">
                    
        </div>
    </div>
    <div id="more" class="loadMore" dataValue="1">加载更多>></div>
            
    <!--弹框-->
    <div class="dateAlert hide" id="dateAlert">
        <div class="d_top"><span id="alert_today">2016年7月11日</span><i id="closeAlert"></i></div>
        <div class="d_tab clearfix bg-fff">
            <div class="lf w33p text-center pt8 pb10 cur" id="tab1">
                <p class="f15px">待回款</p>
                <p class="f13px line-h18 c-808080" id="dueInAmount">2000.00</p>
            </div>
        </div>
        <!--待回款-->
        <div id="list1">
            <div class="d_list pb10" id="d1">
            </div>
        </div>
    </div>

    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/Common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
     <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">

        //点击月份事件
        function clickMonth(item) {
            if (!$(item).next().hasClass("dayList")) {
                var year = $(item).attr("year");
                var month = $(item).attr("month");
                $("body").showLoading("加载中...");
                $.ajax({
                    async: false,
                    type: "post",
                    url: "/ajaxCross/ajax_autoLoan.ashx",
                    dataType: "json",
                    data: {
                        Cmd: "GetReturnAndPayDetail",
                        year: year, month: month
                    },
                    success: function (jsonstr) {
                        $("body").hideLoading();
                        if (jsonstr.length > 0) {
                            $(item).after('<div class="dayList hide" year="' + year + '" month="' + month + '"></div>');
                            var html = new Array();
                            var row = "";
                            $(jsonstr).each(function (ind, rowItem) {
                                if (parseFloat(rowItem.returnMoney) > 0) {
                                    row = '<div onclick="javascript:openAlert($(this));" class="rmWidth rmItem dayItem clearfix" day="' + rowItem.myDate.substr(8, 2) + '" date="' + rowItem.myDate.substr(0, 10) + '" returnMoney="' + fmoney2(rowItem.returnMoney) + '" repayMoney="' + (parseFloat(rowItem.payMoney) > 0 ? fmoney2(parseFloat(rowItem.payMoney) + 0.01) : 0.00) + '" repayZxMoney="' + fmoney1(rowItem.payZxMoney) + '">' +
                                    '<div class="w1 lf f30rem text-overflow"><span>' + rowItem.myDate.substr(8, 2) + '</span></div>' +
                                    '<div class="w2 rf f30rem text-overflow text-right">' + fmoney2(rowItem.returnMoney) + '</div>' +
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
                $(item).find('i').removeClass('rotateZ90').addClass('rotateZ_90');
                dayList.removeClass('hide').removeClass('dayListHide').addClass('dayListShow');
            } else {
                $(item).find('i').removeClass('rotateZ_90').addClass('rotateZ90');
                dayList.removeClass('dayListShow').addClass('dayListHide');
                setTimeout(function () {
                    dayList.addClass('hide');
                }, 300);
            }

            $(".dateAlert").height(document.body.scrollHeight);

        };

        pageIndex = 1;
        $(function () {
            LoadList("empty");
            $("#more").click(function () {
                if (parseInt($(this).attr("dataValue")) >= 11) {
                    $(this).addClass("hide");
                }
                $(this).attr("dataValue", parseInt($(this).attr("dataValue")) + 1);
                LoadList("123");
            });
        });
        function LoadList(flag) {
            $("body").showLoading("加载中...");
            if (flag == "empty") {
                $(".monthList").html("");
            }
            var startDate = $("#more").attr("dataValue");
            $.ajax({
                type: "post",
                url: "/ajaxCross/ajax_autoLoan.ashx",
                dataType: "json",
                async: true,
                data: {
                    Cmd: "GetReturnAndPayMonths",
                    startDate: startDate
                },
                success: function (jsonstr) {
                    $("body").hideLoading();
                    if (jsonstr.list && jsonstr.list.length > 0) {
                        var html = new Array();
                        var row = "";
                        var yearStr = "";
                        var flag = 0;
                        $(jsonstr.list).each(function (index, item) {
                            if (parseFloat(item.returnMoney) > 0 ) {
                                if ((index > 0 && item.myMonth.substr(0, 4) != jsonstr.list[index - 1].myMonth.substr(0, 4)) || (flag == 0 && item.myMonth.substr(0, 4) != $(".monthItem:last").attr("year"))) {
                                    yearStr = '<div class="yearItem">' + item.myMonth.substr(0, 4) + '年</div>';
                                } else {
                                    yearStr = '';
                                }
                                row = yearStr + '<div class="rmWidth rmItem monthItem clearfix" onclick="javascript:clickMonth(this);" year="' + item.myMonth.substr(0, 4) + '" month="' + item.myMonth.substr(5, 2) + '">' +
                                    '<div class="w1 lf f30rem text-overflow pl20rem"><span>' + item.myMonth.substr(5, 2) + '月</span></div>' +
                                    '<div class="w2 rf f30rem text-overflow text-right">' + fmoney2(item.returnMoney) + '</div>' +
                                    '<i class="ico-arrow-r rotateZ90"></i>' +
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
        //加载弹框信息

        function LoadDetail(li) {
            $("body").showLoading("加载中...");
            var date = $(li).attr("date");
            var returnMoney = $(li).attr("returnmoney");
            $.ajax({
                url: "/ajaxCross/ajax_autoLoan.ashx",
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    Cmd: "GetReturnAndPayByDay",
                    Date: date
                },
                success: function (json) {
                    $("body").hideLoading();
                    $("#dueInAmount").html(fmoney2(returnMoney));
                    if (json.length > 0) {
                        $("#d1").html("");
                        var jlStr = "";
                        var row = "";
                        var hkStr = "";
                        $(json).each(function (index, item) {
                            if (parseFloat(item.Amount) + parseFloat(item.InterestAmout) + parseFloat(item.JiangLi) > 0) {
                                if (item.Title == null || item.Title == "null") {
                                    item.Title = "";
                                }
                                if (item.IsReturn == "1") {
                                    if (parseFloat(item.JiangLi) > 0) {
                                        jlStr = '<span class="d_itemTips">奖励:' + fmoney2(item.JiangLi) + '</span>';
                                    } else {
                                        jlStr = '';
                                    }
                                    if (parseInt(item.RepeatInvestType) == 2) {
                                        hkStr = "本金复投";
                                    } else {
                                        hkStr = '待回款（' + item.Periods + '/' + item.Deadline + ')';
                                    }
                                    row = '<div class="pl10 pt10 pr10">' +
                                                '<div class="d_item">' +
                                                    '<p>回款金额:<span class="c-fd6040 r_money">' + fmoney2(parseFloat(item.Amount) + parseFloat(item.InterestAmout) + parseFloat(item.JiangLi)) + '</span>' + jlStr + '</p>' +
                                                    '<p class="c-ababab pt7">(<span class="c-ababab">本金:' + fmoney2(item.Amount) + '</span><span class="c-ababab ml15">预期收益:' + fmoney2(item.InterestAmout) + '</span>)</p>' +
                                                    '<div class="clearfix proName pt8">' +
                                                        '<div class="lf text-overflow">' + item.Title + '</div>' +
                                                        '<div class="rf c-ababab">' + hkStr + '</div>' +
                                                    '</div>' +
                                                '</div>' +
                                            '</div>';
                                    $("#d1").append(row);
                                } 
                            }
                        });
                    }
                },
                error: function () {
                    $("body").hideLoading();
                }
            });
        }
        $(function () {
            //回款与还款切换
            var tab1 = $("#tab1"),
			tab2 = $("#tab2"),
		    tab3 = $("#tab3"),
			list3 = $("#list3"),
			list1 = $("#list1"),
			list2 = $("#list2");
            tab1.click(function () {
                tab1.addClass('cur');
                tab2.removeClass('cur');
                tab3.removeClass('cur');
                list2.hide();
                list3.hide();
                list1.show();
            });
            tab2.click(function () {
                tab2.addClass('cur');
                tab1.removeClass('cur');
                tab3.removeClass('cur');
                list1.hide();
                list3.hide();
                list2.show();
            });
            tab3.click(function () {
                tab3.addClass('cur');
                tab1.removeClass('cur');
                tab2.removeClass('cur');
                list1.hide();
                list2.hide();
                list3.show();
            });
            //隐藏弹框
            $("#closeAlert").click(function () {
                $("#dateAlert").removeClass('moveToTop').addClass('moveToBottom');
                $("#bigDiv").removeClass('hide');
                setTimeout(function () {
                    $("#dateAlert").addClass('hide');
                }, 300);
            });
        });
    </script>
</body>

</html>

