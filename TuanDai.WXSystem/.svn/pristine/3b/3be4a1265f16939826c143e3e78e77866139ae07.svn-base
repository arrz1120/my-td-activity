<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mobile_change_step2.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.mobile_change_step2" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>绑定手机号码</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/cunguan.css?20161220001" />
</head>
<body class="bg-f1f3f5">
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header bb-c2c2c2">
            <div class="back" onclick="javascript:history.go(-1);">返回</div>
            <h1 class="title">绑定手机号码</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>

    <div class="step clearfix bg-fff">
        <div class="w50p lf text-center">
            <span>1</span>验证原手机号码
        </div>
        <div class="w50p lf text-center stepActive">
            <span>2</span>绑定新手机号码
        </div>
        <i class="arrow1"></i>
    </div>

    <div class="bg-fff mt10">
        <div class="inputBox webkit-box bb-e6e6e6">
            <div class="inpName">新手机号码</div>
            <div class="inp">
                <input id="txtTelNo" type="text" placeholder="请输入新手机号码" /></div>
        </div>
        <div class="inputBox webkit-box bb-e6e6e6 bt-e6e6e6">
            <div class="inpName">验证码</div>
            <div class="inp">
                <input id="txtCode" type="text" placeholder="请输入验证码" /></div>
            <a id="btnSendCode" href="javascript:void(0);" class="supportBank f12px" onclick="sendcode()">发送验证码</a>
        </div>
    </div>

    <div class="pl15 pr15 pt20">
        <a id="btnGo" href="javasript:void(0);" class="btn btnYellow" onclick="gonext()">绑定新手机号码</a>
    </div>

    <script type="text/javascript" src="/scripts/jquery.min.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/fastclick.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script>
        var _codeTimeLeft = 180;
        var _codeInterval;

        //发送验证码
        function sendcode() {
            var telNo = $("#txtTelNo").val();
            if (ValidateTelNo(telNo)) {
                $("#btnSendCode").attr("onclick", "");
                $.ajax({
                    url: "/ajaxCross/ajax_s1a2fe.ashx",
                    type: "post",
                    dataType: "json",
                    data: {
                        Cmd: "SendNewMobileValidateCode",
                        phoneNum: telNo,
                        type: 0
                    },
                    success: function (json) {
                        $("#btnSendCode").attr("onclick", "sendcode()");
                        var d = json.result;
                        if (parseInt(d) == -100) {
                            $("body").showMessage({ message: "发送失败，系统错误！", showCancel: false });
                            return;
                        }
                        if (parseInt(d) == -99) {
                            $("body").showMessage({
                                message: "发送失败，登陆失效，请重新登陆！",
                                showCancel: false,
                                okbtnEvent: function () {
                                    location.href = "/user/Login.aspx";
                                }
                            });
                            return;
                        }
                        if (parseInt(d) > 0) {
                            _codeTimeLeft = 180;
                            $("#btnSendCode").attr("onclick", "");
                            _codeInterval = setInterval(function () {
                                if (_codeTimeLeft <= 0) {
                                    clearInterval(_codeInterval);
                                    $("#btnSendCode").attr("onclick", "sendcode(0)").text("发送验证码");
                                    return;
                                }

                                $("#btnSendCode").text(_codeTimeLeft + "s重新发送");
                                _codeTimeLeft--;
                            }, 1000);
                        }
                        else if (d == "-20") {
                            $("body").showMessage({ message: "此号码已使用，请更换！", showCancel: false });
                            return;
                        }
                        else {
                            if (parseInt(json.result) == -180) {
                                $("body").showMessage({ message: "发送验证码间隔需180秒！", showCancel: false });
                                return;
                            } else {
                                $("body").showMessage({ message: json.msg, showCancel: false });
                                return;
                            }

                        }
                    },
                    error: function () {

                        $("#btnSendCode").attr("onclick", "sendcode()");
                    }
                });
            }
        }
        //验证码格式验证
        function ValidateCode(code) {
            if (code == "" || code == "undefined") {
                $("body").showMessage({ message: "验证码不能为空！", showCancel: false });
                return false;
            }
            if (code.length != 6) {
                $("body").showMessage({ message: "验证码需为6位！", showCancel: false });
                return false;
            }
            if (isNaN(code)) {
                $("body").showMessage({ message: "验证码必须为数字！", showCancel: false });
                return false;
            }
            return true;
        }
        //手机号格式验证
        function ValidateTelNo(telno) {
            var phoneRegex = /^(?:13\d|14\d|15\d|17\d|18\d)\d{5}(\d{3}|\*{3})$/;
            if (telno == "" || telno == "undefined") {
                $("body").showMessage({ message: "手机号码不能为空！", showCancel: false });
                return false;
            }
            if (!phoneRegex.test(telno)) {
                $("body").showMessage({ message: "手机号码格式不正确！", showCancel: false });
                return false;
            }
            return true;
        }
        //下一步
        function gonext() {
            var telNo = $("#txtTelNo").val();
            var code = $("#txtCode").val();
            if (ValidateCode(code) && ValidateTelNo(telNo)) {
                MidifyMobileNumber(code, telNo);
            }
        }

        //修改手机号.
        function MidifyMobileNumber(checkcode, moblieTel) {
            $("#btnGo").attr("onclick", "");
            $.ajax({
                url: "/ajaxCross/ajax_s1a2fe.ashx",
                type: "post",
                dataType: "json",
                data: "Cmd=ModifyPhoneByVerifyCode&checkcode=" + checkcode + "&tel=" + moblieTel + "&originalcode=<%=Request.QueryString["originalcode"]%>",
            success: function (jsondata) {
                $("#btnGo").attr("onclick", "gonext()");
                var d = jsondata.result;
                var msg = jsondata.msg;
                if (parseInt(d) == -99) {
                    $("body").showMessage({
                        message: "发送失败，登陆失效，请重新登陆！",
                        showCancel: false,
                        okbtnEvent: function () {
                            location.href = "/user/Login.aspx";
                        }
                    });
                    return;
                }
                if (parseInt(d) > 0) {
                    location.href = "mobile_change.aspx";
                }
                else {
                    if (d == "-4") {
                        $("body").showMessage({ message: "好帮贷已经存在该电话号码，请更换手机号码！", showCancel: false });
                        return;
                    }
                    if (d == "-5") {
                        $("body").showMessage({ message: "好帮贷接口出现异常，请跟客服联系！", showCancel: false });
                        return;
                    }
                    if (d == "-311") {
                        $("body").showMessage({ message: "验证码已过期！", showCancel: false });
                        return;
                    }
                    if (d == "-310") {
                        $("body").showMessage({ message: "验证码已使用,请重新获取！", showCancel: false });
                        return;
                    }

                    if (d == "-309") {
                        $("body").showMessage({ message: "验证码不正确，请重新输入！", showCancel: false });
                        return;
                    }
                    if (d == "-308") {
                        $("body").showMessage({ message: "参数异常！", showCancel: false });
                        return;
                    }

                    if (d == "0") {
                        $("body").showMessage({ message: "系统繁忙，请重新输入！", showCancel: false });
                        return;
                    }
                    if (d == "-7") {
                        $("body").showMessage({ message: msg, showCancel: false });
                        return;
                    }
                }
            },
            error: function () {
                $("#btnGo").attr("onclick", "gonext()");
            }
        });
    }
    </script>
</body>
</html>
