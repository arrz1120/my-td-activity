<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ValidateIdentity.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.ValidateIdentity" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>绑定身份证</title>
<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
<link rel="stylesheet" type="text/css" href="/css/pay.css?v=20160307" /> 
</head>
<body class="bg-f6f7f8">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-c2c2c2">
            <div class="back" onclick="javascript:history.go(-1);"></div>
            <h1 class="title">绑定身份证</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
    <div class="pl15 pr15 pt8 pb8">
    	<p class="line-h23 c-999999 f13px">绑定身份信息能保障您的合法权益，您的身份信息会用于投资合同签署、身份认证等。</p>
    </div>
    
    <div class="pl15 bg-fff bb-e6e6e6 bt-e6e6e6">
		<div class="pt10 pb10 bb-e6e6e6">
			<input class="inp f17px c-212121" type="text" placeholder="请输入真实姓名" id="txtRealName"/>
		</div>
    </div>
    
    <div class="pl15 mt15 bg-fff bb-e6e6e6 bt-e6e6e6">
		<div class="pt10 pb10 bb-e6e6e6">
			<input class="inp f17px c-212121" type="text" placeholder="请输入身份证号码" id="idcard"/>
		</div>
    </div>
	
	<div class="pl15 c-fd6040 f13px mt5" style="display: none;" id="d_error"><i class="state1"></i><span class="c-fd6040 f13px" id="ValidateIdentity1">错误情况</span></div>
	
	<div class="ml15 mr15 mt30">
		<div class="btn btnYellow" id="btnAdd">确定</div>
	</div> 
    
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>  
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/Common.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        var goUrl = "<%= goUrl%>";
        var rechargeMoney = "<%= rechargeMoney%>";
        var selectType = "<%= selectType%>";
        //身份证认证
        $(function () {
            $("#btnAdd").click(function () {
                setIdCard();
            });
            (function ($) {
                $.getUrlParam = function (name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                }
            })(jQuery);
        });
        //验证身份证
        function setIdCard() { 
            var txtRealName = jQuery.trim($('#txtRealName').val());
            var idcard = $.trim($('#idcard').val());
            var nickname = $.trim($("#txtNickName").val());
            var pat = new RegExp("^[\u4E00-\u9FA5A-Za-z0-9_]{2,12}$", "i");
            var isValidForm = true;
            if (txtRealName == '') {
                isValidForm = false;
                $('#ValidateIdentity1').html('请输入您的真实姓名');
                $("#d_error").show();
                return;
            }
            if (txtRealName.length < 2) {
                isValidForm = false;
                $('#ValidateIdentity1').html('真实姓名最少两位');
                $("#d_error").show();
                return;
            }
            //    if (/[^\u4e00-\u9fa5]/.test($.trim(txtRealName))) {
            //        isValidForm = false;
            //        $('#realnameErr').html('真实姓名只能为中文。');
            //        return;
            //    }
            if (idcard == '') {
                isValidForm = false;
                $('#ValidateIdentity1').html('请输入您的证件号码');
                $("#d_error").show();
                return;
            }
            else {
                var idcartValidResult = testIdcard($.trim(idcard));
                if (idcartValidResult.indexOf('通过') == -1) {
                    isValidForm = false;
                    $('#ValidateIdentity1').html(idcartValidResult);
                    $("#d_error").show();
                    return;
                }
                var testAgeResult = testAge($.trim(idcard));
                if (testAgeResult.indexOf('通过') == -1) {
                    isValidForm = false;
                    $('#ValidateIdentity1').html(testAgeResult);
                    $("#d_error").show();
                    return;
                }
            }

            if (isValidForm) {
                $('#ValidateIdentity1').html('');
                $("#d_error").hide();
            }
            else {
                return;;
            }
            $("body").showLoading("身份验证中，请稍候...");
            $.ajax({
                url: "/ajaxCross/ajax_s1a2fe.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "setidcard", realname: txtRealName, idcard: idcard, nickName: "", CredTypeId: "1", BirthDay: "", Sex: "" },
                success: function (json) {
                    $("body").hideLoading();
                    var data = parseInt(json.result);
                    var msg = json.msg;
                    if (data == -100) {
                        $("#ValidateIdentity1").html('系统繁忙，请稍后重试');
                        $("#d_error").show();
                    }
                    else if (data == -99) { window.location.href = "/user/login.aspx"; }
                    if (data == 1) {
                        $("#div_Identity").hide();
                        $("#div_Ok").show();
                        var pageType = GetQueryString("pageType");
                        if (pageType == "ready") {
                            window.location.href = "/Member/safety/bindBankCardNew.aspx?pageType=ready";
                            return false;
                        }
                        if (goUrl == "toRecharge") {
                            window.location.href = "/Member/Bank/Recharge.aspx?backurl=<%=backurl%>&rechargeMoney=" + rechargeMoney + "&selectType=" + selectType;
                        } else {
                            setTimeout("Ok()", 2500);
                        }
                        
                    } else if (data == 100) {
                        window.location = json.msg;
                    } else {
                        $("#ValidateIdentity1").html(json.msg);
                        $("#d_error").show();
                    }
                }
            });
        }

        function Ok() {
            var gobackurl = "<%= GoBackUrl%>";
            if (gobackurl != "") {
                window.location.href = gobackurl;
                return false;
            }
            window.location.href = "/Member/my_userdetailinfo.aspx#safe";
        }

        //验证身份证号方法
        var testIdcard = function (idcard) {
            idcard = idcard.toUpperCase();
            var Errors = new Array("验证通过!", "身份证号码位数不对!", "身份证号码出生日期超出范围!", "身份证号码校验错误!", "身份证地区非法!");
            var area = { 11: "北京", 12: "天津", 13: "河北", 14: "山西", 15: "内蒙古", 21: "辽宁", 22: "吉林", 23: "黑龙江", 31: "上海", 32: "江苏", 33: "浙江", 34: "安徽", 35: "福建", 36: "江西", 37: "山东", 41: "河南", 42: "湖北", 43: "湖南", 44: "广东", 45: "广西", 46: "海南", 50: "重庆", 51: "四川", 52: "贵州", 53: "云南", 54: "西藏", 61: "陕西", 62: "甘肃", 63: "青海", 64: "宁夏", 65: "xinjiang", 71: "台湾", 81: "香港", 82: "澳门", 91: "国外" }
            var idcard, Y, JYM;
            var S, M;
            var idcard_array = new Array();
            idcard_array = idcard.split("");
            if (area[parseInt(idcard.substr(0, 2))] == null) return Errors[4];
            switch (idcard.length) {
            case 18:
                if (parseInt(idcard.substr(6, 4)) % 4 == 0 || (parseInt(idcard.substr(6, 4)) % 100 == 0 && parseInt(idcard.substr(6, 4)) % 4 == 0)) {
                    ereg = /^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/; //闰年出生日期的合法性正则表达式 
                }
                else {
                    ereg = /^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/; //平年出生日期的合法性正则表达式 
                }
                if (ereg.test(idcard)) {
                    S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7 + (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9 + (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10 + (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5 + (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8 + (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4 + (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2 + parseInt(idcard_array[7]) * 1 + parseInt(idcard_array[8]) * 6 + parseInt(idcard_array[9]) * 3;
                    Y = S % 11;
                    M = "F";
                    JYM = "10X98765432";
                    M = JYM.substr(Y, 1);
                    if (M == idcard_array[17])
                        return Errors[0];
                    else
                        return Errors[3];
                }
                else
                    return Errors[2];
                break;
            default:
                return Errors[1];
                break;
            }
        }
        //验证是否成年
        var testAge = function (idcard) {
            var yy, mm, dd, age;
            //var now = new Date();
            var now = new Date(Date.parse("<%=DateTime.Now %>"));
            if (idcard.length == 18) {
                yy = idcard.substr(6, 4)
                mm = idcard.substr(10, 2)
                dd = idcard.substr(12, 2)
            } else {
                return "身份证号位数不对";
            }
            age = now.getFullYear() - yy;

            if (age > 18)
                return "通过";
            else if (age == 18) {
                if (mm < now.getMonth() + 1)
                    return "通过";
                else if (mm == now.getMonth() + 1)
                    if (dd <= now.getDate())
                        return "通过";
                    else
                        return "年龄不能小于18岁";
                else
                    return "年龄不能小于18岁";
            }
            else
                return "年龄不能小于18岁";

        }
    </script>
</body>
</html>