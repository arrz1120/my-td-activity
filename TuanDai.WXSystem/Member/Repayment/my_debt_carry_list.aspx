<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my_debt_carry_list.aspx.cs" Inherits="TuanDai.WXApiWeb.Member.Repayment.my_debt_carry_list" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="format-detection" content="telephone=no" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<title>债权转让</title>
	<link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <!--base-->
    <link rel="stylesheet" type="text/css" href="/css/loadbar.css?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/debt.css?v=20160317001"/>
</head>
<body class="pb15 bg-f1f3f5">
    <%= this.GetNavStr()%>
	<header class="headerMain2">
	  <div class="header bb-e6e6e6"> 
        <div class="header-tab">
	    	<a href="/Member/Repayment/my_debt_carry_list.aspx" class="active">承接</a>
	    	<a href="/Member/Repayment/my_debt_transferlist.aspx" class="">转让</a>
	    </div>
	  </div> 
	</header>
	 
    <div class="tab-nav webkit-box bg-fff bb-e6e6e6 pt10 pb10">
		<div class="box-flex1 text-center f17px <%=CurrTab=="Inprogress"?"tab-nav-active":"" %>" id="Inprogress">回收中</div>
		<div class="box-flex1 text-center f17px <%=CurrTab=="CompletedAndFlow"?"tab-nav-active":"" %>"  id="CompletedAndFlow">已完成</div>
	</div>

    <div id="wrapper" class="pr0" style="top: 90px;">
        <div id="scroller">
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
            <div id="thelist" class="debt-list-wrap">
                <!--加载列表-->
            </div>
            <!--没有标-->
	        <div class="debt-empty" style="display: none;" id="divNone">
		        <div class="img-debt-empty">
			        <img src="/imgs/images/debt-empty.png"/>
		        </div>
		        <div class="text-center f17px c-212121 mt40" id="divTitle">暂无回款中标的</div>
		        <div class="mt40 pl40 pr40">
			        <a class="btn btnRed f16px" href="/pages/invest/invest_list.aspx"><i class="ico ico-arrow-right"></i>前往投资专区</a>
		        </div>
	        </div>
            <div id="pullUp">
                <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
            </div>
        </div>
    </div>
    
	
	<div class="alert z-index10" style="display: none;"></div>

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/iscroll.js"></script>
<script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/jquery.extensions.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
<script type="text/javascript"> 
    var status = "<%=CurrTab%>";
    $(function () {
        $('#Inprogress').bind('click', function () {
            $("body").showLoading("加载中...");
            $(this).addClass("tab-nav-active");
            $("#CompletedAndFlow").removeClass("tab-nav-active");
            status = "Inprogress";
            setTimeout(function () {
                //重新加载数据
                LoadReturnList('empty');
                myScroll.refresh();
                $("body").hideLoading();
            }, 500);
        });

        $('#CompletedAndFlow').bind('click', function () {
            $("body").showLoading("加载中...");
            $(this).addClass("tab-nav-active");
            $("#Inprogress").removeClass("tab-nav-active");
            status = "CompletedAndFlow";
            setTimeout(function () {
                //重新加载数据
                LoadReturnList('empty');
                myScroll.refresh();
                $("body").hideLoading();
            }, 500);
        }); 

        iScroll.onLoadData = LoadReturnList;
        LoadReturnList('empty');
    });
    
    function LoadReturnList(flag) {
        if (flag == "empty") {
            $("#thelist").children().remove();
        }
        jQuery.ajax({
            async: false,
            type: "post",
            url: "/ajaxCross/ajax_autoLoan.ashx",
            dataType: "json",
            data: { Cmd: "GetDebtCarryBind", pageIndex: pageIndex, status: status },
            success: function (jsonstr) {
                if (flag == "empty") {
                    $("#thelist").html("");
                }
                pageCount = jsonstr.PageNum;
                if (pageCount <= 1)
                    $("#pullUp").hide();
                else
                    $("#pullUp").show();
                var html = new Array();
                var str = "";
                if (jsonstr.list && jsonstr.list.length > 0) {
                    $("#divNone").hide();
                    $("#thelist").show();
                    $(jsonstr.list).each(function(index, item) {
                        str += '<section class="mt10 bt-e6e6e6 bb-e6e6e6 pl15 bg-fff debt-list"><a href="my_debt_carry_detail.aspx?SubscribeId='+item.Id+'&Title='+item.m_Title+'&projectid='+item.m_Id+'&tab='+status+'"><div class="bb-e6e6e6 debt-list-title"><p class="f14px c-212121">债权转让<span class="f13px c-808080 ml8">' + item.m_Title + '</span></p></div><div class="debt-list-body"><p class="f12px c-ababab"><i class="ico ico-money1"></i>承接金额<span class="f21px c-ffcf1f ml20">￥' + (item.ReceiveAmount + item.ReceiveInterest).toFixed(2) + '</span></p><p class="f12px c-ababab mt10"><i class="ico ico-date1"></i>下次回款<span class="f12px c-ababab ml20">' + GetString(item) + '</span></p></div></a></section>';
                    });
                    html.push(str);
                    $("#thelist").append(html.join(""));
                }
                else {
                    $("#pullUp").hide();
                    if (status == "Inprogress")
                        $("#divTitle").html("暂无回款中标的");
                    else
                        $("#divTitle").html("暂无已完成标的");
                    $("#divNone").show();
                    $("#thelist").hide();
                }
            },
            error: function (a, b, c) {
                $("#thelist").html("加载有误...");
            }
        });
    }

    function GetString(item) {
        if (item.IsRepayAdvance == "true")
            return "已完成(提前还款)";
        else if(item.Status == "4")
            return "已完成"+'(' + (item.RefundedMonths) + '/' + item.TotalRefundMonths + '期)';
        else if (item.DetailList!=null && item.DetailList.length > 0) {
            return item.NextCycDate + '(' + (item.RefundedMonths + 1) + '/' + item.TotalRefundMonths + '期)';
        }
            
        else
            return "";
    }
</script>

</body>
</html>
