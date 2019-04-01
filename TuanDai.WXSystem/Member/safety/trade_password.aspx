<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="trade_password.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.safety.trade_password" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>交易密码 - 我的账户</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/safety.css?v=20160331001" />
    <!--安全中心-->
    <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
</head>
<body class="bg-f6f7f8">
    <%= this.GetNavStr() %>
    <header class="headerMain">
    <div class="header bb-e6e6e6">
        <div class="back" onclick="javascript:window.location.href='safety.aspx';">返回</div>
        <h1 class="title">交易密码</h1>
    </div>
    <%= this.GetNavIcon() %>
    <div class="none"></div>
    </header>
    <section class="tradePsdBox mt15">
       <div class="pl15 pr15 pt8 pb8 clearfix bb-e6e6e6 bt-e6e6e6 bg-fff">
       	<div class="p-left">
       		<p class="f17px c-212121">交易密码：<b class=""><%= IsTenderNeedPayPassword.Value ? "开启" : "关闭" %></b></p>
       		<p class="f12px c-ababab">进行投标时是否需要输入交易密码</p>
       	</div>
       	<div class="states">
	        <input type="checkbox" class="switch" name="openpsw" id="openpsw" <%= IsTenderNeedPayPassword == true ? "checked=checked" : "" %> />
	        <label for="openpsw"></label>
	      </div>
       </div>
       
       <div class="clearfix mt15 bb-e6e6e6 bt-e6e6e6 bg-fff">
	       	<a class="block pos-r pl15 pr15 pt10 pb10 click-respond" id="aUpdatePwd">
	       		<p class="f17px c-212121">修改交易密码</p>
	       		<i class="ico-arrow-r"></i>
	       	</a>
       </div>
   </section>

    <!--消息弹框-->
    <div id="divTips" style="display: none;">
        <div class="alert z-index1000 webkit-box box-center">
            <div class="alert-select pos-r">
                <div class="text-center c-212121 f17px pt25 pb20" id="msg">是否确定要退出?</div>
                <div class="clearfix bt-e6e6e6">
                    <div class="lf w50p br-e6e6e6">
                        <div class="btn c-808080 f17px br-e6e6e6" id="btnPopCancel" onclick="Done();">取消</div>
                    </div>
                    <div class="rf w50p">
                        <div class="btn c-ffc61a f17px" id="btnPopOK">确定</div>
                    </div>
                </div>
                <div class="bt-e6e6e6" style="display: none;">
                    <div class="btn c-ffc61a f17px" id="dvPopConfirm">我知道了</div>
                </div>
            </div>
        </div>
    </div>

    <!--录入弹窗-->
    <div id="dvInputPass" style="display: none;">
        <div class="alert z-index1000 webkit-box box-center">
            <div class="alert-select pos-r">
                <div class="text-center c-212121 f17px pt25 pb20 fb">请输入交易密码</div>
                <div class="alert-inp ml15 mr15">
                    <input type="password" placeholder="交易密码" id="txtPay" maxlength="30">
                </div>
                <div class="pl10" style="display: none;">
                    <p class="c-fd6040 f13px pos-a" style="left: 20px; top: 115px;" id="dvErrTip"><i class="ico ico-warn"></i>交易密码错误</p>
                </div>
                <div class="clearfix bt-e6e6e6 mt30">
                    <div class="lf w50p br-e6e6e6">
                        <div class="btn c-808080 f17px br-e6e6e6" id="dvInputCancel">取消</div>
                    </div>
                    <div class="rf w50p">
                        <div class="btn c-ffc61a f17px" id="dvInputOK">确定</div>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <script type="text/javascript" src="/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/base.js?v=1"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%= TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        var isUseOpt = "<%=TuanDai.WXApiWeb.GlobalUtils.IsOpenCGT%>";
        $(function () {
            $('#openpsw').click(function () {
                if ($(this).is(':checked')) {
                    UpdateTenderNeedPayPwd(true);
                }
                else {
                    UpdateTenderNeedPayPwd(false);
                }
            });
            $("#aUpdatePwd").click(function () {
                if (isUseOpt.toUpperCase() == "TRUE") {
                    getBankUrl();
                } else {
                    window.location.href = "reset_password.aspx";
                }
            });
        });

        function Done() {
            $("#divTips").fadeOut(300);
            if ($("#openpsw").attr('checked') == "checked") {
                document.getElementById("openpsw").checked = true;
            }
            else {
                $("#openpsw").removeAttr("checked");
            }
        }
        function hideInputDialog() {
            $("#dvInputPass").fadeOut(300);
            if ($("#openpsw").attr('checked') == "checked") {
                document.getElementById("openpsw").checked = true;
            }
            else {
                $("#openpsw").removeAttr("checked");
            }
            $('#dvInputOK').unbind('click');
            $('#dvInputCancel').unbind('click');
            $("#dvInputPass input").unbind('keypress');
        }

        function ShowMsg(msg, isShowOk, okValue, okHandle) {
            $("#msg").html(msg);
            if (isShowOk == "1") {
                $("#btnPopOK").html(okValue);
                $('#btnPopOK').unbind('click').bind('click', okHandle);
                $("#btnPopCancel").val("取消");
                $("#btnPopOK").parent().show();
                $("#dvPopConfirm").parent().hide();
            } else {
                $("#btnPopOK").parent().parent().hide();
                $("#dvPopConfirm").parent().show();
                if ($.isFunction(okHandle))
                    $('#dvPopConfirm').unbind('click').bind('click', okHandle);
                else
                    $('#dvPopConfirm').unbind('click').bind('click', Done);
            }
            $("#divTips").fadeIn(300);
        }


        function UpdateTenderNeedPayPwd(IsTenderNeedPayPwd) {
            if (isUseOpt.toUpperCase() == "TRUE") {
                jQuery.ajax({
                    url: "/ajaxCross/ajax_s1a2fe.ashx",
                    type: "post",
                    dataType: "json",
                    data: {
                        Cmd: "EditIsTenderNeedPayPwd",
                        IsTenderNeedPayPwd: IsTenderNeedPayPwd,
                        payPwd: ""
                    },
                    success: function (data) {
                        $("body").hideLoading();
                        switch (parseInt(data.result)) {
                            case 8888:
                                location.href = unescape(data.msg);
                                break;
                            default:
                                ShowMsg('操作失败，请稍后再试。', '0', '', '');
                                break;
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        $("body").hideLoading();
                        ShowMsg('系统繁忙，请稍后再试。', '0', '', '');
                    }
                });
            }
            else {
                $("#dvInputPass").fadeIn(300);

                $("#dvInputOK")
                    .click(function () {
                        var input = jQuery("#txtPay");
                        if (input.val() == "") {
                            input.focus();
                        } else {
                            submitIsTenderNeedPayPwd(IsTenderNeedPayPwd, jQuery.trim(jQuery("#txtPay").val()));
                        }
                    });
                $("#dvInputCancel").click(function () {
                    hideInputDialog();
                });
                //enter提交
                $("#dvInputPass input").keypress(function (e) {
                    if (e.keyCode == "13") {
                        submitIsTenderNeedPayPwd(IsTenderNeedPayPwd, jQuery.trim(jQuery("#txtPay").val()));
                    }
                });
            }
        }
        function getBankUrl() {
            $.ajax({
                url: "/ajaxCross/ajax_cgt.ashx",
                type: "post",
                dataType: "json",
                data: {
                    Cmd: "ModifyCGTPwd"
                },
                success: function (data) {
                    if (data) {
                        if (data.result == "1") {
                            var msg = unescape(data.msg);
                            window.location.href = msg;
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { 
                    ShowMsg('系统繁忙，请稍后再试。', '0', '', '');
                }
            });
        }
        function submitIsTenderNeedPayPwd(IsTenderNeedPayPwd, payPwd) {
            if (payPwd == "") {
                payPwd.focus();
                return false;
            }
            hideInputDialog();
            $("body").showLoading("提交中...");
            jQuery.ajax({
                url: "/ajaxCross/ajax_s1a2fe.ashx",
                type: "post",
                dataType: "json",
                data: {
                    Cmd: "EditIsTenderNeedPayPwd",
                    IsTenderNeedPayPwd: IsTenderNeedPayPwd,
                    payPwd: payPwd
                },
                success: function (data) {
                    $("body").hideLoading();
                    switch (parseInt(data.result)) {
                        case -100:
                            {
                                ShowMsg('修改配置失败，请稍后再试。', '0', '', '');
                                break;
                            }
                        case -99: {
                            ShowMsg('登录超时，请重新登录', '1', '登录', function () { window.location.href = "/user/Login.aspx"; });
                            break;
                        }
                        case 1:
                            {
                                ShowMsg('修改成功!', '0', '确定', function () { window.location.href = "trade_password.aspx"; });
                                break;
                            }
                        case 0:
                            {
                                ShowMsg('修改配置失败，请稍后再试。', '0', '', '');
                                break;
                            }
                        case -1:
                            {
                                if (data.msg == '0') {

                                    ShowMsg('修改配置失败：今日交易密码已错误5次，请24小时后再进行此操作！', '0', '', '');
                                    break;
                                }
                                else {
                                    ShowMsg('修改配置失败：交易密码错误，今日还有' + data.msg + '次机会，错误5次将锁定24小时！。', "0", '', '');
                                    break;
                                }

                            }
                        case -5:
                            {
                                ShowMsg('修改配置失败：今日交易密码已错误5次，请24小时后再进行此操作！。', '0', '', '');
                                break;
                            }
                        default:
                            {
                                ShowMsg('系统繁忙，请稍后再试。', '0', '', '');
                                break;
                            }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("body").hideLoading();
                    ShowMsg('系统繁忙，请稍后再试。', '0', '', '');
                }
            });
        }
    </script>
</body>
</html>
