<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register_ValidateIdentity.aspx.cs"
    Inherits="TuanDai.WXApiWeb.user.Register_ValidateIdentity" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>身份认证</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
    <link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--base-->
    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js"></script>
    <style type="text/css">
       /*验证中样式*/
        .loadAlert{position: fixed;top: 0;left: 0;width: 100%;height: 100%;z-index: 99;}
        .loadTips{width: 80%;height: 80px;padding: 10px 0;background: rgba(0,0,0,0.7);position: absolute;left: 10%;top: 50%;
            margin-top: -40px;z-index: 99;border-radius: 6px;}
        .loadTips .loadingCirle{width: 40px;height: 40px;background: url('/imgs/images/loadingPic.png') no-repeat;background-size: 40px 40px;
                float: left;margin: 10px 15px 0 15px;-webkit-animation: loading .5s linear infinite;}
        .loadTips .yan{position: absolute;left: 25px;top: 30px;width:20px;-webkit-animation: loadingRotate 1s linear infinite;}
        .loadTips .loadTips_txt h3{color: #fff;font-size: 1.4rem;margin-top: 15px;}
        .loadTips .loadTips_txt p{font-size: 1rem;color: #dbdbdb;}
        @-webkit-keyframes loading {
            from { -webkit-transform:rotate(0deg) translateZ(0); }
            to { -webkit-transform:rotate(360deg) translateZ(0); }
        }
        @-webkit-keyframes loadingRotate {
            from { -webkit-transform:rotateY(0deg) translateZ(0); }
            to { -webkit-transform:rotateY(360deg) translateZ(0); }
        } 
    </style>
    <script type="text/javascript">
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
            $("#ValidateIdentity1").html("");
            var txtRealName = jQuery.trim($('#txtRealName').val());
            var idcard = $.trim($('#idcard').val());
            var nickname = $.trim($("#txtNickName").val());
            var pat = new RegExp("^[\u4E00-\u9FA5A-Za-z0-9_]{2,12}$", "i");
            var isValidForm = true;
            if (txtRealName == '') {
                isValidForm = false;
                $('#realnameErr').html('请输入您的真实姓名。');
                return;
            }
            if (txtRealName.length < 2) {
                isValidForm = false;
                $('#realnameErr').html('真实姓名最少两位。');
                return;
            }
            //    if (/[^\u4e00-\u9fa5]/.test($.trim(txtRealName))) {
            //        isValidForm = false;
            //        $('#realnameErr').html('真实姓名只能为中文。');
            //        return;
            //    }
            if (idcard == '') {
                isValidForm = false;
                $('#idcardErr').html('请输入您的证件号码。');
                return;
            }
            else {
                var idcartValidResult = testIdcard($.trim(idcard));
                if (idcartValidResult.indexOf('通过') == -1) {
                    isValidForm = false;
                    $('#idcardErr').html(idcartValidResult);
                    return;
                }
                var testAgeResult = testAge($.trim(idcard));
                if (testAgeResult.indexOf('通过') == -1) {
                    isValidForm = false;
                    $('#idcardErr').html(testAgeResult);
                    return;
                }
            }

            if (isValidForm) {
                $('#realnameErr').html('');
                $('#idcardErr').html('');
            }
            else {
                return;
            }
            $("#dvPopmsg").show();
            $.ajax({
                url: "/ajaxCross/ajax_s1a2fe.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "setidcard", realname: txtRealName, idcard: idcard, nickName: "", CredTypeId: "1", BirthDay: "", Sex: "" },
                success: function (json) {
                    $("#dvPopmsg").hide();
                    var data = parseInt(json.result);
                    var msg = json.msg;
                    if (data == -100) { $("#ValidateIdentity1").html('系统繁忙，请稍后重试') }
                    else if (data == -99) { window.location.href = "/user/login.aspx"; }
                    if (data == 1) {
                        $("#div_Identity").hide();
                        $("#div_Ok").show();
                        setTimeout("Ok()", 2500);
                    } else {
                        $("#ValidateIdentity1").html(json.msg);
                        return;
                    }
                }
            });
        }

        function Ok() {
            window.location.replace("Register_TradePassWord.aspx?ReturnUrl=<%=returnUrl %>");
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
</head>
<body>
    <header class="headerMain2">
        <div class="header">
            <h1 class="title">身份认证</h1>
            <div class="text"><a href="javascript:;" onclick="location.replace('<%=this.returnUrl == ""?"/index.aspx":this.returnUrl %>')">跳过</a></div>
        </div>
        <div class="none"></div>
    </header>
    <section class="flow-wrap">
        <div class="flow-pic pos-r">
            <p class="flow1 pos-a text-center f13px c-ababab">
                <span class="on"></span>
                身份证认证
            </p>
            <p class="flow2 pos-a text-center f13px c-ababab">
                <span></span>
                设置交易密码
            </p>
            <p class="flow3 pos-a text-center f13px c-ababab">
                <span></span>
                绑定银行卡
            </p>
        </div>
    </section>
    <section class="bg-bdtopBom1-d1d1d1 pl15 mt20 clearfix">
        <div class="pt10 pb10 bb-e6e6e6">
            <div class="phoneCode pr0">
                <div class="c-left">姓名</div>
                <input type="text" id="txtRealName" name="txtRealName" class="codeIpt" onchange='jQuery("#realnameErr").html("")' placeholder="请输入真实姓名" maxlength="20">
            </div>
        </div>
        <span class="verification-3" style="color: red;" id="realnameErr"></span>
        <div class="pt10 pb10">
            <div class="phoneCode pr0">
                <div class="c-left">身份证</div>
                <input type="text" id="idcard" name="idcard" class="codeIpt" placeholder="请输入身份证号码" maxlength="18" onchange='jQuery("#idcardErr").html("")'>
            </div>
        </div>
        <span class="verification-3" style="color: red;" id="idcardErr"></span>
    </section>
        <span class="verification-3" style="color: Red; margin-left:10px;" id="ValidateIdentity1"></span>
    <section class="pd15 mt15">
        <a href="javascript:void(0);" id="btnAdd" class="btn btnYellow">下一步</a>
    </section>
    <section class="pd15 mt60 text-center">
        <%if (TuanDai.WXApiWeb.GlobalUtils.IsWeiXinBrowser)
      {%>
        <p class="c-ababab f14px">如有疑问，请联系客服：<a href="tel:1010-1218#mp.weixin.qq.com" class="inline-block c-f86420 txt-uline f14px">1010-1218</a></p>
        <%}
        %>
        <%else 
        {%>
            <p class="c-ababab f14px">如有疑问，请联系客服：<a href="tel:1010-1218" class="inline-block c-f86420 txt-uline f14px">1010-1218</a></p>
        <%}
        %>
    </section>

  <div class="loadAlert" style="z-index:1000; display: none;" id="dvPopmsg">
    <div class="loadTips">
        <div class="loadingCirle"></div>
        <div class="yan"><img src="/imgs/images/loaduser.png" alt="" /></div>
        <div class="loadTips_txt"><h3>身份验证中，请稍候...</h3></div>
    </div>
 </div>
</body>
</html>
