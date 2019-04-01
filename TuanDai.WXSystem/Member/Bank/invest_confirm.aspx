<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="invest_confirm.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Bank.invest_confirm" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>确认投资</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/pay.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</head>
<body class="bg-fff">
<%= this.GetNavStr()%>
    <div class="text-center">
        <p class="pt33 f15px c-808080">投资金额</p>
        <p class="mt5 f36px pt10 pb15">￥<%=ToolStatus.ConvertLowerMoney(PayMoney) %></p>
        <% if(PrizeId.HasValue && PrizeId!=Guid.Empty){ %>
        <p class="mt10 f13px c-212121">使用<span class="c-212121 ml15"><%=PrizeName %></span></p>
        <%} %>
        <p class="c-ababab f13px mt30">（账户余额：<%= ToolStatus.ConvertLowerMoney(AviMoney) %>）</p>
    </div>
    <%
           
        if (AviMoney < PayMoney) //余额不足，充值
        {
    %>
    <div class="noMoney_tips">账户余额不足，需要充值￥<%= ToolStatus.ConvertLowerMoney(Math.Ceiling(PayMoney - AviMoney)) %></div>
    <div class="pl15 pr15 pt40 mt30">
        <div class="btn btnYellow" id="btnRecharge">确定</div>
    </div>
    <%
       }
       else //余额足，投资
       {
    %>
    <% if (IsShowMobileCode)
       {
           %>
    <div class="pl15 pr15 pay-code">
        <div class="input-code pos-r mt25 mb10">
			<input type="text" placeholder="请输入验证码" class="f17px" id="MobileCode">
			<a class="c-fab600 f17px get-code pos-a" id="GetCode">获取验证码 </a>
			<p class="c-ff7357 f13px pos-a tips mt5" style="display: none;" id="CodeError"><span class="mr5"></span>验证码错误</p>
		</div>
    </div>
    <%
       } %>
    
    <% if (userSetting != null && userSetting.IsTenderNeedPayPassword && !TuanDai.WXApiWeb.GlobalUtils.IsOpenCGT)
       {
    %>
    <div class="i_c">
        <div class="i_b" id="psdBox">
            <input type="password" placeholder="请输入交易密码" id="txtTransPwd"/>
            <div class="eye-box webkit-box box-center" id="btnSee">
                <i class="i_close"></i>
            </div>
        </div>
        <div class="clearfix mt5">
            <div class="lf c-fd6040 f13px" id="d_errorMsg" style="display: none;">
                <i class="state1"></i>交易密码错误
            </div>
            <a class="rf c-fd6040 f13px" href="/Member/safety/ResetPayPwd.aspx">忘记密码？</a>
        </div>
    </div>
    <%
           } %>
    <div class="pl15 pr15 mt20">
		<div class="btn btnYellow" id="btnOk">确定</div>
	</div>
    <%
       } %>
