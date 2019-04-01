<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bindBankCardNew.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.bindBankCardNew" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>绑定银行卡</title>
<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
<link rel="stylesheet" type="text/css" href="/css/pay.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</head>
<body class="bg-f6f7f8">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-c2c2c2">
            <div class="back" onclick="javascript:history.go(-1);"></div>
            <h1 class="title">绑定银行卡</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <div class="pl15 pr15 pt8 pb8">
    	<p class="line-h23 c-999999 f13px">绑定银行卡主要用于充值和提现，每个账号只能绑定一张银行卡。(请绑定本人持有的银行卡)</p>
    </div>
    
    <div class="pl15 bg-fff bb-e6e6e6 bt-e6e6e6">
		<div class="pt10 pb10 pos-r pl92 bb-e6e6e6">
			<span class="c-212121 f17px pos-a l0">持卡人</span>
			<input class="inp f17px c-212121" type="text" placeholder="请输入持卡人名字" value="<%= RealName %>" readonly/>
		</div>
		<div class="pt10 pb10 pos-r pl92">
			<span class="c-212121 f17px pos-a l0">手机号</span>
			<input class="inp f17px c-212121" type="text" placeholder="请输入银行预留手机号" value="<%= TelNo %>" readonly/>
		</div>
    </div>
    
    <div class="mt15 bb-e6e6e6"></div>
    <div class="pl15 bg-fff bb-e6e6e6">
		<div class="pt10 pb10 pos-r pl92 bg-fff">
			<span class="c-212121 f17px pos-a l0">银行卡号</span>
			<input class="inp f17px c-212121" type="text" placeholder="请输入银行卡号" id="txt_bankCard"   onkeyup="this.value=this.value.replace(/\D/g,'')"/>
		</div>
	</div>	
	
	<div class="pl15 c-fd6040 f13px mt5"><i class="state1"></i>请勿绑定信用卡! 不支持使用信用卡充值</div>
	
	<div class="ml15 mr15 mt30">
		<div class="btn btnYellow" id="btnSubmit">确定</div>
	</div>
	
	<a href="/html/App/bank_list.html?type=weixinapp" class="block c-ff6040 f13px text-center text-underline mt50">支持银行卡列表</a>
	
	<!--弹框-->
	<!--无法识别该卡号弹框-->
	<div class="alert webkit-box box-center" style="display: none;" id="alert1">
		<div class="bbc-alert-box">
			<div class="c-212121 f15px pt30 pb30 text-center" id="msg1">无法识别该卡号，请使用其它银行卡!</div>
			<div class="text-center f17px c-ffc61a bt-e6e6e6 pt13 pb13" id="sure1">我知道了</div>
		</div>
	</div>
	<!--确认信息弹框-->
	<div class="alert webkit-box box-center" style="display: none;" id="alert2">
		<div class="bbc-alert-box">
			<div class="fb f17px text-center pt30 pb20">请确认信息</div>
			<div class="f15px c-212121 bbc-alert-center">卡号<span class="ml25 c-212121 f15px" id="sp_cardNo">1234  3546  2345  7683  456</span></div>
			<div class="f15px c-212121 bbc-alert-center">银行<span class="ml25 c-212121 f15px" id="sp_bankName">招商银行</span></div>
			<div class="f13px c-808080 bbc-alert-center pt20 pb20">请确保银行卡信息准确，否则无法进行充值或提现。</div>
    		<div class="webkit-box bt-e6e6e6 mt25">
    			<div class="box-flex1 text-center f17px c-808080 pt10 pb13 br-e6e6e6" id="cancel2">取消</div>
    			<div class="box-flex1 text-center f17px c-ffc61a pt10 pb13" id="sure2">确定</div>
    		</div>
		</div>
	</div> 
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/Common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        var rechargeMoney = "<%= rechargeMoney%>";
        var selectType = "<%= selectType%>";
        $(document).ready(function () {
            var vailStatus = '<%=vailStatus %>';
            var strmsg = "";
            var returnurl = "";
            //if (parseInt(vailStatus) == 0) {
            //    strmsg = "为保障您的资金安全，请先进行身份认证和设置交易密码，再进行本操作。点击确定后转到安全中心。";
            //    alert(strmsg);
            //    window.location.href = "/Member/my_userdetailinfo.aspx#safe";
            //} else
            if (parseInt(vailStatus) == 1) {
                strmsg = "为保障您的资金安全，请先进行身份认证，再进行本操作。点击确定后转到身份认证。";
                alert(strmsg);
                window.location.href = "ValidateIdentity.aspx";
            } else if (parseInt(vailStatus) == 3) {
                strmsg = "为保障您的资金安全，请先进行手机认证，再进行本操作。点击确定后转到手机认证。";
                alert(strmsg);
                window.location.href = "ValidateMobile.aspx";
            }
            //else if (parseInt(vailStatus) == 2) {
            //    strmsg = "为保障您的资金安全，请先进行首次交易密码设置，再进行本操作。点击确定后转到首次交易密码设置。";
            //    alert(strmsg);
            //    window.location.href = "/Member/safety/reset_password.aspx";
            //}
        });

        var cardType = "0";
        var bankCode = "0";
        var cardBound = "false";
        var cardNo = "";
        var isCheck = false;
        $("#txt_bankCard").bind("blur", function () {
            cardNo = $("#txt_bankCard").val().trim();
            if (cardNo.length <= 0) {
                $("#alert1 #msg1").html("银行卡号不能为空");
                $("#alert1").show();
                return false;
            }
            $("body").showLoading("验证中，请稍候……");
            $.ajax({
                url: "/ajaxCross/ajax_userbank.ashx",
                type: "post",
                dataType: "json",
                async: false,   //同步
                data: { Cmd: "GetBankBin", CardNo: cardNo },
                success: function (json) {
                    $("body").hideLoading();
                    var result = json.status;
                    if (result == "1") {
                        if (json.model.card_type == "3") {
                            $("#alert1 #msg1").html("暂不支持信用卡，请重新输入");
                            $("#alert1").show();
                            return false;
                        }
                        if (json.model.card_bound == "true") {
                            $("#alert1 #msg1").html("卡号已绑定另一用户");
                            $("#alert1").show();
                            return false;
                        }
                        cardType = json.model.card_type;
                        bankCode = json.model.bank_code;
                        cardBound = json.model.card_bound;
                        $("#alert2 #sp_cardNo").html(json.model.card_no);
                        $("#alert2 #sp_bankName").html(json.model.bank_name);
                        isCheck = true;
                    }
                    else if (result == "-2") {
                        cardType = "0";
                        bankCode = "0";
                        cardBound = "false";
                        $("#alert1 #msg1").html("手机支付不支持该卡，请换其他卡号");
                        $("#alert1").show();
                    } else {
                        cardType = "0";
                        bankCode = "0";
                        cardBound = "false";
                        $("#alert1 #msg1").html("无法识别卡号，请输入正确的银行卡卡号");
                        $("#alert1").show();
                    }
                }
            });
        });
        $("#sure1").click(function () {
            $("#alert1").hide();
        });
        //点击确定
        $("#sure2").click(function () {
            $("#alert2").hide();
            $.ajax({
                url: "/ajaxCross/ajax_userbank.ashx",
                type: "post",
                dataType: "json",
                data: {
                    Cmd: "addsimplebankaccount",
                    account: cardNo,
                    bankType: bankCode
                },
                success: function (json) {
                    var d = json.result;
                    var msg = json.msg;

                    if (parseInt(d) == 1) {
                        //绑定成功
                        $("#alert1 #msg1").html("银行卡绑定成功");
                        $("#alert1").show();
                        $("#sure1").bind("click", function () {
                            $("#alert1").hide();
                            var pageType = GetQueryString("pageType");
                            if (pageType == "ready") {
                                window.location.href = "/Member/ready/complete.aspx";
                                return false;
                            }
                            var gobackurl = "<%= GoBackUrl%>";
                            if (gobackurl != "") {
                                window.location.href = gobackurl;
                                return false;
                            }
                            if (selectType != "" && rechargeMoney != "") {
                                window.location.href = "/Member/Bank/Recharge.aspx?rechargeMoney=" + rechargeMoney + "&selectType=" + selectType;
                                return false;
                            }
                            location.href = "/Member/my_userdetailinfo.aspx#safe";
                        });

                    }
                    else if (parseInt(d) == -1) {
                        $("#alert1 #msg1").html("添加失败：用户不存在");
                        $("#alert1").show();
                        return false;
                    } else if (parseInt(d) == -2) {
                        //验证码过期
                    } else if (parseInt(d) == -3) {
                        $("#alert1 #msg1").html("卡号已绑定另一用户");
                        $("#alert1").show();
                        return false;
                    }
                    else if (parseInt(d) == -4) {
                        $("#alert1 #msg1").html("添加失败：每个用户最多添加1张银行卡");
                        $("#alert1").show();
                        return false;
                    }
                    else if (parseInt(d) == -5) {
                        $("#alert1 #msg1").html("无法识别卡号，请输入正确的银行卡卡号");
                        $("#alert1").show();
                        return false;
                    }
                    else if (parseInt(d) == -9 || parseInt(d) == -10) {
                        $("#alert1 #msg1").html("添加失败：" + msg);
                        $("#alert1").show();
                        return false;
                    }
                }
            });
        });
        //取消
        $("#cancel2").click(function () {
            $("#alert2").hide();
        });
        //提交按钮
        $("#btnSubmit").click(function () {
            //var telNo = $("#txt_telNo").val().trim();
            //if (telNo.length <= 0) {
            //    $("#alert1 #msg1").html("手机号码不能为空");
            //    $("#alert1").show();
            //    return false;
            //}
            var cardNo = $("#txt_bankCard").val().trim();
            if (cardNo.length <= 0) {
                $("#alert1 #msg1").html("银行卡号不能为空");
                $("#alert1").show();
                return false;
            }
            if (!isCheck) {
                $("#alert1 #msg1").html("银行卡号未通过验证");
                $("#alert1").show();
                return false;
            }
            $("#alert2").show();
        });
    </script>
</body>
</html>
