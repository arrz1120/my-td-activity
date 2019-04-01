﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Wefqb_project.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.Wefqb_project" %>

<%@ Import Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="format-detection" content="telephone=no" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<title>We计划[分期宝]详情</title>
<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
<link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=<%=GlobalUtils.Version %>" />
<link rel="stylesheet" type="text/css" href="/css/account.css?v=<%=GlobalUtils.Version %>" />

</head>
<body class="bg-f1f3f5 pb20">
     <%= this.GetNavStr()%>
     <header class="headerMain">
        <div class="header">
            <div class="back" onclick="javascript:window.location.href='/Member/Repayment/my_return_list.aspx?tab=<%=tab %>'">返回</div>
            <h1 class="title" id="dvTitle">WE计划X[分期宝]</h1>
        </div> 
        <%= this.GetNavIcon()%>
        <div class="none"></div>
    </header>
<div id="wrapper" style="top:0px!important;">
<div id="scroller">
    <div id="pullDown">
        <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
    </div> 

 <div class="detail-top-bg bb-e6e6e6 pt10">
	<div class="pl15 pos-r detail_tit">
		<p class="f14px c-808080 text-overflow"><%=model.ProductName %></p>
        
		
	</div>
	<div class="pt25 text-center f13px c-ababab pos-r">参考回报（<%=model.RepeatInvestType==1?"本息复投":"本金复投" %>）</div>
	<div class="f37px c-fd6040 text-center pt10"><%=ToolStatus.ConvertLowerMoney(DueInterestAmount) %></div>
     <% if (IsWeZnq && RewardInterest>0)
       {
           %>
    <div class="rect-box clearfix"style="margin-left:!important auto;margin-right:!important auto;width: 200px;" >
        <div class="rect_r f11px c-ffffff text-center" style="width:200px;height:auto;">计划奖励:￥<span id="reward" class="c-ffffff"><%=ToolStatus.ConvertLowerMoney(RewardInterest) %></span>(退出时发放)</div>		
	</div>
    <%
       } %>
	<div class="pt10 text-center f13px c-ababab"><span class="f13px c-ababab mr10"><%=model.Deadline %>个月</span>参考年回报率<%=ToolStatus.DeleteZero(model.YearRate)%>% <%=RewardRate>0?"+"+ToolStatus.DeleteZero(RewardRate)+"%":"" %></div>
	<div class="bg005 mt30">
		<div class="pl15 pt10 pb11 pos-r">
			<p class="f17px c-212121">加入金额：<%=ToolStatus.ConvertLowerMoney(model.Amount) %></p>
			<p class="line-h19 f13px c-ababab"><%=model.OrderDate.ToString("yyyy-MM-dd HH:mm") %></p>
			<a class="lookProject c-ababab f13px" href="<%=TuanDai.WXApiWeb.GlobalUtils.ContractViewUrl%>/p2p/weixin/ContractType100.aspx?key=<%=weOrderId %>">查看合同<i class="ico-right"></i></a>
		</div>
		<div class="pl15 pt10 pb11 pos-r bt-e6e6e6">
			<p class="f17px c-212121">已投资金额：<%=ToolStatus.ConvertLowerMoney(model.AmountInvestment) %></p>
            <% if(model.WeStatusId==1 && model.OrderAviAmount>0){ %>
			<p class="line-h19 f13px c-ababab">项目匹配中，<%=model.OrderDate.AddDays(6).ToString("MM月dd日")%>前未投资的金额将解冻</p>
            <%} else if (model.WeStatusId==2) {  %>
             <p class="line-h19 f13px c-ababab"><%=model.OrderAviAmount == 0?"已全部投标完成":"未投资金额已解冻" %></p> 
            <%} %>
		</div>
	</div>
</div>
	
<div class="mt20 bg-fff pl15 pt10 pb10 bt-e6e6e6 bb-e6e6e6">
	<p class="f17px"><%=GetWeFQBStatus() %><span class="f17px c-ababab">（<%=model.ExpireDate.ToString("yyyy-MM-dd")%>到期）</span></p>
    <% if(model.WeStatusId==2){ %>
      <div class="lookProject c-ababab f13px" id="btnApplyTransfer">提前退出<i class="ico-right"></i></div> 
    <%}else if(model.WeStatusId==3){ %>
    <%--<div class="lookProject c-ababab f13px" id="btnCancelTransfer">撤销转让</div>--%>
    <%} %>  
</div>
	
	
<div class="pl15 bg-fff bb-e6e6e6">
	<div class="pt10 pb10 bb-e6e6e6">
		<p class="f17px">交易记录</p>
		<div class="lookProject c-ababab f13px" id="btnViewProject">投资列表<i class="ico-right"></i></div>
	</div>

    <div id="thelist"> 
    </div>	
</div> 
  
        <div id="pullUp">
            <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
        </div>
    </div> 
</div> 

    <!--您持有该计划未满3个月弹框-->
    <div class="alert we-alert" style="display: none;" id="popRansom">
    	<div class="bg-fff pl15 pr15 pb15 we-alert-box">
    		<div class="c-212121 text-center f14px pt30 pb20">您持有该计划未满3个月，请于<%=model.OrderDate.AddDays(7).AddMonths(3).ToString("yyyy年MM月dd日") %>再来申请转让。</div>
    		<div class="btn btnYellow">确定</div>
    	</div>
    </div> 
    <!--确认撤销转让申请？-->
    <div class="alert we-alert" style="display: none;" id="popCancelRansom">
    	<div class="bg-fff pl15 pr15 pb15 we-alert-box">
    		<div class="c-212121 text-center f14px pt30 pb20">确认撤销转让申请？</div>
    		<div class="clearfix we-btn-select">
    			<div class="btnL lf f14px c-212121">取消</div>
    			<div class="btnR rf f14px c-fff">确定</div>
    		</div>
    	</div>
    </div> 
    <!--已成功撤销转让申请弹框-->
    <div class="alert we-alert" style="display: none;" id="popCancelSuc">
    	<div class="bg-fff pl15 pr15 pb15 we-alert-box">
    		<div class="c-212121 text-center f16px pt30 pb30">已成功撤销转让申请</div>
    		<div class="btn btnYellow">确定</div>
    	</div>
    </div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/fastclick.js"></script>
