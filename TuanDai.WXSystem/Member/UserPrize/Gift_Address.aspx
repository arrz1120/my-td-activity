<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gift_Address.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.UserPrize.Gift_Address" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>收货地址</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
    <link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->
    <link rel="stylesheet" type="text/css" href="/css/loan.css?v=20150804" />
</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
<div class="header">
    <div class="back" onclick="javascript:history.go(-1);">返回</div>
    <h1 class="title">收货地址</h1>
</div>
<%= this.GetNavIcon()%>
<div class="none"></div>
</header>
<section class="bg-fff ml15 mr15 mt20 clearfix">
    <div class="addressBox input-border">
        <div class="leftBox">所在地区</div>
        <div class="address-cn">
            <select name="sel_city1" runat="server" id="sel_city1" class="select">
                <option>请选择省市/地区</option>
            </select>
        </div>
    </div>
    <div class="addressBox">
        <div class="address-cn mb5">
            <div class="contBox bg-fff">
                <select name="sel_city2" runat="server" id="sel_city2" class="select">
                    <option>请选择城市</option>
                </select>
            </div>
            <div class="contBox bg-fff">
                <select name="sel_city3" runat="server" id="sel_city3" class="select">
                    <option>请选择区/县</option>
                </select>
            </div>
        </div>
    </div>
    <div class="addressBox input-border pl10">
        <input type="text" id="txt_address" runat="server" placeholder="请填写您的详细地址"/>
    </div>
    <div class="error" id="err_address" style="display:none">
        <div class="hint-text">
            <p class="f12px"><img src="/imgs/images/ico_warn.png" class="mr5">请填写完整的收货地址</p>
        </div>
    </div>
    <div class="addressBox input-border pl10">
        <input type="text" id="txt_name" runat="server" placeholder="请填写您的收货人姓名"/>
    </div>
    <div class="error" id="err_name" style="display:none">
        <div class="hint-text">
            <p class="f12px"><img src="/imgs/images/ico_warn.png" class="mr5">收货人不能为空</p>
        </div>
    </div>
    <div class="addressBox input-border pl10">
        <input type="text" id="txt_phone" runat="server" placeholder="请输入您的手机号码"/>
    </div>
    <div class="error" id="err_phone" style="display:none">
        <div class="hint-text">
            <p class="f12px" id="txtErrPhone"><img src="/imgs/images/ico_warn.png" class="mr5" />手机号码格式不正确</p>
        </div>
    </div>
    <div class="addressBox">
        <input type="submit" id="btn_sumbit" value="确认收货地址" class="btn btnYellow"/>
    </div>
</section>
<!--弹窗-->
<section class="automaticwayBox pt15 clearfix" id="tip" style='bottom: -448px; padding: 10px 15px;'>
<div class="hbody mt10 mb10 clearfix lh30">
<i class="ico-exclamation40 lf mr10"></i>
<span id="msg" class="f14px"></span>
</div>
<div class="completeBox clearfix">
<span style="float: right;max-width: 40%;">
         <a href="javascript:;" class="btn btnYellow" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>
    </span>
    <span style="float: right;max-width: 60%;padding-right: 10px;">
         <input type="button" class="btn btnGreen" value="取消" id="btnCancel" onclick="Done()" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;"/>
    </span>
