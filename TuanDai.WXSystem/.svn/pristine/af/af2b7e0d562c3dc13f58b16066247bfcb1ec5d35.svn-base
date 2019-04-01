<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_payment.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.my_payment" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>我的待付</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/account.css?v=20151118" />
    <!--账户中心-->
</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:window.location.href='/Member/my_account.aspx'">返回</div>
            <h1 class="title">我的待付</h1>
            <%--<div class="text"><a href="borrowLog.aspx">借款记录</a></div>--%>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>

    <div class="payMnetBox clearfix">
        <section class="clearfix">
            <div class="pay-t">
                <div class="mytakeCont"></div>
            </div>
            <div class="payNav clearfix">
                <div class="p-left">
                    <div class="p-left">
	                    <div class="textBox" id="textBox">
	                        <span attrval="0" class="dateBox dayBox c-fac502">按日</span>
	                        <span attrval="1" class="dateBox monthBox">按月</span>
	                    </div>
	                </div>
                </div>
                <div class="p-right">待付本金 + 利息+奖励</div>
            </div>
        </section>
        <section class="pl20 clearfix">
            <!--刷新界  Start-->
            <div id="wrapper" style="top:50px!important;">
                <div id="scroller">
                    <div id="pullDown">
                        <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
                    </div>
                    <div id="report_detail_processing" class="dataTables_processing" style="display: none">正在加载...</div>
                    <!--数据列表 Start-->
                    <div class="listBox clearfix" style="margin-left: 20px;">
                        <ul class="clearfix" id="trhead">
                            <br />
                        </ul>
                    </div>

                    <!--数据列表 End-->
                    <div id="pullUp">
                        <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
                    </div>
                </div>
            </div>
            <!--刷新界  End-->
        </section>
    </div>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        var type = "0";
        pageIndex = 1;
        $(function () {
            GetData("empty");
            //我的待收/我的代付显示隐藏 
            $(".mytakeCont").slideDown(); 
 
            $(".dateBox").click(function () {
            	$(".dateBox").removeClass('c-fac502');
            	$(this).addClass('c-fac502'); 
                type = $(this).attr("attrval");
                pageIndex = 1;
                setTimeout(function () {
                    //重新加载数据
                    GetData('empty');
                    myScroll.refresh();
                }, 500);

                $(".mytakeCont").slideDown();
            });

            setInterval(function () {
                $(".mytakeCont").slideUp(); 
            }, 5000);

            iScroll.onLoadData = GetData; 
        })

        var years = new Array();
        function GetData(flag) {
            $("#report_detail_processing").show();
            if (flag == "empty") {
                $("#trhead").children().remove();
                years = [];
            }
            $.ajax({
                async: false,
                type: "post",
                url: "/ajaxCross/ajax_autoLoan.ashx",
                dataType: "json",
                data: {
                    Cmd: "GetBorrowReturnPlan",
                    type: type, pageIndex: pageIndex
                },
                success: function (jsonstr) {
                    pageCount = parseInt(jsonstr.totalcount);
                    var html = new Array();
                    var str = "";
                    if (jsonstr.result == "1") {
                        var overCostTip = ""; 
                        if (GetMoney(jsonstr.OverCost) > 0) {
                            overCostTip = "（包含逾期:" + GetMoney(jsonstr.OverCost) + "元)";
                        }
                        $('.mytakeCont').html("<%=userModel.NickName %>,您在" + jsonstr.list[0].CycDate + "有" + jsonstr.list[0].num + "笔还款，还款总金额："
                            + GetMoney(jsonstr.list[0].TotalAmount + jsonstr.OverCost) + "元" + overCostTip + "，请备足还款金额！");

                        for (var i = 0; i < jsonstr.list.length; i++) {
                            var date = new Date(jsonstr.list[i].CycDate);
                            var year = date.getFullYear();
                            if ($.inArray(year, years) == -1) {
                                years.push(year);
                                str = "<li class=\"year-line\"><i class=\"year\">" + year + "</i></li>";
                                html.push(str);
                            }
                            str = "<li>" +
                                  "<span class=\"lf f14px c-808080\">" + GetDate(jsonstr.list[i].CycDate) + "</span>" +
                                  "<span class=\"rf f14px c-808080\"><b class=\"c-212121\">￥" + GetMoney(jsonstr.list[i].Amount) + "</b>" +
                                  (jsonstr.list[i].InterestAmout > 0 ? " + <i class=\"c-ff7357\">" + GetMoney(jsonstr.list[i].InterestAmout) + "</i>" : "") +
                                  (jsonstr.list[i].PublisherRedPacket > 0 ? " + <i class=\"c-ff7357\">" + GetMoney(jsonstr.list[i].PublisherRedPacket) + "</i>" : "") + "</span><i class=\"ico-clock\"></i>" +
                                  "</li>";
                            html.push(str);
                        }
                        $("#trhead").append(html.join(""));
                    }
                    else {
                        $('.mytakeCont').html("暂无还款");
                        $("#trhead").append("<li><span class=\"lf f14px c-808080\">暂无还款...</span></li>");
                        pageCount = 0;
                    }
                    if (pageCount <= 1) {
                        $("#pullUp").hide();
                    } else {
                        $("#pullUp").show();
                    }
                    $("#report_detail_processing").hide();
                },
                error: function (a, b, c) {
                    $("#trhead").children().remove();
                    $("#trhead").append("<li><span class=\"lf f14px c-808080\">加载有误...</span></li>");
                }
            });
        }
        function GetDate(CycDate) {
            var date = new Date(CycDate);
            var month = date.getMonth() + 1;
            if (type == "0") {
                var day = date.getDate();
                if (month < 10)
                    month = "0" + month;
                if (day < 10)
                    day = "0" + day;
                return month + "月" + day + "日";
            } else {
                return month + "月";
            }
        }
        function GetMoney(money) { 
            if (money == null || money == undefined || money=="")
                return 0;
            var amount = money.toString();
            var amount1 = money;

            if (amount.indexOf(".") > 0) {
                amount = amount.substr(amount.length - amount.indexOf("."), 4);
                if (parseInt(amount) > 0) {
                    amount = parseFloat(Math.floor(amount1 * 10000 + 0.5) / 10000 + 0.01);
                }
                else {
                    amount = money.toFixed(2);
                }
            }
            return Math.floor(amount * 100) / 100;
        }
    </script>
</body>
</html>
