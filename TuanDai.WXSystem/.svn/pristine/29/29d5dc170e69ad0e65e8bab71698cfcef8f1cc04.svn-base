<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BindMobileCode.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.BindMobileCode" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>绑定手机号码</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	<link rel="stylesheet" type="text/css" href="/css/range.css?v=20160305" />
	<link rel="stylesheet" type="text/css" href="/css/pay.css?v=20160305" />
    <style type="text/css">
        /*验证码弹窗*/
        .automaticwayBox{width:100%; background-color: #fff; padding-top: 5px;position: fixed; left: 0;  z-index: 1010; }
        .account-pop{width:100%; height: 150px;background: #fbfbf9; left: 0;bottom: 0;z-index: 110;text-align: center;}
        .account-pop a{display: block;width: 100%; height: 50px;line-height: 50px;}
        .pop-cn a{border-bottom:1px solid #d9d9d9;}
        .pt15{ padding-top: 15px !important;}
        .clearfix {zoom:1;}
        .clearfix:after{content:'.'; display:block; visibility:hidden; clear:both; height:0;}
        .f14px { font-size: 1.4rem !important;}
    </style>
</head>
<body class="bg-f6f7f8">
    <%= this.GetNavStr()%>
	<header class="headerMain">
	    <div class="header bb-c2c2c2">
	        <a class="back" href="BindMobile.aspx">返回</a>
	        <h1 class="title">绑定手机号码</h1>
	    </div>
        <%= this.GetNavIcon()%>
	    <div class="none"></div>
	</header>
	
	<div class="text-center">
		<div class="big-ico-box mt20">
			<img src="/imgs/images/big-ico03.png"/>
		</div>
		<p class="mt15 fb f17px c-212121">验证码已发送至<span class="c-fab600 f17px"><%= BusinessDll.StringHandler.MaskTelNo(tel)%></span></p>
		<p class="mt15 f13px c-999999">如果收不到验证码，请尝试使用<span class="f13px c-fd6040" id="btnSendVoiceCode">语音验证码</span></p>
	</div>
	
	<div class="clearfix inpBox4 bg-fff pt10 pb10 pl15 mt30 pos-r">
		<div class="lf f17px c-212121">验证码</div>
		<input type="text" class="lf f17px" placeholder="请输入验证码" id="txtCode"/>
		<a class="inp-btn-right f13px bg-ffcf1f c-ffffff pos-a" id="btnSendCode" href="javascript:void(0);">重新发送</a><!-- 60s后重发 : 背景class：bg-dddddd -->
        <span style="font-size: 12px; color:Red; float:right; position:absolute; top: 7px; right:5px;" id="Span2" class="spTip"></span> 
	</div>
	<div class="pl15 c-fd6040 f13px mt5" style="display: none;" id="d_error"><i class="state1"></i><span class="c-fd6040 f13px" id="MsgCodeErr">错误情况</span></div>
	<div class="pl15 pr15 mt30">
		<a class="btn btnYellow" id="btnSubmit">下一步</a>
	</div>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
<script type="text/javascript" src="/scripts/jquery.extensions_code.js"></script>
<script type="text/javascript">
    var tel = '<%= tel%>';
    //发送语音验证码按钮事件
    $("#btnSendVoiceCode").bind("click", function () {
        $("#d_error").hide();
        $.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "GetCodeByMobile", phoneNum: tel, vtype: '1' },
            success: function(data) {
                var status = parseInt(data.result);
                if (status == 1) {
                    $("#MsgCodeErr").text("语音验证码发送成功，请注意接听电话！");
                    $("#d_error").show();
                    return false;
                } else if (status == -100) {
                    $("#MsgCodeErr").text("系统繁忙：请重试！");
                    $("#d_error").show();
                    return false;
                } else {
                    $("#MsgCodeErr").text(data.msg);
                    $("#d_error").show();
                    return false;
                }
            }
        });
    });
    //重新发送按钮事件
    $("#btnSendCode").click(function () {
        $("body").showMessage({ message: "", showCancel: null, url: null });
        $("#btnSendMsg").unbind("click").click(function () {
            $("body").Close();
            $("#d_error").hide();
            sendMobileValidSMSCode("0");
        });
        $("#btnSendVoice").unbind("click").click(function () {
            $("body").Close();
            $("#d_error").hide();
            sendMobileValidSMSCode("1");
        });

        $("#btnCancel").click(function () {
            $("body").Close();
        });
    });
    //获取手机验证码
    //倒计时
    var leftsecond = 180;
    var msg = "";
    var timer = null;
    function sendMobileValidSMSCode(vtype) {
        $("#btnSendCode").hide();
        $("#MsgCodeErr").hide();
        $("#btnSendCode").attr("href", "javascript:void(0);");
        $("#btnSendCode").css("cursor", "default");
        $(".spTip").eq(0).html("短信发送中...");
        jQuery(".spTip").eq(0).show();
        jQuery.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "GetCodeByMobile", phoneNum: tel, vtype: vtype },
            success: function (json) {
                var result = json.result;
                leftsecond = 180;
                if (parseInt(result) == -100) { $("#MsgCodeErr").text("系统繁忙：请重试！"); $("#d_error").show(); return false; }
                
                if (parseInt(result) > 0) {
                    leftsecond = 180;
                    msg = "发送成功";
                    clearInterval(timer);
                    timer = setInterval(setLeftTime, 1000, "1");
                    $("#btnSendCode").attr("href", "javascript:void(0);");
                    $("#btnSendCode").css("cursor", "default");
                    $("#btnSendCode").css("text-decoration", "none");
                }
                else if (result == "-20") {
                    $("#btnSendCode").show();
                    jQuery(".spTip").eq(0).hide();
                    $("#MsgCodeErr").text(json.msg);
                    $("#d_error").show();
                    return false;
                }
                else {
                    leftsecond = 180;
                    msg = "发送失败，";
                    clearInterval(timer);
                    timer = setInterval(setLeftTime, 1000, "1");
                    $("#btnSendCode").attr("href", "javascript:void(0);");
                    $("#btnSendCode").css("cursor", "pointer");
                }
            }
        });
    }

    function setLeftTime() {
        var second = Math.floor(leftsecond);
        $(".spTip").eq(0).html(msg + second + "秒后可重发");
        leftsecond--;
        if (leftsecond < 1) {
            $("#btnSendCode").show();
            jQuery(".spTip").eq(0).hide();
            clearInterval(timer);
            try {
                $("#btnSendCode").attr("href", "javascript:void(0);");
                $("#btnSendCode").css("cursor", "pointer");
            } catch (E) { }
            return;
        }
    }
    //点击下一步
    $("#btnSubmit").bind("click", function () {
        $("#d_error").hide();
        var code = $("#txtCode").val().trim();
        if (code.length <= 0) {
            $("#MsgCodeErr").text("验证码不能为空");
            $("#d_error").show();
            return false;
        }
        jQuery.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "CheckPhoneCode", phoneNum: tel, code: code },
            success: function(json) {
                var status = parseInt(json.result);//-1不存在，-2超时 ，-3已使用过 ,1成功
                if (status == 1) {
                    //验证已通过
                    window.location.href = "SetPassword.aspx?tel=" + tel;
                }else if (status == -1) {
                    $("#MsgCodeErr").text("验证码错误");
                    $("#d_error").show();
                    return false;
                }else if (status == -2) {
                    $("#MsgCodeErr").text("验证码已超时，请重新获取");
                    $("#d_error").show();
                    return false;
                }else if (status == -3) {
                    $("#MsgCodeErr").text("验证码已使用过，请重新获取");
                    $("#d_error").show();
                    return false;
                } else {
                    $("#MsgCodeErr").text("系统繁忙，请重试");
                    $("#d_error").show();
                    return false;
                }
            }
        });
    });
</script>
</body>
</html>
