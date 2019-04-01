<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="account_bind.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.account_bind" %>
<%@ Import Namespace="TuanDai.WXApiWeb" %>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<meta name="format-detection" content="telephone=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<title>绑定团贷网账号</title>
		<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
		<link rel="stylesheet" type="text/css" href="/css/account2.css?v=<%=GlobalUtils.Version %>" />
        <!--账户中心-->
        <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
	</head>

	<body class="bg-f1f3f5">
	    <%= this.GetNavStr()%>
        <div style="display: none;"><%= this.GetNavIcon()%></div>
		<div class="inp-box bg-fff bt-e6e6e6 bb-e6e6e6" style="margin-bottom: 8px;">
			<span class="c-212121 f17px">手机号</span>
			<input type="text" placeholder="请输入手机号码" maxlength="11" id="phone">
		</div>
        <div class="inp-box bg-fff bt-e6e6e6 bb-e6e6e6">
			<span class="c-212121 f17px">验证码</span>
			<input type="text" placeholder="请输入短信验证码" id="code">
            <div class="sendCode" onclick="JAVASCRIPT:sendcode();" id="codestr">发送验证码</div>
            <div style="display: none;" class="sendCode" id="codestr1"></div>
			<div class="inp-err" style="display: none;">请输入短信验证码</div>
		</div>
		<div class="pl15 pr15 mt36">
			<a href="javascript:void(0);" class="btn btnYellow" id="bind">绑定</a>
		</div>
	</body>
	<script type="text/javascript" src="/scripts/jquery.min.js?v=<%=GlobalUtils.Version %>"></script>
	<script type="text/javascript" src="/scripts/fastclick.js?v=<%=GlobalUtils.Version %>"></script>
	<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/Common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>
	<script type="text/javascript">
	    function checkPhone(num) {
	        var length = num.length;
	        if (length == 11) {
	            return true;
	        } else {
	            return false;
	        }
	    }

	    function showErr(txt) {
	        var err = $(".inp-err");
	        err.html(txt).fadeIn();
	        setTimeout(function() {
	            err.fadeOut();
	        }, 2500);
	    }

	    $("#bind").click(function() {
	        var val = $("#phone").val();
	        var err = $(".inp-err");
	        if (val == '') {
	            showErr('请输入手机号码');
	        } else if (!checkPhone(val)) {
	            showErr('手机号格式不正确');
	        }
	        var code = $("#code").val();
	        if (code == '') {
	            showErr('验证码不能为空');
	        }
	        
	        $.ajax({
	            type: "post",
	            url: "account_bind.aspx?cmd=bind",
	            data: { mobilePhone: val,code:code },
	            dataType: "json",
	            async: false,
	            success: function (resp) {
	                if (parseInt(resp.result) == 1) {
	                    window.location.href = "account_bindsuc.aspx";
	                } else {
	                    showErr(resp.msg);
	                }
	            },
	            error: function () {
	                showErr("绑定失败");
	            }
	        });
	    });

	    function sendcode() {
	        var phone = $("#phone").val();
	        if (!checkPhone(phone)) {
	            showErr('手机号格式不正确');
	            return false;
	        } if (phone == '') {
	            showErr('请输入手机号码');
	            return false;
	        }
	        
	        $.ajax({
	            type: "post",
	            url: "account_bind.aspx?cmd=sendcode",
	            data: { mobilePhone: phone },
	            dataType: "json",
	            
	            async:false,
	            success: function (resp) {
	                if (parseInt(resp.result) == 1) {
	                    $("#codestr").hide();
	                    showErr("发送成功，3分钟后可重发");
	                    var s = 180;
	                    var inteid = setInterval(function () {
	                        s--;
	                        $("#codestr1").html("重发剩" + s + "秒");
	                        $("#codestr1").show();
	                        if (s <= 0) {
	                            $("#codestr").show();
	                            $("#codestr1").hide();
	                            clearInterval(inteid);
	                        }
	                        
	                    },1000);
	                } else {
	                    showErr(resp.msg);
	                }
	            },
	            error: function () {
	                showErr("发送失败");
	            }
	        });
	    }

	    
	</script>

</html>