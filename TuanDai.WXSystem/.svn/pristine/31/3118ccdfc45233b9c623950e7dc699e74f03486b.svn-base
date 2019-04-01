<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gift.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.UserPrize.gift" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>精美礼品</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/giftBox.css?v=<%=GlobalUtils.Version %>" />
</head>
<body class="bg-f1f3f5">
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:window.location.href='/Member/UserPrize/Index.aspx'">返回</div>
        <h1 class="title">精美礼品</h1>
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

        <div id="thelist"> 
        </div>
      
        <div class="pt25">
            <%--<p class="text-center c-ababab f13px">如有疑问，请联系客服：<a href="tel:400-641-0888" class="f13px c-ff7357 inline-block">400-641-0888</a></p>--%>
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
    
<!--2018.7.12 新增京东E卡弹窗 star-->
<section class="alert webkit-box box-center hide" id="sDetail">
    <div class="bg-fff popup-con text-center pos-r">
        <h3 class="c-212121 f17px text-center">京东E卡说明</h3>
        <p id="pSource">来源：市场推广注册新用户</p>
        <div class="pos-r text-des">
            <p class="pos-a">说明：</p>
            <p id="pDesc">请至京东官网输入兑换密码使用</p>
        </div>
        <a href="javascript:;" class="c-fcb700 f17px block bt-e6e6e6" id="btnCloseDetail">我知道了</a>
    </div>
</section>

<section class="alert webkit-box box-center hide" id="sWait">
    <div class="bg-fff popup-con text-center pos-r">
        <p class="alert-txt c-333333" id="pWaitText">正在领取，请稍候(10S)…</p>
        <a onclick="JAVASCRIPT:$('#sWait').addClass('hide');" class="f17px block bt-e6e6e6" style="color: #808080;">关闭</a>
    </div>
</section>

<section class="alert webkit-box box-center hide" id="sBad">
    <div class="bg-fff popup-con text-center pos-r">
        <p class="alert-txt c-333333" style="line-height: 40px;">暂时无法获取到卡密，小π正在为您拼命进货，请稍后再试</p>
        <div class="clearfix bt-e6e6e6">		    
            <div class="lf w50p br-e6e6e6">
                <div class="btn c-808080 f17px br-e6e6e6" id="btnBad">关闭</div>		    
            </div>		    
            <div class="rf w50p">
                <div class="btn c-ffc61a f17px" id="btnRe">重新领取</div>
            </div>
        </div>
    </div>
</section>

<section class="alert webkit-box box-center hide" id="sSee">
    <div class="bg-fff popup-con text-center pos-r">
        <h3 class="c-212121 f17px text-center">京东E卡兑换密码</h3>
        <p class="alert-code" id="pPwd"></p>
        <p class="alert-txt">请妥善保管卡密，尽快前往京东商城绑定使用</p>
        <a href="javascript:;" class="c-fcb700 f17px block bt-e6e6e6" id="btnSee">我知道了</a>
    </div>
</section>

<section class="alert webkit-box box-center hide" id="sSuccess">
    <div class="bg-fff popup-con text-center pos-r">
        <h3 class="c-212121 f17px text-center">恭喜您领取京东E卡成功</h3>
        <p class="alert-txt">京东E卡兑换密码</p>
        <p class="alert-code-s" id="pPassword"></p>
        <input type="text" id="hideText" value="111222" style="display: none;"/>
        <p class="alert-txt" style="line-height: 40px;">请妥善保管卡密，尽快前往京东商城绑定使用</p>
        <div class="clearfix bt-e6e6e6">		    
            <div class="lf w50p br-e6e6e6">
                <div class="btn c-808080 f17px br-e6e6e6" id="btnSuccess">关闭</div>		    
            </div>		    
            <div class="rf w50p">
                <div class="btn c-ffc61a f17px" id="btnCopy" data-clipboard-action="copy" data-clipboard-target="#hideText">复制密码</div>
            </div>
        </div>
    </div>
</section>

