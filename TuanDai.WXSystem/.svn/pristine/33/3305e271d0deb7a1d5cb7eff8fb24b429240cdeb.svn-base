<%@ Page Language="C#" AutoEventWireup="true"   CodeBehind="Weftb_Ransom.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.Weftb_Ransom" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title>结束服务</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=<%=GlobalUtils.Version %>" /> 
	<style type="text/css">
		.inpBox{padding: 10px 0 10px 100px;}
		.inpBox span{left: 15px;top: 10px;}
		.inpBox input{border: none;outline: none;font-size: 1.4rem;}
        .end-tips{padding: 0 15px;}
		.end-tips p{ font-size:12px; color: #999999; line-height:18px;text-align: justify; padding-bottom:15px;}
	</style>
</head>
<body>
<%=GetNavStr() %>
 <%-- <header class="headerMain">
	    <div class="header">
	        <div class="back" onclick="javascript:history.go(-1);">返回</div>
	        <h1 class="title">申请转让</h1>
	    </div>
	    <div class="none"></div>
	</header>--%>

	<div class="bg-bdBom1-ccc pl15 pb15">
		<div class="f15px c-212121 pt15 pb15"><%=model.ProductName %></div>
		<%--<div class="p12px c-ababab">退出本金：<%=ToolStatus.ConvertLowerMoney(feeInfo.ApplyAmount) %></div>  --%>
		<div class="p12px c-ababab clearfix mt5">
			 持续服务时间：<%=feeInfo.HoldDayStr %>
			<!-- <div class="rf f12px c-fd6040 mr15" id="btnViewRule">查看转让规则</div> -->
		</div> 
	</div> 
    <div class="bg-bdtopBom1-ccc mt15 pl15">
		<div class="c-212121 f12px pt20">参考总回报<span class="c-ababab f12px">(本金+利息+奖励)</span></div>
		<div class="c-fd6040 f20px pt10">￥<%=ToolStatus.ConvertLowerMoney(feeInfo.DueInAmount)%></div>
        <div class="f12px c-212121 pt25">参考年回报率</div>
		<div class="c-fd6040 f15px pt10"><%=ToolStatus.DeleteZero(feeInfo.ExitRate) %>%<%=feeInfo.RewardRate>0?"+"+ToolStatus.DeleteZero(feeInfo.RewardRate)+"%":""%></div> 
	</div>	

    <%if(!GlobalUtils.IsOpenCGT) {%>
	<div class="bg-bdtopBom1-ccc mt15">
		<div class="inpBox pos-r">
			<span class="f14px c-212121 pos-a">交易密码</span>
			<input type="password" placeholder="请输入交易密码" id="txtPwd" />
		</div>
	</div> 
    <%} %>

    <div class="ml15 mr15 mt20 pb40">
		<div class="btn btnYellow">确认结束服务</div>
	</div>
  

    <div class="end-tips">
        <p>结束服务规则：</p>
        <p>1、以申请结束服务时对应的参考年回报率计算复投宝结束服务时的参考回报；最长持续服务期到期前7天不支持申请结束服务。</p>
        <p>2、确认结束服务后，系统将为您退出债权，完成时间视市场交易情况而定。</p>
        <p>3、结束服务回款将在债权退出完成后到账。</p>
    </div>


  <div  class="hide" id="dvTips">
    <div class="alert webkit-box box-center">
	    <div class="bg-fff alert-con moveTop">
		    <p class="text-center c-212121 f17px fb ">结束服务规则</p>
		    <p class="pt12 f15px c-808080 text-justify pl20 pr20">1、以申请结束服务时对应的参考年回报率计算复投宝结束服务时的参考回报；最长持续服务期到期前7天不支持申请结束服务。</p>
            <p class="pt12 f15px c-808080 text-justify pl20 pr20">2、确认结束服务后，系统将为您退出债权，完成时间视市场交易情况而定。</p>
            <p class="pt12 f15px c-808080 text-justify pl20 pr20">3、结束服务回款将在债权退出完成后到账。</p> 
		    <div class="bt-e6e6e6 pt10 pb10 c-fcb700 text-center f17px mt25" id="btnTipsHide">我知道了</div>
	    </div>
    </div> 
   </div> 
</body>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>

<script type="text/javascript">
    $(function () {
        // $("#btnViewRule").bind("click", function () {
        //     $("#dvTips").fadeIn(300);
        // });
        // $("#btnTipsHide").click(function () {
        //     $("#dvTips").fadeOut(300);
        // });
        $(".btnYellow").click(function () { 
            if (isOpenCGT == "1" && isOpenCgtTrans == "1") {
                if (!checkIsOpen()) {
                    return false;
                }
            }
            var tranPwd = "";
            <%if (!GlobalUtils.IsOpenCGT)
               { %>
                 tranPwd = $("#txtPwd").val().trim();
                if (tranPwd.length <= 0) {
                    $("body").showMessage({ message: "请输入交易密码!", showCancel: false });
                    return false;
                }
            <% } %>
            $("body").showLoading("数据处理中,请稍后...");
            $.ajax({
                url: "/ajaxCross/ajax_wefqb.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "ApplyFTBTransfer", TranPwd: tranPwd, WeOrderId: "<%=weOrderId%>", ApplyAmount: "<%=feeInfo.ApplyAmount%>" },
                success: function (json) {
                    $("body").hideLoading();
                    if (json.result == 1) {
                        $("body").showMessage({
                            message: "申请赎回成功!", showCancel: false, okbtnEvent: function () {
                                window.location.href = "/Member/Repayment/Weftb_project.aspx?weorderid=<%=weOrderId%>";
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
</html>
