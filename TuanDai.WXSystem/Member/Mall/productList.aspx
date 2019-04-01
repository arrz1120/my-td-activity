﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="productList.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.Mall.productList" %>

<asp:content id="Content1" contentplaceholderid="head" runat="Server">
     <title>商品列表页</title>
    <link rel="stylesheet" type="text/css" href="/css/list2.css?v=20160423001" />
    <link rel="stylesheet" type="text/css" href="/css/mall.css?v=20170922" />
    <style type="text/css">
        .goodsList .goodsBox img {width:100px;}
        .tuanbi{top:136px !important;}
    </style>
    </asp:content>
<asp:content id="Content2" contentplaceholderid="body" runat="Server">
      <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-e6e6e6">
            <div class="pageReturn" onclick="javascript:window.location.href='mallindex.aspx';"></div>
            <h1 class="title">商品列表页</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    
    <%if(isLogin){ %>
    <div class="sml-banner pos-r">
		<div class="my-tb pos-a">
			<p>我的团币</p>
			<p><%=validTuanBi %></p>
		</div>
		<img src="/imgs/member/mall/banner.png" alt="">
	</div>
    <%} %>

    <div class="webkit-box bg-fff pt10 pb10 pos-r z-index100 bb-e6e6e6">
        <div class="box-flex1 text-center f16px c-fab600" id="d_value">
            团币数量
			<span class="inline-block">
                <p style="line-height: 5px;"><i class="triangle triangle-up-orange" style="vertical-align: 0; margin-left: 0;"></i></p>
                <p style="line-height: 5px;"><i class="triangle triangle-down-gray" style="vertical-align: 0; margin-left: 0;"></i></p>
            </span>
        </div>
        <div class="box-flex1 text-center f16px c-808080" id="d_sale">
            兑换数量
            <span class="inline-block">
                <p style="line-height: 5px;"><i class="triangle triangle-up-gray" style="vertical-align: 0; margin-left: 0;"></i></p>
                <p style="line-height: 5px;"><i class="triangle triangle-down-gray" style="vertical-align: 0; margin-left: 0;"></i></p>
            </span>
        </div>
        <div class="box-flex1 text-center f16px c-808080" id="d_time">
            上架时间
            <span class="inline-block">
                <p style="line-height: 5px;"><i class="triangle triangle-up-gray" style="vertical-align: 0; margin-left: 0;"></i></p>
                <p style="line-height: 5px;"><i class="triangle triangle-down-gray" style="vertical-align: 0; margin-left: 0;"></i></p>
            </span>
        </div>
    </div>
    <div id="wrapper" style=" background: none;" <%=isLogin?"class=\"tuanbi\"":"" %>>
        <div id="scroller">
            <div id="pullDown" style="background: #f1f3f5;">
                <div class="centerBox-wp">
                    <div class="pullDownTips">
                        <span class="pullDownIcon"></span>
                        <span class="pullDownLabel">下拉刷新...</span>
                    </div>
                </div>
            </div>
            <div class="mt10 bg-fff">
                <ul class="goodsList clearfix w100p c-212121">
                    <!--列表-->
                </ul>
            </div>
            <div id="pullUp" style="background: #f1f3f5;">
                <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>
        </div>
    </div>
    </body>
    </asp:content>
