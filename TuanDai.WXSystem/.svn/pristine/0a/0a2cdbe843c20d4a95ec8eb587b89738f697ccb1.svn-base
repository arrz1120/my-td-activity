<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind="jiaxiquan.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.UserPrize.jiaxiquan" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>加息券</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/giftBox.css?v=<%=GlobalUtils.Version %>" /> 
</head>
<body class="bg-f1f3f5">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:window.location.href='/Member/UserPrize/Index.aspx';">返回</div>
            <h1 class="title">加息券</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
     <!--排序筛选-->
<div class="sort clearfix bg-fff pl20 pr20 pt10 pb10 pos-r">
    <div class="lf w33p text-center f16px c-ffcf1f" id="sort2">获得时间
        <div class="inline-block left-triangle">
            <p><i class="triangle triangle-up-gray"></i></p>
            <p><i class="triangle triangle-down-orange"></i></p>
        </div>
    </div>
    <div class="lf w33p text-center f16px c-808080" id="sort1">失效时间
        <div class="inline-block left-triangle">
            <p><i class="triangle triangle-up-gray"></i></p>
            <p><i class="triangle triangle-down-gray"></i></p>
        </div>
    </div>
    <div class="lf w33p text-center f16px c-808080" id="sort">可使用<i class="ico-con ico-down-gray"></i></div>
</div>
    <div id="wrapper" style="top:44px!important;">
        <div id="scroller">
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>

            <div id="thelist" style="margin:0;padding:0;">                 
            </div>
            <div class="pt25">
              <p class="text-center c-ababab f13px">当前只显示最近<a class="f13px c-ff7357 inline-block">2</a>个月的奖品记录</p> 
            </div>

            <div id="pullUp">
                <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>
        </div>
    </div> 
    <!--弹出的筛选遮罩层-->
<div class="masker z-index10 pos-a hide" id="alert">
    <div class="alert-record pl15 bt-e6e6e6">
        <ul>
            <li class="active bt-e6e6e6" dataUsed="1">可使用</li>
            <li class="bt-e6e6e6" dataUsed="2">已失效</li>
        </ul>
    </div>
</div>
<!--加息券说明弹窗-->
<div class="hide" id="dvPopDesc">
    <section class="alert webkit-box box-center">
        <div class="bg-fff popup-con text-center pos-r" id="alertCon">
            <h3 class="c-212121 f17px text-center">加息券说明</h3>
            <p id="pSource">来源：会员商城兑换商品。</p>
            <p id="pDate">期限：2016.05.10 - 2016.06.10</p>
            <div class="pos-r text-des">
                <p class="pos-a">说明：</p>
                <p id="pDesc">领取期限一个月，使用期限为领取后一个月内，单笔投资满1000元即可使用。</p>
            </div>
            <a href="javascript:void(0);" class="c-fcb700 f17px block bt-e6e6e6" id="btnPopClose">我知道了</a>
        </div>
    </section>
