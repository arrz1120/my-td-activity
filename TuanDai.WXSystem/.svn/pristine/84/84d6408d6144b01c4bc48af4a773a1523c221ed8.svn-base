<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="deposit.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.deposit" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>补充保证金</title>
<link rel="stylesheet" type="text/css" href="/css/base.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" /><!--base-->
<link rel="stylesheet" type="text/css" href="/css/account.css?v=2015090701" /><!--账户中心-->

</head>
<body>
    <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:history.go(-1);">返回</div>
            <h1 class="title">补充保证金</h1>
        </div>
        <div class="none"></div>
    </header>
    <div class="operationInfoMain pb75">
        <section class="pd15 c-212121 f14px">操盘资金预览</section>
        <section class="yellowBox">
            <div class="hd">总操盘资金(元)</div>
            <div class="bd">¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.TraderAmount)%></div>
            <div class="fd">
                <div class="contMain">
                    <p>亏损预警线（元）</p>
                    <p>¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.EarlyWarnAmount)%></p>
                </div>
                <div class="contMain">
                    <p>亏损平仓线（元）</p>
                    <p>¥ <%=Tool.MoneyHelper.ConvertDetailWanMoney(model.EveningUpAmount)%></p>
                </div>
            </div>
        </section>
        <section class="bg-bdtopBom1-ccc bgNone pl15 mt20 clearfix">
            <div class="infoMain pr30">
                <div class="leftBox">保证金额</div>
                <div class="rightBox pr15">
                    <div class="contBox">
                        <input type="text" name="txtAmount" id="txtAmount" typeval="num" class="ipt" value="" placeholder="请输入金额" maxlength="6">
                    </div>
                </div>
                <div class="unit">元</div>
            </div>
        </section>
        <section class="tip2">本保证金真接补充到操盘资金</section>
        <section class="loanBtnBox">
            <input type="button" class="btn btnYellow borderRadius0 h52" value="补充保证金" onclick="show(confirmMain)">
        </section>
    </div>
    
    <!--确认弹窗-->
    <section class="confirmMain hide" id="confirmMain">
        <div class="tit">请输入交易密码</div>
        <div class="mt15 mb15">
            <input type="password" class="input" id="txtPayPwd" name="txtPayPwd">
        </div>
        <div class="completeBox clearfix">
          <span class="btnBox"><input type="button" class="userBtn btnWhite borderColor-ababab" value="取消" onclick="Done(confirmMain)"></span>
          <span class="btnBox"><input type="button" id="btnConfirm" class="userBtn btnYellow" value="确定"></span>
        </div>
    </section>
    <div class="maskLayer hide"></div><!--遮罩层-->
    
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/Common.js"></script>
<script type="text/javascript">
   var projectId="<%=projectId %>";
    //类型//还款方式//模拟弹出，具体请开发自行判断
    function show(i) {
        $(".maskLayer").fadeIn();
        $(i).fadeIn();
    };
    function Done(i) {
        $(".maskLayer").fadeOut();
        $(i).fadeOut();
    }
    $(function () {
        //  限制只能输入数字
        limitInt($("input[typeval='num']"));
        $("#btnConfirm").click(function () {
            addGPMargin();
        });
    });
    function addGPMargin() {
        if (parseInt($("#txtAmount").val()) <= 0) {
            alert("请输入补仓金额!");
            $("#txtAmount").focus();
            return;
        }
        Done(confirmMain);
        $.ajax({
            url: "/ajaxCross/BorrowAjax.ashx",
            type: "post",
            dataType: "json",
            data: { Cmd: "AddGPMargin", PayPwd: $("#txtPayPwd").val(), ProjectId: projectId, Amount: $("#txtAmount").val() },
            success: function (json) {
                if (json.result == "1") {
                    alert("补仓成功!")
                    window.location.href = "/Member/Repayment/borrowShow.aspx?id=" + projectId;
                }
                else {
                    alert(json.msg);
                    $("#txtPayPwd").val();
                }
            },
            error: function () {
                alert("操作失败！");
                $("#txtPayPwd").val();
            }
        });
    }
</script>
</body>
</html>