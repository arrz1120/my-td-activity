<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ebConfirmPay.aspx.cs" Inherits="TuanDai.WXApiWeb.PaymentPlatform.EB.ebConfirmPay" %>

 <!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>充值短信验证</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/account.css?v=20160114" /><!--账户中心-->
<link rel="stylesheet" type="text/css" href="/css/safety.css" /><!--安全中心-->
<link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=20160219001" />

</head>
<body>
<%= this.GetNavStr()%>
<header class="headerMain">
    <div class="header">
        <div class="back" onclick="javascript:history.go(-1);">返回</div>
        <h1 class="title">充值短信验证</h1>
        <%--<div class="text"><a href="recharge_record.html"></a></div>--%>
    </div>
    <%= this.GetNavIcon()%>
    <div class="none"></div>
</header> 
    <section class="recordingBox clearfix">
		
        <div class="bg-bdTop-ccc clearfix numBox">
            <div class="c-212121 f14px text">充值金额</div>
            <div class="c-212121 f14px" style="margin-top: 1px;"><%=ToolStatus.ConvertLowerMoney(Amount)%></div>
        </div>
		
        <div class="clearfix numBox bt-dash-d1d1d1 ml15 bg-fff padding-reset">
            <div class="c-212121 f14px text l0">银行卡号</div>
            <div class="c-212121 f14px" style="margin-top: 1px;"><%=BusinessDll.StringHandler.MaskMiddlePlace(model.BankAccountNo,4,11) %></div>
        </div>
		
        <div class="clearfix numBox bt-dash-d1d1d1 ml15 bg-fff padding-reset">
            <div class="c-212121 f14px text l0">所属银行</div>
            <div class="c-212121 f14px" style="margin-top: 1px;"><%= Tool.EnumHelper.GetDescriptionFromEnumValue(typeof(ConstString.BankType), model.BankType) %></div>
        </div>
        
        <div class="wave_bg h15"></div> 
         
		
        <div class="bg-bdtopBom1-ccc numBox clearfix">
            <div class="text f14px">验证码</div>
            <input type="text" id="txt_smsCode" class="ipt f14px" name="txt_smsCode" maxlength="6" placeholder="请输入短信验证码" value=""/>
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
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript">
    $(function () {
        $(".btnYellow").bind("click", function () {
            $("#trError").hide();
            var strCode = $.trim($("#txt_smsCode").val());
            if (strCode == "") {
                $("#trError").html("短信验证码不能为空");
                $("#trError").show();
                return;
            }
            $("body").showLoading("充值中...");
            jQuery.ajax({
                async: false,
                type: "post",
                url: "/PaymentPlatform/EB/ebPlainPay.aspx?action=confirmpay",
                dataType: "json",
                data: { SMSCode: strCode, IsBindCard: "<%=IsBindCard%>", OrderId: "<%=OrderId%>", RequestId: "<%=RequestId%>" },
                success: function (json) {
                    $("body").hideLoading();
                    if (json.result == "1") {
                        window.location.href = "/PaymentPlatform/EB/ebReturn.aspx";
                    } else { 
                        $("#trError").html(json.msg);
                        $("#trError").show();
                    }
                },
                error: function () {
                    $("body").hideLoading();
                    $("#trError").html("网络异常，请重试！");
                    $("#trError").show();
                    return;
                } 
            });
        })
    });

</script>
</body>
</html>
