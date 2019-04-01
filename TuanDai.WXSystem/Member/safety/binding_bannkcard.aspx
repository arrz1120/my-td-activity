<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="binding_bannkcard.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.binding_bannkcard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>绑定银行卡 - 我的账户</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
    <link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->
</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">绑定银行卡</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
    </header>
    <section class="bg-bdtopBom1-d1d1d1 pd10 mt20 clearfix">
        <div class="phoneCode bindingPhone pr0">
            <div class="c-left">银行卡号</div>
            <input type="text" name="" id="txt_account" class="codeIpt" placeholder="持卡人须与实名认证相符">
        </div>
    </section>
    <section class="bankCardCont bg-bdtopBom1-d1d1d1 pd10 mt20 clearfix">
        <div class="phoneCode bindingPhone pr0">
            <div class="c-left">开户银行</div>
                <select name="bank-name" id="sel_bankList" onchange="selectBank1();">
                 <option value="-1">请选择开户银行</option>
                 <option value="1">招商银行</option>
                    <option value="2">中国银行</option>
                    <option value="3">中国工商银行</option>
                    <option value="4">中国建设银行</option>
                    <option value="5">中国农业银行</option>
                    <option value="6">交通银行</option>
                    <option value="7">上海浦东发展银行</option>
                    <option value="8">中国民生银行</option>
                    <option value="9">兴业银行</option>
                    <option value="10">光大银行</option>
                    <option value="11">深发展银行</option>
                    <option value="12">北京银行</option>
                    <option value="13">中信银行</option>
                    <option value="14">广东发展银行</option>
                    <option value="15">平安银行</option>
                    <option value="16">中国邮政储蓄银行</option>
                    <option value="9999">其他</option>
              </select>
        </div>
    </section>
    <section class="bankCardCont bg-bdtopBom1-d1d1d1 pd10 mt20 clearfix" id="otherbankname" style="display:none">
        <div class="phoneCode bindingPhone pr0">
            <div class="c-left">其它银行</div>
            <input type="text" name="" id="txtOtherBankName" class="codeIpt" placeholder="请输入其它银行账户">
        </div>
    </section>
    <section class="bankCardCont bg-bdtopBom1-d1d1d1 pd10 mt20 clearfix">
        <div class="phoneCode bindingPhone pr0">
            <div class="c-left">所在省份</div>
            <select name="sel_city1" runat="server" id="sel_city1" class="selectcard">
                <option>请选择省份</option>
            </select>
        </div>
    </section>
    <section class="bankCardCont bg-bdtopBom1-d1d1d1 pd10 mt20 clearfix">
        <div class="phoneCode bindingPhone pr0">
            <div class="c-left">所在城市</div>
            <select name="sel_city2" runat="server" id="sel_city2" class="selectcard">
                <option>请选择城市</option>
            </select>
        </div>
    </section>
    <section class="bankCardCont bg-bdtopBom1-d1d1d1 pd10 mt20 clearfix">
        <div class="phoneCode bindingPhone pr0">
            <div class="c-left">支行名称</div>
            <input type="text" name="" id="txtOpenBankName" class="codeIpt" placeholder="请输入开户银行支行名称">
        </div>
    </section>
    <%--<section class="bankCardCont bg-bdtopBom1-d1d1d1 pd10 mt20 clearfix">
        <div class="phoneCode bindingPhone pr0">
            <div class="c-left">手机验证码</div>
            <input type="text" name="" id="txt_smsCode" class="codeIpt" placeholder="请输入验证码">
            <a id="AddbtnSendMsg" class="btncode" href="javascript:void(0);">发送验证码</a>
            <span style="font-size: 12px; color:Red; float:right; position:absolute; top: 0; right:0px;" id="spTip"></span>
        </div>
    </section>--%>
    <div id="trError" style="display:none;" class="addcard_mx">
        
    </div>
    
    <section class="pd15 mt5">
        <a href="javascript:void(0)" id="btn_sumbit" class="btn btnYellow">提交</a>
        <p class="f12px c-ababab lh20 pt10 clearfix">用户充值、提现必须使用与实名信息一致的同一张银行借记卡。如需更换，可以提交改绑申请，经审核后方可更改。</p>
        <p class="f12px c-ababab lh20 pt10 clearfix">目前支持的银行包括：工行、建行、中行、农行、招行、光大、华夏、浦发、平安银行。</p>
    </section>
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=1"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions_code.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var vailStatus = '<%=vailStatus %>';
            var strmsg = "";
            var returnurl = "";
            if (parseInt(vailStatus) < 4) {
                strmsg = "为保障您的资金安全，请先进行身份认证和设置交易密码，再进行本操作。点击确定后转到安全中心。";
                alert(strmsg);
                window.location.href = "safety.aspx";
                //returnurl = "safety.aspx";
            }
            else if (parseInt(vailStatus) == 12) {
                strmsg = "为保障您的资金安全，请先进行首次交易密码设置，再进行本操作。点击确定后转到首次交易密码设置。";
                alert(strmsg);
                window.location.href = "/Member/safety/reset_password.aspx";
            }
        });
        function selectBank1() {
            var type = $("#sel_bankList :selected").val();
            if (type == 9999) {
                $("#otherbankname").show();
            } else {
                $("#otherbankname").hide();
            }
        }
        function clearErr() {
            $("#trError").html("");
            $("#trError").css("display", "none");
        }
        function addErr(err) {
            $("#trError").html(err);
            $("#trError").css("display", "");
        }

        $(function () {
            $("#btn_sumbit").click(function() {
                clearErr();
                if ($("#sel_bankList :selected").val() == 9999 && $("#txtOtherBankName").val().length < 1) {
                    addErr("* 请输入其它银行名称");
                    return false;
                }
                if ($("#txt_account").val().length < 1) {
                    addErr("* 请输入银行账号");
                    return false;
                }
                if ($("#sel_bankList :selected").val() == -1) {
                    addErr("* 请选择开户银行");
                    return false;
                }
                if ($("#sel_city2").val() == "请选择城市") {
                    addErr("* 请选择所在城市");
                    return;
                }

                if ($("#txt_account").val().length < 9) {
                    addErr("* 请输入正确的银行卡号");
                    return false;
                }
                if ($("#txtOpenBankName").val().length < 1) {
                    addErr("* 请输入开户支行名称");
                    return false;
                }
                var province = $("#sel_city1 :selected").val();
                var account = $("#txt_account").val();
                var cityName = $("#sel_city2 :selected").val();
                var bankName = $("#txtOpenBankName").val();
                var bankType = $('#sel_bankList').val();
                var otherBankName = $("#txtOtherBankName").val();
                window.location.href = "/Member/safety/binding_bannkcardconfirm.aspx?province=" + province + "&account=" + account + "&cityName=" + cityName + "&bankName=" + bankName + "&bankType=" + bankType + "&otherBankName=" + otherBankName;
                
            });
        });

        $("#" + 'sel_city1').change(function () {
            var thisDom = $(this);
            $.ajax({
                url: "/ajaxCross/ajax_s1a2fe.ashx",
                type: "post",
                dataType: "json",
                data: "Cmd=getcity&province=" + thisDom.val(),
                success: function (d) {
                    if (d.result == "1") {
                        $('#sel_city2').html("");
                        for (var i = 0; i < d.list.length; i++) {
                            $('#sel_city2').append("<option value='" + d.list[i].CityName + "'>" + d.list[i].CityName + "</option>");
                        }
                        $('#sel_city2').change();
                    }
                }
            });
        });
    </script>
</body>
</html>