<!--2018.7.12 新增京东E卡弹窗 edn-->
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/clipboard.js"></script>
    <script type="text/javascript">
        var orderField = "CreateDate";//排序字段 ExpirationDate
        var orderType = "desc";//排序方式 asc
        var isUsed = "1";//0全部 1可使用 2已过期
        var sortType = "2";
        $(function () {
            LoadGiftList('empty');
            iScroll.onLoadData = LoadGiftList;

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
                    if ($($("#sort2 i").eq(0)).hasClass("triangle-up-orange")) {
                        $($("#sort2 i").eq(0)).removeClass("triangle-up-orange").addClass("triangle-up-gray");
                    }
                    if ($($("#sort2 i").eq(1)).hasClass("triangle-down-orange")) {
                        $($("#sort2 i").eq(1)).removeClass("triangle-down-orange").addClass("triangle-down-gray");
                    }
                }
                if ($("#sort1").hasClass("c-ffcf1f")) {
                    $("#sort1").removeClass("c-ffcf1f").addClass("c-808080");
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
                LoadGiftList("empty");
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
                LoadGiftList("empty");
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
                LoadGiftList("empty");
            });
        });
        //领取京东E卡
        function wait() {
            $("#sWait").removeClass("hide");
            var s = 10;
            var sss = setInterval(function() {
                s = s - 1;
                $("#pWaitText").text('正在领取，请稍候('+s+'S)…');
                if (s <= 0) {
                    $("#sWait").addClass("hide");
                    clearInterval(sss);
                }
            }, 1000);
        }
        function showBad(obj) {
            $("#sBad").removeClass("hide");
            $("#btnRe").click(function () {
                $("#sBad").addClass("hide");
                getUserPrize(obj);
            });
        }
        
        var clipboard = new ClipboardJS('#btnCopy');
        $("#btnCopy").click(function () {
            $("#sSuccess").addClass("hide");
            clipboard.on('success', function (e) {
                console.log(e);
            });
            clipboard.on('error', function (e) {
                console.log(e);
            });
            
        });
        
        function getUserPrize(obj) {
            wait();
            var prizeId = $(obj).attr("attrid");
            var $this = $(obj);
            $.ajax({
                async: false,
                type: "post",
                url: "/ajaxCross/ajax_userPrize.ashx",
                dataType: "json",
                data: { Cmd: "GetUserPrize", id: prizeId },
                success: function (json) {
                    $("#sWait").addClass("hide");
                    if (json.result == "1") {
                        $("#sSuccess").removeClass("hide");
                        $("#pPassword").html("【" + json.msg + "】");
                        $("#hideText").val(json.msg);
                        $("#btnCopy").attr("data-clipboard-text", json.msg);
                        $this.closest('.get-wrap').addClass('moveLeft');
                        $this.hide();
                    } else {
                        showBad(obj);
                    }
                },
                error: function (obj,err,ex) {
                    $("#sWait").addClass("hide");
                    showBad(obj);
                }
            });
        }
        //获取卡密
        function getCardPwd(obj) {
            var prizeId = $(obj).attr("attrid");
            $.ajax({
                async: false,
                type: "post",
                url: "/ajaxCross/ajax_userPrize.ashx",
                dataType: "json",
                data: { Cmd: "getPrizeById", id: prizeId },
                success: function (json) {
                    if (json.result == "1") {
                        $("#sSee").removeClass("hide");
                        $("#pPwd").html("【" + json.msg + "】");
                    } else {
                        $("#sBad").removeClass("hide");
                    }
                },
                error: function (obj, err, ex) {
                    $("#sBad").removeClass("hide");
                }
            });
        }

        $("#btnSuccess").click(function() {
            $("#sSuccess").addClass("hide");
        });
        $("#btnBad").click(function () {
            $("#sBad").addClass("hide");
        });
        $("#btnSee").click(function () {
            $("#sSee").addClass("hide");
        });

        function LoadGiftList(flag) {
            if (flag == "empty") {
                $("#thelist").children().remove(); 
            }
            jQuery.ajax({
                async: false,
                type: "post",
                url: "/ajaxCross/ajax_userPrize.ashx",
                dataType: "json",
                data: { Cmd: "GetGift", pageIndex: pageIndex, sortType:sortType, isUsed: isUsed },
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
                            if (parseInt(item.TypeId) == 9) {//实物奖品
                                if (parseInt(jsonstr.list[i].IsReceive) == 1 && parseInt(jsonstr.list[i].LogisticStatus) > 0) { //已领取且存在物流信息
                                    str = "<section class='ticket-con orange pos-r bg-fff'>" +
                                        "    <i class='circle-th c-top'></i>" +
                                        "    <div class='ticket-d-wrap pt12'>" +
                                        "        <div class='gift-con pos-r'>" +
                                        "            <p class='c-fab600'>" + item.PrizeName + "</p>" +
                                        "            <p>来源：" + item.SourceFrom + "</p>" +
                                        "            <p>说明：" + item.Description + "</p>" +
                                        "        </div>" +
                                        "    </div>" +
                                        "    <a class='bg-ffcf1f button but-y pos-a' href='ViewLogistics.aspx?orderId=" + item.OrderId + "'>查物流</a>" +
                                        "    <i class='circle-th c-bot'></i>" +
                                        "</section>";
                                } else if (parseInt(jsonstr.list[i].IsReceive) == 1) { //已领取
                                    str = "<section class='ticket-con orange pos-r bg-fff'>" +
                                        "    <i class='circle-th c-top'></i>" +
                                        "    <div class='ticket-d-wrap pt12'>" +
                                        "        <div class='gift-con pos-r'>" +
                                        "            <p class='c-fab600'>" + item.PrizeName + "</p>" +
                                        "            <p>来源：" + item.SourceFrom + "</p>" +
                                        "            <p>说明：" + item.Description + "</p>" +
                                        "        </div>" +
                                        "    </div>";
                                    if (item.PrizeName == "走秀网1680元礼包券") {
                                        str += "  <a class='bg-ffcf1f button but-y pos-a' href='http://m.xiu.com'>已领取</a>";
                                    } else {
                                        str += "  <span class='bg-ffcf1f button but-y pos-a'>已领取</span>";
                                    }
                                    str += "    <i class='circle-th c-bot'></i>" +
                                        "</section>";
                                }
                                else {
                                    if (parseInt(jsonstr.list[i].IsExpired) == 1) { //未领取已过期
                                        str = "<section class='ticket-con gift-con gray pos-r bg-fff'>" +
                                            "    <i class='circle-th c-top'></i>" +
                                            "    <div class='ticket-d-wrap pt12'>" +
                                            "        <div class='gift-con pos-r'>" +
                                            "            <p class='c-ababab'>" + item.PrizeName + "</p>" +
                                            "            <p>来源：" + item.SourceFrom + "</p>" +
                                            "            <p>说明：" + item.Description + "</p>" +
                                            "        </div>" +
                                            "    </div>" +
                                            "    <span class='bg-d1d1d1 button but-n pos-a'>已过期</span>" +
                                            "    <i class='circle-th c-bot'></i>" +
                                            "</section>";
                                    } else {   //未领取未过期
                                        str = "<section class='ticket-con orange pos-r bg-fff'>" +
                                            "    <i class='circle-th c-top'></i>" +
                                            "    <div class='get-wrap bg-fff pos-a animated'>" +
                                            "        <div class='git-gift-box git-gift-box'>" +
                                            "            <div class='git-gift'>" +
                                            "                <p class='c-ffffff pos-a'>" + item.PrizeName + (item.ReceiveDateStr != "" ? "<span class='block'>" + item.ReceiveDateStr + "</span>" : "") + "</p>" +
                                            "            </div>" +
                                            "            <a class='bg-ffcf1f button but-g pos-a' href='gift_address.aspx?PrizeId=" + item.Id + "'>领取</a>" +
                                            "        </div>" +
                                            "    </div>" +
                                            "    <div class='ticket-d-wrap pt12'>" +
                                            "        <div class='gift-con pos-r'>" +
                                            "            <p class='c-fab600'>" + item.PrizeName + "</p>" +
                                            "            <p>来源：" + item.SourceFrom + "</p>" +
                                            "            <p>说明：" + item.Description + "</p>" +
                                            "        </div>" +
                                            "    </div>" +
                                            "    <a class='bg-ffcf1f button but-y pos-a' href='ViewLogistics.aspx?orderId=" + item.OrderId + "'>查物流</a>" +
                                            "    <i class='circle-th c-bot'></i>" +
                                            "</section> ";
                                    }
                                }
                            } else if (parseInt(item.TypeId) == 22) {//京东E卡
                                var dataAttr = ' source="' + item.SourceFrom + '" desc="' + item.Description+'"';
                                if (parseInt(item.IsExpired) == 1) {//已过期
                                    str = '<section class="ticket-con gift-con gray pos-r bg-fff">'+
                                                '<i class="circle-th c-top"></i>'+
                                                '<div class="ticket-d-wrap pt12">'+
                                                    '<div class="gift-con pos-r">'+
                                                        '<p class="c-212121">' + item.PrizeName + '<a onclick="showDetail(this);" class="c-fab600 f17px" '+dataAttr+'>（查看详情）</a></p>' +
                                                        '<p>' + item.CreateDateStr + item.ReceiveDateStr + '</p>' +
                                                    '</div>'+
                                                '</div>'+
                                                '<span class="bg-d1d1d1 button but-n pos-a">已过期</span>'+
                                                '<i class="circle-th c-bot"></i>' +
                                            '</section>';
                                }else if (parseInt(item.IsReceive) == 1) { //已领取
                                    str = '<section class="ticket-con orange pos-r bg-fff">' +
                                        '<div class="ticket-d-wrap pt12">' +
                                        '<div class="gift-con pos-r">' +
                                        '<p class="c-212121">' + item.PrizeName + '<a onclick="showDetail(this);" class="c-fab600 f17px" ' + dataAttr + '>（查看详情）</a></p>' +
                                        '<p>京东E卡兑换密码：' + item.ticket + '</p>' +
                                        '<p>' + item.CreateDateStr + item.ExpirationStr + '</p>' +
                                        '</div>' +
                                        '</div>' +
                                        '<span class="bg-ffcf1f button but-y pos-a" attrid="' + item.Id + '" onclick="getCardPwd(this)">查看</span>' +
                                        '<i class="circle-th c-bot"></i>' +
                                        '</section>';
                                } else if (parseInt(item.IsReceive) == 0) { //未领取
                                    str = '<section class="ticket-con orange pos-r bg-fff">'+
                                            '<i class="circle-th c-top"></i>'+
                                            '<div class="get-wrap bg-fff pos-a animated">'+
                                                '<div class="git-gift-box git-gift-box">'+
                                                    '<div class="git-gift">'+
                                                        '<p class="c-ffffff pos-a">' + item.PrizeName + ' <a onclick="showDetail(this);" ' + dataAttr + '>（查看详情）</a><span class="block">' + item.CreateDateStr + item.ReceiveDateStr + '</span></p>' +
                                                    '</div>'+
                                                    '<span class="bg-ffcf1f button but-g pos-a" attrid="' + item.Id + '" onclick="getUserPrize(this)">领取</span>' +
                                                '</div>'+
                                            '</div>'+
                                            '<div class="ticket-d-wrap pt12">'+
                                                '<div class="gift-con pos-r">'+
                                                    '<p class="c-212121">'+item.PrizeName+'<a onclick="showDetail(this);" class="c-fab600 f17px" ' + dataAttr + '>（查看详情）</a></p>' +
                                                                       '<p>京东E卡兑换密码：'+item.ticket+'</p>'+
                                                                        '<p>' + item.CreateDateStr + item.ExpirationStr + '</p>' +
                                                '</div>'+
                                            '</div>'+
                                            '<span class="bg-ffcf1f button but-y pos-a" attrid="' + item.Id + '" onclick="getCardPwd(this)">查看</span>' +
                                            '<i class="circle-th c-bot"></i>' +
                                        '</section>';
                                }
                            }
                            
                            html.push(str);
                        }
                        $("#thelist").append(html.join(""));
                    }
                    else {
                        $("#thelist").html("<div class='debt-empty mt50'><div class='img-debt-empty text-center'><img style='width: 60%;' src='/imgs/images/debt-empty.png'/></div><div class='text-center f14px c-212121 mt20'>暂无精美礼品数据！</div></div></div>"); 
                    }
                },
                error: function (a, b, c) {
                    $("#thelist").html("<div class='debt-empty mt50'><div class='img-debt-empty text-center'><img style='width: 60%;' src='/imgs/images/debt-empty.png'/></div><div class='text-center f14px c-212121 mt20'>加载有误...</div></div></div>");
                    $("#pullUp").hide();
                }
            });
        }
        
        //京东E卡查看详情
        function showDetail(obj) {
            $("#pSource").html("来源：" + $(obj).attr("source"));
            $("#pDesc").html($(obj).attr("desc"));
            $("#sDetail").removeClass("hide");
        }
        //关闭京东E卡详情
        $("#btnCloseDetail").click(function() {
            $("#sDetail").addClass("hide");
        });
    </script>
</body>
</html>
