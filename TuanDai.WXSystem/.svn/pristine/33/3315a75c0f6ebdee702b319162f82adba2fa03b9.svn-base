<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="account_cgt_pay.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Bank.account_cgt_pay" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta http-equiv="Expires" CONTENT="0"> 
    <meta http-equiv="Cache-Control" CONTENT="no-cache"> 
    <meta http-equiv="Pragma" CONTENT="no-cache"> 
    <title>充值</title>
    <link rel="stylesheet" type="text/css" href="/css/base.css?v=20150907" /><!--base-->
    <link rel="stylesheet" type="text/css" href="/css/account.css?v=2015090701" /><!--账户中心-->
</head>
<body>
    <form id="form1" runat="server">
     <!--弹窗-->
     <section class="automaticwayBox pt15 clearfix" id="tip" style='bottom: -448px; padding: 10px 15px;'>
      <div class="hbody clearfix" style="margin-bottom: 9px;">
        <i class="ico-exclamation40 lf mr10"></i>
        <span id="msg" style="  font-size: 14px;line-height: 24px;"></span>
      </div>
      <div class="completeBox clearfix">
        <span style="float: right;max-width: 40%;">
             <a href="javascript:;" class="btn btnYellow h40" id="btnOk" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;">确定</a>
        </span>
        <span style="float: right;max-width: 60%;padding-right: 10px;">
             <input type="button" class="btn btnGreen h40" value="取消" id="btnCancel" onclick="Done()" style="font-size: 1.6rem;padding: 0 10px;min-width: 90px;"/>
        </span>
      </div>
    </section>
    <!--遮罩层-->
     <div class="maskLayer hide"></div>
     <script type="text/javascript" src="/scripts/jquery.min.js"></script>
     <script type="text/javascript" src="/scripts/base.js?v=20150623"></script>
     <script type="text/javascript">
        function Done() {
            applock = 0;
            $(".maskLayer").fadeOut();
            $("#affirmLoanMain").animate({
                bottom: "-430px"
            }, 200)
            $("#tip").animate({
                bottom: "-430px"
            }, 200)

        }

        function ShowMsg(msg, isShowOk, okValue) {
            $(".maskLayer").fadeIn();
            $("#msg").html(msg);
            if (isShowOk == "1") {
                $("#btnOk").html(okValue);
                $("#btnOk").attr("href", "javascript:history.go(-1);");
                $("#btnCancel").val("取消");
                $("#btnCancel").parent().hide();
            }
            var bottom = (document.documentElement.clientHeight - document.getElementById("tip").offsetHeight) / 2;
            $("#affirmLoanMain").animate({
                bottom: "-430px"
            }, 200)

            $("#tip").animate({
                bottom: bottom
            }, 200)
        }
     </script>
    </form>
</body>
</html>
