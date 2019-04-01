<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="withdrawal_confirm.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.withdrawal.withdrawal_confirm" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>确认提现</title> 
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->

</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:window.location.href='/Member/my_account.aspx'">返回</div>
        <h1 class="title">确认提现</h1>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header>
 <section class="bg-bdtopBom1-ccc pd10 mt20 clearfix">
        <div class="phoneCode  pr0">
            <div class="c-left">密码</div>
            <input type="password" name="txtPassword" id="txtPassword" class="codeIpt" placeholder="请输入交易密码">
        </div> 
    </section>
    <section class="bg-bdtopBom1-ccc pd10 mt20 clearfix">
        <div class="phoneCode ">
            <div class="c-left">验证码</div>
            <input type="number" name="txtPhoneCode" id="txtPhoneCode"   maxlength="6"  class="codeIpt" placeholder="请输入短信验证码" onkeyup="this.value=this.value.replace(/\D/g,'')">
            <input type="button" id="btnSendMsgCode" class="btncode" value="发送验证码" />  
        </div> 
    </section>  
    <span style="font-size: 12px; color:Red; top: 10px; right:5px;" id="spTip" class="spTip"></span>

    <section class="pd15 mt5">
        <input type="hidden" id="currentMoeny"  value="<%=currentMoeny %>" />
        <a href="javascript:drawMoney();" class="btn btnYellow">确定</a>
        <a href="/Member/safety/ResetPayPwd.aspx" class="c-ff7357 f14px rf">忘记交易密码</a>
    </section>

