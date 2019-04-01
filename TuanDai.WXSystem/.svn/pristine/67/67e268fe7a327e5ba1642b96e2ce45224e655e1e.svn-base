<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RedPacket.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.UserPrize.RedPacket" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title><%=ShowTitle %></title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/giftBox.css?v=<%=GlobalUtils.Version %>" />
</head>
<body class="bg-f1f3f5 red-packet">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:history.go(-1);">返回</div>
            <h1 class="title"><%=ShowTitle %></h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <!--排序筛选-->
    <div class="sort clearfix bg-fff pl20 pr20 pt10 pb10 pos-r">
        <div class="lf w33p text-center f16px c-ffcf1f" id="sort2">
            获得时间
        <div class="inline-block left-triangle">
            <p><i class="triangle triangle-up-gray"></i></p>
            <p><i class="triangle triangle-down-orange"></i></p>
        </div>
        </div>
        <div class="lf w33p text-center f16px c-808080" id="sort1">
            失效时间
        <div class="inline-block left-triangle">
            <p><i class="triangle triangle-up-gray"></i></p>
            <p><i class="triangle triangle-down-gray"></i></p>
        </div>
        </div>
        <div class="lf w33p text-center f16px c-808080" id="sort">可使用<i class="ico-con ico-down-gray"></i></div>
    </div>
    <div id="wrapper" style="top: 44px!important;">
        <div id="scroller">
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
            <div id="thelist">
            </div>
            <div class="pt25">
                <p class="text-center c-ababab f13px">当前只显示最近<a class="f13px c-ff7357 inline-block">2</a>个月的奖品记录</p>
            </div>
            <div id="pullUp">
                <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>
        </div>
    </div>

    <!--红包说明弹窗-->
    <div class="hide" id="dvPopDesc">
        <section class="alert webkit-box box-center">
            <div class="bg-fff popup-con text-center pos-r" id="alertCon">
                <h3 class="c-212121 f17px text-center"><%=ShowTitle %>说明</h3>
                <p id="pSource">来源：会员商城兑换商品。</p>
                <div class="pos-r text-des">
                    <p class="pos-a">说明：</p>
                    <p id="pDesc">领取期限一个月，使用期限为领取后一个月内，单笔投资满1000元即可使用。</p>
                </div>
                <a href="javascript:void(0);" class="c-fcb700 f17px block bt-e6e6e6" id="btnPopClose">我知道了</a>
            </div>
        </section>
    </div>
    <!--弹出的筛选遮罩层-->
    <div class="masker z-index10 pos-a hide" id="alert">
        <div class="alert-record pl15 bt-e6e6e6">
            <ul>
                <li class="active bt-e6e6e6" dataused="1">可使用</li>
                <li class="bt-e6e6e6" dataused="2">已失效</li>
            </ul>
        </div>
    </div>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/Common.js?v=20160629001"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        var orderField = "CreateDate";//排序字段 ExpirationDate
        var orderType = "desc";//排序方式 asc
        var isUsed = "1";//0全部 1可使用 2已过期
        var sortType = "2";

        $(function () {
            LoadRedPacketList('empty');
            iScroll.onLoadData = LoadRedPacketList;
            $("#btnPopClose").click(function () {
                //$("#dvPopDesc").addClass("hide");
                hideAniFadeOut("#dvPopDesc");
            });

            //排序的js
            var alert = $("#alert");
            var box = alert.find('.alert-record');
            $(".masker").click(function () {
                //               $("#sort i").removeClass("ico-up-gray").addClass("ico-down-gray");
                alert.fadeOut(200);
            });
            $("#sort").click(function () { //点击可使用
                alert.fadeIn(200);
                box.slideDown(200);
                if ($("#sort2").hasClass("c-ffcf1f")) {
                    $("#sort2").removeClass("c-ffcf1f").addClass("c-808080");
                    //                  $(this).addClass("c-ffcf1f").removeClass("c-808080");
                    //                  $("#sort i").removeClass("ico-down-gray").addClass("ico-up-gray");
                    if ($($("#sort2 i").eq(0)).hasClass("triangle-up-orange")) {
                        $($("#sort2 i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    }
                    if ($($("#sort2 i").eq(1)).hasClass("triangle-down-orange")) {
                        $($("#sort2 i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    }
                }
                if ($("#sort1").hasClass("c-ffcf1f")) {
                    $("#sort1").removeClass("c-ffcf1f").addClass("c-808080");
                    //                  $(this).addClass("c-ffcf1f").removeClass("c-808080");
                    if ($($("#sort1 i").eq(0)).hasClass("triangle-up-orange")) {
                        $($("#sort1 i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    }
                    if ($($("#sort1 i").eq(1)).hasClass("triangle-down-orange")) {
                        $($("#sort1 i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    }
                }
            });
            box.find('li').click(function () {
                $(this).siblings().removeClass('active');
                $(this).addClass('active');
                $("#sort").html($(this).html() + '<i class="ico-con ico-down-gray"></i>');
                alert.fadeOut(200);
                box.slideUp(200);
                isUsed = $(this).attr("dataUsed");
                pageIndex = 1;
                LoadRedPacketList("empty");
            });
            $("#sort2").click(function () {//点击获得时间
                alert.fadeOut(200);
                if ($("#sort1").hasClass("c-ffcf1f")) {
                    $("#sort1").removeClass("c-ffcf1f").addClass("c-808080");
                    $(this).addClass("c-ffcf1f").removeClass("c-808080");
                    $($("#sort2 i").eq(1)).addClass("triangle-down-orange").removeClass("triangle-down-gray");
                    if ($($("#sort1 i").eq(0)).hasClass("triangle-up-orange")) {
                        $($("#sort1 i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    }
                    if ($($("#sort1 i").eq(1)).hasClass("triangle-down-orange")) {
                        $($("#sort1 i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    }
                    orderType = "desc";
                    sortType = "2";
                }
                else if ($("#sort").hasClass("c-ffcf1f")) {
                    $("#sort").removeClass("c-ffcf1f").addClass("c-808080");
                    $(this).addClass("c-ffcf1f").removeClass("c-808080");
                    $("#sort i").addClass("triangle-down-gray").removeClass("triangle-down-orange");
                    $($("#sort2 i").eq(1)).removeClass("triangle-down-gray").addClass("triangle-down-orange");
                    orderType = "desc";
                    sortType = "2";
                } else {
                    if ($($("#sort2 i").eq(1)).hasClass("triangle-down-orange")) {
                        $($("#sort2 i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                        $($("#sort2 i").eq(0)).addClass("triangle-up-orange").removeClass("triangle-up-gray");
                        orderType = "asc";
                        sortType = "1";
                    } else {
                        $($("#sort2 i").eq(1)).addClass("triangle-down-orange").removeClass("triangle-down-gray");
                        $($("#sort2 i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                        orderType = "desc";
                        sortType = "2";
                    }
                }
                orderField = "CreateDate";
                LoadRedPacketList("empty");
            });
            $("#sort1").click(function () {//点击失效时间
                alert.fadeOut(200);
                if ($("#sort").hasClass("c-ffcf1f")) {
                    $("#sort").removeClass("c-ffcf1f").addClass("c-808080");
                    $(this).addClass("c-ffcf1f").removeClass("c-808080");
                    $("#sort i").addClass("triangle-down-gray").removeClass("triangle-down-orange");
                    $("#sort1 i").eq(1).removeClass("triangle-down-gray").addClass("triangle-down-orange");
                    sortType = "5";
                }
                else if ($("#sort2").hasClass("c-ffcf1f")) {
                    $("#sort2").removeClass("c-ffcf1f").addClass("c-808080");
                    $(this).addClass("c-ffcf1f").removeClass("c-808080");
                    $("#sort1 i").eq(1).removeClass("triangle-down-gray").addClass("triangle-down-orange");
                    if ($($("#sort2 i").eq(0)).hasClass("triangle-up-orange")) {
                        $($("#sort2 i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    }
                    if ($($("#sort2 i").eq(1)).hasClass("triangle-down-orange")) {
                        $($("#sort2 i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    }
                    sortType = "5";
                } else {
                    if ($($("#sort1 i").eq(1)).hasClass("triangle-down-orange")) {
                        $($("#sort1 i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                        $($("#sort1 i").eq(0)).addClass("triangle-up-orange").removeClass("triangle-up-gray");
                        orderType = "asc";
                        sortType = "4";
                    } else {
                        $($("#sort1 i").eq(1)).addClass("triangle-down-orange").removeClass("triangle-down-gray");
                        $($("#sort1 i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                        orderType = "desc";
                        sortType = "5";
                    }
                }
                orderField = "ExpirationDate";
                LoadRedPacketList("empty");
            });
        });

        function LoadRedPacketList(flag) {
            if (flag == "empty") {
                $("#thelist").children().remove();
            }
            jQuery.ajax({
                type: "post",
                url: "/ajaxCross/ajax_userPrize.ashx",
                data: { Cmd: "GetRedPacketNew", Pageindex: pageIndex, type: "<%= type%>", sortType:sortType, isUsed: isUsed },
                dataType: "json",
                success: function (jsonstr) {
                    if (flag == "empty") {
                        $("#thelist").children().remove();
                    }
                    var html = new Array();
                    var str = "";
                    pageCount = jsonstr.totalcount;
                    if (pageCount <= 1) {
                        $("#pullUp").hide();
                    } else {
                        $("#pullUp").show();
                    }
                    if (jsonstr.result == "1") {
                        for (var i = 0; i < jsonstr.list.length; i++) {
                            var item = jsonstr.list[i];
                            var attrStr = " attrfrom='" + item.SourceFrom + "'attrdesc='" + item.Description + "' onclick='viewDesc(this)' ";

                            //已领取
                            if (item.Receive == "1" && ";1;4;8;9;10;11;13;14;15".indexOf(";" + item.TypeId) != -1) {
                                str = "<section class='ticket-con gray pos-r bg-fff'>" +
                                        "    <div class='ticket-d-wrap pt12'>" +
                                        "        <div class='tx-ticket-details pos-r'>" +
                                        "            <p class='c-10bef0'><span>" + item.PrizeName + "</span><span " + attrStr + ">（查看详情）</span></p>" +
                                        "            <p class='c-ababab'><span>￥</span>" + item.PrizeValue + "</p>" +
                                        "            <p>" + item.CreateDateStr + "</p>" +
                                        "        </div>" +
                                        "    </div>" +
                                        "    <span class='bg-d1d1d1 button but-n pos-a'>已领取</span>" +
                                        "</section>";
                            } else {
                                if (jsonstr.list[i].IsUsed == "1") {
                                    str = "<section class='ticket-con gray pos-r bg-fff'>" +
                                        "    <div class='ticket-d-wrap pt12'>" +
                                        "        <div class='tx-ticket-details pos-r'>" +
                                        "            <p class='c-10bef0'><span>" + item.PrizeName + "</span><span " + attrStr + ">（查看详情）</span></p>" +
                                        "            <p class='c-ababab'><span>￥</span>" + item.PrizeValue + (item.InvestMoney > 0 ? "<span class='c-ababab'>满" + item.InvestMoney + "元可用</span>" : "") + "</p>" +
                                        "            <p>" + item.CreateDateStr + item.ReceiveDateStr + "</p>" +
                                        "        </div>" +
                                        "    </div>" +
                                        "    <span class='bg-d1d1d1 button but-n pos-a'>已使用</span>" +
                                        "</section>";
                                }
                                else if (jsonstr.list[i].IsUsed == "0") {
                                    if (jsonstr.list[i].Receive == "1") {//已领取
                                        str = "<section class='ticket-con red pos-r bg-fff'>" +
                                                "    <div class='ticket-d-wrap pt12'>" +
                                                "        <div class='tx-ticket-details pos-r'>" +
                                                "            <p class='c-10bef0'><span>" + item.PrizeName + "</span><span " + attrStr + ">（查看详情）</span></p>" +
                                                "            <p class='c-fd6040'><span class='c-fd6040'>￥</span>" + item.PrizeValue + (parseFloat(item.InvestMoney) > 0 ? "<span class='c-fd6040'>满" + item.InvestMoney + "元可用</span>" : "") + "</p>" +
                                                "            <p>" + item.CreateDateStr + (item.ExpStr != "" ? item.ExpStr : "") + "</p>" +
                                                "        </div>" +
                                                "    </div>" +
                                                "    <span class='bg-ffcf1f button but-y pos-a'  attrdesc='" + item.Description + "' attrtypeid='" + item.TypeId + "' attrsubtypeid='" + item.SubTypeId + "' attrTiYanJinE='" + item.TiYanJinE + "' attrTiYanJinId='" + item.TiYanJinId + "' attrTiYanJinProfit='" + item.TiYanJinProfit + "' attrDays='" + item.Days + "' userPrizeId='" + item.Id + "'>使用</span>" +
                                                "</section>";
                                    } else {
                                        str = "<section class='ticket-con red pos-r bg-fff'>" +
                                            "    <div class='get-wrap bg-fff pos-a animated'>" +
                                            "        <div class='get-tx-con get-hb-con'>" +
                                            "            <div class='git-tx-ticket'>" +
                                            "             <p class='c-ffffff pos-a'><span class='c-ffffff'>￥</span>" + item.PrizeValue + (item.ReceiveDateStr != "" ? "<span>" + item.CreateDateStr + item.ReceiveDateStr + "</span>" : "") + "</p>" +
                                            "            </div>" +
                                            "            <span class='bg-ffcf1f button but-g pos-a' attrid='" + item.Id + "' attrtypeid='" + item.TypeId + "' attrprizevalue='" + item.PrizeValue + "' attrsubtypeid='" + item.SubTypeId + "' attrTiYanJinE='" + item.TiYanJinE + "' attrTiYanJinId='" + item.TiYanJinId + "' attrTiYanJinProfit='" + item.TiYanJinProfit + "' attrDays='" + item.Days + "' userPrizeId='" + item.Id + "'>领取</span>" +
                                            "        </div>" +
                                            "    </div>" +
                                            "    <div class='ticket-d-wrap pt12'>" +
                                            "        <div class='tx-ticket-details pos-r'>" +
                                            "            <p class='c-10bef0'><span>" + item.PrizeName + "</span><span " + attrStr + ">（查看详情）</span></p>" +
                                            "            <p class='c-fd6040'><span class='c-fd6040'>￥</span>" + item.PrizeValue + (parseFloat(item.InvestMoney) > 0 ? "<span class='c-fd6040'>满" + item.InvestMoney + "元可用</span>" : "") + "</p>" +
                                            "            <p>" + item.CreateDateStr + (item.ExpStr != "" ? item.ExpStr : "") + "</p>" +
                                            "        </div>" +
                                            "    </div>" +
                                            "    <span class='bg-ffcf1f button but-y pos-a' attrdesc='" + item.Description + "' attrtypeid='" + item.TypeId + "' attrsubtypeid='" + item.SubTypeId + "' attrTiYanJinE='" + item.TiYanJinE + "' attrTiYanJinId='" + item.TiYanJinId + "' attrTiYanJinProfit='" + item.TiYanJinProfit + "' attrDays='" + item.Days + "' userPrizeId='" + item.Id + "'>使用</span>" +
                                            "</section>";
                                    }
                                }
                                else {
                                    //已过期
                                    str = "<section class='ticket-con gray pos-r bg-fff'>" +
                                       "    <div class='ticket-d-wrap pt12'>" +
                                       "        <div class='tx-ticket-details pos-r'>" +
                                       "            <p class='c-10bef0'><span>" + item.PrizeName + "</span><span " + attrStr + ">（查看详情）</span></p>" +
                                       "            <p class='c-ababab'><span>￥</span>" + item.PrizeValue +
                                        (parseFloat(item.InvestMoney) > 0 ? "<span class='c-ababab'>满" + item.InvestMoney + "元可用</span>" : "") + "</p>" +
                                        "           <p>" + item.CreateDateStr + item.ExpStr + "</p>" +
                                       "        </div>" +
                                       "    </div>" +
                                       "    <span class='bg-d1d1d1 button but-n pos-a'>已过期</span>" +
                                       "</section>";
                                }
                            }
                            html.push(str);
                        }
                        $("#thelist").append(html.join(""));
                        bindClickEvent();
                    }
                    else {
                        $("#thelist").html("<div class='debt-empty mt50'><div class='img-debt-empty text-center'><img style='width: 60%;' src='/imgs/images/debt-empty.png'/></div><div class='text-center f14px c-212121 mt20'>暂无记录！</div></div></div>");
                    }
                    myScroll.refresh();
                },
                error: function (a, b, c) {
                    $("#thelist").html("<div class='debt-empty mt50'><div class='img-debt-empty text-center'><img style='width: 60%;' src='/imgs/images/debt-empty.png'/></div><div class='text-center f14px c-212121 mt20'>网络不给力，点击重新加载</div></div></div>").click(function () {
                        window.location.href = window.location.href;
                    });
                    $("#pullUp").hide();
                }
            });
        }
        //领取体验券
        function bindClickEvent() {
            $(".but-g").unbind("click");
            $(".but-g").click(function () {
                //GetPrize($(this));
                window.location.href = "/pages/downopenapp.aspx";
            });
            $(".but-y").unbind("click").click(function () {
                var oridesc = $(this).attr("attrdesc");
                var typeid = $(this).attr("attrtypeid");
                var subtypeid = $(this).attr("attrsubtypeid");

                var TiYanJinE = $(this).attr("attrTiYanJinE");
                var TiYanJinId = $(this).attr("attrTiYanJinId");
                var TiYanJinProfit = $(this).attr("attrTiYanJinProfit");
                var Days = $(this).attr("attrDays");
                var userPrizeId = $(this).attr("userPrizeId");
                if (typeid == "16") {
                    if (typeid == "16" && subtypeid == "1") {
                        window.location.href = "<%=ConfigurationManager.AppSettings["ActivityWebsiteUrl"]%>/weixin/20170411_tyj/index.aspx?orderId=" + TiYanJinId + "&userPrizeId=" + userPrizeId;
                        return;
                    }
                    else {
                        window.location.href = "<%=ConfigurationManager.AppSettings["ActivityWebsiteUrl"]%>/weixin/newhand/welfare/page2888.aspx";
                        return;
                    }
                }
                var desc = oridesc;
                if (desc == "")
                    desc = "投资即可使用红包!";
                $("body").showMessage({
                    message: desc, showCancel: true, okString: "投资", okbtnEvent: function () {
                        //判断是否投资新手
                        var investListUrl = "/pages/invest/we/we_list.aspx";
                        if ("<%=IsInvestNewUser%>" == "True")
                            investListUrl = "http://hd.tuandai.com/weixin/fuli/index.aspx?tdfrom=wxTbx";
                        window.location.href = "/pages/downopenapp.aspx";
                    }
                });
            });
        }
        //领取红包
        function GetPrize(obj) {
            window.location.href = "/pages/downopenapp.aspx";
            return false;
            var id = obj.attr("attrid");
            var typeid = obj.attr("attrtypeid");
            var prizeValue = obj.attr("attrprizevalue");
            var subtypeid = obj.attr("attrsubtypeid");

            var TiYanJinE = obj.attr("attrTiYanJinE");
            var TiYanJinId = obj.attr("attrTiYanJinId");
            var TiYanJinProfit = obj.attr("attrTiYanJinProfit");
            var Days = obj.attr("attrDays");
            var userPrizeId = obj.attr("userPrizeId");
            var invest;
            $.ajax({
                async: false,
                type: "post",
                url: "/ajaxCross/ajax_userPrize.ashx",
                dataType: "json",
                data: { Cmd: "GetUserPrize", id: id },
                success: function (json) {
                    //判断是否投资新手
                    var investListUrl = "/pages/invest/invest_list.aspx";
                    if ("<%=IsInvestNewUser%>" == "True")
                        investListUrl = "/pages/invest/invest_baot.aspx";
                    switch (json.result) {
                        case "1":
                            obj.closest('.get-wrap').addClass('moveLeft');
                            obj.hide();
                            if (typeid == "11" || typeid == "13" || typeid == "14") {
                                $("body").showMessage({
                                    message: "现金红包已领取成功!", showCancel: false, okbtnEvent: function () {
                                        $("body").hideMessage();
                                        window.location.href = window.location.href;
                                    }
                                });
                            }
                            //if (typeid == "16") {
                            //    ShowWrapMsg("亲，您已领取体验金，请进我们的体验专区进行投资。", "1", "投资", "/Activity/ExperienceGold/GoInvest.aspx");
                            //} else if (typeid == "3") { 
                            //    var tipMsg = "亲，您已成功领取投资红包,请到标区投资使用此红包。";
                            //    if (json.msg != "") {
                            //        var moneyObj = jQuery.parseJSON(json.msg);
                            //        if (moneyObj.InvestType == 1) {
                            //            tipMsg = "亲，您已成功领取红包，请到标区投资满" + moneyObj.InvestMoney + "元便可使用此红包。";
                            //        } else if (moneyObj.InvestType == 2) {
                            //            tipMsg = "亲，您已成功领取红包，需累计投资满" + moneyObj.InvestMoney + "元便可使用此红包。";
                            //        }
                            //    }
                            //    $("body").showMessage({
                            //        message: tipMsg, showCancel: true, okString: "投资", okbtnEvent: function () {
                            //            window.location.href = investListUrl;
                            //        }
                            //    }); 
                            //} else {
                            //    $("body").showMessage({
                            //        message: "恭喜您成功领取该红包,请到标区进行投资!", showCancel: true, okString: "投资", okbtnEvent: function () {
                            //            window.location.href = investListUrl;
                            //        }
                            //    }); 
                            //}
                            break;
                        case "-3":
                            if (typeid == "16") {
                                if (typeid == "16" && subtypeid == "1") {
                                    window.location.href = "<%=ConfigurationManager.AppSettings["ActivityWebsiteUrl"]%>/weixin/20170411_tyj/index.html?orderId=" + TiYanJinId + "&amount=" + TiYanJinE + "&profit=" + TiYanJinProfit + "&userPrizeId=" + userPrizeId + "&days=" + Days;
                                    return;
                                }
                                else {
                                    window.location.href = "<%=ConfigurationManager.AppSettings["ActivityWebsiteUrl"]%>/weixin/newhand/welfare/page2888.aspx";
                                    return;
                                }
                            }
                            else if (typeid == "3") {
                                $("body").showMessage({
                                    message: "该红包已经领取过,请到标区投资使用此红包。", showCancel: true, okbtnEvent: function () {
                                        window.location.href = investListUrl;
                                    }
                                });
                            } else {
                                $("body").showMessage({ message: "奖品已经领取!", showCancel: false });
                            }
                            break;
                        case "0":
                            $("body").showMessage({ message: "领取失败,请重试!", showCancel: false });
                            break;
                        case "-1":
                            $("body").showMessage({ message: "奖品已领取!", showCancel: false });
                            break;
                        case "-2":
                            if (typeid == "14" && subtypeid == "0") {
                                switch (prizeValue) {
                                    case "5":
                                        {
                                            invest = '1000';
                                            break;
                                        }
                                    case "15":
                                        {
                                            invest = '8000';
                                            break;
                                        }
                                    case "20":
                                        {
                                            invest = '2万';
                                            break;
                                        }
                                    case "160":
                                        {
                                            invest = '5万';
                                            break;
                                        }
                                    case "188":
                                        {
                                            invest = '10万';
                                            break;
                                        }
                                }
                                $("body").showMessage({
                                    message: "此红包累计投资满" + invest + "元即可领取,为保障您的权益,投资之前需要完成手机认证、实名认证", showCancel: true, okbtnEvent: function () {
                                        window.location.href = "/Member/safety/safety.aspx";
                                    }
                                });
                            } else {
                                $("body").showMessage({
                                    message: "领取之前请完成实名认证", showCancel: true, okbtnEvent: function () {
                                        window.location.href = "/Member/safety/safety.aspx";
                                    }
                                });
                            }
                            break;
                        case "-18":
                            $("body").showMessage({ message: "邀请奖励赠送2天后才能领取!", showCancel: false });
                            break;
                        case "-88":
                            if (typeid == "14" && subtypeid == "0") {
                                switch (prizeValue) {
                                    case "5":
                                        {
                                            invest = '1000';
                                            break;
                                        }
                                    case "15":
                                        {
                                            invest = '8000';
                                            break;
                                        }
                                    case "20":
                                        {
                                            invest = '2万';
                                            break;
                                        }
                                    case "160":
                                        {
                                            invest = '5万';
                                            break;
                                        }
                                    case "188":
                                        {
                                            invest = '10万';
                                            break;
                                        }
                                }
                                $("body").showMessage({
                                    message: "亲,您需累计投资满" + invest + "元即可领取,是否立即投资?", showCancel: true, okString: "投资", okbtnEvent: function () {
                                        window.location.href = investListUrl;
                                    }, cancelString: "取消"
                                });
                            }
                            else {
                                $("body").showMessage({ message: "领取失败,不符合领取条件!", showCancel: false });
                            }
                            break;
                        case "-89":
                        case "-90":
                            $("body").showMessage({ message: "团贷网提醒您,红包已经过期!", showCancel: false });
                            break;
                        case "-91":
                            $("body").showMessage({
                                message: "您的累计投资金额未达标,立即投资?", showCancel: true, okString: "是", okbtnEvent: function () {
                                    window.location.href = investListUrl;
                                }, cancelString: "否"
                            });
                            break;
                        case "-11":
                            $("body").showMessage({ message: "团贷网提醒您,领取时间未开始!", showCancel: false });
                            break;
                        case "-12":
                            $("body").showMessage({ message: "团贷网提醒您,领取时间已结束,已经过期!", showCancel: false });
                            break;
                        default:
                            $("body").showMessage({ message: "网络异常,请重试!", showCancel: false });
                            break;
                    }
                }
               , error: function () {
                   $("body").showMessage({ message: "网络异常,请重试!", showCancel: false });
               }
            });
        }
        //查看详情
        function viewDesc(obj) {
            var $this = $(obj);
            $("#pSource").html("来源：" + $this.attr("attrfrom"));
            $("#pDesc").html($this.attr("attrdesc"));
            showAniFadeIn("#dvPopDesc");
            //$("#dvPopDesc").removeClass("hide");
        }
    </script>
</body>
</html>
