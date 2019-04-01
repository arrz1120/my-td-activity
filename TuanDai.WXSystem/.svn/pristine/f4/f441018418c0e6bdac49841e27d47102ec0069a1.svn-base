<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BindMobile.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.BindMobile" %>

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
</head>
<body class="bg-f6f7f8">
    <%= this.GetNavStr()%>
	<header class="headerMain">
	    <div class="header bb-c2c2c2">
	        <div class="back" onclick="javascript:history.go(-1);">返回</div>
	        <h1 class="title">绑定手机号码</h1>
	    </div>
        <%= this.GetNavIcon()%>
	    <div class="none"></div>
	</header>
	
	<div class="text-center">
		<div class="big-ico-box mt20">
			<img src="/imgs/images/big-ico01.png"/>
		</div>
		<p class="mt15 fb f17px c-212121">绑定手机号码</p>
		<p class="mt15 f13px c-999999">手机号码主要用于登录、收取验证码以及回款提</p>
		<p class="f13px c-999999">醒等，是保障您资金安全的重要凭证。</p>
	</div>
	
	<div class="clearfix inpBox4 bg-fff pt10 pb10 pl15 mt30">
		<div class="lf f17px c-212121">手机号码</div>
		<input type="text" class="lf f17px" placeholder="请输入手机号码" id="txtMobileTelNo" maxlength="11"  onKeyUp="value=value.replace(/\D/g,'')" onafterpaste="value=value.replace(/\D/g,'')"/>
	</div>
	<div class="pl15 c-fd6040 f13px mt5" style="display: none;" id="d_error"><i class="state1"></i><span class="c-fd6040 f13px" id="MsgCodeErr">错误情况</span></div>
	<div class="pl15 pr15 mt30">
		<a class="btn btnYellow" id="btnSubmit">下一步</a>
	</div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
<script>
    //点击下一步
    $("#btnSubmit").click(function () {
        if (!ValidateMobilerNumber()) {
            return false;
        }
        $.ajax({
            url: "/ajaxCross/ajax_s1a2fe.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "BindMobilePhone", phoneNum: $("#txtMobileTelNo").val(), vtype: '0' },
            success: function (jsondata) {
                var d = parseInt(jsondata.result);
                var msg = jsondata.msg;
                if (d == -100) {
                    $("#MsgCodeErr").text("系统繁忙：请重试！");
                    $("#d_error").show();
                    return false;
                }else if (d == 1) {
                    //手机号码未注册，成功发送验证码
                    window.location.href = "BindMobileCode.aspx?tel=" + $("#txtMobileTelNo").val();
                } else if (d == -38) {
                    //手机号码已注册
                } else {
                    $("#MsgCodeErr").text(msg);
                    $("#d_error").show();
                    return false;
                }

            }
        });
    });

    /*手机号码验证*/
    function ValidateMobilerNumber() {
        var mobileNumber = $("#txtMobileTelNo").val();
        var phoneRegex = /^(?:13\d|14\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$/
        if (mobileNumber == "") {
            $("#MsgCodeErr").text("手机号码不能为空");
            $("#d_error").show();
            return false;
        }
        else if (!phoneRegex.test(mobileNumber)) {
            $("#MsgCodeErr").text("输入手机号码格式不正确");
            $("#d_error").show();
            return false;
        }
        else {
            $("#d_error").hide();
            return true;
        }
    };
</script>
</body>
</html>