<asp:content id="Content3" contentplaceholderid="footer" runat="Server">
    <script type="text/javascript" src="/scripts/statistics.tencent.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        var sortFiled = "0";//0团币数量,1兑换数量,2上架时间
        var order = "1";//1升序 0降序
        var pageSize = "8";
        var type = "<%= type%>";
        var inter = "<%= inter%>";
        function LoadData() {
            var paramObj = { Cmd: "GetProductList", pageIndex: pageIndex, pageSize: pageSize, goodsType: "-1", sortFiled: sortFiled, order: order, type: type, inter: inter };
            $.ajax({
                type: "get",
                url: "/ajaxCross/ajax_mall.ashx",
                dataType: "json",
                data: paramObj,
                success: function (jsonData) {
                    pageCount = jsonData.TotalRecords % pageSize == 0 ? jsonData.TotalRecords / pageSize : parseInt(jsonData.TotalRecords / pageSize) + 1;
                    if (pageCount <= 1) {
                        $("#pullUp").hide();
                    } else {
                        $("#pullUp").show();
                    }
                    if (pageIndex == 1)
                        $(".goodsList").html("");
                    if (parseInt(jsonData.Status) == 1) {
                        if (jsonData.Data.length > 0) {
                            var liHtml = "";
                            for (var i = 0; i < jsonData.Data.length; i++) {
                                var cssStr = "";
                                if (i % 2 == 0)
                                    cssStr = 'br-e6e6e6';

                                //增加特价处理的部分
                                var buyEndDate = new Date(jsonData.Data[i].BuyingEndDate);      //如果传回来的是时间格式，这里得到的时间会多8个小时                
                                var buyStartDate = new Date(jsonData.Data[i].BuyingStartDate);  //如果传回来字符窜，则没有这个问题  
                                var now = new Date();
                                //加入特价标志
                                var joinBuyingFlag = jsonData.Data[i].IsJoin && !jsonData.Data[i].IsDone && buyEndDate > now;

                                liHtml = '';
                                if (joinBuyingFlag) {
                                    liHtml += '<li class="w50p lf bt-e6e6e6 activityLi ';
                                }
                                else {
                                    liHtml += '<li class="w50p lf bt-e6e6e6 ';
                                }
                                liHtml += cssStr + '" onclick="javascript:window.location.href=\'productdetail.aspx?id=' + jsonData.Data[i].Id + '\'">';
                                if (jsonData.Data[i].LeastLevel > 1) {
                                    liHtml += '<div class="zhuanxiang">V' + jsonData.Data[i].LeastLevel + '以上专享</div>';
                                }
                                liHtml += '<div class="webkit-box box-center goodsBox">' +
                                    '<Img src="' + jsonData.Data[i].ImageUrl + '"/>' +
                                    '</div>';
                                if (joinBuyingFlag) {
                                    liHtml += '<p class="f14px pt5 pl12 pr5 text-overflow">' + jsonData.Data[i].ProductName + '</p>';
                                }
                                else {
                                    liHtml += '<p class="f14px pr5 pl12 pr5 text-overflow">' + jsonData.Data[i].ProductName + '</p>';
                                }

                                if (joinBuyingFlag) {
                                    liHtml += '<img class="qgj" src="/imgs/member/mall/qgj.png"/>'
                                    if (buyStartDate < now) {
                                        liHtml += '<p class="line-h18 c-fd6040 f10px pl12 activityTime" tv="' + jsonData.Data[i].BuyingEndDate + '">'
                                                + '<i class="ico_clock1"></i>距结束仅剩:&nbsp;'
                                                + GetTimeSpan(buyEndDate, jsonData.Data[i].Id)
                                                + '</p>';
                                    }
                                    else {
                                        liHtml += '<p class="line-h18 c-979797 f10px pl12 activityTime" tv="' + jsonData.Data[i].BuyingStartDate + '">'
                                                + '<i class="ico_clock2"></i>距开始还有:&nbsp;'
                                                + GetTimeSpan(buyStartDate, jsonData.Data[i].Id);
                                        + '</p>';
                                    }
                                    liHtml += '<div class="activityBox">'
                                            + '<div class="clearfix media">'
                                            + '<div class="lf pl5 pt10">'
                                            + '<i class="ico_pai1"></i><span class="f18px c-ffffff">' + jsonData.Data[i].BuyingPrice + '</span>'
                                            + '</div>'
                                            + '<div class="rf pt2 pr5">'
                                            + '<div class="normalPrice">'
                                            + '<i class="ico_pai2"></i>' + jsonData.Data[i].PriceValue
                                            + '<div class="priceLine"></div>'
                                            + '</div>'
                                            + '<div class="exchangePeople">' + jsonData.Data[i].SaleCounts + '人兑换</div>'
                                            + '</div>'
                                            + '</div>';
                                    if (joinBuyingFlag && buyStartDate < now) {
                                        liHtml += '<div class="qiang qiang_on"></div>';
                                    }
                                    else {
                                        liHtml += '<div class="qiang qiang_off"></div>';
                                    }


                                }
                                else {
                                    liHtml += '<div class="line-h18 pl12 pr10 clearfix">' +
                                        '<span class="c-fd6040 lf">' + jsonData.Data[i].PriceValue + '团币</span>' +
                                        '<span class="c-ababab rf">' + jsonData.Data[i].SaleCounts + '人兑换</span>'
                                }
                                liHtml += '</div>';
                                if (jsonData.Data[i].Stock <= 0) {
                                    liHtml += '<div class="sell-out"></div>';
                                }
                                liHtml += '</li>';
                                $(".goodsList").append(liHtml);

                            }
                            if (jsonData.Data.length % 2 == 1) {
                                liHtml = '<li class="w50p lf bt-e6e6e6">' +
                                    '<p class="f14px pt5 pl12 pr5 text-overflow">更多精彩，敬请期待！</p>' +
                                    '<p class="line-h18 pl12"><i class="ico-m1"></i><span class="f12px c-fd6040">0</span><i class="ico-m2"></i><span class="c-808080 f12px">0</span></p>' +
                                    '<div class="webkit-box box-center">' +
                                    '<div class="webkit-box box-center goodsBox">' +
                                    '<div class="goodsItem"><img src="/imgs/member/mall/logo.png"/></div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</li>';
                                $(".goodsList").append(liHtml);
                            }

                            //循环倒数
                            $.each($(".activityTime"), function (i, o) {
                                var t = $(this).attr("tv");
                                var hId = $(this).find("span[id^=h_]").attr("id");
                                var mId = $(this).find("span[id^=m_]").attr("id");
                                var sId = $(this).find("span[id^=s_]").attr("id");
                                time(t.toString(), "#" + hId.toString(), "#" + mId.toString(), "#" + sId.toString());
                            });
                        }
                    } else {
                        $(".goodsList").append("请上拉加载...");
                    }
                    myScroll.refresh();
                },
                error: function () {
                    $(".goodsList").append("请上拉加载...");
                }
            });
        };

        $(function () {
            //点击团币数量
            $("#d_value").click(function () {
                order = "1";
                if ($(this).hasClass("c-fab600")) {
                    if ($($("#d_value p i").eq(0)).hasClass("triangle-up-orange")) {
                        $($("#d_value p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                        $($("#d_value p i").eq(1)).removeClass("triangle-down-gray").addClass("triangle-down-orange");
                        order = "0";
                    } else {
                        $($("#d_value p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                        $($("#d_value p i").eq(0)).removeClass("triangle-up-gray").addClass("triangle-up-orange");
                        order = "1";
                    }
                } else if ($("#d_sale").hasClass("c-fab600")) {
                    $("#d_sale").removeClass("c-fab600").addClass("c-808080");
                    $("#d_value").addClass("c-fab600").removeClass("c-808080");
                    $($("#d_sale p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    $($("#d_sale p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    $($("#d_time p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    $($("#d_time p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    $($("#d_value p i").eq(0)).removeClass("triangle-up-gray").addClass("triangle-up-orange");
                } else {
                    $("#d_time").removeClass("c-fab600").addClass("c-808080");
                    $("#d_value").addClass("c-fab600").removeClass("c-808080");
                    $($("#d_sale p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    $($("#d_sale p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    $($("#d_time p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    $($("#d_time p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    $($("#d_value p i").eq(0)).removeClass("triangle-up-gray").addClass("triangle-up-orange");
                }

                sortFiled = "0";
                pageIndex = 1;
                LoadData();
            });
            //点击兑奖数量
            $("#d_sale").click(function () {
                order = "1";
                if ($(this).hasClass("c-fab600")) {
                    if ($($("#d_sale p i").eq(0)).hasClass("triangle-up-orange")) {
                        $($("#d_sale p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                        $($("#d_sale p i").eq(1)).removeClass("triangle-down-gray").addClass("triangle-down-orange");
                        order = "0";
                    } else {
                        $($("#d_sale p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                        $($("#d_sale p i").eq(0)).removeClass("triangle-up-gray").addClass("triangle-up-orange");
                        order = "1";
                    }
                }
                else if ($("#d_value").hasClass("c-fab600")) {
                    $("#d_sale").addClass("c-fab600").removeClass("c-808080");
                    $("#d_value").removeClass("c-fab600").addClass("c-808080");
                    $($("#d_value p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    $($("#d_value p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    $($("#d_time p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    $($("#d_time p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    $($("#d_sale p i").eq(0)).removeClass("triangle-up-gray").addClass("triangle-up-orange");
                } else {
                    $("#d_time").removeClass("c-fab600").addClass("c-808080");
                    $("#d_sale").addClass("c-fab600").removeClass("c-808080");
                    $($("#d_value p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    $($("#d_value p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    $($("#d_time p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    $($("#d_time p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    $($("#d_sale p i").eq(0)).removeClass("triangle-up-gray").addClass("triangle-up-orange");
                }


                sortFiled = "1";
                pageIndex = 1;
                LoadData();
            });
            //点击上架时间
            $("#d_time").click(function () {
                order = "1";
                if ($(this).hasClass("c-fab600")) {
                    if ($($("#d_time p i").eq(0)).hasClass("triangle-up-orange")) {
                        $($("#d_time p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                        $($("#d_time p i").eq(1)).removeClass("triangle-down-gray").addClass("triangle-down-orange");
                        order = "0";
                    } else {
                        $($("#d_time p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                        $($("#d_time p i").eq(0)).removeClass("triangle-up-gray").addClass("triangle-up-orange");
                        order = "1";
                    }
                }
                else if ($("#d_value").hasClass("c-fab600")) {
                    $("#d_time").addClass("c-fab600").removeClass("c-808080");
                    $("#d_value").removeClass("c-fab600").addClass("c-808080");
                    $($("#d_value p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    $($("#d_value p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    $($("#d_sale p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    $($("#d_sale p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    $($("#d_time p i").eq(0)).removeClass("triangle-up-gray").addClass("triangle-up-orange");
                } else {
                    $("#d_time").addClass("c-fab600").removeClass("c-808080");
                    $("#d_sale").removeClass("c-fab600").addClass("c-808080");
                    $($("#d_value p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    $($("#d_value p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    $($("#d_sale p i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    $($("#d_sale p i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    $($("#d_time p i").eq(0)).removeClass("triangle-up-gray").addClass("triangle-up-orange");
                }
                sortFiled = "2";
                pageIndex = 1;
                LoadData();
            });
            LoadData();
            iScroll.onLoadData = LoadData;
        });


        //倒计时
        function pad(n) {
            return (n < 10 ? '0' : '') + n;
        }

        function time(target_time, hourId, minuteId, secondId) {
            target_time = new Date(target_time);
            var $hour = $(hourId),
                $minute = $(minuteId),
                $second = $(secondId);

            getCountdown();

            var timeout = setInterval(function () {
                getCountdown();
            }, 1000);

            function getCountdown() {
                var now_time = new Date().getTime();
                var left_time = (target_time - now_time) / 1000;
                if (left_time <= 0) {
                    window.location.reload();
                    return;
                }
                //left_time = left_time % 86400;
                hours = pad(parseInt(left_time / 3600));
                left_time = left_time % 3600;
                minutes = pad(parseInt(left_time / 60));
                seconds = pad(parseInt(left_time % 60));

                $hour.html(hours);
                $minute.html(minutes);
                $second.html(seconds);
            }
        }

        function GetTimeSpan(time1, id) {
            var date1 = new Date(time1.toString());
            var now = new Date();
            var timeSpan;
            if (date1 < now) {
                //计算出小时数
                timeSpan = now.getTime() - date1.getTime();
            }
            else {
                timeSpan = date1.getTime() - now.getTime();
            }

            var days = Math.floor(timeSpan / (24 * 3600 * 1000));

            var leave1 = timeSpan % (24 * 3600 * 1000)    //计算天数后剩余的毫秒数
            var hours = Math.floor(leave1 / (3600 * 1000));

            hours = (hours + days * 24) > 10 ? (hours + days * 24).toString() : "0" + hours;
            //计算相差分钟数
            var leave2 = leave1 % (3600 * 1000)        //计算小时数后剩余的毫秒数
            var minutes = Math.floor(leave2 / (60 * 1000))
            minutes = minutes > 10 ? minutes.toString() : "0" + minutes;
            //计算相差秒数
            var leave3 = leave2 % (60 * 1000)      //计算分钟数后剩余的毫秒数
            var seconds = Math.round(leave3 / 1000)
            seconds = seconds > 10 ? seconds.toString() : "0" + seconds;

            if (date1 < now) {
                return '<span class="f10px c-979797" id="h_' + id + '">' + hours + '</span> :'
                        + '<span class="f10px c-979797" id="m_' + id + '">' + minutes + '</span> :'
                        + '<span class="f10px c-979797" id="s_' + id + '">' + seconds + '</span>';
            }
            else {
                return '<span class="f10px c-fd6040" id="h_' + id + '">' + hours + '</span> :'
                    + '<span class="f10px c-fd6040" id="m_' + id + '">' + minutes + '</span> :'
                    + '<span class="f10px c-fd6040" id="s_' + id + '">' + seconds + '</span>';
            }

        }
    </script>
    </asp:content>