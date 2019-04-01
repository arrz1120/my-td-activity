﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="mallIndex.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.Mall.mallIndex" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">    
    <link rel="stylesheet" type="text/css" href="/css/swiper.3.1.7.min.css?v=20160412" />
    <link rel="stylesheet" type="text/css" href="/css/mall.css?v=20170922" />
    <style type="text/css">
        .goodsList .goodsBox img {
            max-height: 90%;
            max-width: 90%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f1f3f5">
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header bb-e6e6e6">
                <div class="pageReturn" onclick="javascript:window.location.href='/Member/my_account.aspx';"></div>
                <h1 class="title">会员商城</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>
        <% if (BannerList != null && BannerList.Count > 0)
           {
        %>
        <div class="swiper-container" id="swiper-banner">
            <div class="swiper-wrapper">
                <% 
           var imgIndex = 0;
           foreach (var imgeInfo in BannerList)
           {
               imgIndex++; %>
                <div class="swiper-slide"><a href="<%=imgeInfo.Url %>">
                    <img src="<%= imgeInfo.ImageUrl %>" <%=imgIndex>1?"style='display:none;'":"" %> /></a></div>
                <%} %>
            </div>
            <div class="swiper-pagination" id="nav-mark"></div>
        </div>
        <%
       } %>


        <div class="index-nav bg-fff bb-e6e6e6">
            <div class="clearfix">
                <div class="w50p lf pt15 pb15 nav-item br-e6e6e6" onclick="JAVASCRIPT:window.location.href='myProduct.aspx';">
                    <i class="nav-item-i1"></i>
                    <p class="f14px">我的商品</p>
                    <p class="c-ababab line-h20" id="myProduct"></p>
                </div>
                <div class="w50p lf pt15 pb15 nav-item br-e6e6e6" onclick="JAVASCRIPT:window.location.href='tuanbiDetail.aspx';">
                    <i class="nav-item-i2"></i>
                    <p class="f14px">我的团币</p>
                    <p class="c-ababab line-h20"><%=UserVipInfo.ValidTuanBi %></p>
                </div>
            </div>
        </div>

        <div class="bt-e6e6e6 bb-e6e6e6 mt15 bg-fff">
            <div class="click-respond">
                <a href="lottery.aspx" class="invset-guide-tit pos-r f14px c-212121 bb-e6e6e6 pl15">
                    <i class="index-sprite index-ico4 mr10"></i>赚团币·抽奖品
                </a>
            </div>
            <div class="knowMore pl15 pr15 pb20 pt20 clearfix">
                <div class="w50p lf knowMore_l" onclick="javascript:window.location.href='lottery.aspx';">
                    <div class="webkit-box box-center box-vertical bg_more more5">
                        <p class="f15px c-ffffff">幸运转盘赢大礼</p>
                        <p class="f12px c-ffffff line-h18">好运气在等着你</p>
                    </div>
                </div>
                <div class="w50p lf knowMore_r" onclick="javascript:window.location.href='/pages/app/appvipcenter/mytask.aspx<%=IsInApp?"?type=mobileapp":"" %>';">
                    <div class="webkit-box box-center box-vertical bg_more more6">
                        <p class="f15px c-ffffff">做任务赚团币</p>
                        <p class="f12px c-ffffff line-h18">快来看看吧</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt15 bg-fff bt-e6e6e6 bb-e6e6e6">
            <div class="click-respond pl15">
                <a href="productList.aspx" class="invset-guide-tit pos-r f14px c-212121">
                    <i class="index-sprite index-ico5 mr10"></i>兑奖品
				<p class="f12px c-808080 pos-a">更多<i class="i-arrow-right"></i></p>
                </a>
            </div>
            <ul class="goodsList clearfix w100p c-212121">
                <!--商品列表-->
            </ul>
        </div>
        </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript" src="/scripts/statistics.tencent.js"></script>
    <script type="text/javascript" src="/scripts/swiper.3.1.7.jquery.min.js"></script>
    <script type="text/javascript">

        $(function () {
            var swiper_banner = new Swiper('#swiper-banner', {
                onInit: function () {
                    $('#swiper-banner').find('img').show();
                },
                autoplay: 5000,
                direction: 'horizontal',
                loop: true,
                pagination: '#nav-mark'
            });

            $.ajax({
                url: "/ajaxCross/ajax_mall.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "GetMyProduct", pageIndex: 1, pageSize: 1, status: 0 },
                success: function (jsonData) {
                    if (parseInt(jsonData.Status) == 1) {
                        $("#myProduct").html("已兑换" + jsonData.TotalRecords + "件商品");
                    } else {
                        $("#myProduct").html("暂无兑换商品");
                    }
                },
                error: function () {
                    $("#myProduct").html("暂时还未兑换商品");
                }
            });

        });

        var sortFiled = "0";//0团币数量,1兑换数量,2上架时间
        var order = "1";//1升序 0降序
        function LoadData() {
            var paramObj = { Cmd: "GetProductList", pageIndex: "1", pageSize: "6", goodsType: "-1", sortFiled: sortFiled, order: order, type: "", inter: "" };
            $.ajax({
                type: "get",
                url: "/ajaxCross/ajax_mall.ashx",
                dataType: "json",
                data: paramObj,
                success: function (jsonData) {
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

                            $.each($(".activityTime"), function (i, o) {
                                var t = $(this).attr("tv");
                                var hId = $(this).find("span[id^=h_]").attr("id");
                                var mId = $(this).find("span[id^=m_]").attr("id");
                                var sId = $(this).find("span[id^=s_]").attr("id");
                                time(t.toString(), "#" + hId.toString(), "#" + mId.toString(), "#" + sId.toString());
                            });
                        }
                    } else {
                        $(".goodsList").append("暂无商品...");
                    }
                },
                error: function () {
                    $(".goodsList").append("暂无商品...");
                }
            });
        };

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

        LoadData();

    </script>
</asp:Content>