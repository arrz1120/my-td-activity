﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="lottery.aspx.cs" MasterPageFile="~/MVipWebStite.Master" Inherits="TuanDai.WXApiWeb.Member.Mall.lottery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>团币抽奖</title>
    <link rel="stylesheet" type="text/css" href="/css/mall.css?v=20170821001" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <body class="bg-f1f3f5">
        <%= this.GetNavStr()%>
        <header class="headerMain">
            <div class="header bb-e6e6e6">
                <div class="pageReturn" onclick="javascript:history.go(-1);"></div>
                <h1 class="title">团币抽奖</h1>
            </div>
            <%= this.GetNavIcon()%>
            <div class="none"></div>
        </header>

        <div class="lottery_t webkit-box box-align">
            <div class="userHead">
                <img src="<%=string.IsNullOrEmpty(userVipInfo.HeadImage)?"/imgs/bav_head.gif":userVipInfo.HeadImage %>" />
            </div>
            <div class="ml10">
                <p class="c-681501 f17px"><%=userVipInfo.NickName %></p>
                <p class="c-681501 f12px">拥有团币：<span class="c-ef3550 f12px"><%=userVipInfo.ValidTuanBi %></span></p>
            </div>
        </div>
        <a href="" class="rule_btn">查看规则></a>

        <% if (userPrizeSettings != null && userPrizeSettings.Count == 12)
           {
        %>
        <div class="lottery_m pos-r">
            <img class="bg_wave" src="/imgs/member/mall/bg_wave.png" />
            <div class="pl15 pr15 pt18 pb20">
                <div class="l_table">
                    <table border="0" cellspacing="0" cellpadding="0" id="table">
                        <tr>
                            <td id="prize1" data="1">
                                <div class="bg_td">
                                    <p>
                                        <img src="<%=userPrizeSettings[0].ThumbnailImageUrl %>" />
                                    </p>
                                    <p><%=userPrizeSettings[0].ProductName %></p>
                                </div>
                            </td>
                            <td id="prize2" data="2">
                                <div class="bg_td ">
                                    <p>
                                        <img src="<%=userPrizeSettings[1].ThumbnailImageUrl %>" />
                                    </p>
                                    <p><%=userPrizeSettings[1].ProductName %></p>
                                </div>
                            </td>
                            <td id="prize3" data="3">
                                <div class="bg_td ">
                                    <p>
                                        <img src="<%=userPrizeSettings[2].ThumbnailImageUrl %>" />
                                    </p>
                                    <p><%=userPrizeSettings[2].ProductName %></p>
                                </div>
                            </td>
                            <td id="prize4" data="4">
                                <div class="bg_td ">
                                    <p>
                                        <img src="<%=userPrizeSettings[3].ThumbnailImageUrl %>" />
                                    </p>
                                    <p><%=userPrizeSettings[3].ProductName %></p>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td id="prize12" data="12">
                                <div class="bg_td ">
                                    <p>
                                        <img src="<%=userPrizeSettings[11].ThumbnailImageUrl %>" />
                                    </p>
                                    <p><%=userPrizeSettings[11].ProductName %></p>
                                </div>
                            </td>
                            <td colspan="2" rowspan="2">
                                <div class="l_now l_now_down webkit-box box-center box-vertical" id="btnLottery">
                                    <p class="c-ff4442 f24px">马上抽奖</p>
                                    <p class="c-681501 f12px mt10">（100团币/次）</p>
                                </div>
                            </td>
                            <td id="prize5" data="5">
                                <div class="bg_td ">
                                    <p>
                                        <img src="<%=userPrizeSettings[4].ThumbnailImageUrl %>" />
                                    </p>
                                    <p><%=userPrizeSettings[4].ProductName %></p>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td id="prize11" data="11">
                                <div class="bg_td ">
                                    <p>
                                        <img src="<%=userPrizeSettings[10].ThumbnailImageUrl %>" />
                                    </p>
                                    <p><%=userPrizeSettings[10].ProductName %></p>
                                </div>
                            </td>
                            <td id="prize6" data="6">
                                <div class="bg_td ">
                                    <p>
                                        <img src="<%=userPrizeSettings[5].ThumbnailImageUrl %>" />
                                    </p>
                                    <p><%=userPrizeSettings[5].ProductName %></p>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td id="prize10" data="10">
                                <div class="bg_td ">
                                    <p>
                                        <img src="<%=userPrizeSettings[9].ThumbnailImageUrl %>" />
                                    </p>
                                    <p><%=userPrizeSettings[9].ProductName %></p>
                                </div>
                            </td>
                            <td id="prize9" data="9">
                                <div class="bg_td ">
                                    <p>
                                        <img src="<%=userPrizeSettings[8].ThumbnailImageUrl %>" />
                                    </p>
                                    <p><%=userPrizeSettings[8].ProductName %></p>
                                </div>
                            </td>
                            <td id="prize8" data="8">
                                <div class="bg_td ">
                                    <p>
                                        <img src="<%=userPrizeSettings[7].ThumbnailImageUrl %>" />
                                    </p>
                                    <p><%=userPrizeSettings[7].ProductName %></p>
                                </div>
                            </td>
                            <td id="prize7" data="7">
                                <div class="bg_td ">
                                    <p>
                                        <img src="<%=userPrizeSettings[6].ThumbnailImageUrl %>" />
                                    </p>
                                    <p><%=userPrizeSettings[6].ProductName %></p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <%
       } %>
        <div class="lottery_b">
            <img src="/imgs/member/mall/lottery_b.png" />
            <div class="awardList pl15 pr15">
                <div id="awardList">
                    <ul class="pl15 pr15">
                        <% if (userPrizeHistorys != null && userPrizeHistorys.Count > 0)
                           {
                               foreach (var prizeHistory in userPrizeHistorys)
                               {
                        %>
                        <li class="webkit-box">
                            <div class="f13px text-overflow">
                                <i>
                                    <img src="<%=string.IsNullOrEmpty(prizeHistory.HeadImage)?"/imgs/bav_head.gif":prizeHistory.HeadImage %>" /></i><%=MaskPointPre(prizeHistory.UserName, 6) %>
                            </div>
                            <div class="f13px text-overflow c-ef8d00"><%=prizeHistory.PrizeName %></div>
                            <div class="f13px text-overflow"><%=DateStringFromNow(prizeHistory.AddDate) %></div>
                        </li>
                        <%
                           }
                       } %>
                    </ul>
                </div>
            </div>
        </div>

        <!--弹框-->
        <!--中奖弹框-->
        <div class="alert webkit-box box-center" id="alert1" style="display: none;">
            <div class="lottery_alert pl15 pr15 pos-r lottery_alert_1" id="lottery_alert_1">
                <div class="alert_c" onclick="javascript:$('#alert1').fadeOut();" style="width: 25px; height: 25px;"></div>
                <div class="fire"></div>
                <div class="alert_t webkit-box box-center">
                    <img src="/imgs/member/mall/cj1.png" />
                </div>
                <p class="f17px c-aa6e19 text-center">恭喜您获得</p>
                <p class="f20px c-f04444 text-center mt5">18元投资红包</p>
                <p class="mt5 mb5 f11px  text-center tips"  id="tips">温馨提示：请在15天内前往【我-我的会员-<br>
                会员商城-我的商品】领取并填写收货地址，逾期则视为自动放弃该奖品</p>
                <div class="alert_b clearfix mt30">
                    <div class="alert_b_l lf c-ffffff text-center f17px">查看奖品</div>
                    <div class="alert_b_r rf c-ffffff text-center f17px" onclick="javascript:$('#alert1').fadeOut();Lottery();">再抽一次</div>
                </div>
            </div>
        </div>
        <!--木有中奖弹框-->
        <div class="alert webkit-box box-center" id="alert2" style="display: none;">
            <div class="lottery_alert pl15 pr15 pos-r">
                <div class="alert_c" onclick="javascript:$('#alert2').fadeOut();" style="width: 25px; height: 25px;"></div>
                <div class="alert_t webkit-box box-center">
                    <img src="/imgs/member/mall/not_award.png" />
                </div>
                <p class="f20px c-aa6e19 text-center mt20">很遗憾没有中奖!</p>
                <div class="alert_b_one text-center f17px c-ffffff" onclick="javascript:$('#alert2').fadeOut();Lottery();">再抽一次</div>
            </div>
        </div>
        <!--团币不足弹框-->
        <div class="alert webkit-box box-center" id="alert3" style="display: none;">
            <div class="lottery_alert pl15 pr15 pos-r">
                <div class="alert_c" onclick="javascript:$('#alert3').fadeOut();" style="width: 25px; height: 25px;"></div>
                <div class="alert_t webkit-box box-center">
                    <img src="/imgs/member/mall/not_enough.png" />
                </div>
                <p class="f20px c-aa6e19 text-center mt20">您的团币不足!</p>
                <div class="alert_b_one text-center f17px c-ffffff">去赚团币</div>
            </div>
        </div>

        <div class="alert webkit-box box-center hide" id="rule_alert">
            <div class="lottery_alert rule_alert pl15 pr15 pos-r">
                <div class="alert_c"></div>

                <ul class="list f12px">
                    <li>1. 若抽中虚拟奖品（除团币外），可前往【我-我的会员-会员商城-我的商品】查看；</li>
                    <li>2. 若抽中团币，系统将直接发放至您的账户，可前往【我-我的会员-我的团币】查看；</li>
                    <li>3. 若抽中实物奖品，可前往【我-我的会员-会员商城-我的商品】查看，请在中奖日起15天内领取并填写收货地址，逾期则视为自动放弃该奖品；</li>
                    <li>4.自中奖日起30天内，有任何疑问，可咨询平台客服：1010-1218；</li>
                    <li>5.若中奖超过30天，且商品状态显示已发货，平台默认商品无误（无质量问题），将不再处理售后问题。</li>
                </ul>
            </div>
        </div>

    </body>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="Server">
    <script type="text/javascript" src="/scripts/statistics.tencent.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript">
        var table = $("#table");
        w = $(".l_table").innerWidth();
        var bRotate = false;
        //	table.width(w);
        var td = table.find('.bg_td');
        td.each(function (i) {
            td.eq(i).css({
                'width': (w - 20) / 4 - 9
            });
        });
        var $btnLottery = $("#btnLottery");
        $btnLottery.css('width', td.width() * 2 + 5);
        $btnLottery.parent().css('width', td.width() * 2 + 10);

        window.onload = function () {
            $btnLottery.removeClass('l_now_down');
            $btnLottery.on('touchstart', function () {
                $(this).addClass('l_now_down');
            }).on('touchend', function () {
                $(this).removeClass('l_now_down');
            })
        }

        //滚动
        setInterval(AutoScroll, 2000);
        function AutoScroll(obj) {
            $("#awardList").find("ul:first").animate({
                marginTop: "-37px"
            }, 500, function () {
                $(this).css({ marginTop: "0px" }).find("li:first").appendTo(this);
            });
        }

        //显示中奖的信息
        function ShowPrize(imgUrl, prizeName, btnName) {
            $("#alert1 div img").attr("src", imgUrl);
            $($("#alert1 div p").eq(1)).html(prizeName);
            if (btnName) {
                $("#alert1 .alert_b_l").html(btnName).attr("onclick", "javascript:window.location.href='tuanbiDetail.aspx'");
            } else {
                $("#alert1 .alert_b_l").html("查看奖品").attr("onclick", "javascript:window.location.href='myProduct.aspx'");
            }
            $("#alert1").fadeIn();
        }

        //显示错误信息
        function ShowError(msg, btnValue, url) {
            $("#alert3 div p").html(msg);
            $("#alert3 div .alert_b_one").html(btnValue).click(function () {
                if (url)
                    window.location.href = url;
                else
                    $("#alert3").fadeOut();
            });
            $("#alert3").fadeIn();
        }

        //抽奖滚动
        function roll() {
            if ($("#prize12").find(".bg_td").hasClass("bg_lottery")) {
                $("#prize12").find(".bg_td").removeClass("bg_lottery");
                $("#prize1").find(".bg_td").addClass("bg_lottery");
            }
            else if ($("#prize1").find(".bg_td").hasClass("bg_lottery")) {
                $("#prize1").find(".bg_td").removeClass("bg_lottery");
                $("#prize2").find(".bg_td").addClass("bg_lottery");
            }
            else if ($("#prize2").find(".bg_td").hasClass("bg_lottery")) {
                $("#prize2").find(".bg_td").removeClass("bg_lottery");
                $("#prize3").find(".bg_td").addClass("bg_lottery");
            }
            else if ($("#prize3").find(".bg_td").hasClass("bg_lottery")) {
                $("#prize3").find(".bg_td").removeClass("bg_lottery");
                $("#prize4").find(".bg_td").addClass("bg_lottery");
            }
            else if ($("#prize4").find(".bg_td").hasClass("bg_lottery")) {
                $("#prize4").find(".bg_td").removeClass("bg_lottery");
                $("#prize5").find(".bg_td").addClass("bg_lottery");
            }
            else if ($("#prize5").find(".bg_td").hasClass("bg_lottery")) {
                $("#prize5").find(".bg_td").removeClass("bg_lottery");
                $("#prize6").find(".bg_td").addClass("bg_lottery");
            }
            else if ($("#prize6").find(".bg_td").hasClass("bg_lottery")) {
                $("#prize6").find(".bg_td").removeClass("bg_lottery");
                $("#prize7").find(".bg_td").addClass("bg_lottery");
            }
            else if ($("#prize7").find(".bg_td").hasClass("bg_lottery")) {
                $("#prize7").find(".bg_td").removeClass("bg_lottery");
                $("#prize8").find(".bg_td").addClass("bg_lottery");
            }
            else if ($("#prize8").find(".bg_td").hasClass("bg_lottery")) {
                $("#prize8").find(".bg_td").removeClass("bg_lottery");
                $("#prize9").find(".bg_td").addClass("bg_lottery");
            }
            else if ($("#prize9").find(".bg_td").hasClass("bg_lottery")) {
                $("#prize9").find(".bg_td").removeClass("bg_lottery");
                $("#prize10").find(".bg_td").addClass("bg_lottery");
            }
            else if ($("#prize10").find(".bg_td").hasClass("bg_lottery")) {
                $("#prize10").find(".bg_td").removeClass("bg_lottery");
                $("#prize11").find(".bg_td").addClass("bg_lottery");
            }
            else if ($("#prize11").find(".bg_td").hasClass("bg_lottery")) {
                $("#prize11").find(".bg_td").removeClass("bg_lottery");
                $("#prize12").find(".bg_td").addClass("bg_lottery");
            }
        }
        //设置中奖的背景色
        function setbg_lottery(i) {
            $(".bg_td").removeClass("bg_lottery");
            if (i == 1)
                $("#prize1").find(".bg_td").addClass("bg_lottery");
            if (i == 2)
                $("#prize2").find(".bg_td").addClass("bg_lottery");
            if (i == 3)
                $("#prize3").find(".bg_td").addClass("bg_lottery");
            if (i == 4)
                $("#prize4").find(".bg_td").addClass("bg_lottery");
            if (i == 5)
                $("#prize5").find(".bg_td").addClass("bg_lottery");
            if (i == 6)
                $("#prize6").find(".bg_td").addClass("bg_lottery");
            if (i == 7)
                $("#prize7").find(".bg_td").addClass("bg_lottery");
            if (i == 8)
                $("#prize8").find(".bg_td").addClass("bg_lottery");
            if (i == 9)
                $("#prize9").find(".bg_td").addClass("bg_lottery");
            if (i == 10)
                $("#prize10").find(".bg_td").addClass("bg_lottery");
            if (i == 11)
                $("#prize11").find(".bg_td").addClass("bg_lottery");
            if (i == 12)
                $("#prize12").find(".bg_td").addClass("bg_lottery");
        }

        $btnLottery.click(function () {

            if (bRotate) return;
            bRotate = true;
            Lottery();
        });

        //抽奖
        function Lottery() {
            $.ajax({
                type: "post",
                url: "/ajaxCross/ajax_mall.ashx",
                dataType: "json",
                data: { Cmd: "MemberCoinLottery" },
                success: function (jsonData) {
                    var status = parseInt(jsonData.Status);
                    if (status == -3) {//团币不足
                        ShowError("您的团币不足！", "去赚团币吧", "allTask.aspx");
                    } else if (status == 1) {
                        $("#prize1").find(".bg_td").addClass("bg_lottery");
                        var time = setInterval("roll()", 100);
                        setTimeout(function () {
                            clearInterval(time);
                        }, 1500);
                        var time1 = setInterval(function () {
                            roll();
                            //取得选中样式的
                            var dataid = $(".bg_lottery").parent().attr("data");
                            if (dataid == parseInt(jsonData.PrizeIndex) + 1) {
                                clearInterval(time1);
                                setTimeout(function () {
                                    var typeid = parseInt(jsonData.SubTypeId);
                                    if (typeid == 0) { //运气不佳未中奖
                                        $("#alert2").fadeIn();
                                    } else {
                                        if (parseInt(jsonData.SubTypeId) == 3) {
                                            if ($("#lottery_alert_1").hasClass("lottery_alert_1")) {
                                                $("#lottery_alert_1").removeClass("lottery_alert_1");
                                            }
                                            $("#tips").hide();
                                            ShowPrize(jsonData.ImageUrl, jsonData.ProductName, "查看团币");
                                        }
                                        else if (parseInt(jsonData.SubTypeId) == 2) {
                                            if (!$("#lottery_alert_1").hasClass("lottery_alert_1")) {
                                                $("#lottery_alert_1").addClass("lottery_alert_1");
                                            }
                                            $("#tips").show();
                                            ShowPrize(jsonData.ImageUrl, jsonData.ProductName);
                                        } else {
                                            if ($("#lottery_alert_1").hasClass("lottery_alert_1")) {
                                                $("#lottery_alert_1").removeClass("lottery_alert_1");
                                            }
                                            $("#tips").hide();
                                            ShowPrize(jsonData.ImageUrl, jsonData.ProductName);
                                        }

                                    }
                                    $(".lottery_t div p span").html(jsonData.ValidTuanBi);
                                    if (parseInt(jsonData.SubTypeId) == 3) {
                                        $(".lottery_t div p span").html(jsonData.ValidTuanBi + jsonData.PriceValue);
                                    }

                                }, 1000);
                            }
                        }, 300);
                        setTimeout(function () {
                            bRotate = false;
                            setbg_lottery(parseInt(jsonData.PrizeIndex) + 1);
                        }, 2500);


                    } else if (status == -99) {//未登录
                        ShowError("您还未登录！", "我要登录", "/user/login.aspx?returnurl=" + window.location.href);
                    } else if (status == -2) {
                        ShowError("会员信息不存在！", "我要注册", "/user/register.aspx?returnurl=" + window.location.href);
                    } else if (status == -5) {
                        ShowError("您还未绑定手机号！", "我要绑定", "/Member/safety/safety.aspx?returnurl=" + window.location.href);
                    } else {
                        ShowError("服务器繁忙！", "我知道啦");
                    }
                },
                error: function () {
                    bRotate = false;
                }
            });
        }

        //setInterval("roll()", 50);        
        $('.rule_btn').on('click', function (e) {
            e.preventDefault();
            $('#rule_alert').removeClass('hide')
            $(".alert_c").unbind("click").bind("click", function () {
                $('#rule_alert').addClass("hide");
            });
        })
    </script>
</asp:Content>
