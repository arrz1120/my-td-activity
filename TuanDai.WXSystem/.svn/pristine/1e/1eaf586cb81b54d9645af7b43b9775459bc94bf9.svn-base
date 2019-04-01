<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="exchangevip.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.exchangevip" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>兑换VIP</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->
</head>
<body>
    <%= this.GetNavStr()%>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:window.location.href='/Member/upgradeaccount.aspx'">返回</div>
            <h1 class="title">兑换VIP</h1>
        </div>
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>

    <section class="bg-bdtopBom1-ccc pl15 mt20 clearfix">
        <div class="pt10 pb10">
                <input type="text" name="txtVip" id="txtVip" class="vip-code" placeholder="请输入VIP兑换券密码">
        </div>
    </section>

    <section class="pd15 mt15">
        <a href="javascript:void(0);" target="_blank" class="btn btnYellow" id="btnVip">确认兑换</a>
    </section>

<!--弹窗-->
 <section class="automaticwayBox pt15 clearfix" id="tip" style='bottom: -448px; padding: 10px 15px;'>
  <div class="hbody clearfix" style="margin-bottom: 9px;">
    <i class="ico-exclamation40 lf mr10"></i>
    <span id="msg" style="  font-size: 14px;line-height: 39px;"></span>
  </div>
  <div class="completeBox clearfix">
    <span style="float: right;max-width: 40%;">
        <a href="javascript:;" class="btn btnYellow h40" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>  
    </span>
    <span style="float: right;max-width: 60%;padding-right: 20px;">
        <input type="button" class="btn btnGreen h40" value="取消" id="btnCancel" onclick="Done()" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;"/> 
    </span>
  </div>
</section>
<!--遮罩层-->
<div class="maskLayer hide"></div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/base.js?v=1"></script>
<script type="text/javascript">
    $(function () {
        $("#btnVip").click(function () {
            if ($.trim($("#txtVip").val()) == "") {
                $("#txtVip").focus();
                return;
            }
            else {
                $.ajax({
                    url: "/ajaxCross/Login.ashx",
                    type: "post",
                    dataType: "json",
                    data: { Cmd: "RechargeVip", pwd: $.trim($("#txtVip").val()) },
                    success: function (json) {
                        if (parseInt(json.result) == -100) {
                            ShowMsg("程序异常！");
                        }
                        else if (parseInt(json.result) == -3) {
                            ShowMsg("对不起，您还未登录！", "1", "登录", "/user/Login.aspx?ReturnUrl=" + window.location.href);
                        }
                        else if (parseInt(json.result) == 1) {
                            ShowMsg("已兑换成功", "1", "确定", "/Member/upgradeaccount.aspx");
                            $("#txtVip").val("");
                        }
                        else if (parseInt(json.result) == 0) {
                            ShowMsg("兑换失败");
                        }
                        else if (parseInt(json.result) == -1) {
                            ShowMsg("VIP会员兑换劵不存在或者已经使用");
                            $("#txtVip").val("");
                        }
                        else if (parseInt(json.result) == -2) {
                            ShowMsg("VIP会员兑换劵已过有效期");
                        }
                    }
                });
            }
        });
    });
    function Done() {
        $(".maskLayer").fadeOut();
        $("#tip").animate({
            bottom: "-430px"
        }, 200);
    }
    function ShowMsg(msg, isShowOk, okValue, url) {
        $(".maskLayer").fadeIn();
        $("#msg").html(msg);
        if (isShowOk == "1") {
            $("#btnOk").html(okValue);
            $("#btnOk").attr("href", url);
            $("#btnCancel").val("取消");
            $("#btnOk").parent().show();
        } else {
            $("#btnOk").parent().hide();
            $("#btnCancel").val("确定");
        }
        var bottom = (document.documentElement.clientHeight - document.getElementById("tip").offsetHeight) / 2;
        $("#tip").animate({
            bottom: bottom
        }, 200);
    }
</script>
</body>
</html>