<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tuanbiDetail.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.Mall.tuanbiDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>团币明细</title>
    <link rel="stylesheet" type="text/css" href="/css/list2.css?v=20160406001" />
    <link rel="stylesheet" type="text/css" href="/css/mall.css?v=20170424001" />
    <style type="text/css">
        .liselected {
            color: #fab600;
            background: url("/imgs/member/mall/ico-gx.png") no-repeat right;
            background-size: 13px 9px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f1f3f5">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-e6e6e6">
            <div class="pageReturn" onclick="javascript:window.location.href='mallindex.aspx';"></div>
            <h1 class="title">团币明细</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <div class="sub-list">
        <div class="screen-box pos-r bg-f6f7f8 bb-e6e6e6">
            <img src="/imgs/member/mall/pic-tbmx.png" class="pos-a">
            <div class="pos-a my-tb">
                <p class="f12px c-ababab"><span class="f26px c-fd6040 mr5" id="totalTuanBi"><%=UserVipInfo.ValidTuanBi %></span>枚</p>
                <p class="f15px c-808080">我的团币</p>
            </div>
            <div class="select">
                <div class="selectName"><span class="selectId c-808080 f15px mr5" month="1">最近1个月的明细</span><i class="ico-sprite01 ico-triangle rotate0"></i></div>
                <div class="selectCon">
                    <ul>
                        <li class="bb-e6e6e6 ml15"><a href="javascript:;" month="1" class="liselected" style="color: #fab600;">最近1个月的明细</a></li>
                        <li class="bb-e6e6e6 ml15"><a href="javascript:;" month="3">最近3个月的明细</a></li>
                        <li class="ml15"><a href="javascript:;" month="12">最近12个月的明细</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div id="wrapper" style="top: 82px; background: none;">
            <div id="scroller">
                <div id="pullDown" style="background: #f1f3f5;">
                    <div class="centerBox-wp">
                        <div class="pullDownTips">
                            <span class="pullDownIcon"></span>
                            <span class="pullDownLabel">下拉刷新...</span>
                        </div>
                    </div>
                </div>
                <ul class="pl15 bg-fff bb-e6e6e6 pos-r z-index10" id="tuanbiList">
                    <!-- 列表-->
                </ul>
                <div id="pullUp" style="background: #f1f3f5;">
                    <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
                </div>
            </div>
        </div>
    </div>

    <div class="layer-tb"></div>

    <!--无数据的时候显示-->
    <div class="text-center bt-e6e6e6 no-update" style="display: none">
        <img src="/imgs/member/pic-asset1.png" alt="">
        <p class="f17px c-212121 pt40">暂无团币记录</p>
    </div>
    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript" src="/scripts/statistics.tencent.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        $(function () {


            //订单筛选
            $(".select").each(function () {
                var select = $(this);
                var zIndex = parseInt(select.css("z-index"));
                var selectName = $(this).children(".selectName");
                var selectId = $(this).find(".selectId");
                var selectCon = $(this).children(".selectCon");
                var layerTb = $(".layer-tb");
                var triangle = $(".ico-triangle");

                //展开效果
                var _show = function () {
                    selectCon.slideDown(200);
                    selectName.addClass("cur");
                    select.css("z-index", zIndex + 1);
                    layerTb.fadeIn(200).bind("touchmove", function (e) {
                        e.preventDefault();
                    });
                    triangle.removeClass('rotate0');
                };

                //关闭效果
                var _hide = function () {
                    selectCon.slideUp(200);
                    selectName.removeClass("cur");
                    select.css("z-index", zIndex);
                    layerTb.fadeOut(200);
                    triangle.addClass('rotate0');
                };

                selectName.click(function () {
                    selectCon.is(":hidden") ? _show() : _hide();
                });

                selectCon.find("a").click(function () {
                    selectId.html($(this).html()).attr("month", $(this).attr("month"));
                    $(".select .selectCon ul li a").removeClass("liselected").removeAttr("style");
                    $(this).addClass("liselected").attr("style", "color: #fab600;");
                    _hide();
                    pageIndex = 1;
                    layerTb.fadeOut(200);
                    LoadData();
                });

                layerTb.click(function (i) {
                    !$(i.target).parents(".select").first().is(select) ? _hide() : "";
                    layerTb.fadeOut(200);
                });
            });

            function nameOverflow() {
                $.each($(".name-overflow"), function (i, item) {
                    $(this).css('max-width', $(window).width() - $('li .rf').width() - 40);
                });
            }
            nameOverflow();

            var pageSize = "10";
            function LoadData() {
                var paramObj = { Cmd: "GetTuanbiHistory", pageIndex: pageIndex, pageSize: pageSize, month: $(".selectId").attr("month") };
                $.ajax({
                    type: "get",
                    url: "/ajaxCross/ajax_mall.ashx",
                    dataType: "json",
                    data: paramObj,
                    success: function (jsonData) {
                        pageCount = jsonData.recordCout % pageSize == 0 ? jsonData.recordCout / pageSize : parseInt(jsonData.recordCout / pageSize) + 1;
                        if (pageCount <= 1) {
                            $("#pullUp").hide();
                        } else {
                            $("#pullUp").show();
                        }
                        if (pageIndex == 1)
                            $("#tuanbiList").html("");
                        var lis = "";
                        if (jsonData.list.length > 0) {
                            var liHtml = "";
                            for (var i = 0; i < jsonData.list.length; i++) {
                                var cssStr = "";
                                if (i > 0)
                                    cssStr = 'bt-e6e6e6';
                                liHtml = '<li class="clearfix pr15 ' + cssStr + ' pt10 pb10">' +
                                    '<div class="lf">' +
                                    '<p class="c-212121 f17px text-overflow name-overflow">' + SubName(jsonData.list[i].Description) + '</p>' +
                                    '<p class="line-h16 mt5 f13px c-ababab"><i class="ico-clock mr5"></i>' + jsonData.list[i].AddDate + '</p>' +
                                    '</div>' +
                                    '<div class="rf f15px c-212121">';
                                if (jsonData.list[i].TuanBiValue < 0)
                                    liHtml += '<p class="c-212121 f17px text-right">' + jsonData.list[i].TuanBiValue + '</p>';
                                else
                                    liHtml += '<p class="c-fd6040 f17px text-right">+' + jsonData.list[i].TuanBiValue + '</p>';
                                liHtml += '<p class="f13px c-d1d1d1 line-h16 mt5">账户剩余：' + jsonData.list[i].AfterTuanBiValue + '枚</p>' +
                                    '</div>' +
                                    '</li>';
                                lis += liHtml;
                            }
                            $("#tuanbiList").append(lis);
                        }
                        else {
                            $(".no-update").show();
                            $("#pullUp").hide();
                        }
                        myScroll.refresh();
                    },
                    error: function () {
                        $(".no-update").show();
                        $("#pullUp").hide();
                    }
                });
            };
            LoadData();
            iScroll.onLoadData = LoadData;

            function SubName(str) {
                if (str.length > 12) {
                    return str.substring(0, 11) + "...";
                } else {
                    return str;
                }
            }

        });
    </script>
</asp:Content>