</body>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript">
    //交易密码显示隐藏
    $("#btnSee").click(function () {
        var $psd = $("#psdBox").find('input');
        var eye = $(this).find('i');
        if ($psd.attr('type') == 'password') {
            eye.removeClass('i_close').addClass('i_open');
            $psd.attr('type', 'text');
        } else {
            eye.removeClass('i_open').addClass('i_close');
            $psd.attr('type', 'password');
        }
    });
    var checkCount = 0;
    var profitMoneyStr = "<%= ProfitMoney%>";
    $("#d_errorMsg").hide();
    var isInvest = true;
    //点击确定按钮事件
    $("#btnOk").bind("click", function () {
        if (!isInvest) {
            $("body").showMessage({ message: "不能重复购买", showCancel: false });
            return false;
        }
        isInvest = false;
        $("#d_errorMsg").hide();
        
        if ("<%= userSetting.IsTenderNeedPayPassword && !TuanDai.WXApiWeb.GlobalUtils.IsOpenCGT%>" == "True") {
            var pwd = $("#txtTransPwd").val();
            if (pwd.length <= 0) {
                $("#d_errorMsg").html('<i class="state1"></i>交易密码不能为空');
                $("#d_errorMsg").show();
                return false;
            }
        } else {
            var pwd = "";
        }

        if ('<%=investType%>' == "project") {
            $("body").showLoading("投资中...");
            $.ajax({
                url: "/ajaxCross/InvestAjax.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "addloan", bid: '<%= projectId%>', tendAmount: '<%= PayMoney%>', TranPwd: pwd, unit: '<%= unit%>',code:$("#MobileCode").val(),prizeid:"<%=PrizeId%>" },
                success: function (json) {
                    if (json.result == "-999") {
                        checkCount = 0;
                        AsyncGetBuyProjectStutas("<%=projectId%>", "<%=PayMoney%>", "<%=unit%>", json);
                    }else if (json.result == "-11") {
                        $("body").hideLoading();
                        $("body").showMessage({ message: json.msg, showCancel: false,okbtnEvent:function() {
                            window.location.href = '/Member/safety/safety.aspx';
                        } });
                        return false;
                    } else if (json.result == "-111") {
                        $("body").hideLoading();
                        $("#CodeError").html('<span class="mr5"></span>'+json.msg).show();
                        return false;
                    } else if (json.result == "8888") {//存管通
                        location.href = unescape(json.msg);
                    }
                    else if (json.result != "1") {
                        $("body").hideLoading();
                        $("body").showMessage({ message: json.msg, showCancel: false });
                        return false;
                    } else {
                        $("body").hideLoading();
                        //申购成功
                        window.location.href = "/pages/invest/invest_success.aspx?projectid=<%= projectId%>&payMoney=<%= PayMoney%>&profitMoney=<%= ProfitMoney%>&investType=project" +
                                                "&PrizeId=<%=PrizeId%>"; 
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("body").hideLoading();
                    $("body").showMessage({ message: "系统繁忙：请重试", showCancel: false });
                    return false;
                }
            });
    } else if ('<%=investType%>' == "weplan") {
            $("body").showLoading("投资中...");
            $.ajax({
                url: "/ajaxCross/InvestAjax.ashx",
                type: "post",
                async: true,
                dataType: "json",
                data: { Cmd: "BuyWePlan", ProductId: '<%= projectId%>', BuyQty: '<%= unit%>', TranPwd: pwd, RepeatInvestType: '<%= RepeatInvestType%>', PrizeId: "<%=PrizeId%>" },
                success: function (json) {
                    if (json.result == "-999") {
                        checkCount = 1;
                        setTimeout(AsyncGetBuyWePlanStutas(json,1),3000);
                    } else if (json.result == "-6") {
                        $("body").hideLoading();
                        $("body").showMessage({ message: "未通过实名认证", showCancel: false,okbtnEvent:function() {
                            window.location.href = '/Member/safety/ValidateIdentity.aspx';
                        } });
                        return false;
                    }
                    else if (json.result == "-12") {
                        $("body").hideLoading();
                        $("body").showMessage({
                            message: "未通过手机验证", showCancel: false, okbtnEvent: function () {
                                window.location.href = '/Member/safety/ValidateMobile.aspx';
                            }
                        });
                        return false;
                    }
                    else if (json.result == "-13") {
                        $("body").hideLoading();
                        $("body").showMessage({ message: "您已成功购买过加息标，请明天再来抢加息标。", showCancel: false });
                        return false;
                    }
                    else if (json.result == "-14") {
                        $("body").hideLoading();
                        $("body").showMessage({ message: "您最多可加入" +<%= SetModel.Param4Value%> +"元，请重新设置加入份数。", showCancel: false });
                        return false;
                    } else if (json.result == "1") {
                        $("body").hideLoading(); 
                        //购买成功
                        window.location.href = "/pages/invest/invest_success.aspx?projectid=<%= projectId%>&payMoney=<%= PayMoney%>&profitMoney=<%= ProfitMoney%>&investType=weplan&PrizeId=<%=PrizeId%>";
                    } else if (json.result == "8888") {//存管通
                        location.href = json.msg;
                    } else {
                        $("body").hideLoading();
                        $("body").showMessage({ message: json.msg, showCancel: false });
                        return false;                       
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("body").hideLoading();
                    $("body").showMessage({ message: "系统繁忙：请重试", showCancel: false });
                    return false;
                }
            });
        }

        setInterval(function () {
            isInvest = true;
        }, 3000);
    });
//点击充值按钮事件
$("#btnRecharge").bind("click", function () {
    var backurl = "<%= GetEncodeBackUrl()%>";
        var IsValidateIdentity = "<%= userModel.IsValidateIdentity%>";
        var rechargeMoney = '<%= ToolStatus.ConvertLowerMoney(PayMoney - Math.Floor(AviMoney)) %>';
        rechargeMoney = parseFloat(rechargeMoney.replace(/\,/g, ""));
        var selectType = 2;
        if (IsValidateIdentity == "False") {//身份验证未通过
            window.location.href = "/Member/safety/ValidateIdentity.aspx?backurl=" + backurl + "&goUrl=toRecharge&rechargeMoney=" + rechargeMoney + "&selectType=" + selectType;
            return false;
        }
        window.location.href = "Recharge.aspx?rechargeMoney=" + rechargeMoney + "&selectType=" + selectType + "&backurl=" + backurl;
    });

    //异步请求申购结果
    function AsyncGetBuyProjectStutas(id, tendValue, nowUnit, jsonData) {
        var d = jsonData.result;
        var msg = jsonData.msg;
        var subscribeId = jsonData.msg.split("|")[1];
        $.ajax({
            url: "/ajaxCross/InvestAjax.ashx",
            type: "post",
            dataType: "json",
            cache: false,
            data: { Cmd: "GetSubscribeStatus", subscribeId: subscribeId },
            success: function (json) {
                if (json.result == "-998") {
                    setTimeout(function () { setLeftTime(id, tendValue, nowUnit, jsonData, json.msg); }, 3000);
                } else if (json.result == "1") {
                    $("body").hideLoading();
                    //申购成功
                    window.location.href = "/pages/invest/invest_success.aspx?projectid=<%= projectId%>&payMoney=<%= PayMoney%>&profitMoney=<%= ProfitMoney%>&investType=project&prizeId=<%=PrizeId%>";
                } else {
                    $("body").hideLoading();
                    $("body").showMessage({ message: json.msg, showCancel: false });
                }
            }
        });
}
function setLeftTime(id, tendValue, nowUnit, jsonData, errMsg) {
    if (checkCount < 3) {
        AsyncGetBuyProjectStutas(id, tendValue, nowUnit, jsonData);
        checkCount++;
    }
    else {
        $("body").hideLoading();
        $("body").showMessage({
            message: "投标失败，请稍后再试!", showCancel: false, okbtnEvent: function () {
                window.location.href = "/pages/invest/invest_fail.aspx?projectid=<%= projectId%>&payMoney=<%= PayMoney%>&investType=project&error=" + errMsg;
                }
            });
        }
    }
    //=============We计划
    //异步请求购买we计划结果
    function AsyncGetBuyWePlanStutas(jsonData,checkCount) {
        var weOrderId = jsonData.msg.split("|")[1];
        $.ajax({
            url: "/ajaxCross/InvestAjax.ashx",
            type: "post",
            dataType: "json",
            cache: false,
            data: { Cmd: "GetBuyWeplanStatus", weOrderId: weOrderId, checkCount: checkCount },
            success: function (json) {
                if (json.result == "-998") {
                    //2秒后再执行一次查询
                    setTimeout(function () { AsyncGetBuyWePlanStutasAgain(jsonData, json.msg); }, 3000);

                } else if (json.result == "1") {
                    $("body").hideLoading();
                    //申购成功
                    window.location.href = "/pages/invest/invest_success.aspx?projectid=<%= projectId%>&payMoney=<%= PayMoney%>&profitMoney=<%= ProfitMoney%>&investType=weplan&prizeId=<%=PrizeId%>";
                } else {
                    $("body").hideLoading();
                    $("body").showMessage({ message: json.msg, showCancel: false });
                }
            }
        });
}
//再一次请求购买we计划结果 
function AsyncGetBuyWePlanStutasAgain(jsonData, errMsg) {
    if (checkCount < 3) {
        checkCount++;
        AsyncGetBuyWePlanStutas(jsonData,checkCount);
    }
    else {
        $("body").hideLoading();
        $("body").showMessage({
            message: "购买失败，请稍后再试...", showCancel: false, okbtnEvent: function () {
                window.location.href = "/pages/invest/invest_fail.aspx?projectid=<%= projectId%>&payMoney=<%= PayMoney%>&investType=weplan&error=" + errMsg;
                }
            });
        }
}

    //发送验证码
    var ctime = 0;
    $("#GetCode").bind("click", function () {
        if (ctime > 0) {
            return;
        }
        ctime = 60;
        //MobileCode
        $.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: {
                Cmd: "GetCodeByZQZR"
            },
            success: function (json) {
                if (json.result == "1") {
                    $("#MobileCode").attr('placeholder', "验证码发送成功");
                    $("#CodeError").hide();
                    var timeSub = setInterval(function () {
                        ctime--;
                        $("#GetCode").html(ctime + "s");
                        if (ctime < 1) {
                            $("#GetCode").html("发送验证码");
                            $("#MobileCode").attr('placeholder', "请输入验证码");
                            clearInterval(timeSub);
                        }
                    }, 1000);
                } else {
                    if (json.result == "-190") {
                        $("body").showMessage({ message: "您今天的验证码已用完，请您明天再来抢债权转让标~" ,showCancel:false,okbtnEvent:function() {
                            window.location.href = '/pages/invest/WE/WE_list.aspx';
                        }});
                    } else if (json.result == "-180") {
                        $("#CodeError").html('<span class="mr5"></span>您当前操作过于频繁，请' + json.msg.substr(json.msg.indexOf("_")+1, json.msg.length - json.msg.indexOf("_")-1) + 's后再来操作').show();
                    }
                    $("#GetCode").html("发送验证码");
                    $("#MobileCode").attr('placeholder', json.msg);
                    ctime = 0;
                }
            }
        });
    });
</script>
</html>
