<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Recharge.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Bank.Recharge" %>

<%@ Import Namespace="Tool" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>充值</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/account2.css?v=20160517" />
    <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <style type="text/css">
        /**弹窗******************************************/
        .popup {
            width: 100%;
            height: 100%;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 500;
            background: rgba(0,0,0,0.3);
            display: -webkit-box;
            -webkit-box-pack: center;
            -webkit-box-align: center;
        }

        .popupCont {
            width: 80%;
            height: auto;
            padding: 20px 15px 30px 15px;
            -webkit-border-radius: 8px;
            border-radius: 8px;
            background-color: #fff;
            position: fixed;
            top: 30%;
            left: 50%;
            margin-left: -40%;
            z-index: 600;
        }

            .popupCont .title {
                text-align: center;
                font-size: 1.5rem;
                color: #666;
                line-height: 110%;
                margin-bottom: 20px;
            }

            .popupCont .contBox {
                color: #666;
                font-size: 1.2rem;
                line-height: 150%;
                min-height: 40px;
                padding: 0;
            }

            .popupCont .inputBox {
                padding: 10px 80px 10px 5px;
                margin-top: 10px;
                position: relative;
                z-index: 50;
            }

            .popupCont .ipt {
                width: 100%;
                height: 20px;
                line-height: 20px;
                border: 0;
                background: none;
                font-size: 1.2rem;
                color: #ababab;
            }

            .popupCont .btncode {
                display: block;
                width: 90px;
                height: 28px;
                line-height: 28px;
                color: #fac502;
                font-size: 1.2rem;
                text-align: center;
                box-shadow: none;
                border-style: none;
                background: #fff;
                border: 1px solid #fbc503;
                -webkit-border-radius: 4px;
                border-radius: 4px;
                position: absolute;
                top: 7px;
                right: 5px;
            }

            .popupCont .disabled {
                color: #797979;
                background: #d0d0d0;
                border-color: #d0d0d0;
            }

        .mask {
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,.5);
            position: fixed;
            top: 0;
            left: 0;
            z-index: 510;
        }
        /*充值弹框*/
        .hide {
            display: none;
        }

        .popup .popupCon {
            background: #fff;
            width: 85%;
            text-align: center;
            border-radius: 8px;
        }

            .popup .popupCon h2 {
                height: 60px;
                line-height: 60px;
                color: #212121;
                font-size: 1.6rem;
            }

            .popup .popupCon .table {
                padding: 0 10px;
            }

                .popup .popupCon .table table {
                    width: 100%;
                    border: 1px solid #d1d1d1;
                }

                .popup .popupCon .table th {
                    padding: 10px 0;
                    border-bottom: 1px solid #e6e6e6;
                    background: #fffdf5;
                    color: #694514;
                    font-size: 1.1rem;
                }

                .popup .popupCon .table td {
                    padding: 10px 0;
                    border-bottom: 1px solid #e6e6e6;
                    font-size: 1.1rem;
                    color: #212121;
                }

                .popup .popupCon .table tr.bg-fcfcfc td {
                    background: #fcfcfc !important;
                }

                .popup .popupCon .table tr .br-e6e6e6 {
                    border-right: 1px solid #e6e6e6;
                }

        .popup .iKnow {
            height: 40px;
            line-height: 40px;
            color: #fff;
            background: #ffcf1f;
            font-size: 1.4rem;
            border-bottom-left-radius: 8px;
            border-bottom-right-radius: 8px;
        }

        @media only screen and (max-width: 320px) {
            .popup .popupCon .table th {
                padding: 6px 0;
                font-size: 1rem;
            }

            .popup .popupCon .table td {
                padding: 6px 0;
                font-size: 1rem;
            }
        }
        
        .rc-tips{ position: relative; padding-left: 38px;}
		.rc-tips em{ font-size: 12px; color: #ababab; position: absolute;left: 0;top: 0;}
        
    </style>
</head>
<body class="bg-f1f3f5">
    <%= this.GetNavStr()%>
    <div class="clearfix pl15 pr15 pt10 pb10">
        <div class="lf f12px c-808080">
            可用资金<span class="c-212121 f15px ml15">￥<%=ToolStatus.ConvertLowerMoney(AviMoney)%></span>
        </div>
        <div class="rf f12px c-1fcafb" onclick="javascript:window.location.href='/Member/Bank/Rechagehistory.aspx';">充值记录&nbsp;></div>
    </div>
    <div class="inputBox bg-fff bt-e6e6e6 bb-e6e6e6">
        <span class="c-212121 f17px">金额</span>
        <input type="number" placeholder="最低充值金额<%=ToolStatus.DeleteZero(MinRechargeAmount)%>元" id="t_money" value="<%=rechargeMoney >0 ?rechargeMoney.ToString():"" %>" onblur="testAmount()" />
    </div>
    <div class="mt15 bt-e6e6e6 bb-e6e6e6 bg-fff pl15 pr15">
        <% if (GlobalUtils.IsWeiXinBrowser && !GlobalUtils.IsOpenCGT)
           { %>
        <div class="clearfix pt15 pb15">
            <div class="lf payType f15px"><span paytype="1" class="selectBox <%=DefPayType==1?"selected":"" %>"><i></i></span>微信支付</div>
            <div class="rf f12px c-1fcafb" id="showTable">限额说明&nbsp;></div>
        </div>
        <% } %>
        <div class="pt15 pb15 bt-e6e6e6">
            <p class="payType f15px">
                <span paytype="2" class="selectBox <%=DefPayType==2?"selected":"" %>"><i></i></span>
                <%=string.IsNullOrEmpty(bankNo)?"未绑卡":bankName+bankNo.Right(4)%>
            </p>
            <p class="f12px c-ababab pl12 ml20">
                <% if (!string.IsNullOrEmpty(bank.BankDesc))
                   {
                %>
                    (<%= bank.BankDesc%>)
                <%
                   }
                   else
                   {
                       if (bank.IsBankMaintain)
                       { %>
                      (该银行卡正在维护中,无法获取额度)
                    <%}
                       else
                       { %>
                      (限额：<%=bank.SingleAmt%>/ 笔，<%=bank.DayAmt%>/天)
                    <%}
                   } %>
            </p>
        </div>
    </div>

    <div class="mt30 pl15 pr15">
        <div class="btn btnYellow" id="confirmRecharge">下一步</div>
        <%--<p class="f12px c-ababab text-justify mt10 rc-tips"><em>（1）</em>如果您的充值资金用于还款，请暂停<span class="f12px c-1fcafb" onclick="javascript:window.location.href='<%=GlobalUtils.MTuanDaiURL %>/Member/setAuto/auto_invest.aspx';">自动投标</span>；</p>--%>
		<p class="f12px c-ababab text-justify mt5">充值资金不投标需等<span class="c-fd6040 f12px">15天</span>后才能提现，<span class="c-fd6040 f12px">23:45</span>分至次日<span class="c-fd6040 f12px">00:45</span>分为银行对账时间，建议避开该时段充值，以免出现到账延迟。 <a href="recharge_question.aspx" class="f12px c-1fcafb">更多常见问题&gt;</a></p>
    </div>

    <!--弹出层 S-->
    <section class="popup hide" id="popupTable">
        <div class="popupCon">
            <h2>限额说明</h2>
            <div class="table">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <th class="br-e6e6e6">单笔/单日限额</th>
                        <th>银行</th>
                    </tr>
                    <tr>
                        <td class="br-e6e6e6">5万/5万</td>
                        <td>中信、平安、浦发</td>
                    </tr>
                    <tr class="bg-fcfcfc">
                        <td class="br-e6e6e6">4万/4万</td>
                        <td>光大</td>
                    </tr>
                    <tr>
                        <td class="br-e6e6e6">3万/3万</td>
                        <td>招行、广发</td>
                    </tr>
                    <tr class="bg-fcfcfc">
                        <td class="br-e6e6e6">2万/2万</td>
                        <td>民生</td>
                    </tr>
                    <tr>
                        <td class="br-e6e6e6">1万/5万</td>
                        <td>工商</td>
                    </tr>
                    <tr>
                        <td class="br-e6e6e6">1万/1万</td>
                        <td>中国、建设、交行</td>
                    </tr>
                    <tr>
                        <td class="br-e6e6e6">5千/1万</td>
                        <td>兴业</td>
                    </tr>
                    <tr class="bg-fcfcfc">
                        <td class="br-e6e6e6" style="border-bottom: 0;">5千/5千</td>
                        <td style="border-bottom: 0;">农行、储蓄</td>
                    </tr>
                </table>
            </div>
            <div class="iKnow mt10">我知道了</div>
        </div>

    </section>



    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=GlobalUtils.Version %>"></script>

    <script type="text/javascript">
        var rechareLianLianlock = 0;
        var rechareBaofulock = 0;
        var thirdPayType = "<%=ThirdPayType%>";
        var payMethod = "<%=DefPayType%>";//付款方式
        var MinRecharge = parseFloat("<%=MinRechargeAmount%>");
        var vailStatus = "<%= vailStatus%>";

        $(function () {
            var strmsg = "";
            if (parseInt(vailStatus) == 0) {
                strmsg = "为保障您的资金安全，请先进行身份认证和设置交易密码，再进行本操作。点击确定后转到安全中心。";
                $("body").showMessage({
                    message: strmsg, okString: "确定", showCancel: true, okbtnEvent: function () {
                        if (isOpenCGT == "1") {
                            window.location.href = "/Member/safety/pre_invest.aspx";
                        } else {
                            window.location.href = "/Member/safety/safety.aspx";
                        }

                    }
                });
            } else if (parseInt(vailStatus) == 1) {
                strmsg = "为保障您的资金安全，请先进行身份认证，再进行本操作。点击确定后转到身份认证。";
                $("body").showMessage({
                    message: strmsg, okString: "确定", showCancel: true, okbtnEvent: function () {
                        window.location.href = "/Member/safety/ValidateIdentity.aspx";
                    }
                });
            } else if (parseInt(vailStatus) == 3) {
                strmsg = "为保障您的资金安全，请先进行手机认证，再进行本操作。点击确定后转到手机认证。";
                $("body").showMessage({
                    message: strmsg, okString: "确定", showCancel: true, okbtnEvent: function () {
                        window.location.href = "/Member/safety/ValidateMobile.aspx";
                    }
                });
            }
            else if (parseInt(vailStatus) == 5) {
                strmsg = "充值需绑定本人持有的银行卡。";
                var url = "/Member/Bank/recharge_bindCardagreement.html?v=20160312001";
                if (isOpenCGT == "1") {
                    url = "/Member/cgt/cgtBindCard.aspx";
                }
                $("body").showMessage({
                    message: strmsg, okString: "马上绑定", showCancel: true, okbtnEvent: function () {
                        window.location.href = url;
                    }
                });
            } else if (parseInt(vailStatus) == -1) {
                if (isOpenCGT == "1") {
                    $("body").showMessage({
                        message: "您填写的预留手机号码有误，请修改后再进行充值",
                        okString: "马上修改",
                        okbtnEvent: function () {
                            $.ajax({
                                url: "/ajaxCross/ajax_cgt.ashx",
                                type: "post",
                                dataType: "json",
                                data: { Cmd: "MODIFY_MOBILE_Req" },
                                success: function (json) {
                                    var status = parseInt(json.result);
                                    if (status == 1) {
                                        window.location.href = unescape(json.msg);
                                    }
                                },
                                error: function () {
                                    window.location.href = window.location.href;
                                }
                            });
                        }
                    });
                }
            } else if (parseInt(vailStatus) == -2) { //未开通存管
                $("body").showMessage({
                    message: "您的账号还未开通存管",
                    okString: "立即升级",
                    okbtnEvent: function () {
                        window.location.href = "/Member/cgt/openCgt.aspx";
                    }
                });
            }
            $("#t_money").bind("keyup", function () {
                $this = $(this);
                $this.val($this.val().toString().replace(/[^(\d|\.)]+/, ""));
            });

            $('#confirmRecharge').click(function () {
                if (identity() == false) {
                    return false;
                }
                if (parseInt(rechareLianLianlock) > 0) {
                    $("body").showMessage({ message: "您好,提交过于频繁.连续提交需要超过10秒,请稍后重试!", showCancel: false });
                    return false;
                }
                if (BlurMoney1() && parseInt(rechareLianLianlock) == 0) {
                    var amount = $("#t_money").val();
                    try {
                        //-------存管通验证---2016-12-21----
                        if (isOpenCGT == "1" && !checkIsOpen("recharge"))
                            return false;
                        //-------存管通验证结束----------
                    } catch (e) {

                    }

                    if (payMethod == "2") { //银行卡充值
                         <%if (string.IsNullOrEmpty(bankNo)){%>
                        //未绑卡时
                        if (isOpenCGT == "1") {
                            window.location.href = "/Member/safety/bindBankCardNew.aspx";
                        } else {
                            window.location.href = "/Member/Bank/recharge_bindCardagreement.html?v=20160312001";
                        }
                        return false;
                        <%}%>
                        $("body").showLoading("充值中...");
                        setTimeout("frecharelock(" + rechareLianLianlock + ");", 10000);
                        if (isOpenCGT != "1") {
                            if (thirdPayType == "eb") {
                                $.get("/PaymentPlatform/EB/ebPlainPay.aspx?action=getebpaycheck&Amount=" + amount,
                                    function (result) {
                                        $("body").hideLoading();
                                        if (result.result == "1") {
                                            var jsonObj = jQuery.parseJSON(result.msg);
                                            var href = "/PaymentPlatform/EB/ebConfirmPay.aspx?Amount=" +
                                                amount +
                                                "&isbind=" +
                                                jsonObj.IsBindCard +
                                                "&OrderId=" +
                                                jsonObj.OrderId +
                                                "&RequestId=" +
                                                jsonObj.RequestId;
                                            window.location.href = href;
                                        } else {
                                            $("body").showMessage({ message: result.msg, showCancel: false });
                                        }
                                    });
                            } else {
                                $("body").hideLoading();
                                var href = "/Member/Bank/account_lianlian_pay.aspx?Amount=" + amount + "&Sel=8";
                                window.location.href = href;
                            }
                            return;
                        } else {
                            window.location.href = "account_cgt_pay.aspx?Amount=" + amount + "&bankno=<%=Tool.DESC.Encrypt(bankNo)%>";
                     }
                 } else {//微信支付 
                     if (isOpenCGT == "1") {
                         $("body").showMessage({ message: "开通存管后不支持微信支付", showCancel: false });
                     } else {
                         setTimeout("frecharelock(" + rechareLianLianlock + ");", 10000);
                         callWXPay();
                     }
                 }
                 return true;
             }
                rechareLianLianlock = 0;
                return false;
            });
            $("#showTable").click(function () {
                $("#popupTable").removeClass('hide');
            });
            $(".iKnow").click(function () {
                $("#popupTable").addClass('hide');
            });
            $(".selectBox").click(function () {
                payMethod = $(this).attr("paytype");
                $(".selectBox").removeClass('selected');
                $(this).addClass('selected');
            });
        });
     function testAmount() {
         var money = $("#t_money").val();

         if (money == '') {
             $("body").showMessage({ message: "请输入充值金额，如1063.20", showCancel: false });
             return false;
         }
         if (!(/^\d+(.)?\d{1,2}$/.test($("#t_money").val()))) {
             $("body").showMessage({ message: "请输入正确的充值金额，如1063.20", showCancel: false });
             $("#t_money").val(parseFloat(money).toFixed(2));
             return false;
         }
         if (parseFloat(money) < parseFloat(MinRecharge)) {
             $("body").showMessage({ message: "最小充值金额为" + MinRecharge, showCancel: false });
             return false;
         }

         return true;
     }
     function frecharelock(obj) {
         rechareLianLianlock = 0;
     }
     function identity() {
         var IsValidateIdentity = '<%=this.IsValidateIdentity %>';
            if (IsValidateIdentity == 'False') {
                alert("你还没有进行实名认证，连连充值必须进行实名认证");
                window.location.href = "/Member/safety/ValidateIdentity.aspx";
                return false;
            }
            return true;
        }

        function BlurMoney1() {
            var money = $("#t_money").val();
            if (isNaN(money)) {
                $("body").showMessage({ message: "充值金额输入格式错误", showCancel: false });
                return false;
            }
            if (money == "") {
                $("body").showMessage({ message: "充值金额不能为空", showCancel: false });
                return false;
            }
            if (parseFloat(money) < parseFloat(MinRecharge)) {
                $("body").showMessage({ message: "最小充值金额为" + MinRecharge, showCancel: false });
                return false;
            }
            if (!(/^\d+(.)?\d{1,2}$/.test($("#t_money").val()))) {
                $("body").showMessage({ message: "请输入正确的充值金额，如1063.20", showCancel: false });
                $("#t_money").val(parseFloat(money).toFixed(2));
                return false;
            }
            if (parseFloat(money) > 500000) {
                $("body").showMessage({ message: "单笔充值金额最大为500,000", showCancel: false });
                return false;
            }
            return true;
        }
    </script>
    <script type="text/javascript" src="/scripts/recharge.js?v=<%=GlobalUtils.Version%>"></script>
</body>
</html>
