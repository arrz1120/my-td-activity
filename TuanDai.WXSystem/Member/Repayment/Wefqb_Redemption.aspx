<%@ Page Language="C#" AutoEventWireup="true"  CodeBehind ="Wefqb_Redemption.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.Wefqb_Redemption" %>
<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>申请转让</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=<%=GlobalUtils.Version %>" /> 
	<style type="text/css">
		.inpBox{padding: 10px 0 10px 100px;}
		.inpBox span{left: 15px;top: 10px;}
		.inpBox input{border: none;outline: none;font-size: 1.4rem;}
	</style>
</head>
<body>
    <%=GetNavStr() %>
	<%--<header class="headerMain">
	    <div class="header">
	        <div class="back" onClick="javascript:history.go(-1);">返回</div>
	        <h1 class="title">申请转让</h1>
	    </div>
	    <div class="none"></div>
	</header>--%>

	<div class="bg-bdBom1-ccc pl15 pb15">
		<div class="f15px c-212121 pt15 pb15"><%=model.ProductName %></div>
		<div class="p12px c-ababab">持有时间：<%=HoldDayStr %></div>
		<div class="p12px c-ababab clearfix mt5">
			管理费率：0.5%
			<div class="rf f12px c-fd6040 mr15" id="btnViewRule">查看转让规则</div>
		</div> 
	</div> 
    <div class="bg-bdtopBom1-ccc mt15 pl15">
		<div class="c-212121 f12px pt20">参考回报<span class="c-ababab f12px">(债权总额+奖励-管理费)</span></div>
		<div class="c-fd6040 f20px pt10">￥<%=ToolStatus.ConvertLowerMoney(feeInfo.TransferAmount+feeInfo.RewardAmount-feeInfo.WeManagerFee)%></div>
        <div class="f12px c-212121 pt25">当前债权总额</div>
		<div class="c-fd6040 f15px pt10">￥<%=ToolStatus.ConvertLowerMoney(feeInfo.TransferAmount)%></div>
		<div class="f12px c-212121 pt25">参考服务费<span class="c-ababab f12px">(从到账金额中扣取)</span></div>
		<div class="c-fd6040 f15px pt10">￥<%=ToolStatus.ConvertLowerMoney(feeInfo.WeManagerFee) %></div>
		<div class="f12px c-212121 pt25">奖励<span class="c-ababab f12px">(加息奖励)</span></div>
        <div class="c-fd6040 f15px pt10">￥<%=ToolStatus.ConvertLowerMoney(feeInfo.RewardAmount) %></div>
	</div>	
    <%if (!TuanDai.WXApiWeb.GlobalUtils.IsOpenCGT)
      {%>
	<div class="bg-bdtopBom1-ccc mt15">
		<div class="inpBox pos-r">
			<span class="f14px c-212121 pos-a">交易密码</span>
			<input type="password" placeholder="请输入交易密码" id="txtPwd" />
		</div>
	</div> 
    <%} %>
	<div class="ml15 mr15 mt20 pb40">
		<div class="btn btnYellow">申请转让</div>
	</div>
  
   <div  class="hide" id="dvTips">
    <div class="alert webkit-box box-center">
	    <div class="bg-fff alert-con moveTop">
		    <p class="text-center c-212121 f17px fb ">转让规则说明</p>
		    <p class="pt12 f15px c-808080 text-justify pl20 pr20">1、持有满3个月即可申请提前退出，转让完成时间视市场交易情况而定。目前仅支持全额（本金+已获收益）提前退出。申请提前退出至转让成功前一日仍然计息；</p>
            <p class="pt12 f15px c-808080 text-justify pl20 pr20">2、提前退出需支付成交金额0.5%的管理费，每成功转让一笔从到账金额中扣除，计划到期退出无需管理费。</p>
		    <div class="bt-e6e6e6 pt10 pb10 c-fcb700 text-center f17px mt25" id="btnTipsHide">我知道了</div>
	    </div>
    </div> 
   </div> 
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript">
    $(function () {
        $("#btnViewRule").bind("click", function () {
            $("#dvTips").fadeIn(300);
        });
        $("#btnTipsHide").click(function () {
            $("#dvTips").fadeOut(300);
        });
        $(".btnYellow").click(function () {
            if (isOpenCGT == "1" && isOpenCgtTrans == "1") {
                if (!checkIsOpen()) {
                    return false;
                }
            }
            var tranPwd = "";
            <% if (!TuanDai.WXApiWeb.GlobalUtils.IsOpenCGT)
               { %>
                tranPwd = $("#txtPwd").val().trim();
                if (tranPwd.length <= 0) {
                    $("body").showMessage({message:"请输入交易密码!",showCancel:false}); 
                    return false;
                }
            <% } %>
            $("body").showLoading("数据处理中,请稍后...");
            $.ajax({
                url: "/ajaxCross/ajax_wefqb.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "ApplyWeFqbTransfer", TranPwd: tranPwd, WeOrderId: "<%=weOrderId%>" },
                success: function (json) {
                    $("body").hideLoading();
                    if (json.result == 1) {
                        $("body").showMessage({
                            message: "申请赎回成功!", showCancel: false, okbtnEvent: function () {
                                window.location.href = "/Member/Repayment/Wefqb_project.aspx?weorderid=<%=weOrderId%>";
                            }
                        });
                    } else if (json.result == '8888') {
                        window.location.href = json.msg;
                    } else {
                        $("body").showMessage({ message: json.msg, showCancel: false });
                    }
                }
            });
        });
    });

</script>
</body>
</html>