<!--遮罩层-->
<div class="maskLayer hide"></div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script> 
<script type="text/javascript" src="/scripts/jquery.extensions_code.js"></script>     
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js"></script>
<script type="text/javascript">
    var withDrawMoney=<%=withDrawMoney%>;
    var couponAmount=<%=couponAmount%>;
    var drawType="<%=drawType%>";
    $(function () {
        $("#btnSendMsgCode").click(function () { 
            $("body").showMessage({ message: "", showCancel: null, url: null });
            $("#btnSendMsg").unbind("click").click(function () {
                $("body").Close();
                sendMobileValidSMSCode_dx("0");
            });
            $("#btnSendVoice").unbind("click").click(function () {
                $("body").Close();
                sendMobileValidSMSCode_dx("1");
            });

            $("#btnCancel").click(function () {
                $("body").Close();
            });
        });
    });
   
    //获取手机验证码
    //倒计时
    var leftsecond = 60;
    var msg = "";
    var timer = null;
    var applock = 0;
    function sendMobileValidSMSCode_dx(vtype) {    
        $("#btnSendMsgCode").val("短信发送中...");
        $("#btnSendMsgCode").attr('disabled', true);
        $("#btnSendMsgCode").addClass("disabled");
        jQuery.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "getUsersMSCode", vtype: vtype },
            success: function (json) {
                var result = json.result;
                leftsecond = 60;
                if (parseInt(result) == -100) { alert("系统繁忙，请刷新页面重试！"); }
                else if (parseInt(result) == -99) { window.location.href = "/user/login.aspx?ReturnUrl=" + window.location.href; }
                if (result == "1") {
                    leftsecond = 60;
                    msg = "";
                    clearInterval(timer);
                    timer = setInterval(setLeftTime, 1000, "1");   
                }
                else {
                    leftsecond = 60;
                    msg = "发送失败，";
                    clearInterval(timer);
                    timer = setInterval(setLeftTime, 1000, "1");  
                    $("#spTip").show();
                    $("#spTip").html("发送失败，60秒后可重发");
                }
            },
            error: function () {
                $("#btnSendMsgCode").attr('disabled', false);
                $("#btnSendMsgCode").removeClass("disabled"); 
                $("#spTip").show();
                $("#spTip").html("网络异常，请重试。"); 
                return false;
            }
        });
    } 

    function setLeftTime() {
        var second = Math.floor(leftsecond);
        $("#btnSendMsgCode").val(second + "秒后可重发"); 
        leftsecond--;
        if (leftsecond < 1) { 
            $("#btnSendMsgCode").val("发送验证码");
            $("#btnSendMsgCode").attr('disabled', false);
            $("#btnSendMsgCode").removeClass("disabled"); 
            clearInterval(timer);  
            $("#spTip").hide();
            return;
        }
    } 
    function funapplock(){
        applock = 0;
    }
    function drawMoney() { 
        if (parseInt(applock) > 0) {
            applock = parseInt(applock) + 1;
            alert("您好，提交过于频繁.连续提现要超过1分钟,请稍后重试！");
            if (parseInt(applock) == 1) {
                window.setTimeout("funapplock()", 60000);
            }
            return;
        }
        applock = 1;
        if ($("#txtPassword").val().length < 1) {
            alert("您好，请输入交易密码后再点击确认提现！");
            applock = 0;
            return;
        }
        var txtPhoneCode = jQuery("#txtPhoneCode").val();
        if ($("#txtPhoneCode").val() == "") {
            alert("您好，验证码不能为空！");
            applock = 0;
            return;
        }
      

        if (parseFloat(withDrawMoney) <= parseFloat($("#currentMoeny").val()) && $("#txtPassword").val().length > 0 && parseFloat(withDrawMoney) > 0) {
            //正式提交提现申请
            $.ajax({
                url: "/ajaxCross/ajax_s1a2fe.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: 'drawdespoint', amount: withDrawMoney, pwd: $("#txtPassword").val(), checkcode: txtPhoneCode, couponAmount: couponAmount,drawType:drawType},
                success: function (json) {
                    handlerWithdraw(json);
                }
            }); 
        }
    }

    function handlerWithdraw(json) {
        var d = json.result;
        applock = 0;
        if (parseInt(d) == -100) { alert("系统繁忙：请重试！"); return; }
        else if (parseInt(d) == -99) { window.location.href = "/user/login.aspx?ReturnUrl=" + window.location.href; }
        else if (parseInt(d) > 0) {
            window.location.href = "/Member/withdrawal/withdrawal_suc.aspx?drawtype="+drawType;
        } else if (parseInt(d) == 0) {
            alert("申请提现失败：请重试！");
            return;
        } else if (parseInt(d) == -2) {
            alert("申请提现失败：查询好帮贷信息时出错,请稍后重试！");
            return;
        } else if (parseInt(d) == -3) {
            alert("申请提现失败：可用资金不足，请确认在好帮贷有净值标？");
            return;
        } else if (parseInt(d) == -4) {
            alert("申请提现失败：好帮贷用户冻结失败,请稍后重试。");
            return;
        } else if (parseInt(d) == -5) {
            alert("好帮贷账户资金解冻失败,请联系团贷网客服。");
            return;
        } else if (parseInt(d) == -10) {
            alert("提现失败:您的用户已经被冻结。");
            return;
        } else if (parseInt(d) == -11) {
            alert("提现失败:" + json.msg);
            return;
        } else if (parseInt(d) == -23) {
            alert("提现失败:该帐户已经冻结。");
            return;
        } else if (parseInt(d) == -24) {
            alert("提现失败:单笔提现已经达到上限。");
            return;
        } else if (parseInt(d) == -25) {
            if (json.msg == '0') {
                alert("提现失败:今日交易密码已错误5次，请24小时后再进行此操作！");
                return;
            }
            else {
                alert("提现失败:交易密码错误，今日还有" + json.msg + "次机会，错误5次将锁定24小时！");
                return;
            }

        }
        else if (parseInt(d) == -251) {
            alert("提现失败:今日交易密码已错误5次，请24小时后再进行此操作！");
            return;
        }
        else if (parseInt(d) == -26) {
            alert("您好，提现金额必须大于0。");
            return;
        } else if (parseInt(d) == -1) {
            alert("申请提现失败：可用资金不足。");
            return;
        } else if (parseInt(d) == -51) { 
            alert("失败:要提现,请先完善银行帐号。");
            location.href = "/Member/safety/binding_bannkcard.aspx";
        } else if (parseInt(d) == -52) {
            alert("为保障您的资金安全，请先进行首次安全设置，再进行本操作。点击确定后转到首次安全设置。");
            location.href = "/Member/safety/safety.aspx";
        } else if (parseInt(d) == -110) {
            alert("申请提现失败：还有未还的逾期本息及滞纳金。");
            return;
        }
        else if (parseInt(d) == -299) {
            alert("申请提现失败：多张银行卡不允许提现。");
            return;
        }
        else if (parseInt(d) == -300) {
            alert("申请提现失败：银行卡在审核中不允许提现。");
            return;
        }
        else if (parseInt(d) == -301) {
            alert("申请提现失败：银行卡审核不通过不允许提现。");
            return;
        }
        else if (parseInt(d) == -302) {
            alert("申请提现失败：银行卡信息异常。");
            return;
        }else if(parseInt(d) == -49){
            alert("优惠券不存在!");
            return;
        }
        else {
            alert("申请提现失败：请重试。");
            return;
        }
    }
</script>

</body>
</html>
