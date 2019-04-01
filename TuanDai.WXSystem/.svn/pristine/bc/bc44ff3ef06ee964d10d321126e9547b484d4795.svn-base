<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="simubao_income_trend.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.income_trend" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>收益走势</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/account.css?v=2015090701" />
    <!--账户中心-->

</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:history.go(-1);">返回</div>
            <h1 class="title">收益走势</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <div class="returned-box simubao-returned clearfix">
        <div id="wrapper">
            <div id="scroller">
                <div id="pullDown">
                    <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
                </div>
                <div id="report_detail_processing" class="dataTables_processing" style="display: none">正在加载...</div>

                <!--图表-->
                <section class="trend-chart bg-fff pl15 pr15">
                    <h3 class="c-434343 f14px pt10 pb10">近期走势</h3>
                    <div style="width: 100%">
                        <div>
                            <canvas id="canvas" height="300" width="600"></canvas>
                        </div>
                    </div>
                </section>

                <div class="bg-fbfbf9 pt15"></div>
                <section class="clearfix">
                    <h3 class="pl15 f14px c-434343 bg-fff mt10">最新净值</h3>
                    <div class="returned-nav clearfix">
                        <div class="p-left c-434343">时间</div>
                        <div class="p-left1 c-434343">最新净值</div>
                        <div class="p-right c-434343">累计净值</div>
                    </div>
                </section>
                <section class="clearfix bg-bdBom1-ccc">
                    <div class="listBox pd0 clearfix trend-list">
                        <ul class="clearfix ml15 mr15" id="thelist">
                            <li>
                                <span class="lf f13px c-808080">暂无数据</span>
                            </li>
                        </ul>
                    </div>
                </section>
                <!--数据列表 End-->
                <div id="pullUp">
                    <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
                </div>
            </div>
            <!--刷新界  End-->
        </div>
    </div>


    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/Chart.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        pageIndex = 1;
        $(function ()
        {
            iScroll.onLoadData = LoadList;
            LoadList('empty');
            setTimeout(getSMBProjectFundDetail, 1000);
        });

        function getSMBProjectFundDetail()
        {
            var dateList = new Array();
            var priceList = new Array();
            jQuery.ajax({
                async: false,
                type: "post",
                url: "/ajaxCross/ajax_simubao.ashx",
                dataType: "json",
                data: { Cmd: "GetSMBProjectFundDetail", projectid: "<%=ProjectId%>" },
                success: function (jsonstr)
                {
                    if (jsonstr.result == "1")
                    {
                        for (var i = 0; i < jsonstr.list.length; i++)
                        {
                            dateList[i] = jsonstr.list[i].PriceDate;
                            priceList[i] = jsonstr.list[i].Price;
                        }
                    }
                }
            });
            var lineChartData = {
                labels: dateList,
                datasets: [
                      {
                          label: "收益走势",
                          fillColor: "transparent",
                          strokeColor: "rgba(255,194,27,1)",
                          pointColor: "rgba(151,187,205,1)",
                          pointStrokeColor: "#000",
                          pointHighlightFill: "#000",
                          pointHighlightStroke: "rgba(151,187,205,1)",
                          data: priceList
                      }
                ]
            };

            var ctx = document.getElementById("canvas").getContext("2d");
            window.myLine = new Chart(ctx).Line(lineChartData, {
                responsive: true,
                bezierCurve: false,
                pointDot: false,
                scaleLineWidth: 2,
                scaleFontColor: "#adadad",
                scaleFontSize: 8
            });
        }

        function LoadList(flag)
        {
            $("#report_detail_processing").show();
            if (flag == "empty")
            {
                $("#thelist").children().remove();
            }
            jQuery.ajax({
                async: false,
                type: "post",
                url: "/ajaxCross/ajax_simubao.ashx",
                dataType: "json",
                data: { Cmd: "GetSMBJingZhiPageList", projectId: "<%=ProjectId%>", pageIndex: pageIndex },
                success: function (jsonstr)
                {
                    if (flag == "empty")
                    {
                        $("#thelist").html("");
                    }
                    var html = new Array();
                    var str = "";
                    if (jsonstr.result == "1")
                    {
                        if (jsonstr.list.length > 0)
                        {
                            for (var i = 0; i < jsonstr.list.length; i++)
                            {
                                str = "<li><span class='lf f13px c-808080'>" + jsonstr.list[i].PriceDate + "</span>" +
                                    " <span class='md pos-a f13px c-fd6040'>" + jsonstr.list[i].Price + "</span>" +
                                    "<span class='rf f13px c-808080'>" + jsonstr.list[i].TotalPrice + "</span></li>";

                                html.push(str);
                            }
                            $("#thelist").append(html.join(""));
                        }
                        pageCount = jsonstr.pageCount;
                        if (pageCount <= 1)
                        {
                            $("#pullUp").hide();
                        } else
                        {
                            $("#pullUp").show();
                        }
                    } else
                    {
                        $("#thelist").html("<li><span class='md pos-a f13px c-fd6040'>暂没有记录...</span></li>");
                    }
                    $("#report_detail_processing").hide();
                },
                error: function (a, b, c)
                {
                    $("#thelist").html("加载有误...");
                    $("#report_detail_processing").hide();
                }
            });
        }
    </script>

</body>
</html>