<script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/cgtWindow.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>

<script type="text/javascript">
    var weOrderId = "<%=weOrderId%>";
    var transferDate = "<%=model.TransferDate.ToString("yyyy-MM-dd HH:mm")%>";
    var isY7Z7 = "<%= IsY7Z7%>";
    $(function () {
        iScroll.onLoadData = LoadProjectList;
        LoadProjectList('empty');
        if (isY7Z7 == "False") {
            <%--$(".detail_tit").click(function () {
                window.location.href = "/pages/invest/WE/WeFqb_detail.aspx?id=<%=model.ProductId%>";
            });--%>
        }
        //申请转让
        $("#btnApplyTransfer").click(function () {
            window.location.href = "/pages/downopenapp.aspx";
            return false;
            if (isOpenCGT == "1" && isOpenCgtTrans == "1") {
                if (!checkIsOpen()) {
                    return false;
                }
            }
            var year = new Date(transferDate).getFullYear();
            var month = new Date(transferDate).getMonth();
            var day = new Date(transferDate).getDate();
            if (new Date() < new Date(year, month, day)) {
                 $("#popRansom").show();
            } else {
                window.location.href = "/Member/Repayment/Wefqb_Redemption.aspx?orderid=<%=weOrderId%>";
            }
        });

        //取消转让
        $("#btnCancelTransfer").click(function () {
            $("body").showLoading("数据处理中，请稍后...."); 
            $.ajax({
                url: "/ajaxCross/ajax_wefqb.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "CheckTransferHasJoin", WeOrderId: "<%=weOrderId%>" },
                success: function (json) {
                    if (json.result == "1") {
                        $("body").hideLoading();
                        $("#popCancelRansom").show();
                    } else {
                        $("body").showMessage({ message: "您的债权已有人承接，不支持撤销操作，请您耐心等待转让完成",showCancel:false}); 
                    }
                },
                error: function () {
                    $("body").showMessage({ message: "网络异常，请重试！", showCancel: false }); 
                }
            }); 
        });
        $("#popCancelRansom .btnR").click(function () {
            $("#popCancelRansom").hide();
            $("body").showLoading("数据处理中，请稍后....");
            $.ajax({
                url: "/ajaxCross/ajax_wefqb.ashx",
                type: "post",
                dataType: "json",
                data: { Cmd: "CancleWeFqbTransfer", WeOrderId: "<%=weOrderId%>" },
                success: function (json) {
                    $("body").hideLoading();
                    if (json.result == 1) {
                        $("#popCancelSuc").show(); 
                    } else {
                        $("body").showMessage({message:json.msg,showCancel:false});
                    }
                },
                error: function () {
                    $("body").showMessage({ message: "网络异常，请重试！", showCancel: false });
                }
            });
        });
        $("#popCancelSuc .btnYellow").unbind("click").bind("click",function(){
            window.location.href = window.location.href;
        });
        $("#popCancelRansom .btnL").click(function () {
            $(".we-alert").hide();
        });
        $(".btnYellow").click(function () {
            $(".we-alert").hide();
        });
    });
    function LoadProjectList(flag) {
        $("body").showLoading("数据加载中...");
        if (flag == "empty") {
            $("#thelist").children().remove();
        }
        jQuery.ajax({
            type: "Post",
            url: "/ajaxCross/InvestAjax.ashx",
            dataType: "json",
            data: { Cmd: "GetWeFQBTradeDetailShowList", pageIndex: pageIndex, weOrderId: "<%=weOrderId%>" },
            success: function (jsonstr) {
                if (flag == "empty") {
                    $("#thelist").children().remove();
                } 
                pageCount = jsonstr.pageCount;
                if (pageCount <= 1)
                    $("#pullUp").hide();
                else
                    $("#pullUp").show();

                var html = new Array();
                var str = "";
                if (jsonstr.result == "1") {
                    for (var i = 0; i < jsonstr.list.length; i++) {
                        var item = jsonstr.list[i]; 
                        str = "<div class='bb-e6e6e6" + (item.LinkUrl != "" ? "click-respond" : "") + "' >" +
                            "   <div class='mt2 f17px pt8 " + (parseFloat(item.InAmount) > 0 ? "c-9bc84a" : "c-fd6040") + " '>" + (parseFloat(item.InAmount) > 0 ? "+¥" + item.InAmount : "-¥" + item.OutAmount) + "</div>" +
                            "   <div class='clearfix mt1 pr15 pb15'>"+
                            "     <div class='lf f13px c-ababab pl5 w50p text-overflow'>" + item.ActionStr + "</div>" +
                            "     <div class='rf f13px c-ababab'>" + item.AddDate + "</div>" +
                            "   </div>" +
                            "</div> "; 
                        html.push(str);
                    }
                    $("#thelist").append(html.join(""));
                    myScroll.refresh();
                }
                else {
                    $("#thelist").append(" <div class='bb-e6e6e6'>暂时没有记录</div>");
                }
                $("body").hideLoading(); 
            },
            error: function (msg) {
                $("body").hideLoading(); 
            }
        });
    }
</script>


</body>
</html>
