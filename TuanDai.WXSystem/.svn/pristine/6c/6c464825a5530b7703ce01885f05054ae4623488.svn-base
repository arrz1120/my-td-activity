<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="binding_bannkcardconfirm.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.binding_bannkcardconfirm" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>手机验证</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/account.css?v=20160114" /><!--账户中心-->
<link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->

</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:history.go(-1);">返回</div>
            <h1 class="title">手机验证</h1>
            <%--<div class="text"><a href="recharge_record.html"></a></div>--%>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <section class="recordingBox clearfix">
		
        <div class="bg-bdTop-ccc clearfix numBox">
            <div class="c-212121 f14px text">持卡人</div>
            <div class="c-212121 f14px" style="margin-top: 1px;"><%= BusinessDll.StringHandler.MaskMiddlePlace(model.RealName,1,1) %></div>
        </div>
		
        <div class="clearfix numBox bt-dash-d1d1d1 ml15 bg-fff padding-reset">
            <div class="c-212121 f14px text l0">银行卡号</div>
            <div class="c-212121 f14px" style="margin-top: 1px;"><%=BusinessDll.StringHandler.MaskMiddlePlace(account,4,11) %></div>
        </div>
		
        <div class="clearfix numBox bt-dash-d1d1d1 ml15 bg-fff padding-reset">
            <div class="c-212121 f14px text l0">所属银行</div>
            <div class="c-212121 f14px" style="margin-top: 1px;"><%= bankName %></div>
        </div>
        
        <div class="wave_bg h15"></div>
        
        <div class="item pb15">
				<div class="itemRow1 clearfix">
					<div class="changeCard rf"><a href="/Member/Bank/about_changecard.aspx">换卡须知</a></div>
				</div>
			</div>
		
        <div class="bg-bdtopBom1-ccc numBox clearfix">
            <div class="text f14px">手机号</div>
            <input type="text" id="txtTelNo" readonly class="ipt f14px" name="" placeholder="请输入银行预留手机号码" value="<%= BusinessDll.StringHandler.MaskMiddlePlace(model.TelNo,3,4)%>"/>
        </div>
		
        <div class="bg-bdtopBom1-ccc numBox clearfix mt20">
            <div class="text f14px">验证码</div>
            <input type="text" class="ipt f14px" name="" id="txt_smsCode" placeholder="请输入短信验证码">
        	<input type="button" id="AddbtnSendMsg" class="btncode f12px" value="发送验证码" />
            <span style="font-size: 12px; color:Red; float:right; position:absolute; top: 10px; right:0px;" id="spTip"></span>
        </div>
        <div id="trError" style="display:none;" class="addcard_mx"></div>
        <div class="mt60 pl20 pr20">
	        <div class="btn btnYellow">提交</div>
        </div>
    </section>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
<script type="text/javascript" src="/scripts/Common.js?v=1"></script>
<script type="text/javascript" src="/scripts/jquery.extensions_code.js"></script>
<script type="text/javascript">
    
    $("#AddbtnSendMsg").click(function () {
        clearErr();
        $("body").showMessage({ message: "", showCancel: null, url: null });
        $("#btnSendMsg").unbind("click").click(function () {
            $("body").Close();
            sendMobileValidSMSCode("0");
        });
        $("#btnSendVoice").unbind("click").click(function () {
            $("body").Close();
            sendMobileValidSMSCode("1");
        });

        $("#btnCancel").click(function () {
            $("body").Close();
        });
    });

    var leftsecond = 180; //倒计时
    var msg = "";
    var timer = null;
    //获取手机验证码
    function sendMobileValidSMSCode(vtype,telNo) {
        
        $("#AddbtnSendVoiceMsg").hide();
        $("#AddbtnSendMsg").hide();
        $("#AddbtnSendMsg").attr("href", "javascript:void(0);");
        $("#AddbtnSendMsg").css("cursor", "default");
        $("#AddbtnSendMsg").css("text-decoration", "none");
        $('#spTip').html("发送中...");

        jQuery.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "getUsersMSCodeEditBank", vtype: vtype },
            success: function (json) {
                var result = json.result;
                leftsecond = 180;
                if (result == "1") {
                    //msg = "发送成功未收到";
                    clearInterval(timer);
                    timer = setInterval(setLeftTime, 1000, "1");
                    $("#AddbtnSendMsg").attr("href", "javascript:void(0);");
                    $("#AddbtnSendMsg").css("cursor", "default");
                    $("#AddbtnSendMsg").css("text-decoration", "none");
                    jQuery("#spTip").eq(0).show();
                }
                else {
                    //msg = "发送失败，";
                    clearInterval(timer);
                    timer = setInterval(setLeftTime, 1000, "1");
                    $("#AddbtnSendMsg").attr("href", "javascript:void(0);");
                    $("#AddbtnSendMsg").css("cursor", "pointer");
                }

            }
        });

    }

    function setLeftTime() {

        var second = Math.floor(leftsecond);
        jQuery("#spTip").eq(0).html(second + "秒后重新获取");
        leftsecond--;
        if (leftsecond < 1) {
            $("#AddbtnSendMsg").show();
            jQuery("#spTip").eq(0).hide();
            clearInterval(timer);
            try {
                $("#AddbtnSendMsg").attr("href", "javascript:void(0);");
                $("#AddbtnSendMsg").css("cursor", "pointer");
            } catch (E) { }
            return;
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

    var province = '<%= province%>';
    var account = '<%= account%>';
    var cityName = '<%= cityName%>';
    var bankName = '<%= bankName%>';
    var bankType = '<%= bankType%>';
    var otherBankName = '<%= otherBankName%>';
    $(".btnYellow").click(function () {
        clearErr();
        var smsCode = $("#txt_smsCode").val();
        if (smsCode.length < 6) {
            addErr("* 手机验证码至少6位");
            return false;
        }
        $.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: {
                Cmd: "addbankaccount", province: province,
                account: account, cityName: cityName,
                bankName: bankName, bankType: bankType, otherBankName: otherBankName, code: smsCode
            },
            success: function (json) {
                var d = json.result;
                var msg = json.msg;
                if (parseInt(d) == 1) {
                    //globalDialog("团贷网提醒您", "您好，银行卡添加成功！", "safety.aspx?userId=" + userId, "1");
                    location.href = "binding_card_suc.aspx";
                }
                else if (parseInt(d) == -1) {
                    addErr("添加失败：用户不存在！");
                    return false;
                } else if (parseInt(d) == -2) {
                    addErr("添加失败：" + msg);
                    return false;
                } else if (parseInt(d) == -3) {
                    addErr("添加失败：该银行账号已经绑定另一用户，不能再绑定！");
                    return false;
                }
                else if (parseInt(d) == -4) {
                    addErr("添加失败：每个用户最多添加1张银行卡！");
                    return false;
                }
            }
        });
    });
</script>
</body>
</html>
