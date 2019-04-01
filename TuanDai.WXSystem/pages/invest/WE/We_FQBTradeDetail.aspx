<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="We_FQBTradeDetail.aspx.cs" Inherits="TuanDai.WXApiWeb.pages.invest.WE.We_FQBTradeDetail" %>

<%@ Import  Namespace="TuanDai.WXApiWeb" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <title><%=model.IsWeFQB?"We计划分期宝":"复投宝" %>投资列表</title>
    <link rel="stylesheet" type="text/css" href="/css/global.css?v=<%=GlobalUtils.Version %>" />
    <link rel="stylesheet" type="text/css" href="/css/project-detail.css?v=<%=GlobalUtils.Version %>" />
</head>
<body class="bg-f1f3f5 pb20">
<%= this.GetNavStr()%>
	<header class="headerMain">
	    <div class="header">
	        <div class="back" onclick="javascript:history.go(-1);">返回</div>
	        <h1 class="title">投资列表</h1>
	    </div>
        <%= this.GetNavIcon()%>
	    <div class="none"></div>
	</header>


	<div id="wrapper" style="top:0px!important;">
        <div id="scroller">
            <div id="pullDown">
                <span class="pullDownIcon"></span><span class="pullDownLabel">下拉刷新...</span>
            </div>
            <div id="report_detail_processing" class="dataTables_processing" style="display:none">正在加载...</div>
	               <div class="clearfix pl15 pr15">
		                <div class="lf f12px c-808080">标的名称</div>
		                <div class="rf f12px c-808080">投资金额</div>
	                </div>
	                <div class="pl15 bg-fff bt-e6e6e6 bb-e6e6e6" id="thelist"> 
	                </div> 

                <div id="pullUp">
                     <span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多...</span>
                </div> 
		    </div>
        </div>
	
    <script type="text/javascript" src="/scripts/jquery.min.js"></script> 
    <script type="text/javascript" src="/scripts/fastclick.js"></script>
    <script type="text/javascript" src="/scripts/iscroll.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/scrollUpdate.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript" src="/scripts/base.js?v=<%=TuanDai.WXApiWeb.GlobalUtils.Version %>"></script>
    <script type="text/javascript">
        var pageIndex = 1;
        var IsFTB = <%=model.IsFTB?1:0%>;
         $(function () { 
             iScroll.onLoadData = LoadProjectList;
             LoadProjectList("empty");
        });
         function LoadProjectList(flag) {
             if (flag == "empty") {
                 $("#thelist").children().remove();
             }
             jQuery.ajax({
                 async: false,
                 type: "post",
                 url: "/ajaxCross/ajax_wefqb.ashx",
                 dataType: "json",
                 data: { Cmd: "GetWeFQBProjectList", pageIndex: pageIndex, WeOrderId: "<%=weOrderId%>" },
                 success: function (jsonstr) {
                     if (flag == "empty") {
                         $("#thelist").html("");
                     }
                     var html = new Array();
                     var str = "";

                     pageCount = jsonstr.pageCount;
                     if (pageCount <= 1)
                         $("#pullUp").hide();
                     else
                         $("#pullUp").show();

                     if (jsonstr.result == "1") {
                         for (var i = 0; i < jsonstr.list.length; i++) {
                             var item=jsonstr.list[i];  
                             str =  "<div class='clearfix pt15 pb12'>"+
                                    "<div class='w50p lf'>"+
                                    "    <p class='f17px text-overflow'>" + item.Title + "</p>" +
                                    "    <p class='f13px c-ababab'>" + item.AddDate + "</p>" +
                                    "</div>"+
                                    "<div class='w50p rf text-right pr5'>"+
                                    "     <p class='f17px" + (IsFTB==1?" pt15":"")+"' >￥" + item.Amount + "</p>" +
                                    (IsFTB==0?"<p class='f13px c-ffcf1f'>" + item.StatusDesc + "</p>":"") +
                                    " </div>" +
                                    "</div> ";
                             html.push(str);
                         }
                         $("#thelist").append(html.join(""));
                     }
                     else {
                         $("#thelist").html("<div class='clearfix pt15 pb12'>暂时未匹配到标!</div>");
                     }
                 },
                 error: function (a, b, c) {
                     $("#thelist").html("<div class='clearfix pt15 pb12'>数据加载有误...</div>");
                 }
             });
         }
    </script>
</body>
</html>