</div>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    
    <script type="text/javascript"> 
        var orderField = "CreateDate";//排序字段 ExpirationDate
        var orderType = "desc";//排序方式 asc
        var isUsed = "1";//0全部 1可使用 2已过期
        var sortType = "2";
        $(function () {
            LoadRedPacketList('empty');
            iScroll.onLoadData = LoadRedPacketList;
            if (pageCount <= 1) {
                $("#pullUp").hide();
            }
            $("#btnPopClose").click(function () {
                //$("#dvPopDesc").addClass("hide");
                hideAniFadeOut("#dvPopDesc");
            });
            //排序的js
            var alert = $("#alert");
            var box = alert.find('.alert-record');
            $(".masker").click(function () {
                alert.fadeOut(200);
            });
            $("#sort").click(function () { //点击可使用
                alert.fadeIn(200);
                box.slideDown(200);
                if ($("#sort2").hasClass("c-ffcf1f")) {
                    $("#sort2").removeClass("c-ffcf1f").addClass("c-808080");
//                  $(this).addClass("c-ffcf1f").removeClass("c-808080");
//                  $("#sort i").removeClass("triangle-down-gray").addClass("triangle-down-orange");
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
        function bindClickEvent() {
            $(".but-g").unbind("click");
            $(".but-g").click(function () {
                var prizeId = $(this).attr("attrid");
                var $this = $(this);
                $.ajax({
                    async: false,
                    type: "post",
                    url: "/ajaxCross/ajax_userPrize.ashx",
                    dataType: "json",
                    data: { Cmd: "GetUserPrize", id: prizeId },
                    success: function (json) {
                        if (json.result == "1") {
                            $("body").showMessage({
                                message: "恭喜您成功领取该加息券!", showCancel: false, okbtnEvent: function () {
                                    $("body").hideMessage();
                                    $this.closest('.get-wrap').addClass('moveLeft');
                                    $this.hide();
                                }
                            }); 
                        } else {
                            $("body").showTips("领取失败!");
                        }
                    },
                    error: function () {
                        $("body").showTips("网络异常,请重试!");
                    }
                });
            });
        }
        function LoadRedPacketList(flag) {
            if (flag == "empty") {
                $("#thelist").children().remove();
            }
            jQuery.ajax({
                type: "post",
                url: "/ajaxCross/ajax_userPrize.ashx",
                data: { Cmd: "GetRateCoupon", Pageindex: pageIndex, sortType:sortType, isUsed: isUsed,type:"5" },
                dataType: "json",
                success: function (jsonstr) {
                    if (flag == "empty") {
                        $("#thelist").children().remove();
                    }
                    var html = new Array();
                    var str = "";
                    pageCount = jsonstr.pageCount;
                    if (pageCount <= 1) {
                        $("#pullUp").hide();
                    } else {
                        $("#pullUp").show();
                    }

                    if (jsonstr.result == "1") { 
                        $(jsonstr.list).each(function (i, item) {
                            var attrStr = " attrfrom='" + item.SourceFrom + "'attrdesc='" + item.Description + "'attrDate='"+item.DeadlineStr+"' onclick='viewDesc(this)' ";
                            if (item.IsUsed == "2") {//已过期
                                str = "<section class='ticket-con gray pos-r bg-fff'>" +
                                      " <div class='ticket-d-wrap'>" +
                                      "    <div class='ticket-details pos-r'>" +
                                      "            <p class='c-212121'>+" + parseFloat(item.PrizeValue) + "%加息券" + "<span " + attrStr + ">（查看详情）</span>" + "</p>" +
                                        '<p class="c-ababab"><em class="c-ababab">+</em>' + parseFloat(item.PrizeValue) + '<em class="c-ababab">%</em><span class="c-ababab">投资指定项目使用</span></p>' +
                                        '<p>' + item.CreateDateStr+item.ExpirationStr + '</p>' +
                                      "  </div>" +
                                      " </div>" +
                                      " <span class='bg-d1d1d1 button but-n pos-a'>已过期</span>" +
                                      "</section>";
                            } else if (item.IsUsed == "0") {
                                if (item.Receive == "0") {
                                    str = "<section class='ticket-con blue pos-r bg-fff'>" +
                                        "    <div class='get-wrap bg-fff pos-a animated'>" +
                                        "        <div class='get-con'>" +
                                        "            <div class='git-ticket'>" +
                                        "                <p class='c-ffffff pos-a'><span class='c-ffffff'>+</span>" + parseFloat(item.PrizeValue) + "%" + (item.ReceiveDateStr != "" ? "<span>" + item.CreateDateStr + item.ReceiveDateStr + "</span>" : "") + "</p>" +
                                        "            </div>" +
                                        "            <span class='bg-ffcf1f button but-g pos-a' attrid='" + item.Id + "'>领取</span>" +
                                        "        </div>" +
                                        "    </div>" +
                                        "    <div class='ticket-d-wrap'>" +
                                        "        <div class='ticket-details pos-r'>" +
                                        "            <p class='c-212121'>+" + parseFloat(item.PrizeValue) + "%加息券" + "<span " + attrStr + ">（查看详情）</span>" + "</p>" +
                                        '<p class="c-41bef0"><em class="c-41bef0">+</em>'+ parseFloat(item.PrizeValue) +'<em class="c-41bef0">%</em><span class="c-41bef0">投资指定项目使用</span></p>'+
                                        '<p>'+item.CreateDateStr+item.ExpirationStr+'</p>'+
                                        "        </div>" +
                                        "    </div>" +
                                        "    <a class='bg-ffcf1f button but-y pos-a' href='/pages/invest/WE/WE_list.aspx'>使用</a>" +
                                        "</section>";
                                } else {
                                    //已领取
                                    str =   "<section class='ticket-con blue pos-r bg-fff'>"+
                                            " <div class='ticket-d-wrap'>"+
                                            "  <div class='ticket-details pos-r'>"+
                                            "            <p class='c-212121'>+" + parseFloat(item.PrizeValue) + "%加息券" + "<span " + attrStr + ">（查看详情）</span>" + "</p>" +
                                        '<p class="c-41bef0"><em class="c-41bef0">+</em>' + parseFloat(item.PrizeValue) + '<em class="c-41bef0">%</em><span class="c-41bef0">投资指定项目使用</span></p>' +
                                        '<p>' + item.CreateDateStr + item.ExpirationStr + '</p>' +
                                        "        </div>" +
                                            "  </div>"+
                                            " </div>"+
                                            " <a class='bg-ffcf1f button but-y pos-a' href='/pages/invest/WE/WE_list.aspx'>使用</a>" +
                                            "</section>";
                                }
                            }
                            else //已使用
                            {
                                str = "<section class='ticket-con gray pos-r bg-fff'>" +
                                    "	<div class='ticket-d-wrap'>" +
                                    "		<div class='ticket-details pos-r'>" +
                                    "            <p class='c-212121'>+" + parseFloat(item.PrizeValue) + "%加息券" + "<span " + attrStr + ">（查看详情）</span>" + "</p>" +
                                        '<p class="c-ababab"><em class="c-ababab">+</em>' + parseFloat(item.PrizeValue) + '<em class="c-ababab">%</em><span class="c-ababab">投资指定项目使用</span></p>' +
                                        '<p>' + item.CreateDateStr+item.ReceiveDateStr + '</p>' +
                                    "		</div>" +
                                    "	</div>" +
                                    "	<span class='bg-d1d1d1 button but-n pos-a'>已使用</span>" +
                                    "</section>";
                            }
                            html.push(str);
                        });
                        $("#thelist").append(html.join(""));
                        bindClickEvent();
                    }
                    else {
                        $("#thelist").html("<div class='debt-empty mt50'><div class='img-debt-empty text-center'><img style='width: 60%;' src='/imgs/images/debt-empty.png'/></div><div class='text-center f14px c-212121 mt20'>暂无加息券数据！</div></div></div>");
                    }
                },
                error: function (a, b, c) { 
                    $("#thelist").html("<div class='debt-empty mt50'><div class='img-debt-empty text-center'><img style='width: 60%;' src='/imgs/images/debt-empty.png'/></div><div class='text-center f14px c-212121 mt20'>加载有误...</div></div></div>");
                    $("#pullUp").hide();
                }
            });
        }
        //查看详情
        function viewDesc(obj) {
            var $this = $(obj);
            $("#pSource").html("来源：" + $this.attr("attrfrom"));
            $("#pDesc").html($this.attr("attrdesc"));
            $("#pDate").html("期限："+$this.attr("attrdate"));
            //$("#dvPopDesc").removeClass("hide");
            showAniFadeIn("#dvPopDesc");
        }
    </script>
</body>
</html>