</div>
</section>
<!--遮罩层-->
<div class="maskLayer hide"></div>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js"></script>
<script type="text/javascript">
    function clearErr(obj) {
        $(obj).css("display", "none");
    }
    function addErr(obj) {
        //$(obj).html(err);
        $(obj).css("display", "");
    }
    $(function () {
        $("#btn_sumbit").click(function () {
            clearErr("#err_address");
            clearErr("#err_name");
            clearErr("#err_phone");
            if ($.trim($("#txt_address").val()).length < 1) {
                addErr("#err_address");
                $("#txt_address").focus();
                return false;
            }
            if ($.trim($("#txt_name").val()).length < 1) {
                addErr("#err_name");
                $("#txt_name").focus();
                return false;
            }
            if ($.trim($("#txt_phone").val()).length < 1) {
                addErr("#err_phone");
                $("#txtErrPhone").text("请输入完整的手机号码");
                $("#txt_phone").focus();
                return false;
            }
            if (!/^(13|14|15|17|18)[0-9]{9}$/.test($("#txt_phone").val())) {
                addErr("#err_phone");
                $("#txtErrPhone").text("手机号码格式不正确"); 
                $("#txt_phone").focus();
                return false;
            }

            $.ajax({
                url: "/ajaxCross/ajax_userPrize.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "GetMallUserPrize", id: "<%=PrizeId %>", sel_city1: $("#sel_city1 :selected").val(),
                    sel_city2: $("#sel_city2 :selected").val(), sel_city3: $("#sel_city3 :selected").val(),
                    address: $("#txt_address").val(), name: $('#txt_name').val(), phone: $("#txt_phone").val()
                },
                success: function (json) {
                    switch (json.result) {
                        case "1":
                            if (json.msg == "") {
                                ShowMsg('恭喜您！成功领取奖品', '1', '查看状态', '/Member/UserPrize/gift.aspx');
                            }
                            break;
                        case "0":
                            ShowMsg('领取失败，请重试', '0', '', '');
                            break;
                        case "-1":
                            ShowMsg('奖品已领取', '0', '', '');
                            break;
                        case "-2":
                            ShowMsg('领取之前请完成实名认证', '1', '确定', '/Member/safety/ValidateIdentity.aspx');
                            break;
                        case "-12":
                            ShowMsg('领取时间已过期', '0', '', '');
                            break;
                        case "-11":
                            ShowMsg('未到领取时间', '0', '', '');
                            break;
                        default:
                            ShowMsg('网络异常，请重试', '0', '', '');
                            break;
                    }
                }
            });
        });

        $("#sel_city1").change(function () {
            var thisDom = $(this);
            $.ajax({
                url: "/ajaxCross/ajax_userPrize.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "GetCity", vtype: "1", id: thisDom.val() },
                success: function (d) {
                    if (d.result == "1") {
                        $('#sel_city2').html("");
                        for (var i = 0; i < d.list.length; i++) {
                            $('#sel_city2').append("<option value='" + d.list[i].ProId + "'>" + d.list[i].ProName + "</option>");
                        }
                        $('#sel_city2').change();
                    }
                }
            });
        });
        $("#sel_city2").change(function () {
            var thisDom = $(this);
            $.ajax({
                url: "/ajaxCross/ajax_userPrize.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "GetCity", vtype: "2", id: thisDom.val() },
                success: function (d) {
                    if (d.result == "1") {
                        $('#sel_city3').html("");
                        for (var i = 0; i < d.list.length; i++) {
                            $('#sel_city3').append("<option value='" + d.list[i].ProId + "'>" + d.list[i].ProName + "</option>");
                        }
                    }
                }
            });
        });
    });

    function Done() {
        $(".maskLayer").fadeOut();
        $("#affirmLoanMain").animate({
            bottom: "-430px"
        }, 200)
        $("#tip").animate({
            bottom: "-430px"
        }, 200)
    }

    function ShowMsg(msg, isShowOk, okValue, url) {
        $(".maskLayer").fadeIn();
        $("#msg").html(msg);
        if (isShowOk == "1" && url != "") {
            $("#btnOk").html(okValue);
            $("#btnOk").attr("href", url);
            $("#btnCancel").val("取消");
            $("#btnOk").parent().show();

        } else {
            $("#btnCancel").val("确定");
            $("#btnOk").parent().hide();
        }
        var bottom = (document.documentElement.clientHeight - document.getElementById("tip").offsetHeight) / 2;
        $("#affirmLoanMain").animate({
            bottom: "-430px"
        }, 200)

        $("#tip").animate({
            bottom: bottom
        }, 200)
    }
</script>
</body>
</html>
